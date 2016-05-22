baszczewski-web-development
==================

Webserver, database, npm and other cool stuff.

Usage
-----

To create the image `baszczewski/web-development`, execute the following command on the folder:

	docker build -t baszczewski/web-development .

Running
------------------------------

docker run -it -p 80:80 -p 3306:3306 -p 4040:4040 -e 'MARIADB_USER=test' -e 'MARIADB_PASS=test' -v /home/user/www:/www -v /home/user/db:/db baszczewski/web-development