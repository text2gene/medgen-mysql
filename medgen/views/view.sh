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
# Table Load orderd dependancy 
# 
# view_pubmed_* DEPS view_preferred_*
#+##############################################################

echo "(clean) drop medgen.views_* " 
. db.config 
$mysql_connect < drop_views.sql 

echo "1. MedGenUID lto UMLS ConceptID Mapping"  
$mysql_connect < view_medgen_uid.sql 

echo "2. NCBI Prerred NAMES for Diseases, Concepts, and SemanticTypes" 
$mysql_connect < view_preferred.sql

echo "3. Concept:Concept " 
$mysql_connect < view_concept_hierarchy.sql

echo "4. Disease:Subtypes " 
$mysql_connect < view_disease_subtype.sql 

echo "4. Disease:Gene "
$mysql_connect < view_gene_disease.sql 

echo "5. MedGen:HPO (HPO Human Phenotypes) "
$mysql_connect < view_medgen_hpo.sql 


echo "7. Molecular Consequences " 
$mysql_connect < view_molecular_consequences.sql
