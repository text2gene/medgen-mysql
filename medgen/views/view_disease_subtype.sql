call log('view_disease_subtype.sql', 'begin');
-- ################################################################

drop table   if exists view_disease_subtype; 
CREATE TABLE           view_disease_subtype
(
  DiseaseID   char(8) not null, 
  SubtypeID   char(8) not null
); 

call utf8_unicode('view_disease_subtype'); 

insert into view_disease_subtype
select distinct 
  CUI1 as DiseaseID, 
  CUI2 as SubTypeID
from 
  MGREL   relate, 
  MGCONSO concept, 
  MGSTY   semantic
where 
  relate.REL   = 'CHD'         and 
  relate.CUI2  = concept.CUI   and 
  concept.CUI  = semantic.CUI  and 
  semantic.STY = 'Disease or Syndrome'; 

-- ################################################################
call log('view_disease_subtype.sql', 'done');
