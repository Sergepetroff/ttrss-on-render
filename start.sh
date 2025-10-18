#!/bin/sh
# Inline comments only in English.
# Start cron and the web server.

# Write cron entry
echo "0 */2 * * * /usr/bin/curl -fsS http://localhost/backend.php?op=globalUpdateFeeds >/dev/null 2>&1" > /etc/crontabs/root

# Start cron in background
crond

# Start PHP built-in web server
php -S 0.0.0.0:10000 -t /var/www/ttrss
