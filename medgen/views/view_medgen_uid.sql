call log('view_medgen_uid', 'MedGenUID:ConceptID');

select ' MedGen PubMed table is 70M rows, this will take a few minutes ' as fyi; 

drop   table if exists view_medgen_uid;  
CREATE TABLE           view_medgen_uid 
select distinct        UID as MedGenUID, 
       		       CUI as ConceptID from medgen_pubmed; 


alter table view_medgen_uid ENGINE=InnoDB DEFAULT CHARSET=utf8; 
alter table view_medgen_uid add index (MedGenUID); 
alter table view_medgen_uid add index (ConceptID); 
-- ###################################################
call log('view_medgen_uid', 'end');

