alter table test_condition_gene add index (GeneTestsID); 
alter table test_condition_gene add index (test_type); 
alter table test_condition_gene add index (GTR_identifier);
alter table test_condition_gene add index (MIM_number); 
alter table test_condition_gene add index (concept_type); 
alter table test_condition_gene add index (concept_type, gene_or_SNOMED_CT_ID); 
