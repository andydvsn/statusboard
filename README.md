StatusBoard v1.00
=================

A collection of little scripts and web code to implement a basic status board.

Installation
------------

Put things in the right place.

Edit /etc/inittab on your Raspberry Pi and change:

1:2345:respawn:/sbin/getty --noclear 38400 tty1 

to

1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1

to enable auto-login.

Usage
-----

Use it.

Acknowledgements
----------------

CoolClock is entirely the work of Simon Baird and it's awesome.
http://randomibis.com/coolclock/

