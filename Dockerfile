# Use maintained TT-RSS image
FROM wangqiru/ttrss:latest

# Create config.php inline
RUN mkdir -p /var/www/html && \
    echo "<?php
define('PLUGINS', 'af_feedmod');
\$self_url_path = getenv('SELF_URL_PATH') ?: 'https://ttrss-yourname.onrender.com/';
\$db_type = getenv('DB_TYPE') ?: 'pgsql';
\$db_host = getenv('DB_HOST') ?: 'db';
\$db_user = getenv('DB_USER') ?: 'ttrss';
\$db_password = getenv('DB_PASSWORD') ?: 'secret_pass';
\$db_name = getenv('DB_NAME') ?: 'ttrss';
?>" > /var/www/html/config.php

# Create placeholder plugin inline
RUN mkdir -p /var/www/html/plugins/fulltextrss && \
    echo "<?php class FullTextRss { public static function init(\$host) {} } ?>" \
    > /var/www/html/plugins/fulltextrss/plugin.php

# Cron setup: update feeds every 2h
RUN mkdir -p /etc/periodic/2hour && \
    echo "0 */2 * * * curl -fsS http://localhost/backend.php?op=globalUpdateFeeds >/dev/null 2>&1" \
    > /etc/periodic/2hour/update_feeds && chmod +x /etc/periodic/2hour/update_feeds

# Start cron + webserver
CMD crond && php -S 0.0.0.0:10000 -t /var/www/html
