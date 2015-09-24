FROM ruby:2.2.2

# setup crontab
RUN apt-get update && \
    apt-get install -y cron rsyslog rsync && \
    rm -rf /var/lib/apt/lists/*
COPY ./crontab /etc/crontab
RUN touch /var/log/cron.log

# Volumes - backup gem defaults location is ~/Backup/
VOLUME ["/root/Backup/logs"]

# Copy App
COPY . /root/Backup
RUN cd /Backup; bundle install
WORKDIR /Backup

COPY bin/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]