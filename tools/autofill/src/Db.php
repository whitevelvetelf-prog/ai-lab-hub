<?php
declare(strict_types=1);

/**
 * Локальна проміжна база (SQLite) — "черга" кандидатів. Жива MySQL-база сайту тут НЕ чіпається.
 * Стадії: discovered → fetched → enriched → valid | review | rejected | manual | error → exported
 */
final class Db
{
    private static ?PDO $pdo = null;

    public static function pdo(): PDO
    {
        if (self::$pdo === null) {
            $dir = (string)cfg('paths.data');
            if (!is_dir($dir)) {
                mkdir($dir, 0777, true);
            }
            $p = new PDO('sqlite:' . $dir . '/queue.sqlite');
            $p->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $p->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            $p->exec('PRAGMA journal_mode=WAL');
            $p->exec(self::SCHEMA);
            self::$pdo = $p;
        }
        return self::$pdo;
    }

    private const SCHEMA = <<<'SQL'
CREATE TABLE IF NOT EXISTS candidates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    domain TEXT NOT NULL UNIQUE,
    url TEXT NOT NULL,
    name_hint TEXT,
    source TEXT,
    target_subcat TEXT,
    stage TEXT NOT NULL DEFAULT 'discovered',
    note TEXT,
    partner_hint_url TEXT,
    logo_file TEXT,
    data_json TEXT,
    tokens_in INTEGER DEFAULT 0,
    tokens_out INTEGER DEFAULT 0,
    batch_no INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_candidates_stage ON candidates(stage);
CREATE TABLE IF NOT EXISTS existing (
    domain TEXT PRIMARY KEY,
    name TEXT,
    name_norm TEXT,
    subcats TEXT
);
CREATE INDEX IF NOT EXISTS idx_existing_name ON existing(name_norm);
SQL;
}
