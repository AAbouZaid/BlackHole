#!/bin/bash

if [ "`whoami`" != "root" ]
then
    echo "Must run as root"
    exit 1
fi

PIP=`which pip`

if [ "$PIP" != "" ]
then
    echo "IMPORTANT: You will need the python headers and gcc to install some of the dependencies. If you don't have them, install them first"
    echo "ubuntu/debian: build-essential, python-dev"
    echo "Press any key...or cancel with control C"
    read
    BLACKHOLE_PATH="/opt/BlackHole"
    export INSTALL="$PIP install --upgrade"
    echo "Installing dependencies ..."
    $INSTALL django=="1.5"
    $INSTALL paramiko
    $INSTALL urwid
    $INSTALL simplejson
    $INSTALL django-qsstats-magic
    $INSTALL python-dateutil
    echo "READ: The installer wont install MySQLdb, because maybe you want to use some other engine. If you want to use Mysql, Install MySQLdb!!"
    echo "Installing app in $BLACKHOLE_PATH ..."
    mkdir $BLACKHOLE_PATH
    cp -rf apache $BLACKHOLE_PATH
    cp -rf blackhole $BLACKHOLE_PATH
    cp launcher/* $BLACKHOLE_PATH
    echo "Creating group ..."
    groupadd blackhole
	echo "Next steps ..."
	echo "1. Create the database (name: blackhole) and a user/password (whatever you like)."
	echo "2. Add the user/password you've created to $BLACKHOLE_PATH/blackhole/black_hole/settings.py in the DATABASES section"
	echo "3. Create the tables with: $BLACKHOLE_PATH/blackhole/manage.py syncdb"
	echo "4. Add some initial configuration with: $BLACKHOLE_PATH/blackhole/manage.py initial_setup"
	echo "5. Set the path where you want to save the session logs (make shure that the group 'blackhole' has write permissions!!!) in $BLACKHOLE_PATH/blackhole.config"
	echo "6. Configure the web server. If you use apache you can use this example ($BLACKHOLE_PATH/apache/blackhole.conf.example), is ready to use. Remember to enable the port 8080."
    echo "7. That's all. Enter to the web (http://x.x.x.x:8080/blackhole/index/) and create all the configurations!!"
	echo "8. Remember to set $BLACKHOLE_PATH/blackhole_launcher.py as the shell for all the users. And set 'blackhole' as their group"
else
    echo "You need pip in your $PATH"
    exit 1
fi
