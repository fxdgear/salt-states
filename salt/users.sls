django:
  user.present:
    - shell: /bin/bash
    - home: /home/django
    - uid: 4000
    - gid: 4000
    - groups:
      - www-data

