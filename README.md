Yalla
=====

Vagrant setup for [selenium](http://docs.seleniumhq.org/), [strider](https://github.com/Strider-CD/strider) and vnc 

### Installation
```
# Virtualbox and vagrant are required. eg. brew cask install virtualbox vagrant
git clone https://github.com/tjoskar/yalla.git
cd yalla
vagrant up
```

Add ``` 192.168.33.10 yalla.dev ``` to your host file.

### Selenium
Using firefox and google chrome.  
Available at:  
```
http://127.0.0.1:4444/wd/hub  
http://yalla.dev:3000/wd/hub
```

### Strider
Available at: ``` http://yalla.dev:3000 ```   
Eg. config for https://github.com/tjoskar/Simple-task   
Test:
```
grunt test
python tasks.py &
sleep 5
python -m unittest discover
kill $!
```

Cleanup:
```
# Bug?
rm -fr /home/vagrant/.strider/.venv
```

Install ``` grunt-cli ``` global and run ``` pip install -r requirements.txt ```

### Vnc
Available at: ``` yalla.dev:5901 ```  
password: ``` 123456 ```
