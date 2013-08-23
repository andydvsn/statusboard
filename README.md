StatusBoard
===========

A collection of little scripts and web code to implement a basic status board.


Installation
------------

# Raspberry Pi

Get Raspbian onto an SD card and do the standard raspi-config. Then:

1. Use the settings in our config.txt, assuming you are also using a standard-def display in portratit mode over composite! Of course you are. ;)

2. Install Chromium, or your browser of choice, and unclutter to lose the pointer.

	sudo apt-get update
	sudo apt-get install chromium-browser unclutter

3. Put the .bash_profile and .xinitrc into /home/pi.

4. Edit .xinitrc to load a page from the correct location. We use:

	172.16.10.2/statusboard

But you will probably need something different, depending on where you're going to host the status board files.

5. Enable auto-login on the Pi by editing /etc/inittab and change:

	1:2345:respawn:/sbin/getty --noclear 38400 tty1 

to

	1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1

You should now find that the Pi has a 90 degree rotated display and fires up Chromium automatically on reboot. This is all that needs to be done on the Pi.


# Mac

1. Put statusboard.sh into /usr/local/bin.

	sudo mkdir -p /usr/local/bin
	sudo cp statusboard.sh /usr/local/bin/
	sudo chmod +x /usr/local/bin/statusboard.sh

2. Put com.studios.statusboard.plist into /Library/LaunchDaemons and start it:

	sudo cp com.studios.statusboard.plist /Library/LaunchDaemons/
	sudo chown root:wheel /Library/LaunchDaemons/com.studios.statusboard.plist
	sudo launchctl load /Library/LaunchDaemons/com.studios.statusboard.plist

We only use Macs in the studios, so that's what this system monitors. But you could write anything that spits out a bit of HTML and get the web side to read it.


# Web

Just copy the files to a location on the webserver that the Pi will be fetching from. Make sure that PHP is enabled, otherwise it you won't get much data!


Usage
-----

Look at it.


Acknowledgements
----------------

CoolClock is entirely the work of Simon Baird and it's awesome.
http://randomibis.com/coolclock/

