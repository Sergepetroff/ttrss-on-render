<?php
define('PLUGINS', 'af_feedmod');
$self_url_path = getenv('SELF_URL_PATH') ?: 'https://ttrss.onrender.com/';
$db_type = getenv('DB_TYPE') ?: 'pgsql';
$db_host = getenv('DB_HOST') ?: 'db';
$db_user = getenv('DB_USER') ?: 'ttrss';
$db_password = getenv('DB_PASSWORD') ?: 'secret_pass';
$db_name = getenv('DB_NAME') ?: 'ttrss';
?>
