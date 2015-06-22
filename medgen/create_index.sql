-- MedGen concept tables CUI (Concept Unique Identifer)
call create_index('MGMERGED', 'CUI');
call create_index('MGCONSO' ,'CUI');
call create_index('MGCONSO','SCUI');
call create_index('MGDEF',   'CUI');
call create_index('NAMES',   'CUI');

-- MedGen References (May include direct or indirect OMIM references) 
call create_index('medgen_pubmed','UID');  -- MedGen primary key 
call create_index('medgen_pubmed','CUI');  -- UMLS   primary key
call create_index('medgen_pubmed','PMID'); -- PubMed primary key

-- MedGen RELATIONSHIPS
call create_index('MGREL','CUI1'); -- Concept 1
call create_index('MGREL','CUI2'); -- Concept 2
call create_index('MGREL','REL');  -- Relationship
call create_index('MGREL','RELA'); -- Relationsihp Additional 

-- OMIM References (directly from OMIM to PubMed)
call create_index('omim_pubmed','MIM');  -- MIM
call create_index('omim_pubmed','PMID'); -- PMID

-- MedGen to HPO SourceVocab Indexes
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


