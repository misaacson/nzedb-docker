# Build & Run Instructions

You'll need to have a functional docker install. From the project directory

```
$ docker-compose up -d
```

The memcached & percona images will get pulled down from Dockerhub and the nzedb container will build. This will take some time depending on your computer, connection speed, direction of wind, etc. Once its complete you'll see the 3 containers initialize. Type the following to confirm everything is peachy.

```
$ docker-compose ps
         Name                        Command               State           Ports         
----------------------------------------------------------------------------------------
nzedbdocker_memcached_1   docker-entrypoint.sh memcached   Up      11211/tcp             
nzedbdocker_mysql_1       docker-entrypoint.sh mysqld      Up      3306/tcp              
nzedbdocker_nzedb_1       apache2-foreground               Up      0.0.0.0:8080->80/tcp
```

The system is now accessible via browser on localhost via the mapped port, currently configured as 8080.

```
http://localhost:8080
```

You will be greeted with the nzedb install screen. It will walk you through initial setup. Click the button on the bottom to continue.

![setup](/images/setup-install.png)

Page 1 is the system check. Everything in the status column should be a green ok. click continue at the bottom of the page.

![setup](/images/setup-step1-1.png)

Page 2 is the database information. Enter the information as shown in the picture.

![setup](/images/setup-step2-1.png)

on clicking next you get confirmation that its setup correctly. Continue to step 3

![setup](/images/setup-step3-1.png)

the certs are pulled as part of the docker build and the suggested default are valid.

![setup](/images/setup-step3-2.png)

Continue to step 4.

![setup](/images/setup-step4-1.png)

You'll need an account from a USENET providers. I've happily been using [Giganews](https://www.giganews.com) for many years.

![setup](/images/setup-step4-2.png)

Almost done, save everything.

![setup](/images/setup-step5-1.png)

Setup your admin user using whatever values you like.

![setup](/images/setup-step6-1.png)

Continue to setup paths

![setup](/images/setup-step7-1.png)

the defaults are fine, continue

![setup](/images/setup-step7-2.png)

Done. Continue to the admin page

![setup](/images/setup-done.png)

The basic site setup is completed but more configuration is necessary before anything useful will happen. The [nzedb wiki](https://github.com/nZEDb/nZEDb/wiki) explains further steps.
