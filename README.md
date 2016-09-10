# SETUP

## Mac OSX

# https://www.rabbitmq.com/install-homebrew.html
```
brew update
brew install rabbitmq
echo "PATH=$PATH:/usr/local/sbin" >> ~/.bash_profile
```


## Editing .conf

# http://www.rabbitmq.com/configure.html
```
# /usr/local/etc/rabbitmq/rabbitmq-env.conf
CONFIG_FILE=/usr/local/etc/rabbitmq/rabbitmq
NODE_IP_ADDRESS=127.0.0.1
NODENAME=rabbit@localhost
```


## Starting

```
ulimit -S -n 4096
brew services start rabbitmq
```

### To have launchd start rabbitmq now and restart at login:
```
brew services start rabbitmq
```

### Or, if you don't want/need a background service you can just run:
```
rabbitmq-server
```


## Management Plugin

#### https://www.rabbitmq.com/management.html
URL: http://localhost:15672

guest:guest
