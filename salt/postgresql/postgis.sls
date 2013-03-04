include:
  - postgresql

postgis-packages:
  pkg.installed:
    - names:
      - postgis
      - postgresql-9.1-postgis
      - libgdal-dev
    - require:
      - pkg: postgresql

postgis-template:
  file.managed:
    - name: /etc/postgresql/9.1/main/postgis_template.sh
    - source: salt://postgresql/create_template_postgis-debian.sh
    - user: postgres
    - group: postgres
    - mode: 755
  cmd.run:
    - name: bash /etc/postgresql/9.1/main/postgis_template.sh
    - user: postgres
    - cwd: /var/lib/postgresql
    - unless: psql -U postgres -l|grep template_postgis
    - require:
      - pkg: postgis-packages
      - file: postgis-template
      - pkg: postgresql
      - cmd: /var/lib/postgresql/configure_utf-8.sh

django-user:
  cmd.run:
    - name: psql -c "CREATE ROLE django SUPERUSER LOGIN PASSWORD 'rat8me'"
    - user: postgres
    - unless: psql -U postgres -c 'SELECT rolname FROM pg_roles;'|grep "vagrant"
    - require:
      - cmd: /var/lib/postgresql/configure_utf-8.sh

vagrant-user:
  cmd.run:
    - name: psql -c "CREATE ROLE vagrant SUPERUSER LOGIN"
    - user: postgres
    - unless: psql -U postgres -c 'SELECT rolname FROM pg_roles;'|grep "vagrant"
    - require:
      - cmd: /var/lib/postgresql/configure_utf-8.sh

myproject-db:
    postgres_database.present:
    - name: myproject
    - runas: postgres
    - template: template_postgis
    - require:
      - cmd: django-user
      - cmd: postgis-template

