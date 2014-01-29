Yalla
=====

Vagrant setup for [selenium](http://docs.seleniumhq.org/), [strider](https://github.com/Strider-CD/strider) and vnc 

### Installation
```bash
# Install virtualbox and vagrant, eg. brew cask install virtualbox vagrant
clone https://github.com/tjoskar/yalla.git
cd yalla
vagrant up
```

Add:
```bash
192.168.33.10 yalla.dev
```
to your host file.

### Selenium
Using firefox and google chrome
Available at:
http://127.0.0.1:4444/wd/hub
http://yalla.dev:3000/wd/hub

### Strider
Available at:
http://yalla.dev:3000

### Vnc
Available at:
yalla.dev:5901
password:
```bash
123456
```
