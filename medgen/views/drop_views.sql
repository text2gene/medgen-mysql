call log('drop_views.sql', 'begin'); 

-- ############################################
drop table if EXISTS view_medgen_uid          ;

drop table if EXISTS view_concept             ;
drop table if EXISTS view_concept_def         ;

drop table if EXISTS view_concept_child       ;
drop table if EXISTS view_concept_usage       ;

drop table if EXISTS view_concept_preferred   ; 
drop table if EXISTS view_disease_preferred   ; 

drop table if EXISTS view_contributor_usage   ;

drop table if EXISTS view_disease_child       ;
drop table if EXISTS view_disease_subtype     ;
drop table if EXISTS view_disease_subtype_name; 

drop table if EXISTS view_medgen_hpo          ;
drop table if EXISTS view_medgen_hpo_omim     ;
drop table if EXISTS view_medgen_uid          ;
-- ############################################

call log('drop_views.sql', 'end'); 
