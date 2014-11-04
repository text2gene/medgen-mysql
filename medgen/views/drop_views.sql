call log('drop_views.sql', 'begin'); 

-- ############################################

drop table if EXISTS view_medgen_uid          ;

drop table if EXISTS view_concept_child       ;
drop table if EXISTS view_concept_usage       ;

drop table if EXISTS view_contributor_usage   ;

drop table if EXISTS view_disease_child       ;
drop table if EXISTS view_disease_subtype     ;

drop table if EXISTS view_genetic_disease     ;

drop table if EXISTS view_medgen_hpo          ;
drop table if EXISTS view_medgen_hpo_omim     ;
drop table if EXISTS view_medgen_uid          ;

drop table if EXISTS view_mode_of_inheritance ;
drop table if EXISTS view_preferred_concept   ;
drop table if EXISTS view_preferred_disease   ;
drop table if EXISTS view_preferred_usage     ;

drop table if EXISTS view_pubmed              ;
drop table if EXISTS view_pubmed_concept      ;
drop table if EXISTS view_pubmed_disease      ;

drop table if EXISTS view_relate_usage        ;
drop table if EXISTS view_semantic_usage      ;
drop table if EXISTS view_vocab_usage         ;

-- ############################################

call log('drop_views.sql', 'end'); 
