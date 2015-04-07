#!/bin/bash

set -e

export TODAY="$(date +%Y-%m-%d__h%Hm%Ms%S)"
export BATCH="$TODAY" 

source common.sh 

require   $1 "pick a dataset like ./create_database clinvar" 

dbconfig="$1/db.config"

require $dbconfig "DATASET/db.config not found" 
source  $dbconfig

export DB_TABLE=$2

if [ "$#" -lt 2 ]; then 
    export DB_FILE="$DATASET.$TODAY.mysqldump"
else
    export DB_FILE="$DATASET.$DB_TABLE.$TODAY.mysqldump"
fi 

export DB_DUMP="mysqldump --skip-lock-tables -u $DB_USER -p$DB_PASS -h $DB_HOST --port $DB_PORT  $DATASET $DB_TABLE" 

echo '##########################' 
echo " DATASET  = $DATASET "
echo " BATCH    = $BATCH" 
echo " DB_TABLE = $DB_TABLE" 
echo " DB_FILE  = $DB_FILE " 
echo " DB_DUMP  = $DB_DUMP " 
echo '##########################' 
echo "$DATASET/mysqldump" 

mkdir -p $DATASET/mysqldump/ 

$mysql_dataset -e "call log('backup_database.sh', 'begin')"

$DB_DUMP > $DATASET/mysqldump/$DB_FILE

$mysql_dataset -e "call log('backup_database.sh', 'done')"

ls -lh $DATASET/mysqldump

echo '    ' 
echo 'done' 
echo '##########################' 
