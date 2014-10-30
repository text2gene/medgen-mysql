#!/bin/bash

set -e

export TODAY="$(date +%F)"
export BATCH="$TODAY" 

####################
DB_USER=umls 
DB_PASS=umls
DB_HOST="localhost" 
DB_PORT="3306"  
#DB_LOCK="--skip-lock-tables"
DB_LOCK=""
####################

export DB_NAME=$1 
export DB_TABLE=$2

# require $DB_NAME   "which database?" 

if [ "$#" -lt 2 ]; then 
    export DB_FILE="$DB_NAME.$TODAY.mysqldump"
else
    export DB_FILE="$DB_NAME.$DB_TABLE.$TODAY.mysqldump"
fi 

export DB_DUMP="mysqldump $DB_LOCK -u $DB_USER -p$DB_PASS -h $DB_HOST --port $DB_PORT  $DB_NAME $DB_TABLE" 

echo '##########################' 
echo " DB_NAME  = $DB_NAME " 
echo " DB_TABLE = $DB_TABLE" 
echo " DB_FILE  = $DB_FILE " 
echo " DB_DUMP  = $DB_DUMP " 
echo '##########################' 
echo "$DB_NAME/mysqldump" 

mkdir -p $DB_NAME/mysqldump/ 

$DB_DUMP > $DB_NAME/mysqldump/$DB_FILE

ls -lh $DB_NAME/mysqldump

echo '    ' 
echo 'done' 
echo '##########################' 
