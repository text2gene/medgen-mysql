call log('view_mode_of_inheritance.sql', 'begin');
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

-- alter table view_mode_of_inheritance ','ConceptID) ; 
-- alter table view_mode_of_inheritance add column Name varchar(1000) default null; 

-- update 
--   view_mode_of_inheritance  as Inherit, 
--   view_concept_preferred    as Term
-- set    Inherit.Name       = Term.Name 
-- where  Inherit.ConceptID  = Term.ConceptID;

-- ################################################################
call log('view_mode_of_inheritance.sql', 'done');
