#!/bin/bash 

source ../common.sh 
source db.config 

echo ======================================================
echo "gene begin" 

$mysql_dataset -e "call DATASET('gene')"

$mysql_dataset -e "call log('readme','ftp://ftp.ncbi.nlm.nih.gov/gene/README')" 
$mysql_dataset -e "call log('gene','load')" 

echo ======================================================

chmod +x *.sh 

$mysql_dataset -e "call log('load_tables','refresh')" 

load_table tsv mim2gene_medgen  mim2gene_medgen 
load_table tsv gene2pubmed      gene2pubmed
load_table tsv gene2go          gene2go
load_table tsv gene_info        gene_info
load_table tsv gene_group       gene_group
load_table tsv gene_history     gene_history
load_table tsv stopwords_gene   stopwords_gene

# [end of load.sh for gene]
