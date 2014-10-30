#!/bin/bash

source common.sh 

require   $1 "pick a dataset like ./create_database clinvar" 

dbconfig="$1/db.config"

require $dbconfig "DATASET/db.config not found" 
source  $dbconfig

require $DATASET  "which dataset?" 

WORK=$DATASET

interpolate_file_config "example/create_database"           > $WORK/create_database.sql
interpolate_file_config "example/create_logger.sql"        >> $WORK/create_database.sql 
interpolate_file_config "example/create_memory.sql"        >> $WORK/create_database.sql  
interpolate_file_config "example/create_user"               > $WORK/create_user.sql
interpolate_file_config "example/drop_user"                 > $WORK/drop_user.sql 

echo "MySQL: attempting to create DATASET=$DATASET as YOU=$USER" 
mysql -u $USER -p             < $WORK/create_database.sql

echo "MySQL: attempting to create DATASET=$DATASET as YOU=$USER" 
mysql -u $USER -p -D $DATASET < $WORK/create_tables.sql
