select '#disease_names in GTR per source' as note; 

create table map_disease_names_per_source 
select count(*) as cnt, SourceName from gtr_disease_names group by SourceName order by cnt desc; 

create table map_disease_names_no_mim
select * from gtr_gene_condition_source_id where DiseaseMIM = ''; 

select '57 GTR disease_names are not in OMIM and have ClinicalTerm'; 
select * from gtr_gene_condition_source_id where DiseaseMIM = '' and SourceName= 'SNOMED CT'; 

select '14 unique GTR disease_names in SNOMED but not OMIM' 
select distinct DiseaseName from gtr_gene_condition_source_id where DiseaseMIM = '' and SourceName = 'SNOMED CT'; 
-- +----------------------------------------------+
-- | DiseaseName                                  |
-- +----------------------------------------------+
-- | Primary dilated cardiomyopathy               |
-- | Disorder of cardiovascular system            |
-- | Primary familial hypertrophic cardiomyopathy |
-- | Carbohydrate-deficient glycoprotein syndrome |
-- | Amyotrophic lateral sclerosis                |
-- | Osteogenesis imperfecta                      |
-- | Dystrophic epidermolysis bullosa             |
-- | Limb-girdle muscular dystrophy               |
-- | Xeroderma pigmentosum                        |
-- | Spinal muscular atrophy                      |
-- | De Lange syndrome                            |
-- | Noonan's syndrome                            |
-- | Hirschsprung's disease                       |
-- | Achromatopsia                                |
-- +----------------------------------------------+

-- gtr_test_condition_gene



select count(distinct gene_or_SNOMED_CT_ID) as cnt_genes from gtr_test_condition_gene where concept_type = 'gene'; 



 
