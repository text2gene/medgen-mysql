call log('view_concept_genetic_tests', 'refresh');
-- ################################################################

drop   table if exists view_genetic_tests; 
create table           view_genetic_tests 
select distinct 
     semantic.STY as SemanticType, 
     attr.CUI     as ConceptID, 
     attr.ATUI    as AttributeID
from 
     MGSAT as attr, 
     MGSTY as semantic 
where
     attr.ATN = 'NCBI_GTR_TEST_CLINICAL_ID'  and 
     attr.CUI = semantic.CUI ;  

-- ################################################################
call log('view_concept_genetic_tests', 'done');
