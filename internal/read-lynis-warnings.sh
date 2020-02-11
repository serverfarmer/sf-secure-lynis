#!/bin/sh

grep ^warning /var/log/lynis-report.dat \
	|grep -vFf /opt/farm/ext/secure-lynis/config/allowed.conf \
	|grep -vFf /etc/local/.config/allowed.lynis
