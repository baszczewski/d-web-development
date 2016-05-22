#!/bin/bash

InstallDatabase()
{
    echo "=> install db"
    sudo mysql_install_db

    # allow access
    sudo chmod -R 777 /db

    # init variables
    USER=${MARIADB_USER:-root}
    
    if [ "$MARIADB_PASS" = "**Random**" ]; then
        unset MARIADB_PASS
    fi

    PASS=${MARIADB_PASS:-$(pwgen -s 12 1)}

    # start database server
    sudo service mysql start

    # now db is available
    echo "=> db is running"
    
    # create main user
    echo "=> creating MySQL user ${USER} with ${PASS} password"
    sudo /usr/bin/mysql -uroot -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS'"
    sudo /usr/bin/mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION"

    # stop database server
    echo "=> stop db"
    sudo service mysql stop
}

StartMySQL()
{
    # if database is not instaled
    if [ ! -d /db/mysql ]; then
        InstallDatabase
    fi

    # start mysql server
    sudo service mysql start
}

StartApache()
{
    sudo service apache2 start
}

StartPHP()
{
    # setup phpinfo    
    if [ ! -d /www/phpinfo ]; then
        mkdir /www/phpinfo
        cp /tmp/phpinfo.php /www/phpinfo/index.php
    fi
    
    # setup phpmyadmin
    if [ ! -d /www/phpmyadmin ]; then
        cd /www
        composer create-project phpmyadmin/phpmyadmin --repository-url=https://www.phpmyadmin.net/packages.json --no-dev
    fi
}

StartMySQL
StartApache
StartPHP

# bash
/bin/bash