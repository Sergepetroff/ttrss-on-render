FROM clue/ttrss:latest
COPY plugins.local /var/www/ttrss/plugins.local
COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 10000
CMD ["/start.sh"]
