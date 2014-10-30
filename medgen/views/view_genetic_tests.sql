-- ################################################################

call log('view_test_clinical', 'refresh');

drop   table if exists view_test_clinical; 
create table           view_test_clinical 
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

select 'usage' as TODO; 

select SemanticType, count(distinct ConceptID) as cnt 
from view_test_clinical group by SemanticType order by cnt desc ; 

-- +----------------------------------+------+
-- | SemanticType                     | cnt  |
-- +----------------------------------+------+
-- | Disease or Syndrome              | 3992 |
-- | Congenital Abnormality           |  350 |
-- | Neoplastic Process               |  145 |
-- | Finding                          |  132 |
-- | Pathologic Function              |   34 |
-- | Sign or Symptom                  |   26 |
-- | Mental or Behavioral Dysfunction |   11 |
-- | Anatomical Abnormality           |    4 |
-- | Gene or Genome                   |    3 |
-- | Cell or Molecular Dysfunction    |    3 |
-- +----------------------------------+------+

call log('view_test_clinical', 'done');
-- ################################################################
-- end 

-- begin     
-- ################################################################
