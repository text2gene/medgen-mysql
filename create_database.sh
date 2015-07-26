#!/bin/bash

source common.sh 

require   $1 "pick a dataset like ./create_database clinvar" 

dbconfig="$1/db.config"

require $dbconfig "DATASET/db.config not found" 
source  $dbconfig

require $DATASET  "which dataset?" 

WORK=$DATASET

interpolate_file_config "templates/create_database.template.sql"       > $WORK/create_database.sql
interpolate_file_config "templates/create_logger.template.sql"        >> $WORK/create_database.sql
interpolate_file_config "templates/create_memory.template.sql"        >> $WORK/create_database.sql

echo "MySQL: attempting to create DATASET=$DATASET" 
mysql -u medgen -pmedgen < $WORK/create_database.sql
mysql -u medgen -pmedgen -D $DATASET < $WORK/create_tables.sql
