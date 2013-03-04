postgresql:
  pkg:
    - installed
  service.running:
    - enable: True

/var/lib/postgresql/configure_utf-8.sh:
  cmd.run:
    - name: bash /var/lib/postgresql/configure_utf-8.sh
    - user: postgres
    - cwd: /var/lib/postgresql
    - unless: psql -U postgres template1 -c 'SHOW SERVER_ENCODING'|grep "UTF8"
    - require:
      - pkg: postgresql
      - file: /var/lib/postgresql/configure_utf-8.sh

  file.managed:
    - name: /var/lib/postgresql/configure_utf-8.sh
    - source: salt://postgresql/configure-locale.sh
    - user: postgres
    - group: postgres
    - mode: 755

postgres-pkgs:
  pkg:
    - installed
    - names:
      - postgresql-client
      - postgresql-contrib
      - pgadmin3
      - postgresql-server-dev-9.1
    - require:
      - file: /var/lib/postgresql/configure_utf-8.sh

django-db:
    postgres_database.present:
    - name: django
    - runas: postgres
    - require:
      - cmd: /var/lib/postgresql/configure_utf-8.sh

vagrant-db:
    postgres_database.present:
    - name: vagrant
    - runas: postgres
    - require:
      - cmd: /var/lib/postgresql/configure_utf-8.sh
