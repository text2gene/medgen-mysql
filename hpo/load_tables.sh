echo "######################################" 
echo "[ HPO Human Phenotype Ontology]" 
echo 
echo " Loading HPO provided database export " 
echo 
echo "######################################" 

. db.config 

load_table tsv disease2gene2phenotypes	archive/annotation/ALL_SOURCES_ALL_FREQUENCIES_diseases_to_genes_to_phenotypes.txt
load_table tsv gene2phenotype		archive/annotation/ALL_SOURCES_ALL_FREQUENCIES_genes_to_phenotype.txt
load_table tsv phenotype2gene		archive/annotation/ALL_SOURCES_ALL_FREQUENCIES_phenotype_to_genes.txt
load_table tsv gene2disease archive/annotation/genes_to_diseases.txt
load_table tsv disease2gene archive/annotation/diseases_to_genes.txt

$mysql_dataset < mirror/archive/annotation/MYHPO*.sql

# drop table abstract_sentence;
# drop table sentence2term;
# drop table disease2pubmedref;
# drop table external_object_pubmed;
