Sandstorm Base
=========

Secure by default Sandstorm installation with nginx reverse proxy and base
Debian setup.

Status: alpha, initial release, not to be depended on :)

Requirements
------------

Root access to a Debian Jessie installation.

A wildcard TLS certificate.

Role Variables
--------------

sandstorm_hostname: defaults to {{ansible_fqdn}}
sandstorm_port: defaults to 6080

ssl_certificate_path: path provided to the nginx ssl_certificate config value
ssl_certificate_key_path: path provided to the nginx ssl_certificate_key config value
ssl_trusted_certificate_path: path provided to the nginx ssl_trusted_certificate config value

See the [nginx configuration
docs](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_certificate)
for details on these fields.

Dependencies
------------

jnv.unattended-upgrades
geerlingguy.firewall

Example Playbook
----------------

See [test.yml](test.yml)

You can test this role with Vagrant:

```
$ ansible-galaxy install -p dependencies -r requirements.txt
$ vagrant up
Navigate to https://sandstorm.io.vagrant.dev
```

License
-------

MIT

Author Information
------------------

Matt Urbanski <iflowfor8hours>
Charlie Austin <charltonaustin>
Jack Singleton <jacksingleton>

