call log('view_disease_subtype.sql', 'begin');
-- ################################################################

call log('view_disease_child', 'refresh');
-- ################################################################

drop table if exists view_disease_child; 

create table view_disease_child like view_concept_child; 
alter  table view_disease_child change ConceptID Disease char(8); 
alter  table view_disease_child drop column SemanticType; 
alter  table view_disease_child change ChildSemanticType SemanticType varchar(50) not null; 

call utf8_unicode('view_disease_child'); 

insert into  view_disease_child (Disease, ChildID, SemanticType) 
select distinct ConceptID, ChildID, ChildSemanticType from view_concept_child 
where SemanticType = 'Disease or Syndrome'; 

call log('view_disease_child', 'done');
-- 

-- ################################################################
call log('view_disease_subtype', 'refresh');

drop table   if exists view_disease_subtype; 
CREATE TABLE           view_disease_subtype
(
  Disease   char(8) not null, 
  Subtype   char(8) not null
); 

call utf8_unicode('view_disease_subtype'); 
call utf8_unicode('view_disease_preferred'); 

insert into view_disease_subtype
select distinct 
  CUI1 as Disease, 
  CUI2 as SubType
from 
  MGREL   relate, 
  MGCONSO concept, 
  MGSTY   semantic
where 
  relate.REL   = 'CHD'         and 
  relate.CUI2  = concept.CUI   and 
  concept.CUI  = semantic.CUI  and 
  semantic.STY = 'Disease or Syndrome'; 

call log('view_disease_subtype', 'done');

-- ################################################################
call log('view_disease_subtype_name', 'refresh');

drop table if exists view_disease_subtype_name ; 

create table view_disease_subtype_name
select distinct
 D.SemanticType as SemanticType, 
 D.SourceVocab  as DiseaseVocab, 
 D.Disease      as Disease, 
 D.Name         as DiseaseName, 
 D.SourceVocab  as SubtypeVocab, 
 D.Disease      as Subtype, 
 D.Name         as SubtypeName 
from 
 view_disease_subtype as Tree, 
 view_disease_preferred   as D, 
 view_disease_preferred   as S 
where 
 Tree.Disease = D.Disease  and 
 Tree.Subtype = S.Disease 
order by 
 DiseaseName, SubtypeName; 

alter table view_disease_subtype_name
      add column id int not null auto_increment first, 
      add primary key (id) ;

-- ################################################################
call log('view_disease_subtype.sql', 'end');
