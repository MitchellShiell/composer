#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to create a single PostgreSQL database.
function create_database() {
    local database=$1
    echo "Creating database '$database'"
    
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
        CREATE DATABASE $database;
EOSQL
}

# Iterate over each database name specified in the POSTGRES_MULTIPLE_DATABASES environment variable.
for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr "," "\n"); do
    create_database $db
done