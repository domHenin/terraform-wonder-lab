#!/bin/bash

sudo yum -y install mysql-server
sudo systemctl status mysql && mysql -uroot -p