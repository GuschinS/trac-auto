#!/bin/bash
apt-get update
apt-get upgrade -y
apt-get install wget
apt install net-tools
apt-get install unzip -y
apt-get install unzip default-jre mysql-server -y
/ Not required in actual script
MYSQL_ROOT_PASSWORD=50ycBFsr4emxwB#w
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"
 mysql -u root -p50ycBFsr4emxwB#w -e "create database traccar"
  mysql -u root -p50ycBFsr4emxwB#w -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY '50ycBFsr4emxwB#w'"
  mysql -u root -p50ycBFsr4emxwB#w -e "GRANT ALL PRIVILEGES ON traccar.* TO admin@localhost"
wget https://www.traccar.org/download/traccar-linux-64-latest.zip
unzip traccar-linux-*.zip && ./traccar.run
cat > /opt/traccar/conf/traccar.xml << EOF
<?xml version='1.0' encoding='UTF-8'?>

<!DOCTYPE properties SYSTEM 'http://java.sun.com/dtd/properties.dtd'>

<properties>

    <entry key="config.default">./conf/default.xml</entry>
	<entry key='web.port'>80</entry>

    <entry key='database.driver'>com.mysql.jdbc.Driver</entry>
    <entry key='database.url'>jdbc:mysql://localhost/traccar?allowPublicKeyRetrieval=true&amp;useSSL=false&amp;serverTimezone=UTC&amp;useSSL=false&amp;allowMultiQueries=true&amp;autoReconnect=true&amp;useUnicode=yes&amp;characterEncoding=UTF-8&amp;sessionVariables=sql_mode=''</entry>
    <entry key='database.user'>admin</entry>
    <entry key='database.password'>50ycBFsr4emxwB#w</entry>

</properties>
EOF
service traccar start
