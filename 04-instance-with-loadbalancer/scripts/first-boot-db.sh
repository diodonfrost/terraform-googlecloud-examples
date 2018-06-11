#!/bin/bash

echo "hello world" >> /tmp/hello.txt

apt update
apt install mariadb-server -y
systemctl start mysql
systemctl enable mysql
