#!/bin/sh

url="https://github.com/CISOfy/lynis"
path=/opt/lynis


if [ ! -d $path ]; then
	echo "installing Lynis auditing tool"
	git clone "$url" $path

elif [ ! -d $path/.git ] && [ ! -d $path/.svn ]; then
	echo "directory $path busy, skipping Lynis installation"
	exit 0

else
	/opt/farm/scripts/git/pull.sh $path
fi


echo "setting up Lynis custom profile"
file=/opt/lynis/serverfarmer.prf
/opt/farm/ext/secure-lynis/config-lynis.sh >$file
chmod 0640 $file


touch      /etc/local/.config/allowed.lynis
chmod 0600 /etc/local/.config/allowed.lynis

if ! grep -q /opt/farm/ext/secure-lynis/cron/check.sh /etc/crontab; then
	echo "setting up crontab entry"
	echo "25 1 * * * root /opt/farm/ext/secure-lynis/cron/check.sh" >>/etc/crontab
fi
