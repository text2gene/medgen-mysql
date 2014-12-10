#!/bin/bash 

################################################################
# MedGen  
# ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/README.html
# ##############################################################

. ../db.config 

echo "######################################"
echo "MedGen concept views" 
echo "######################################"

echo "Human readable view of concepts" 
$mysql_dataset < view_concept.sql 

echo "Human readable view of definitions" 
$mysql_dataset < view_concept_def.sql 

# echo "NCBI Preferred NAMES for Diseases, Concepts, and SemanticTypes" 
# $mysql_dataset < view_concept_preferred.sql

echo "######################################"
echo "SemanticType views" 
echo "######################################"

echo "SemanticTypes (MGSTY.* joined to Concept)" 
$mysql_dataset < view_semantics.sql

echo "Genetic Tests" 
$mysql_dataset < view_genetic_tests.sql

echo "######################################"
echo "TREE Hierarchy" 
echo "######################################"

echo "concept:concept::broader:narrower" 
$mysql_dataset < view_concept_tree.sql

echo TREE Hierarchy
echo "concept:concept::broader:disease"
$mysql_dataset < view_disease_tree.sql

echo TREE Hierarchy 
echo "concept:concept::disease:subtype" 
$mysql_dataset < view_disease_subtype.sql 

echo "######################################"
echo "MAPPINGS"
echo "######################################"

echo "HPO Human Phenotype Ontology"
echo "medgen:hpo" 
$mysql_dataset < view_medgen_hpo.sql 

echo "Online Mendelian Inheritance in Man"
echo "medgen:hpo::hpo:omim" 
$mysql_dataset < view_medgen_hpo_omim.sql 

echo "genetic conditions inheritance"
$mysql_dataset < view_mode_of_inheritance.sql

echo "MedGen to UMLS Unified Medical Language System"
echo "medgen:MedGenUID::UMLS:ConceptID"
$mysql_dataset < view_medgen_uid.sql 

echo "######################################"
echo "COUNTS"
echo "######################################"
$mysql_dataset < count_medgen.sql 
$mysql_dataset < count_pubmed.sql 

echo "######################################"
echo "Schema and memory usage"

$mysql_dataset -e "call mem" 

echo "######################################"

