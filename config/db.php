<?php
// PDO configuration with local override support.
//
// Priority:
// 1) config/db.local.php (if present)
// 2) Environment variables (DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASS)
// 3) Defaults below

$db = [
    'host' => 'localhost',
    'port' => '3306',
    'name' => 'ecommerce_db',
    'user' => 'root',
    'pass' => '',
];

$db_local_file = __DIR__ . '/db.local.php';
if (file_exists($db_local_file)) {
    $local = require $db_local_file;
    if (is_array($local)) {
        $db = array_merge($db, array_intersect_key($local, $db));
    }
}

$env_host = getenv('DB_HOST');
$env_port = getenv('DB_PORT');
$env_name = getenv('DB_NAME');
$env_user = getenv('DB_USER');
$env_pass = getenv('DB_PASS');

if ($env_host !== false && $env_host !== '') { $db['host'] = $env_host; }
if ($env_port !== false && $env_port !== '') { $db['port'] = $env_port; }
if ($env_name !== false && $env_name !== '') { $db['name'] = $env_name; }
if ($env_user !== false && $env_user !== '') { $db['user'] = $env_user; }
if ($env_pass !== false) { $db['pass'] = $env_pass; }

$dsn = 'mysql:host=' . $db['host']
    . ';port=' . $db['port']
    . ';dbname=' . $db['name']
    . ';charset=utf8mb4';

try {
    $pdo = new PDO($dsn, $db['user'], $db['pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (Throwable $e) {
    $pdo = null;
    error_log('DB connection failed: ' . $e->getMessage());
}
