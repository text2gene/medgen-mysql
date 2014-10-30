#!/bin/bash 

# TODO: DRY: FabFile.py 

source ../common.sh 
source db.config 

echo ======================================================
echo "medgen begin" 

$mysql_dataset -e "call DATASET(DATABASE())"

$mysql_dataset -e "call log('readme','DATABASE()')" 
$mysql_dataset -e "call log('DATABASE()','load')" 

echo ======================================================

chmod +x *.sh 

$mysql_dataset -e "call log('load_tables','refresh')" 

load_table rrf  MGCONSO  MGCONSO.RRF
load_table rrf  MGDEF    MGDEF.RRF
load_table rrf  MGREL    MGREL.RRF
load_table rrf  MGSAT    MGSAT.RRF 
load_table rrf  MGSTY    MGSTY.RRF
load_table rrf  NAMES    NAMES.RRF
load_table rrf  MERGED   MERGED.RRF
load_table rrf  medgen_pubmed    medgen_pubmed.lnk
load_table rrf  medgen_hpo       MedGen_HPO_Mapping.txt 
load_table rrf  medgen_hpo_omim  MedGen_HPO_OMIM_Mapping.txt 

# [end of load.sh for medgen]
