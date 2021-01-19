#!/bin/sh

if [ "${#P_TZ}" -gt "0" ]; then
	echo P_TZ:${P_TZ}
	TZ="/usr/share/zoneinfo/${P_TZ}"
	if [ -f "${TZ}" ]; then
		cp ${TZ} /etc/localtime
		echo "${P_TZ}" >/etc/timezone
	fi
fi

# Check /postfix exist and not empty
if [ -d /postfix ] && [ "$(ls -A /postfix)" ]; then
	cp -a /postfix /etc/
	chown -R root:postfix /etc/postfix
	chmod -R g+r /etc/postfix
	chmod -R go-w /etc/postfix
else
	echo /postfix not available or empty.
	exit
fi

# Copy /etc/postfix/sasl2
if [ -d /etc/postfix/sasl2 ]; then
	rm -rf /etc/sasl2
	mv /etc/postfix/sasl2 /etc/
fi

exec postfix start-fg
