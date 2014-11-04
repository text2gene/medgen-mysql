#!/bin/bash

set -e

export TODAY="$(date +%F)"
export BATCH="$TODAY" 

function require()
{
    if [ "$#" -lt 2 ]; then 
    	echo "Requirement not met: $1 $2"
    	exit 0
    fi
}

function escape()
{
  ESCAPED=$(echo "$1" | sed "s| |\\\ |g" | sed "s|\:|\\\:|g" | sed "s|\.|\\\.|g" | sed "s|\/|\\\/|g")
}

function interpolate_file()
{
  file=$1
  pattern=$2

  escape $3

  replacement="$ESCAPED"

  sed s/$pattern/$replacement/g $file
}

function interpolate_file_config()
{
  file=$1

  interpolate_file $file "@@@DATASET" $DATASET | \
      interpolate "@@@DB_USER" $DB_USER | \
      interpolate "@@@DB_PASS" $DB_PASS | \
      interpolate "@@@DB_HOST" $DB_HOST | \
      interpolate "@@@DB_PORT" $DB_PORT | \
      interpolate "@@@README"  $README 
}


function interpolate()
{
  pattern=$1

  escape $2

  replacement="$ESCAPED"

  sed s/$pattern/$replacement/g
}

function load_table() 
{
    export SEP=$1
    export TABLE=$2
    export FILE=$3
    export SKIP=$4

    if [ "$FILE" = " " ]; 
    then 
	FILE=$TABLE
    fi 

    if [ "$#" -lt 4 ]; then 
	SKIP=1
    fi 

    require $SEP   "tsv,csv,rrf" 
    require $TABLE "table name?"
    require $FILE  "input filename?" 

    if [ "rrf" = $SEP ]; then # NLM RRF rich relase format (pipe delimited) 
	SEP='|'
    fi 
    
    if [ "tsv" = $SEP ]; then # Tab Sep Values 
	SEP='\\t'
    fi 
    
    if [ "csv" = $SEP ];then # Comma Sep Values 
	SEP=','
    fi 

    echo 
    echo "-- begin table"

    interpolate_file "../templates/load_table" "@@@TABLE" $TABLE | \
	interpolate "@@@FILE"   mirror/$FILE | \
	interpolate "@@@SEP"    $SEP  | \
	interpolate "@@@SKIP"   $SKIP | \
	$mysql_dataset    
}

function create_table_from() 
{
    export SQL_TABLE=$1
    export SQL_WHERE=$2

    if [ "$#" -lt 2 ]; then 
	SQL_WHERE=1
    fi 

    require  $SQL_TABLE  "table name?"
    require  $SQL_WHERE  "where condition?" 

    interpolate_file "../templates/create_table_from" "@@@TABLE" $SQL_TABLE | \
	interpolate "@@@WHERE"   $SQL_WHERE
}

function create_index() 
{
    export SQL_TABLE=$1
    export SQL_INDEX=$2

    if [ "$#" -lt 2 ]; then 
	SQL_INDEX='ConceptID'
    fi 

    require  $SQL_TABLE  "table name?"
    require  $SQL_INDEX  "index column?" 

    interpolate_file "../templates/create_index" "@@@TABLE" $SQL_TABLE | \
	interpolate "@@@INDEX"   $SQL_INDEX
}


function show_usage() 
{
    export SQL_TABLE=$1
    export SQL_BY=$2
    export SQL_CNT=$3

    if [ "$#" -lt 3 ]; then 
	SQL_CNT='*'
    fi 

    require  $SQL_TABLE  " table name ? "
    require  $SQL_BY     " group by   ? " 

    interpolate_file "../templates/show_usage" "@@@TABLE" $SQL_TABLE | \
	interpolate "@@@BY"     $SQL_BY    | \
	interpolate "@@@CNT"    $SQL_CNT
}
