# Bootstrapping OpenRuko
[![Build Status](https://travis-ci.org/openruko/vagrant-openruko.png)](https://travis-ci.org/openruko/vagrant-openruko)

Chef recipes for bootstrapping [OpenRuko](https://github.com/openruko).

Both a Vagrantfile for running local development environments and a generic deploy script for generic VPSs

## Vagrant Install

To generate a new VirtualBox VM with OpenRuko and all its dependencies already installed.

```
$ sudo apt-get install vagrant
$ git clone https://github.com/openruko/vagrant-openruko.git
$ cd vagrant-openruko
$ vagrant up
# wait ...
```

## VPS Install

This has been tested on vanilla installs of Ubuntu 12.04 64bit. So fire up a remote instance then on your local machine;

```
$ git clone https://github.com/openruko/vagrant-openruko.git
$ cd vagrant-openruko
$ ./deploy.sh root@<host>
# wait ...
```

## Launch tests

Login to the server (vagrant ssh) and run

```
$ cd ~/openruko/integration-tests
$ ./run.sh
```

See also [integration-tests](https://github.com/openruko/integration-tests)

## Standalone usage

If you are under a proxy, export the following environment variable in the host machine:

```
export HTTP_PROXY=http://proxy.xxx:3128
export HTTPS_PROXY=http://proxy.xxx:3128
export NO_PROXY=localhost
```

Connect to the server with SSH, and create a new project (we will use node.js)

```
$ mkdir myapp
$ cd myapp
$ git init
$ npm init
$ cat > index.js << EOF
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
EOF

$ cat > Procfile << EOF
web: node index.js
EOF

$ git add -A
$ git commit -m 'fisrt commit'

$ ~/openruko/client/openruko create myapp
# email: openruko@openruko.com
# Password: rukosan

$ git push heroku master
$ curl 127.0.0.1:1337
```

