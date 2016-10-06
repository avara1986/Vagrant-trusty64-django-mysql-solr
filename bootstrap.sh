#!/bin/bash
if ! [ -L /home/vagrant/web ]; then
  rm -rf /home/vagrant/web
  ln -fs /vagrant/web /home/vagrant/web
fi
PROJECT_DIR=/home/vagrant/web
USER_HOME=/home/vagrant/

echo "Environment installation is beginning. This may take a few minutes.."

##
#	Install core components
##

echo "Updating package repositories.."
apt-get update

echo "Installing required packages.."
apt-get -y install git

echo "Installing and upgrading pip.."
apt-get -y install python-setuptools
easy_install -U pip

echo "Installing required packages for NFS file sharing for vagrant.."
apt-get -y install nfs-common


##
#   Setup the database
##

echo "Installing required packages for mysql.."
debconf-set-selections <<< 'mysql-server mysql-server/root_password password ROOTPASSWORD'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ROOTPASSWORD'
apt-get install -y mysql-server 2> /dev/null
apt-get install -y mysql-client 2> /dev/null

if [ ! -f /var/log/dbinstalled ];
then
    echo "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'test1234'" | mysql -uroot -pROOTPASSWORD
    echo "CREATE DATABASE vagrant" | mysql -uroot -pROOTPASSWORD
    echo "GRANT ALL ON vagrant TO 'vagrant'@'localhost'" | mysql -uroot -pROOTPASSWORD
    echo "flush privileges" | mysql -uroot -pROOTPASSWORD
    touch /var/log/dbinstalled
    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -pROOTPASSWORD internal < /vagrant/data/initial.sql
    fi
fi

echo "Installing JDK"
wget --no-check-certificate https://github.com/aglover/ubuntu-equip/raw/master/equip_java7_64.sh && bash equip_java7_64.sh


echo "Installing python dependencies"
apt-get install -y libmysqlclient-dev

echo "Installing required packages for python ..."
apt-get install -y python-dev python-pip

echo "Installing Solr ..."
curl -LO https://archive.apache.org/dist/lucene/solr/4.10.2/solr-4.10.2.tgz
tar xvzf solr-4.10.2.tgz
touch solr-4.10.2/example/logs/solr.log
chmod 777 solr-4.10.2/example/logs/solr.log
cp web/schema.xml solr-4.10.2/example/solr/collection1/conf/schema.xml
solr-4.10.2/bin/solr start


echo "Installing virtualenvwrapper from pip.."
pip install virtualenvwrapper

##
#	Setup virtualenvwrapper
##
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ${USER_HOME}/.bashrc

##
#	Setup virtualenv
##
echo "Install the virtual environment.."
sudo su - vagrant /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh;cd ${PROJECT_DIR};mkvirtualenv --python=`which python2.7` vweb; deactivate;"

##
#	Setup is complete.
##
echo ""
echo "The environment has been installed."
echo ""
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo ""
exit 0