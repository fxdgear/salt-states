include:
  - files
  - python

# pkg.latest
# service.running
mod_wsgi:
  pkg:
    - installed
    - name: libapache2-mod-wsgi

apache_log:
  file.managed:
    - name: /var/log/apache2/mysite.com/error.log
    - user: vagrant

remove_existing_conf:
  file.absent:
      - name: /etc/apache2/sites-enabled/000-default

/etc/apache2/mods-enabled/ssl.load:
  file.symlink:
    - target: /etc/apache2/mods-available/ssl.load

/etc/apache2/mods-enabled/ssl.conf:
  file.symlink:
    - target: /etc/apache2/mods-available/ssl.conf

/etc/apache2/mods-enabled/rewrite.load:
  file.symlink:
    - target: /etc/apache2/mods-available/rewrite.load

httpd:
  pkg:
    - installed
    - name: apache2
  service:
    - running
    - name: apache2
    - enable: True
    - require:
      - pkg: mod_wsgi


date > /tmp/started_apache:
  cmd:
    - wait
    - watch:
      - service: httpd

restart-apache:
  cmd.run:
    - name: /etc/init.d/apache2 restart
    - require:
      - file: /etc/apache2/mods-enabled/ssl.load
      - file: /etc/apache2/mods-enabled/ssl.conf
      - file: /etc/apache2/mods-enabled/rewrite.load
      - file: /etc/apache2/sites-enabled/vagrant.conf
      - virtualenv: /home/vagrant/mysite.com

