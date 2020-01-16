#!/bin/sh

# 1. run Lynis and scan the system
cd /opt/lynis
/opt/lynis/lynis audit system --cronjob --quiet --profile serverfarmer.prf 2>/dev/null \
	|grep -v custom.prf \
	|grep -v "had a long execution:"

# 2. warn about obvious problems by email from crontab

if [ -f /etc/image-id ] && grep -q ami-ecs /etc/image-id; then
	/opt/farm/ext/secure-lynis/internal/read-lynis-warnings.sh |grep -v AUTH-9308
elif [ ! -d /opt/farm/ext/firewall ] || [ -f /etc/local/.config/logcheck.nofirewall ]; then
	/opt/farm/ext/secure-lynis/internal/read-lynis-warnings.sh |grep -v FIRE-4512
else
	/opt/farm/ext/secure-lynis/internal/read-lynis-warnings.sh
fi

# 3. leave /var/log/lynis.* files for possible inspection
