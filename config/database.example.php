<?php

declare(strict_types=1);

/**
 * AI LAB HUB — приклад підключення до бази даних (PDO).
 *
 * Скопіюйте цей файл у config/database.php та підставте свої значення:
 *   cp config/database.example.php config/database.php
 */

$host    = '127.0.0.1';
$port    = 3306;
$dbname  = 'your_database_name';
$user    = 'your_db_user';
$password = 'your_db_password';
$charset = 'utf8mb4';

$dsn = "mysql:host={$host};port={$port};dbname={$dbname};charset={$charset}";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

return new PDO($dsn, $user, $password, $options);
