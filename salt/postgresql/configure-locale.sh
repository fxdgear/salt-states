export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
pg_dropcluster --stop 9.1 main
pg_createcluster --start -e UTF-8 9.1 main
