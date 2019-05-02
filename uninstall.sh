#!/bin/sh

if grep -q /opt/farm/ext/secure-lynis/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/ext\/secure-lynis\/cron/d" /etc/crontab
fi
