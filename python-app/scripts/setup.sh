#!/bin/bash

SEPARATOR='=================='
export PGPASSWORD='password'

echo "$SEPARATOR  Setup Demo: Docker, PostgreSQL with single-node Citus on port 5500 $SEPARATOR"
docker run -d --name citus_coordinator -p 5432:5432 -e POSTGRES_PASSWORD=$PGPASSWORD citusdata/citus

echo "$SEPARATOR Testing Citus Version $SEPARATOR"
psql -U postgres -h localhost -d postgres -c "SELECT * FROM citus_version();"

echo "$SEPARATOR Creating Database $SEPARATOR"
#psql -U postgres -h localhost -c "CREATE DATABASE startup;"
psql -U postgres -h localhost -f data.sql

echo "$SEPARATOR Copy database files into Docker container $SEPARATOR"
docker cp companies.csv citus_coordinator:.
docker cp campaigns.csv citus_coordinator:.
docker cp ads.csv citus_coordinator:.

echo "$SEPARATOR Populating data into companies, campaigns and ads tables $SEPARATOR"
psql -U postgres -h localhost -d postgres -c "\copy companies from 'companies.csv' with csv;"
psql -U postgres -h localhost -d postgres -c "\copy campaigns from 'campaigns.csv' with csv;"
psql -U postgres -h localhost -d postgres -c "\copy ads from 'ads.csv' with csv;"

echo "$SEPARATOR List Data $SEPARATOR"
psql -U postgres -h localhost -d postgres -t -A -c  "SELECT * FROM companies LIMIT 10;"
psql -U postgres -h localhost -d postgres -t -A -c "SELECT * FROM campaigns LIMIT 10;" 
psql -U postgres -h localhost -d postgres -t -A -c "SELECT * FROM ads LIMIT 10;"