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
  apt-get install -y python-software-properties python g++ make python-pip python-virtualenv openjdk-7-jre unzip git-core python-dev libmysqlclient-dev python-mysqldb
  apt-get install -y x11vnc xvfb vnc4server fluxbox firefox

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

  echo 'Lets install nodejs'
  apt-get install -y nodejs

  echo 'Create a (soft) link to avoid conflicts'
  [ -f /usr/local/bin/node ] && mv /usr/local/bin/node /usr/local/bin/node_old
  [ -f /usr/bin/node ] && mv /usr/bin/node /usr/bin/node_old
  ln -s /usr/bin/nodejs /usr/bin/node

  echo 'Lest install google chrome'
  apt-get install -y google-chrome-stable

  echo 'Download and copy the ChromeDriver to /usr/local/bin'
  cd /tmp
  wget "http://chromedriver.storage.googleapis.com/2.8/chromedriver_linux32.zip"
  wget "http://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar"
  unzip chromedriver_linux32.zip
  mv chromedriver /usr/local/bin
  mv selenium-server-standalone-2.39.0.jar /usr/local/bin
  chmod +x /usr/local/bin/chromedriver
  chmod +x /usr/local/bin/selenium-server-standalone-2.39.0.jar

  echo 'Install mogoDB'
  apt-get install -y mongodb-10gen

  echo 'Install phantomJS'
  apt-get install -y phantomjs

  echo 'Download Strider'
  cd /home/vagrant
  git clone https://github.com/Strider-CD/strider.git
  cd strider
  npm install

  echo 'Loop back yalla.dev'
  echo "127.0.0.1       yalla.dev" | tee -a /etc/hosts
  mkdir -p /home/vagrant/data/log

  echo 'Copy some files'
  mkdir -p /home/vagrant/.vnc
  chmod +x /home/vagrant/data/systemfiles/copy_files.sh
  /home/vagrant/data/systemfiles/copy_files.sh

  grep -q -e 'source .prompt' /home/vagrant/.bashrc || echo 'source .prompt' >> /home/vagrant/.bashrc

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

echo "Starting Selenium with chrome and firefox..."
service selenium start

echo "Starting Strider..."
service strider start
