/etc/supervisord.conf:
  file.managed:
    - source: salt://files/supervisord.conf
    - user: root
    - group: root
    - mode: 644

/etc/supervisor/conf.d/celeryd.conf:
  file.managed:
    - source: salt://files/vagrant-celeryd.conf
    - makedirs: True


/etc/apache2/sites-enabled/vagrant.conf:
  file.symlink:
    - target: /home/vagrant/mysite.com/src/myproject/apache/vagrant.conf

/home/vagrant/mysite.com/lib/python2.7/site-packages/_virtualenv_path_extensions.pth:
  file.managed:
    - source: salt://files/_virtualenv_path_extensions.pth
    - user: root
    - group: root

/home/vagrant/.aliases:
  file.managed:
    - source: salt://files/aliases
    - user: vagrant
    - group: vagrant

/home/vagrant/.bashrc:
  file.append:
    - text:
      - source /home/vagrant/.aliases
  cmd.run:
    - name: source /home/vagrant/.bashrc


/usr/lib/libz.so:
  file.symlink:
    - target: /usr/lib/x86_64-linux-gnu/libz.so

/usr/lib/libfreetype.so:
  file.symlink:
    - target: /usr/lib/x86_64-linux-gnu/libfreetype.so

/usr/lib/libjpeg.so:
  file.symlink:
    - target: /usr/lib/x86_64-linux-gnu/libjpeg.so
