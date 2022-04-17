#!/usr/bin/env bash

touch /var/www/cagette/crontab.log

# Added a cronjob in a new crontab
echo "*  * * * * cd /var/www/cagette/www && /usr/bin/neko index.n cron/minute >> /var/www/cagette/crontab.log 2>&1" > /etc/crontab
echo "0  * * * * cd /var/www/cagette/www && /usr/bin/neko index.n cron/hour >> /var/www/cagette/crontab.log 2>&1" >> /etc/crontab
echo "15 0 * * * cd /var/www/cagette/www && /usr/bin/neko index.n cron/daily >> /var/www/cagette/crontab.log 2>&1" >> /etc/crontab

crontab /etc/crontab
/usr/sbin/service cron start
tail -f /var/www/cagette/crontab.log
