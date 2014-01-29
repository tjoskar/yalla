#!/bin/sh

# Copy files
cp /home/vagrant/data/systemfiles/etc/init.d/selenium /etc/init.d/
cp /home/vagrant/data/systemfiles/etc/init.d/strider /etc/init.d/
cp /home/vagrant/data/systemfiles/etc/init.d/vncserver /etc/init.d/

cp /home/vagrant/data/systemfiles/etc/X11/xorg.conf /etc/X11/

cp /home/vagrant/data/systemfiles/usr/local/bin/selenium /usr/local/bin/
cp /home/vagrant/data/systemfiles/usr/local/bin/strider /usr/local/bin/

cp /home/vagrant/data/systemfiles/home/.vnc/passwd /home/vagrant/.vnc/
cp /home/vagrant/data/systemfiles/home/.vnc/xstartup /home/vagrant/.vnc/

cp /home/vagrant/data/systemfiles/home/.prompt /home/vagrant/


chown vagrant:vagrant /home/vagrant/.vnc/passwd
chown vagrant:vagrant /home/vagrant/.vnc/xstartup
chown vagrant:vagrant /home/vagrant/.prompt

chmod +x /etc/init.d/selenium
chmod +x /etc/init.d/strider
chmod +x /etc/init.d/vncserver
chmod +x /usr/local/bin/selenium
chmod +x /usr/local/bin/strider
