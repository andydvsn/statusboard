#!/bin/bash

# statusboardinstaller.sh v1.00 by Andy Davison
#  Puts everything in the right place and starts it.

if [ "$USER" != "root" ]; then
	echo "Please run $0 as root."
	exit 0
fi

if [ $# -lt 1 ]; then
	echo "Usage: $0 <master dir>"
	echo
	echo "Point me to the master directory from GitHub."
	exit 0
fi

if [ ! -d $1/mac ]; then
	echo "The 'mac' directory is missing from the GitHub components."
	exit 0
else

	echo "Copying..."
	cp $1/mac/com.studios.statusboard.plist /Library/LaunchDaemons
	cp $1/mac/statusboard.sh /usr/local/bin
	chown root:wheel /Library/LaunchDaemons/com.studios.statusboard.plist
	chmod 644 /Library/LaunchDaemons/com.studios.statusboard.plist
	chmod 755 /usr/local/bin/statusboard.sh

	echo "Starting..."
	launchctl load /Library/LaunchDaemons/com.studios.statusboard.plist
	launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist

	OURHOST=`hostname`

	/usr/local/bin/statusboard.sh

	echo
	echo "Check http://$OURHOST/statusboard/status to ensure things are working."
	echo "You will need to edit the address in /usr/local/bin/statusboard.sh for StatHat updates."
	echo
	echo "Complete."
	exit 0

fi

