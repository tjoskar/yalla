#!/bin/sh
set -e

if [ -e /.installed ]; then
  echo 'Already installed.'

else
  echo ''
  echo 'INSTALLING'
  echo '----------'

  # Update app-get
  apt-get update

  # Install some basic packets
  apt-get install -y python-software-properties python g++ make python-pip python-virtualenv openjdk-7-jre unzip git-core
  apt-get install -y x11vnc xvfb fluxbox firefox

  # Add chris-lea/nodejs (https://launchpad.net/~chris-lea/+archive/node.js/)
  add-apt-repository -y ppa:chris-lea/node.js

  # Add Google public key to apt
  wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
  # Add Google to the apt-get source list
  echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

  # Import the MongoDB public GPG Key
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
  # Create a /etc/apt/sources.list.d/mongodb.list file
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

  # Run an update again
  apt-get update

  # Lets install nodejs
  apt-get install -y nodejs

  # Create a (soft) link to avoid conflicts
  mv /usr/local/bin/node /usr/local/bin/node_old 2>/dev/null
  mv /usr/bin/node /usr/bin/node_old 2>/dev/null
  ln -s /usr/bin/nodejs /usr/bin/node

  # Lest install google chrome
  apt-get install -y google-chrome-stable

  # Download and copy the ChromeDriver to /usr/local/bin
  cd /tmp
  wget "http://chromedriver.storage.googleapis.com/2.8/chromedriver_linux32.zip"
  wget "http://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar"
  unzip chromedriver_linux32.zip
  mv chromedriver /usr/local/bin
  mv selenium-server-standalone-2.39.0.jar /usr/local/bin
  chmod +x /usr/local/bin/chromedriver
  chmod +x /usr/local/bin/selenium-server-standalone-2.39.0.jar

  # Install mogoDB
  apt-get install -y mongodb-10gen

  # Install phantomJS
  apt-get install -y phantomjs

  # Download Strider
  cd /home/vagrant
  git clone https://github.com/Strider-CD/strider.git
  cd strider
  npm install

  # Loop back yalla.dev
  echo "127.0.0.1       yalla.dev" | tee -a /etc/hosts
  mkdir /home/vagrant/data/log 2>/dev/null

  # Copy some files
  chmod +x /home/vagrant/data/systemfiles/copy_files.sh
  source /home/vagrant/data/systemfiles/copy_files.sh

  echo 'source .prompt' >> /home/vagrant/.bashrc

  # Make sure that vagrant doesn't re-install everything
  touch /.installed
fi

echo "\n##    ##    ###    ##       ##          ###    "
echo " ##  ##    ## ##   ##       ##         ## ##   "
echo "  ####    ##   ##  ##       ##        ##   ##  "
echo "   ##    ##     ## ##       ##       ##     ## "
echo "   ##    ######### ##       ##       ######### "
echo "   ##    ##     ## ##       ##       ##     ## "
echo "   ##    ##     ## ######## ######## ##     ## \n"

# Start Xvfb, Chrome, and Selenium in the background
echo "Starting vnc4server ..."
service vncserver start
# nohup vnc4server > /home/vagrant/data/log/vnc4server.txt &
# nohup x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=${1:-1024x768x16} -gone 'killall Xvfb' -bg -nopw > /home/vagrant/data/log/x11vnc.txt &

echo "Starting Selenium with chrome and firefox..."
service selenium start
# cd /usr/local/bin
# export DISPLAY=:1
# nohup java -jar ./selenium-server-standalone-2.39.0.jar -Dwebdriver.chrome.driver='./chromedriver' > /home/vagrant/data/log/selenium.txt &

echo "Starting Strider..."
service strider start
# cd /home/vagrant/strider
# nohup node bin/strider > /home/vagrant/data/log/strider.txt &
