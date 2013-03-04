python-pkgs:
  pkg:
    - installed
    - names:
      - python-pip
      - python-dev
      - build-essential
      - python-imaging

virtualenvwrapper:
  pip.installed:
    - require:
      - pkg: python-pkgs


/home/vagrant/mysite.com:
  virtualenv.managed:
    - no_site_packages: True
    - distribute: True
    - cwd: /home/vagrant/mysite.com
    - requirements: /home/vagrant/mysite.com/src/myproject/requirements.txt
    - require:
        - pkg: python-pkgs



