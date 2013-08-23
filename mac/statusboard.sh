#!/bin/bash

# statusboard.sh v1.06 (23/08/13) by Andy Davison.
#  Stat gatherer and sender for the status board.



### Stathat Bit

# We only bother with this if we're running on a Studio system.
STUDIO=`hostname -s`
if [[ "$STUDIO" =~ "studio" ]]; then

	# Get the current load average.
	LOAD=`uptime | awk -F\averages:\  {'print $2'} | awk {'print $1'}`

	# Upload if it's been more than one minute.
	STATHAT=""
	if [ ! -f /tmp/statusboard_stathat ]; then
		touch /tmp/statusboard_stathat
		STATHAT="GO"
	else
		STATHAT=`find /tmp/statusboard_stathat -mmin +1`
	fi

	if [[ "$STATHAT" != "" ]]; then
		#echo "Uploading load average of $LOAD..."
		curl -d "email=youraddress@here.com&stat=$STUDIO load&value=$LOAD" http://api.stathat.com/ez &>/dev/null
		touch /tmp/statusboard_stathat
	fi

fi



### Local Bit

## User Activity
CONSOLEUSER=`who | grep console | awk {'print $1'}`
USERDETAILS=`w`
USERDETAILS=`echo "$USERDETAILS" | grep console`
LOGINTIME=`echo $USERDETAILS | awk {'print $4'}`
IDLETIME=`/usr/sbin/ioreg -c IOHIDSystem | /usr/bin/awk '/HIDIdleTime/ {print int($NF/1000000000); exit}'`

# Convert idle time to something nicer than seconds.
if [[ "$IDLETIME" -gt 300 ]]; then

	D=$((IDLETIME/60/60/24))
	H=$((IDLETIME/60/60%24))
	M=$((IDLETIME/60%60))

	[[ "$M" -gt 0 ]] && NICEIDLE=$M"m"
	[[ "$H" -gt 0 ]] && NICEIDLE=$H"h "$M"m"
	[[ "$D" -gt 0 ]] && NICEIDLE=$D"d "$H"h "$M"m"

	NICEIDLE="Idle ($NICEIDLE)"
	REALLYIDLE="yes"

else

	if [[ "$CONSOLEUSER" != "" ]]; then
		NICEIDLE="Console in Use"
	else
		NICEIDLE="Console Ready"
	fi

	REALLYIDLE="no"

fi



## System Activity
# Get the usage of the Workspace drive as a percentage.
WORKSPACEUSE=`df -k /Volumes/Workspace | grep Workspace | awk {'print $5'} | cut -f1 -d%`
WORKSPACEREM=$((100-$WORKSPACEUSE))
WORKSPACESTS="ok"
[[ "$WORKSPACEUSE" -gt 80 ]] && WORKSPACESTS="warning"
[[ "$WORKSPACEUSE" -gt 90 ]] && WORKSPACESTS="critical"



## Output

# Prep
[ ! -d /Library/WebServer/Documents/statusboard ] && mkdir -p /Library/WebServer/Documents/statusboard

# Display the user name, or real name, with appropriate tags and the like.
if [[ "$CONSOLEUSER" == "" ]]; then

	echo "<div class=\"console vacant\"><h4>Available</h4></div>" > /Library/WebServer/Documents/statusboard/status

elif [[ "$CONSOLEUSER" == "admin" ]]; then

	echo "<div class=\"console maintenance\"><h4>Maintenance</h4></div>" > /Library/WebServer/Documents/statusboard/status

elif [[ "$CONSOLEUSER" == "Guest" ]]; then

	echo "<div class=\"console engaged\"><h4>Guest User</h4></div>" > /Library/WebServer/Documents/statusboard/status

else

	if [ -f /tmp/statusboard_prevuser ]; then

		PREVIOUSUSER=`cat /tmp/statusboard_prevuser | sed -n 1p`

		echo $CONSOLEUSER
		echo $PREVIOUSUSER

		if [[ "$CONSOLEUSER" == "$PREVIOUSUSER" ]]; then
			FIRSTNAME=`cat /tmp/statusboard_prevuser | sed -n 2p`
			LASTNAME=`cat /tmp/statusboard_prevuser | sed -n 3p`
		else
			FIRSTNAME=`dscl -q /Active\ Directory/DS/All\ Domains/ -read /Users/$CONSOLEUSER FirstName | xargs | awk -F\FirstName\:\  {'print $2'}`
			LASTNAME=`dscl -q /Active\ Directory/DS/All\ Domains/ -read /Users/$CONSOLEUSER LastName | xargs | awk -F\LastName\:\  {'print $2'}`
		fi
		
	else

		FIRSTNAME=`dscl -q /Active\ Directory/DS/All\ Domains/ -read /Users/$CONSOLEUSER FirstName | xargs | awk -F\FirstName\:\  {'print $2'}`
		LASTNAME=`dscl -q /Active\ Directory/DS/All\ Domains/ -read /Users/$CONSOLEUSER LastName | xargs | awk -F\LastName\:\  {'print $2'}`

	fi

	if [[ "$FIRSTNAME" == "" ]] && [[ "$LASTNAME" == "" ]]; then
		DISPLAYNAME="$CONSOLEUSER"
	else
		DISPLAYNAME="$FIRSTNAME $LASTNAME"
		echo $CONSOLEUSER > /tmp/statusboard_prevuser
		echo $FIRSTNAME >> /tmp/statusboard_prevuser
		echo $LASTNAME >> /tmp/statusboard_prevuser
	fi

	echo "<div class=\"console engaged\"><h4>$DISPLAYNAME</h4></div>" > /Library/WebServer/Documents/statusboard/status

fi


# Universal stats.
echo "<div class=\"idle $REALLYIDLE\"><h5>$NICEIDLE</h5></div>" >> /Library/WebServer/Documents/statusboard/status
echo "<div class=\"workspace $WORKSPACESTS\"><h6>$WORKSPACEREM% Workspace Remaining</h6></div>" >> /Library/WebServer/Documents/statusboard/status


exit 0




