call log('view_mode_of_inheritance.sql', 'begin');
-- ################################################################

drop   table if exists view_mode_of_inheritance; 
create table           view_mode_of_inheritance
select DISTINCT
 OMIM_CUI       as OMIM_ConceptID, 
 MIM_number     as OMIM_ID,
 OMIM_name      as OMIM_Name, 
 HPO_name       as Inheritance, 
 HPO_CUI        as HPO_ConceptID, 
 HPO_ID         as HPO_ID, 
 MedGen_name    as Name, 
 MedGen_source  as SourceVocab, 
 STY            as SemanticType
from medgen_hpo_omim
where Relationship = 'inheritance_type_of'; 

call freq('view_mode_of_inheritance', 'Inheritance');

-- ################################################################
call log('view_mode_of_inheritance.sql', 'done');
