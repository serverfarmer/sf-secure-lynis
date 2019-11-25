#!/bin/sh

# 1. run Lynis and scan the system
cd /opt/lynis
/opt/lynis/lynis audit system --cronjob --quiet --profile serverfarmer.prf 2>/dev/null \
	|grep -v custom.prf \
	|grep -v "had a long execution:"

# 2. warn about obvious problems by email from crontab
if [ ! -d /opt/farm/ext/firewall ] || [ -f /etc/local/.config/logcheck.nofirewall ]; then
	grep warning /var/log/lynis-report.dat \
		|grep -vFf /opt/farm/ext/secure-lynis/config/allowed.conf \
		|grep -vFf /etc/local/.config/allowed.lynis \
		|grep -v FIRE-4512
else
	grep warning /var/log/lynis-report.dat \
		|grep -vFf /opt/farm/ext/secure-lynis/config/allowed.conf \
		|grep -vFf /etc/local/.config/allowed.lynis
fi

# 3. leave /var/log/lynis.* files for possible inspection
