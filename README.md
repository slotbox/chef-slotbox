# Bootstrapping OpenRuko

Chef recipes for bootstrapping [OpenRuko](https://github.com/openruko).

Both a Vagrantfile for running local development environments and a generic deploy script for generic VPSs

## Vagrant Install

To generate a new VirtualBox VM with OpenRuko and all its dependencies already installed.

```
$ sudo apt-get install vagrant
$ git clone https://github.com/openruko/chef-openruko.git
$ cd chef-openruko
$ vagrant up
# wait ...
```

## VPS Install

This has been tested on vanilla installs of Ubuntu 12.04 64bit. So fire up a remote instance then on your local machine;

```
$ git clone https://github.com/openruko/chef-openruko.git
$ cd chef-openruko
$ ./deploy.sh root@<host>
# wait ...
```

## Launch tests

The first usage of `Chef OpenRuko` was for testing openruko on a clean VM.

To launch the tests login to the server (`vagrant ssh` if your using Vagrant) and run:

```
$ sudo su - rukosan
[rukosan] $ cd /home/rukosan/openruko/integration-tests
[rukosan] $ ./run.sh
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
[rukosan] $ mkdir myapp
[rukosan] $ cd myapp
[rukosan] $ git init
[rukosan] $ npm init
[rukosan] $ cat > index.js << EOF
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
EOF

[rukosan] $ cat > Procfile << EOF
web: node index.js
EOF

[rukosan] $ git add -A
[rukosan] $ git commit -m 'fisrt commit'

[rukosan] $ ~/openruko/client/openruko create myapp
# email: openruko@openruko.com
# Password: rukosan

[rukosan] $ git push heroku master
[rukosan] $ curl 127.0.0.1:1337
```



