call log('view_concept_tree.sql', 'begin');
-- ################################################################
call log('view_concept_def', 'MedGen Definitions');

drop   table if exists view_concept_def; 
create table           view_concept_def 
select CUI as ConceptID, 
       DEF as Definition, 
       SAB as SourceVocab
from MGDEF; 

call utf8_unicode('view_concept_def'); 
call create_index('view_concept_def','ConceptID');
call create_index('view_concept_def','SourceVocab');

-- ################################################################
call log('view_concept_tree.sql', 'done');
