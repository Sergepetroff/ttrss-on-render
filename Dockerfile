# Use maintained TT-RSS image
FROM wangqiru/ttrss:latest

# Set environment variables
ENV SELF_URL_PATH=https://ttrss-yourname.onrender.com \
    DB_HOST=localhost \
    DB_USER=ttrss \
    DB_PASS=ttrsspass \
    DB_NAME=ttrss

# Copy custom config and plugins
COPY config.php /var/www/html/config.php
COPY plugins/fulltextrss /var/www/html/plugins/fulltextrss

# Cron setup: update feeds every  2h
# Cron setup: update feeds every 2h
RUN mkdir -p /etc/periodic/2hour && \
    echo "0 */2 * * * curl -fsS http://localhost/backend.php?op=globalUpdateFeeds >/dev/null 2>&1" \
    > /etc/periodic/2hour/update_feeds && \
    chmod +x /etc/periodic/2hour/update_feeds
RUN chmod +x /etc/periodic/2hour/update_feeds
