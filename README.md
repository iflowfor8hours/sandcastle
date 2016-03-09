Sandcastle
=========

Secure by default Sandstorm installation with nginx reverse proxy and base
Debian setup.

**Status**: alpha, initial release, not to be depended on :)

Requirements
------------

Root access to a Debian Jessie installation.

A wildcard TLS certificate. (must be copied to the box before this role runs, see [test.yml](test.yml))

Role Variables
--------------

### Sandstorm

* **sandstorm_hostname**: defaults to `{{ansible_fqdn}}`
* **sandstorm_wildcard_host**: defaults to
  `*.{{sandstorm_hostname}}`, lets us change `WILDCARD_HOST` in
  `sandstorm.conf`
* **sandstorm_port**: defaults to `6080`
* **sandstorm_dev_accounts**: defaults to `"false"`, set to `"yes"` to enable
  (note: must be the string "yes", with quotes)
* **sandstorm_verify_installer**: defaults to `false`, set to
  `true` to enable gpg verification of sandstorm installer
* **sandstorm_onion**: defaults to `false` for now. still work in progress

### SSH

* **ssh_onion**: defaults to `true`. only allow ssh access through
  a tor hidden service (tor and ssh client setup required, see
  https://stribika.github.io/2015/01/04/secure-secure-shell.html#traffic-analysis-resistance)
* **ssh_debug**: defaults to `false`. always bind ssh to `0.0.0.0`, even if ssh_onion is `true`

### Nginx

* **ssl_certificate_path**: path provided to the nginx ssl_certificate config value
* **ssl_certificate_key_path**: path provided to the nginx ssl_certificate_key config value
* **ssl_trusted_certificate_path**: path provided to the nginx ssl_trusted_certificate config value

See the [nginx configuration
docs](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_certificate)
for details on the SSL fields.

### Backups

* **backup_target**: backup target for `duplicity` (see the [duplicity
  docs](http://duplicity.nongnu.org/duplicity.1.html#sect7))
* **backup_target_password**: if your backup target needs a password
* **backup_encryption_key_id**: the key id of the gpg key to use to encrypt backups
* **backup_signing_key_id**: the key id of the gpg key to use to sign backups
* **backup_hour**: hour of the day to run the backup
* **backup_minute**: minute of the hour to run the backup
* **backup_max_age**: delete backups older than this. a full
  backup will also be performed at this interval to insure that
  files older than this are not kept around due to subsequent
  incremental backups. see the `TIME FORMATS` section of `man
  duplicity` for documentation on the format

See `test/gen-duplicity-keys.sh` for an example of generating the backup keys.

### Centralized logging
* **elasticsearch_addresses**: A list of addresses to the ES clusters intended
to receive logs. Can be specified as a URI or IP:PORT
* **filebeat_prospectors**: A list of hashes containing the path to the file(s)
to be logged, and the `document_type` for ES indexing
* **filebeat_ssl_enabled**: enable ssl configuration for filebeat client; if
this is set to false, the following variables are ignored
* **filebeat_certificate_path**: certificate for TLS client authentication
* **filebeat_certificate_key_path**: client Certificate Key
* **filebeat_certificate_authorities**: list of root certificates for HTTPS
server verifications

See `test/gen-filebeat-keys.sh` for an example of generating the filebeat keys.

### Other

* **firewall_allowed_tcp_ports**: defaults to `[80, 443]`. add
  `22` if you want to ssh directly instead of through Tor

* **enable_mta**: defaults to `"false"`, set to true to install
  and configure exim4. if left `false` we ensure that exim4 is
  stopped and remove it. Do not enable if you are using `sandstorm_onion`.
  First, doing so would expose the IP address of your server and second, when
  the Sandstorm hidden service is enabled DNS queries are routed through Tor,
  which does not return MX records. 


Dependencies
------------

* jnv.unattended-upgrades
* geerlingguy.firewall
* hardening.os-hardening

Example Playbook
----------------

See [test.yml](test.yml)

You can see `test.yml` in action with Vagrant:

* `ansible-galaxy install -r requirements.yml`
* `./test/gen-duplicity-keys.sh`
* `./test/gen-test-cert.sh`
* `./test/gen-filebeat-cert.sh`
* Add `test/rootCA.pem` to your browsers trusted authorities list (**note!**
  while this is added to your browser anyone with access to rootCA.key will be
  able to compromise your TLS connections)
* `vagrant up`
* Navigate to https://sandstorm.172.19.22.22.xip.io/

License
-------

MIT

Author Information
------------------

* Matt Urbanski (iflowfor8hours)
* Charlie Austin (charltonaustin)
* Jack Singleton (jacksingleton)
* Vladimir Zelmanov (vzelmanov)
