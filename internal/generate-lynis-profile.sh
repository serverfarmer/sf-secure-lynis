#!/bin/sh
. /opt/farm/scripts/init

if [ -f /etc/X11/xinit/xinitrc ]; then
	level="workstation"
else
	level="server"
fi

if grep -qFx $OSVER /opt/farm/ext/secure-lynis/config/nosecurity.conf; then
	skipsec="yes"
else
	skipsec="no"
fi

cat /opt/farm/ext/secure-lynis/templates/serverfarmer.prf.tpl |sed \
	-e s/%%skipsec%%/$skipsec/g \
	-e s/%%level%%/$level/g
