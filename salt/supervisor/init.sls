include:
  - python
  - files

/var/log/celery/myproject.log:
  file.managed:
    - name: /var/log/celery/myproject.log
    - user: root
    - mode: 755
    - makedirs: True

supervisor:
  pip.installed:
    - name: supervisor
    - require:
      - pkg: python-pkgs

/etc/init.d/supervisord:
  file.managed:
    - source: salt://files/supervisord.sh
    - makedirs: True
    - mode: 755
  cmd.run:
    - name: sudo service supervisord restart
    - require:
      - pip.installed: supervisor
      - file: /etc/init.d/supervisord



