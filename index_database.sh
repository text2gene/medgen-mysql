#!/bin/bash

set -e
source common.sh 

require $1 "pick a dataset like ./index_database.sh gene" 

dbconfig="$1/db.config"

require $dbconfig "DATASET/db.config not found" 
source  $dbconfig

require $DATASET  "which dataset?" 

$mysql_dataset -e "call log('index_database.sh', 'begin')"

pushd . 
cd $DATASET
$mysql_dataset < create_index.sql 
popd

$mysql_dataset -e "call log('index_database.sh', 'done')"

echo '##################################################################' 
echo "DATASET: $DATASET " 

$mysql_dataset -e 'call tail'; 
$mysql_dataset -e 'call mem'; 

echo '##################################################################' 
