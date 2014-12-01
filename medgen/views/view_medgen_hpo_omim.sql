call log('view_medgen_hpo_omim.sql', 'begin'); 
-- ################################################################

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

-- ################################################################
call log('view_medgen_hpo_omim.sql', 'done'); 
