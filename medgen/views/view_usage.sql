call log('summary.sql', 'begin');

-- ############################################
--    NCBI MedGen Human Curation Summary 
-- ############################################
--  20 Contributors 
--  Disease Gene Human Expert Curation 
--  Usage Statistics (Genes Concepts Diseeases)
-- ############################################

-- #################################################################
call log('summary_gene_curation', '#genes,#concepts,#omim per clinvar.gene_condition_source_id');

drop   table if exists summary_gene_curation; 
create table summary_gene_curation
   select SourceName as Curation, 
     count(distinct GeneID)     as cnt_genes, 
     count(distinct ConceptID)  as cnt_concepts, 
     count(distinct DiseaseMIM) as cnt_omim
   from 
     clinvar.gene_condition_source_id
   group by SourceName 
   order by cnt_genes desc ;

-- medgen all source vocabularies 
-- that contribute annotations by human experts  

insert into summary_gene_curation
   select 'NCBI_MEDGEN_CURATION' as Curation, 
     count(distinct GeneID)      as cnt_genes, 
     count(distinct ConceptID)   as cnt_concepts, 
     count(distinct DiseaseMIM)  as cnt_omim
   from 
     clinvar.gene_condition_source_id;

call log('summary_gene_curation', 'done');

-- #################################################################

call log('summary_vocab', '#concepts per SourceVocab (medgen.NAMES.source)');

drop table if exists summary_vocab; 

select count(distinct CUI) into @cnt from NAMES; 

create table summary_vocab
select source as SourceVocab, 
       count(distinct CUI)      as cnt_concepts, 
       count(distinct CUI)/@cnt*100 as percent
from NAMES 
group by source order by cnt_concepts desc; 

alter table summary_vocab change percent percent Float(2) default 0; 

call log('summary_vocab', 'done'); 

-- #################################################################
call log('summary_semantics', '#concepts per SemanticType (medgen.MGSTY.STY) .');

select count(*) into @cnt from NAMES; 

drop  table if exists summary_semantics; 

create table summary_semantics
select semantic.STY   as SemanticType, 
       count(distinct NAMES.CUI)  as cnt_concepts, 
       count(distinct NAMES.CUI)/@cnt*100  as percent
from  NAMES, 
      MGSTY as semantic
where NAMES.CUI = semantic.CUI 
group by SemanticType 
order by cnt_concepts desc; 

alter table summary_semantics change percent percent Float(2) default 0; 

call log('summary_semantics', 'done'); 

-- #################################################################
-- call log('summary_vocabs_semantics', '#concepts per {SourceVocab,SemanticType}');

-- select count(distinct CUI) into @cnt from NAMES;

-- drop  table if exists view_preferred_usage; 

-- create table view_preferred_usage
-- select concept.SAB    as SourceVocab, 
--        semantic.STY   as SemanticType, 
--        count(distinct NAMES.CUI)  as cnt, 
--        count(distinct NAMES.CUI)/@cnt  as percent
-- from  NAMES, 
--       MGCONSO as concept, 
--       MGSTY   as semantic
-- where    concept.ISPREF   = 'Y'   and 
-- 	 concept.STT      = 'PF'  and 
--  	 concept.SUPPRESS = 'N'   and  
--  	 concept.CUI      = NAMES.CUI  and 
--  	 concept.CUI      = semantic.CUI 
-- group by SourceVocab, SemanticType 
-- order by cnt desc; 

-- alter table summary_vocabs_semantics change percent percent Float(2) default 0; 

call log('summary_vocabs_semantics', 'done');

-- ################################################################

call log('summary_concept','count #SourceVocab, #SemanticType per concept'); 

drop    table if exists summary_concept; 

create  table summary_concept
select     C.CUI as ConceptID, 
	   count(distinct C.SAB) as cnt_vocab, 
           count(distinct S.STY) as cnt_semtype,
	   count(distinct C.STR) as cnt_names
from       MGCONSO C,
	   MGSTY   S
where      C.CUI = S.CUI 
group by   C.CUI
order by   cnt_semtype desc; 

call log('summary_concept','done'): 

-- ################################################################
call log('view_relate_usage', 'count MedGen relationships');

drop table if exists view_relate_usage; 

select count(distinct RUI) into @cnt from MGREL ; 

create table view_relate_usage
select REL, RELA, SL as SourceVocab, 
       COUNT(distinct RUI)      as cnt, 
       COUNT(distinct RUI)/@cnt as prct
from  MGREL group by REL,RELA, SL order by SL, REL, RELA; 

call log('view_relate_usage', 'done'); 

-- #################################################################
call log('view_medgen_hpo_omim_usage', 'count #relations from OMIM to HPO by type'); 

select count(*) into @cnt from  view_medgen_hpo_omim; 

drop table if exists view_medgen_hpo_omim_usage; 
create table         view_medgen_hpo_omim_usage
   SELECT
    SemanticType,
    OMIM_SemanticType, 
    relationship as OMIM_to_HPO, 
    HPO_SemanticType, 
    count(*) as cnt, 
    count(*)/@cnt as prct 
   FROM     view_medgen_hpo_omim 
   GROUP BY SemanticType, OMIM_SemanticType, relationship, HPO_SemanticType 
   ORDER BY cnt desc; 

-- #################################################################
call log('summary.sql', 'done');
