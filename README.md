# nzedb-docker

Docker & compose files to get an [nzedb](https://github.com/nZEDb/nZEDb) environment up & running easily. Due to all the media package dependencies the resulting container size is a fairly portly 1.3G er so. This configuration is fairly useless for a real system (read: NO TUNING) but for just playing around or running a few groups its fine.

Installation instructions are [here](INSTALL.md)

# Notes

Tmux & screen are both installed, in order for them to work reliably /dev/pts needs to be mounted in the nzedb container. Launching them from outside the container is relatively simple, i.e.

```
docker-compose exec nzedb screen sh /var/www/nzedb/misc/update/nix/screen/sequential/simple.sh
<detach>
docker-compose exec nzedb screen -R
```

or

```
docker-compose exec nzedb php /var/www/nzedb/misc/update/nix/tmux/start.php
<detach>
docker-compose exec nzedb tmux attach
```
