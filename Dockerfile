FROM owncloud:fpm

RUN apt-get update && apt-get upgrade -y && apt-get install -y supervisor redis-server php5-redis

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
