FROM owncloud:10.0.10

RUN apt-get update && apt-get upgrade -y && apt-get install -y supervisor sudo cron

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/owncloud

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/owncloud

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

COPY apache.crt /etc/ssl/certs/
COPY apache.key /etc/ssl/private/

RUN update-ca-certificates
RUN a2enmod rewrite && a2enmod headers && a2enmod ssl

COPY owncloud-ssl.conf /etc/apache2/conf-available/owncloud-ssl.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /scripts
COPY perms.sh /scripts/
RUN chown root.root /scripts/perms.sh
RUN chmod 750 /scripts/perms.sh


RUN a2enconf owncloud-ssl.conf

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
