FROM owncloud:10.0.3

RUN apt-get update && apt-get upgrade -y && apt-get install -y supervisor redis-server php5-redis

RUN mkdir -p /etc/ssl/owncloud/certs
RUN mkdir -p /etc/ssl/owncloud/private

RUN update-ca-certificates
RUN a2enmod rewrite && a2enmod headers && a2enmod ssl
COPY owncloud-ssl.conf /etc/apache2/conf-available/owncloud-ssl.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN a2enconf owncloud-ssl.conf

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
