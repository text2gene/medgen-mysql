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


call log('view_medgen_hpo', 'medgen_hpo concepts');
-- ################################################################
drop table   if exists view_medgen_hpo; 
CREATE TABLE            view_medgen_hpo 
SELECT
       STY           as SemanticType, 
       MedGenStr_SAB as SourceVocab, 
       CUI           as ConceptID, 
       MedGenStr     as ConceptName, 
       HpoStr        as PhenotypeName,
       SDUI 	     as HP
FROM   medgen_hpo; 

alter table view_medgen_hpo ENGINE=InnoDB DEFAULT CHARSET=utf8; 

alter table view_medgen_hpo add index (SemanticType); 
alter table view_medgen_hpo add index (SourceVocab); 
alter table view_medgen_hpo add index (ConceptID); 
alter table view_medgen_hpo add index (HP); 
-- ################################################################
-- end 

-- begin 
call log('view_medgen_hpo_omim', 'refresh');
-- ################################################################
drop table if exists view_medgen_hpo_omim; 
CREATE TABLE         view_medgen_hpo_omim
SELECT 
       OMIM_CUI      as OMIM_ConceptID, 
       MIM_number    as MIM, 
       OMIM_name     as OMIM_Name, 
       relationship, 
       HPO_CUI       as HPO_ConceptID, 
       HPO_ID        as HP, 
       HPO_name      as HPO_Name, 
       MedGen_Name   as Name, 
       MedGen_Source as SourceVocab, 
       STY           as SemanticType 
FROM 
     medgen_hpo_omim; 

alter table view_medgen_hpo_omim ENGINE=InnoDB DEFAULT CHARSET=utf8; 

alter table view_medgen_hpo_omim add index (SemanticType); 
alter table view_medgen_hpo_omim add index (SourceVocab); 
alter table view_medgen_hpo_omim add index (HPO_ConceptID); 
alter table view_medgen_hpo_omim add index (OMIM_ConceptID); 
alter table view_medgen_hpo_omim add index (MIM); 
alter table view_medgen_hpo_omim add index (HP); 

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

alter table view_mode_of_inheritance add index (ConceptID) ; 
alter table view_mode_of_inheritance add column Name varchar(1000) default null; 

update 
  view_mode_of_inheritance  as Inherit, 
  view_concept_preferred    as Term
set    Inherit.Name       = Term.Name 
where  Inherit.ConceptID  = Term.ConceptID;
-- ################################################################
-- end 
