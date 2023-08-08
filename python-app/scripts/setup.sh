#!/bin/bash

SEPARATOR='=================='
export PGPASSWORD='password'

echo "$SEPARATOR  Setup Demo: Docker, PostgreSQL with single-node Citus on port 5500 $SEPARATOR"
sudo docker run -d --name citus_coordinator -p 5432:5432 -e POSTGRES_PASSWORD=$PGPASSWORD citusdata/citus

sleep 10

echo "Installing PostgreSQL Client"
sudo apt-get install postgresql-client

echo "$SEPARATOR Testing Citus Version $SEPARATOR"
psql -U postgres -h localhost -d postgres -c "SELECT * FROM citus_version();"

echo "$SEPARATOR Creating Database $SEPARATOR"
#psql -U postgres -h localhost -c "CREATE DATABASE startup;"
psql -U postgres -h localhost -f ../sql/data.sql

#echo "$SEPARATOR Copy database files into Docker container $SEPARATOR"
#sudo docker cp ../csv/companies.csv citus_coordinator:.
#sudo docker cp ../csv/campaigns.csv citus_coordinator:.
#sudo docker cp ../csv/ads.csv citus_coordinator:.

echo "$SEPARATOR Populating data into companies, campaigns and ads tables $SEPARATOR"
psql -U postgres -h localhost -d postgres -c "\copy companies from '../csv/companies.csv' with csv;"
psql -U postgres -h localhost -d postgres -c "\copy campaigns from '../csv/campaigns.csv' with csv;"
psql -U postgres -h localhost -d postgres -c "\copy ads from '../csv/ads.csv' with csv;"

echo "$SEPARATOR List Data $SEPARATOR"
psql -U postgres -h localhost -d postgres -t -A -c  "SELECT * FROM companies LIMIT 10;"
psql -U postgres -h localhost -d postgres -t -A -c "SELECT * FROM campaigns LIMIT 10;" 
psql -U postgres -h localhost -d postgres -t -A -c "SELECT * FROM ads LIMIT 10;"