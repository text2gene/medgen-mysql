call log('view_concept_preferred.sql', 'begin');
-- ################################################################

call log('view_concept_preferred', 'Preferred use of SourceVocab:SemanticType');
drop  table if exists view_concept_preferred; 

select count(distinct CUI) into @cnt from NAMES;

create table view_concept_preferred
select distinct 
       semantic.STY   as SemanticType, 
       prefer.source  as SourceVocab, 
       prefer.CUI     as ConceptID, 
       prefer.name    as Name
from  NAMES   as prefer, 
      MGCONSO as concept, 
      MGSTY   as semantic
where    concept.ISPREF   = 'Y'   and 
	 concept.STT      = 'PF'  and 
 	 concept.SUPPRESS = 'N'   and  
 	 concept.CUI      = prefer.CUI  and 
 	 concept.CUI      = semantic.CUI  ; 

call utf8_unicode('view_concept_preferred'); 
call create_index('view_concept_preferred','ConceptID');
call create_index('view_concept_preferred','SemanticType');
call create_index('view_concept_preferred','SourceVocab');
call create_index('view_concept_preferred','Name');

drop table if exists view_concept_missing; 
create table view_concept_missing 
select * from NAMES where CUI not in (select CUI from MGCONSO); 

-- ################################################################
call log('view_concept_preferred.sql', 'done');
