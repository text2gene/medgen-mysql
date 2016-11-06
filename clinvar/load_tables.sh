## standard terms 
load_table tsv  disease_names             disease_names
load_table tsv  gene_condition_source_id  gene_condition_source_id

## references 
load_table tsv  cross_references          cross_references.txt 
load_table tsv  var_citations		  var_citations.txt

## clinvar summaries  
load_table tsv  variant_summary           variant_summary.txt
load_table tsv  gene_specific_summary     gene_specific_summary.txt
load_table tsv  molecular_consequences    molecular_consequences.txt
load_table tsv  variation_allele          variation_allele.txt

## load xml dump
load_table tsv          clinvar_hgvs      clinvar_hgvs.tsv


## clingen summaries 
load_table tsv  clingen_gene_curation_list  ClinGen_gene_curation_list.tsv  7


source db.config
echo 'BIOMED-769: deleting clinvar citations that have no pubmed identifier (PMID)' 
$mysql_dataset -e 'select * from var_citations where citation_id = 0' 
$mysql_dataset -e 'delete from var_citations where citation_id = 0' 
