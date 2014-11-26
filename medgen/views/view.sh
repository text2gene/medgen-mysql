#!/bin/bash 

# ssh biomed.vpc.locusdev.net 
# 
# biomed$ cd /mnt/biomed/dataset/medgen
# biomed$ . db.config 
# 
# biomed$ $mysql_dataset -e "call mem" 
# biomed$ $mysql_dataset
#
################################################################
# MedGen  
# 
# ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/README.html
# ##############################################################
# Example:  
# select 'C0007194' into @CUI; 
#
# ##############################################################

echo "(clean) drop medgen.views_* " 

. ../db.config 
$mysql_dataset < drop_views.sql 

echo "Human readable view of concepts" 
$mysql_dataset < view_concept.sql 

echo "Human readable view of definitions" 
$mysql_dataset < view_concept_def.sql 

echo "MedGen Hierarchy of concepts " 
$mysql_dataset < view_concept_tree.sql

echo "MedGenUID to UMLS ConceptID Mapping" 
$mysql_dataset < view_medgen_uid.sql 

##############################################################

# echo "2. NCBI Prerred NAMES for Diseases, Concepts, and SemanticTypes" 
# $mysql_dataset < view_preferred.sql

# echo "4. Disease:Subtypes " 
# $mysql_dataset < view_disease_subtype.sql 

# echo "5. MedGen:HPO (HPO Human Phenotypes) "
# $mysql_dataset < view_medgen_hpo.sql 

# echo "7. PubMed references" 
# $mysql_dataset < view_pubmed.sql
