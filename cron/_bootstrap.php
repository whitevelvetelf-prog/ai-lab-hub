<?php

declare(strict_types=1);

/**
 * AI LAB HUB — спільний запуск cron-завдань реклами (каталог cron/ поза public/:
 * з браузера недоступний; виконується лише з командного рядка).
 *
 * promo_cron_run('job', лімітСекунд, fn(PDO): string):
 *   * лише CLI: при виклику з веба одразу 404 і вихід;
 *   * блокування від паралельного запуску (flock на storage/locks/<job>.lock):
 *     якщо попередній запуск ще працює — 'skipped';
 *   * обмеження часу (set_time_limit);
 *   * журнал storage/logs/cron.log із простою ротацією (> 1 МБ → cron.log.1);
 *   * запис у таблицю cron_runs (job, started_at, finished_at, status, message), час — UTC;
 *   * сесія MySQL у UTC (promo_db_utc); «доба» рахується за Europe/Kyiv у коді.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/promo.php';

const PROMO_CRON_LOG_MAX = 1048576;

function promo_cron_log(string $job, string $line): void
{
    $dir = __DIR__ . '/../storage/logs';
    if (!is_dir($dir)) {
        @mkdir($dir, 0775, true);
    }
    $file = $dir . '/cron.log';
    if (is_file($file) && filesize($file) > PROMO_CRON_LOG_MAX) {
        @rename($file, $file . '.1');
    }
    $msg = '[' . gmdate('Y-m-d H:i:s') . ' UTC] ' . $job . ': ' . $line . "\n";
    @file_put_contents($file, $msg, FILE_APPEND | LOCK_EX);
    echo $msg;
}

/** @param callable(PDO):string $fn */
/** Чи це MySQL 1615 «Prepared statement needs to be re-prepared». */
function promo_cron_is_reprepare(Throwable $e): bool
{
    return $e instanceof PDOException && ((int) ($e->errorInfo[1] ?? 0) === 1615 || str_contains($e->getMessage(), ' 1615 '));
}

/**
 * $retryOnReprepare — для завдань, що вибирають роботу за станом у базі (зараз — усі cron-завдання): якщо MySQL повернув 1615 (на спільному сервері хостингу
 * кеш визначень таблиць витісняє підготовлені запити), завдання повторюється ОДИН раз на новому з'єднанні з
 * емульованими prepared statements (PDO::ATTR_EMULATE_PREPARES = true; значення так само екрануються драйвером).
 * Незавершену транзакцію першої спроби перед повтором відкочуємо, щоб повтор не чекав на її блокування.
 * Повтор рівносильний наступному плановому запуску (листи — з черги за статусом), тож дублів не додає.
 */
function promo_cron_run(string $job, int $maxSeconds, callable $fn, bool $retryOnReprepare = false): int
{
    @set_time_limit($maxSeconds);
    ignore_user_abort(true);

    $lockDir = __DIR__ . '/../storage/locks';
    if (!is_dir($lockDir)) {
        @mkdir($lockDir, 0775, true);
    }
    $lock = @fopen($lockDir . '/' . $job . '.lock', 'c');
    if ($lock === false) {
        promo_cron_log($job, 'ERROR: не вдалося відкрити файл блокування');

        return 1;
    }

    /** @var PDO $pdo */
    $pdo = require __DIR__ . '/../config/database.php';
    promo_db_utc($pdo);

    $record = static function (string $status, ?string $message, ?int $id = null) use ($pdo, $job): ?int {
        try {
            if ($id === null) {
                $pdo->prepare('INSERT INTO cron_runs (job, started_at, finished_at, status, message) VALUES (:j, :s, :f, :st, :m)')
                    ->execute([':j' => $job, ':s' => promo_utc_now(), ':f' => $status === 'running' ? null : promo_utc_now(), ':st' => $status, ':m' => $message]);

                return (int) $pdo->lastInsertId();
            }
            $pdo->prepare('UPDATE cron_runs SET finished_at = :f, status = :st, message = :m WHERE id = :id')
                ->execute([':f' => promo_utc_now(), ':st' => $status, ':m' => $message !== null ? mb_substr($message, 0, 1000) : null, ':id' => $id]);
        } catch (Throwable $e) {
            promo_cron_log($job, 'cron_runs: ' . $e->getMessage());
        }

        return $id;
    };

    if (!flock($lock, LOCK_EX | LOCK_NB)) {
        promo_cron_log($job, 'SKIPPED: попередній запуск ще працює');
        $record('skipped', 'попередній запуск ще працює');

        return 0;
    }

    $runId = $record('running', null);
    $started = microtime(true);
    try {
        try {
            $message = $fn($pdo);
        } catch (Throwable $first) {
            if (!$retryOnReprepare || !promo_cron_is_reprepare($first)) {
                throw $first;
            }
            if ($pdo->inTransaction()) {
                try {
                    $pdo->rollBack();
                } catch (Throwable) {
                }
            }
            promo_cron_log($job, 'RETRY after 1615 at ' . basename($first->getFile()) . ':' . $first->getLine());
            /** @var PDO $retryPdo */
            $retryPdo = require __DIR__ . '/../config/database.php';
            $retryPdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, true);
            promo_db_utc($retryPdo);
            $message = $fn($retryPdo) . ' [повтор після 1615 у ' . basename($first->getFile()) . ':' . $first->getLine() . ']';
        }
        $message .= sprintf(' (%.1f с)', microtime(true) - $started);
        $record('ok', $message, $runId);
        promo_cron_log($job, 'OK ' . $message);
        $code = 0;
    } catch (Throwable $e) {
        $where = ' @ ' . basename($e->getFile()) . ':' . $e->getLine();
        $record('error', $e->getMessage() . $where, $runId);
        promo_cron_log($job, 'ERROR ' . $e->getMessage() . $where);
        $code = 1;
    } finally {
        flock($lock, LOCK_UN);
        fclose($lock);
    }

    return $code;
}
