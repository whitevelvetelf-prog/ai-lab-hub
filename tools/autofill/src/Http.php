<?php
declare(strict_types=1);

final class Http
{
    private static function apply($ch): void
    {
        curl_setopt($ch, CURLOPT_USERAGENT, (string)cfg('user_agent'));
        $ca = cfg('ca_bundle');
        if ($ca) {
            curl_setopt($ch, CURLOPT_CAINFO, $ca);
        }
    }

    /** GET з лімітом розміру. Повертає status/body/url(фінальний)/ctype/error. */
    public static function get(string $url, int $timeout = 15, array $headers = [], ?int $maxBytes = null): array
    {
        $max = $maxBytes ?? (int)cfg('max_html_bytes', 2000000);
        $buf = '';
        $hasAccept = false;
        foreach ($headers as $h) {
            if (stripos($h, 'accept:') === 0) {
                $hasAccept = true;
            }
        }
        $hdr = ['Accept-Language: en,uk;q=0.8'];
        if (!$hasAccept) {
            $hdr[] = 'Accept: text/html,application/xhtml+xml,application/json;q=0.9,*/*;q=0.5';
        }
        $hdr = array_merge($hdr, $headers);

        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_MAXREDIRS      => 5,
            CURLOPT_TIMEOUT        => $timeout,
            CURLOPT_CONNECTTIMEOUT => 8,
            CURLOPT_ENCODING       => '',
            CURLOPT_HTTPHEADER     => $hdr,
            CURLOPT_WRITEFUNCTION  => function ($c, $d) use (&$buf, $max) {
                $buf .= $d;
                return strlen($buf) > $max ? 0 : strlen($d);
            },
        ]);
        self::apply($ch);
        curl_exec($ch);
        $errno = curl_errno($ch);
        $res = [
            'status' => (int)curl_getinfo($ch, CURLINFO_HTTP_CODE),
            'body'   => $buf,
            'url'    => (string)curl_getinfo($ch, CURLINFO_EFFECTIVE_URL),
            'ctype'  => (string)curl_getinfo($ch, CURLINFO_CONTENT_TYPE),
            'error'  => curl_error($ch),
        ];
        curl_close($ch);
        if ($errno === CURLE_WRITE_ERROR && strlen($buf) > $max) {
            $res['error'] = ''; // обрізали свідомо — це не помилка
        }
        return $res;
    }

    /** Фінальна адреса після редіректів (для посилань Product Hunt тощо). */
    public static function resolve(string $url): ?string
    {
        if ($url === '') {
            return null;
        }
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_NOBODY         => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_MAXREDIRS      => 6,
            CURLOPT_TIMEOUT        => 12,
            CURLOPT_RETURNTRANSFER => true,
        ]);
        self::apply($ch);
        curl_exec($ch);
        $u = (string)curl_getinfo($ch, CURLINFO_EFFECTIVE_URL);
        curl_close($ch);
        return $u !== '' ? $u : null;
    }

    public static function postJson(string $url, array $payload, array $headers = [], int $timeout = 60): array
    {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST           => true,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => $timeout,
            CURLOPT_HTTPHEADER     => array_merge(['content-type: application/json'], $headers),
            CURLOPT_POSTFIELDS     => json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
        ]);
        self::apply($ch);
        $body = curl_exec($ch);
        $code = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $err = curl_error($ch);
        curl_close($ch);
        return ['status' => $code, 'body' => $body === false ? '' : (string)$body, 'error' => $err];
    }

    /** Виклик Anthropic Messages API з повторами на 429/5xx. Кидає виняток на 4xx (крім 429). */
    public static function claude(array $payload): array
    {
        $key = (string)cfg('anthropic_key');
        if ($key === '') {
            throw new RuntimeException('Немає anthropic_key у config.php');
        }
        for ($try = 0; $try < 5; $try++) {
            $r = self::postJson(
                'https://api.anthropic.com/v1/messages',
                $payload,
                ['x-api-key: ' . $key, 'anthropic-version: 2023-06-01'],
                180
            );
            if ($r['status'] === 200) {
                $j = json_decode($r['body'], true);
                if (is_array($j)) {
                    return $j;
                }
            }
            if ($r['status'] === 0 || $r['status'] === 429 || $r['status'] >= 500) {
                sleep((int)(2 ** $try) * 2);
                continue;
            }
            throw new RuntimeException('Anthropic HTTP ' . $r['status'] . ': ' . substr($r['body'], 0, 300));
        }
        throw new RuntimeException('Anthropic: вичерпано спроби (перевантаження або мережа)');
    }
}
