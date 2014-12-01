call log('view_medgen_uid', 'MedGenUID:ConceptID');

select ' MedGen PubMed table is 80M+ rows, this will take a few minutes ' as fyi; 

drop   table if exists view_medgen_uid;  
CREATE TABLE           view_medgen_uid 
select distinct        UID as MedGenUID, 
       		       CUI as ConceptID from medgen_pubmed; 

call utf8_unicode('view_medgen_uid'); 
call create_index('view_medgen_uid','MedGenUID');
call create_index('view_medgen_uid','ConceptID');

-- ###################################################
call log('view_medgen_uid', 'end');

