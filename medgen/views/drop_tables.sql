call log('medgen.view_drop_tables.sql', 'begin'); 
-- 
--  ===================
--   NCBI STANDRD TERMS 
--  ====================

select 'MedGen shares standard_terms and NAMES with Gene/GTR/GeneReviews/etc.' as info; 
-- ############################################
drop table if EXISTS gene_condition_source_id ;
drop table if EXISTS NAMES                    ;
-- ############################################

select 'application log with schema README'     as info; 
-- ############################################
drop table if EXISTS log                      ;
drop table if EXISTS README                   ;
-- ############################################

select 'MedGen RRF MERGED
        Concepts, Definitions, 
        Relations, Attributes, and SemanticStypes' as info; 
-- ############################################
drop table if EXISTS MERGED                   ;
drop table if EXISTS MGCONSO                  ;
drop table if EXISTS MGDEF                    ;

drop table if EXISTS MGREL                    ;
drop table if EXISTS MGSAT                    ;
drop table if EXISTS MGSTY                    ;
-- ############################################

select 'medgen linkout to HPO, OMIM, and PubMed'as info; 
-- ############################################
drop table if EXISTS medgen_hpo               ;
drop table if EXISTS medgen_hpo_omim          ;
drop table if EXISTS medgen_pubmed            ;
-- ############################################

call log('medgen.view_drop_tables.sql', 'donee'); 
