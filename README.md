StatusBoard
===========

A collection of little scripts and web code to implement a basic status board using a Raspberry Pi.


Installation
------------

# Raspberry Pi

Get Raspbian onto an SD card and do the standard raspi-config. Then:

1. Use the settings in our config.txt, assuming you are also using a standard-def display in portratit mode over composite! Of course you are. ;)

2. Install the Matchbox window manager (to keep Midori happy) and Unclutter to lose the pointer. Matchbox is required as otherwise Midori has a habit of only using a small portion of the screen, but it really is a tiny window manager.

		sudo apt-get update
		sudo apt-get install matchbox unclutter

3. Put the .bash_profile and .xinitrc into /home/pi.

4. Edit .xinitrc to load a page from the correct location. You will find in the .xinitrx that we use:

		http://172.16.10.2/statusboard

	You will likely need something different, depending on where you're going to host the status board files.

5. Enable auto-login on the Pi by editing /etc/inittab and change:

		1:2345:respawn:/sbin/getty --noclear 38400 tty1 

	to

		1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1

You should now find that the Pi has a 90 degree rotated display and fires up Midori automatically on reboot. If you check the .xinitrc file, you'll notice that the Pi actually sits and counts 43200 seconds (12 hours) before restarting Midori; this is just a bit of a cheat to do a complete refresh of the page now and again.


# Mac

You can download and unzip the whole repo and point the __statusboardinstaller.sh__ script at it now, or manually:

1. Put statusboard.sh into /usr/local/bin.

        sudo mkdir -p /usr/local/bin
        sudo cp statusboard.sh /usr/local/bin/
        sudo chmod +x /usr/local/bin/statusboard.sh

2. Put com.studios.statusboard.plist into /Library/LaunchDaemons and start it:

        sudo cp com.studios.statusboard.plist /Library/LaunchDaemons/
        sudo chown root:wheel /Library/LaunchDaemons/com.studios.statusboard.plist
        sudo launchctl load /Library/LaunchDaemons/com.studios.statusboard.plist

3. Enable Apache

	If you're using Lion, just turn it on in System Preferences > Sharing.

	If you're using Mountain Lion, which has inexplicably removed this option:

        sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist

We only use Macs in the studios, so that's what this system monitors. But you could write anything that spits out a bit of HTML and get the web side to read it.

The __hubroom__ code is for monitoring our Hub Room temperature. This is copied only onto the server (in our circumstances) and the incoming air temperature is read using [Marcel Bresink's Temperature Monitor](http://www.bresink.com/osx/TemperatureMonitor.html "Temperature Monitor") command line binary. Just hide this 'block' in CSS or put your own magic there.


# Web

Just copy the files to a location on the webserver that the Pi will be fetching from. Make sure that PHP is enabled, otherwise it you won't get much data!


Usage
-----

Look at it.


Acknowledgements
----------------

CoolClock is entirely the work of Simon Baird and it's awesome.
http://randomibis.com/coolclock/

