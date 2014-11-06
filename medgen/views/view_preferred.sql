call log('view_preferred.sql', 'begin');
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

-- ################################################################
call log('view_disease_preferred', 'ncbi preferred disease names');

drop table if exists view_disease_preferred; 

create table view_disease_preferred like view_concept_preferred; 
alter  table view_disease_preferred change ConceptID Disease char(8); 

insert into view_disease_preferred
select distinct SemanticType,SourceVocab,ConceptID, Name 
from view_concept_preferred
where SemanticType = 'Disease or Syndrome'; 

call log('view_preferred.sql', 'done.');
-- ################################################################
