#!/bin/bash
################################################################################
# Script for installing Postgres on Ubuntu 16.04, 18.04, 20.04 and 22.04 (could be used for other version too)
# Author: Phu Dang Kim
#-------------------------------------------------------------------------------
# This script will install Postgres on your Ubuntu server.
# Seperate Odoo server and Database PostgreSQL server and Nginx server.
#-------------------------------------------------------------------------------
# Make a new file:
# sudo nano db-install.sh
# Place this content in it and then make the file executable:
# sudo chmod +x db-install.sh
# Execute the script to install Odoo:
# ./db-install
################################################################################

#--------------------------------------------------
# Install PostgreSQL Server
#--------------------------------------------------
OE_USER="odoo"
PASSWORD="odoo"
INSTALL_POSTGRESQL_FOURTEEN = "False"
echo -e "\n---- Install PostgreSQL Server ----"
if [ $INSTALL_POSTGRESQL_FOURTEEN = "True" ]; then
    echo -e "\n---- Installing postgreSQL V14 due to the user it's choise ----"
    sudo curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    sudo apt-get update
    sudo apt-get install postgresql-16
else
    echo -e "\n---- Installing the default postgreSQL version based on Linux version ----"
    sudo apt-get install postgresql postgresql-server-dev-all -y
fi

#--------------------------------------------------
# Creat User For Odoo
#--------------------------------------------------
echo -e "\n---- Creating the ODOO PostgreSQL User  ----"
sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true
sudo su - postgres -c "psql -c \"ALTER USER $OE_USER WITH PASSWORD '$PASSWORD';\"" 2> /dev/null || true