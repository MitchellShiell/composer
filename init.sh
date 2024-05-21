#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to create a single PostgreSQL database.
function create_database() {
    # Use the first argument passed to the function as the database name.
    local database=$1
    
    # Print a message indicating the start of the database creation process.
    echo "Creating database '$database'"
    
    # Execute the SQL command to create the database using psql.
    # The -v ON_ERROR_STOP=1 option ensures that the script stops if there's an error.
    # The --username "$POSTGRES_USER" specifies the PostgreSQL user to connect as.
    # The <<-EOSQL syntax starts a heredoc block where the SQL command is written.
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
        CREATE DATABASE $database;
EOSQL
}

# Iterate over each database name specified in the POSTGRES_MULTIPLE_DATABASES environment variable.
# This variable is expected to contain a comma-separated list of database names.
for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr "," "\n"); do
    # Call the create_database function for each database name.
    create_database $db
done