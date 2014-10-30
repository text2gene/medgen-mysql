call log('medgen.create_index.sql','begin'); 

call create_index('MERGED'  ,'CUI');
call create_index('MGCONSO' ,'CUI');
call create_index('MGCONSO','SCUI');
call create_index('MGDEF',   'CUI');
call create_index('NAMES',   'CUI');

 
call create_index('medgen_pubmed','UID');  -- MedGen primary key 
call create_index('medgen_pubmed','CUI');  -- UMLS   primary key
call create_index('medgen_pubmed','PMID'); -- PubMed primary key
call create_index('medgen_pubmed','NAME'); -- Description


call create_index('medgen_hpo','MedGenStr_SAB'); -- MedGen Source vocabulary 


call create_index('medgen_hpo','CUI');  -- UMLS   id 
call create_index('medgen_hpo','STY');  -- Semantic Type 


call create_index('medgen_hpo_omim','OMIM_CUI');  
call create_index('medgen_hpo_omim','MIM_number'); 
call create_index('medgen_hpo_omim','relationship'); 
call create_index('medgen_hpo_omim','HPO_CUI');  
call create_index('medgen_hpo_omim','HPO_ID');  
call create_index('medgen_hpo_omim','MedGen_source');  
call create_index('medgen_hpo_omim','STY');  


drop table if exists medgen_uid;  
create table medgen_uid select distinct UID, CUI from medgen_pubmed; 


call create_index('medgen_uid','UID'); 
call create_index('medgen_uid','CUI'); 


call log('medgen.create_index.sql','done'); 
