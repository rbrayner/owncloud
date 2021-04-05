FROM owncloud/server:10.7

RUN apt-get update && apt-get upgrade -y && apt-get install -y supervisor sudo cron


# Add crontab file in the cron directory
ADD crontab /etc/cron.d/owncloud-addon

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/owncloud-addon

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN mkdir /scripts
COPY perms.sh /scripts/
RUN chown root.root /scripts/perms.sh
RUN chmod 750 /scripts/perms.sh

EXPOSE 80

