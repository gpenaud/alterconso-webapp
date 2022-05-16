#!/usr/bin/env bash

touch /var/www/cagette/crontab.log

# Added a cronjob in a new crontab
echo "*  * * * * cd /var/www/cagette/www && /usr/bin/neko index.n cron/minute > /dev/null 2>&1" > /etc/crontab
echo "0  * * * * cd /var/www/cagette/www && /usr/bin/neko index.n cron/hour > /dev/null 2>&1"  >> /etc/crontab
echo "15 0 * * * cd /var/www/cagette/www && /usr/bin/neko index.n cron/daily > /dev/null 2>&1" >> /etc/crontab

# allow run as www-data user
crontab -u www-data /etc/crontab
chmod u+s /usr/sbin/cron
