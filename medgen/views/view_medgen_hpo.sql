call log('view_medgen_hpo.sql', 'begin'); 
-- ################################################################

desc medgen_hpo; 
-- +---------------+--------------+------+-----+---------+-------+
-- | Field         | Type         | Null | Key | Default | Extra |
-- +---------------+--------------+------+-----+---------+-------+
-- | CUI           | char(8)      | NO   | MUL | NULL    |       |
-- | SDUI          | varchar(100) | YES  |     | NULL    |       |
-- | HpoStr        | text         | NO   |     | NULL    |       |
-- | MedGenStr     | text         | NO   |     | NULL    |       |
-- | MedGenStr_SAB | varchar(20)  | NO   |     | NULL    |       |
-- | STY           | varchar(50)  | NO   | MUL | NULL    |       |
-- +---------------+--------------+------+-----+---------+-------+

call log('view_medgen_hpo', 'medgen_hpo concepts');
-- ################################################################
drop table   if exists view_medgen_hpo; 
CREATE TABLE           view_medgen_hpo 
SELECT
       MedGenStr_SAB as SourceVocab, 
       STY           as SemanticType, 
       CUI           as ConceptID, 
       MedGenStr     as ConceptName, 
       HpoStr        as PhenotypeName,
       SDUI 	     as HPO_ID
FROM   medgen_hpo; 

call utf8_unicode('view_medgen_hpo'); 
call create_index('view_medgen_hpo', 'SemanticType'); 
call create_index('view_medgen_hpo', 'SourceVocab'); 
call create_index('view_medgen_hpo', 'ConceptID'); 
call create_index('view_medgen_hpo', 'HPO_ID'); 
-- ################################################################
call log('view_medgen_hpo.sql', 'done'); 



desc medgen_hpo_omim; 
-- +---------------+-------------+------+-----+---------+-------+
-- | Field         | Type        | Null | Key | Default | Extra |
-- +---------------+-------------+------+-----+---------+-------+
-- | OMIM_CUI      | char(8)     | NO   | MUL | NULL    |       |
-- | MIM_number    | varchar(20) | YES  | MUL | NULL    |       |
-- | OMIM_name     | text        | YES  |     | NULL    |       |
-- | relationship  | varchar(50) | YES  | MUL | NULL    |       |
-- | HPO_CUI       | char(8)     | NO   | MUL | NULL    |       |
-- | HPO_ID        | varchar(20) | YES  | MUL | NULL    |       |
-- | HPO_name      | text        | YES  |     | NULL    |       |
-- | MedGen_name   | text        | YES  |     | NULL    |       |
-- | MedGen_source | varchar(20) | YES  | MUL | NULL    |       |
-- | STY           | varchar(50) | NO   | MUL | NULL    |       |
-- +---------------+-------------+------+-----+---------+-------+

-- begin 
call log('view_medgen_hpo_omim', 'refresh');
-- ################################################################

drop table if exists view_medgen_hpo_omim; 
CREATE TABLE         view_medgen_hpo_omim
SELECT distinct 
       OMIM_STY.STY          as OMIM_SemanticType,
       mapping.OMIM_CUI      as OMIM_ConceptID, 
       mapping.MIM_number    as OMIM_ID, 
       mapping.OMIM_name     as OMIM_Name, 
       mapping.relationship  as Relationship, 
       HPO_STY.STY           as HPO_SemanticType,
       mapping.HPO_CUI       as HPO_ConceptID, 
       mapping.HPO_ID        as HPO_ID, 
       mapping.HPO_name      as HPO_Name,        
       mapping.MedGen_Source as SourceVocab, 
       mapping.STY           as SemanticType,
       mapping.MedGen_Name   as Name
FROM 
     medgen_hpo_omim as mapping, 
     MGSTY as OMIM_STY, 
     MGSTY as HPO_STY
where 
     mapping.OMIM_CUI = OMIM_STY.CUI and 
     mapping.HPO_CUI  =  HPO_STY.CUI ;

call utf8_unicode('view_medgen_hpo_omim'); 
call create_index('view_medgen_hpo_omim','SemanticType'); 
call create_index('view_medgen_hpo_omim','SourceVocab'); 
call create_index('view_medgen_hpo_omim','HPO_ConceptID'); 
call create_index('view_medgen_hpo_omim','OMIM_ConceptID'); 
call create_index('view_medgen_hpo_omim','OMIM_ID'); 
call create_index('view_medgen_hpo_omim','HPO_ID'); 

alter table view_medgen_hpo_omim add column OMIM_SemanticType varchar(50) not null; 
alter table view_medgen_hpo_omim add column HPO_SemanticType  varchar(50) not null; 

update view_medgen_hpo_omim as V, MGSTY as sem
set    V.OMIM_SemanticType = sem.STY 
where  V.OMIM_ConceptID    = sem.CUI; 

update view_medgen_hpo_omim as V, MGSTY as sem
set    V.HPO_SemanticType = sem.STY 
where  V.HPO_ConceptID    = sem.CUI; 

call log('view_medgen_hpo.sql', 'done'); 
-- ################################################################
-- end 

-- bgein 
call log('view_mode_of_inheritance', 'Mode Of Inheritance (HPO SourceVocab)');
-- ################################################################

drop   table if exists view_mode_of_inheritance; 
create table           view_mode_of_inheritance
select DISTINCT 
       OMIM_SemanticType as SemanticType, 
       SourceVocab       as SourceVocab,
       OMIM_ConceptID    as ConceptID,
       HPO_Name          as Inheritance
from view_medgen_hpo_omim 
where relationship = 'inheritance_type_of'; 

alter table view_mode_of_inheritance ','ConceptID) ; 
alter table view_mode_of_inheritance add column Name varchar(1000) default null; 

update 
  view_mode_of_inheritance  as Inherit, 
  view_concept_preferred    as Term
set    Inherit.Name       = Term.Name 
where  Inherit.ConceptID  = Term.ConceptID;
-- ################################################################
-- end 
