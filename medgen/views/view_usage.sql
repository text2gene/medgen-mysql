call log('view_usage.sql', 'begin');

-- ############################################
--    NCBI MedGen Human Curation Summary 
-- ############################################
--  20 Contributors 
--  Disease Gene Human Expert Curation 
--  Usage Statistics (Genes Concepts Diseeases)
-- ############################################

call log('view_curation_usage', '#genes,#concepts,#diseases per curator');

drop   table if exists view_curation_usage; 
create table view_curation_usage
   select SourceName as Curation, 
     count(distinct GeneID)     as cnt_genes, 
     count(distinct ConceptID)  as cnt_concepts, 
     count(distinct DiseaseMIM) as cnt_diseases
   from 
     clinvar.gene_condition_source_id
   group by SourceName 
   order by cnt_genes desc ;

-- medgen all source vocabularies 
-- that contribute annotations by human experts  

insert into view_curation_usage 
   select 'NCBI_MEDGEN_CURATION' as Curation, 
     count(distinct GeneID)      as cnt_gene, 
     count(distinct ConceptID)   as cnt_concepts, 
     count(distinct DiseaseMIM)  as cnt_diseases
   from 
     clinvar.gene_condition_source_id;

call log('view_curation_usage', 'done');

-- #################################################################
call log('view_vocab_usage', 'NCBI preferred terms counts for GTR/MedGen/etc.');

drop table if exists view_vocab_usage; 

select count(*) into @cnt from NAMES; 

create table view_vocab_usage 
select source as SourceVocab, 
       count(distinct NAMES.CUI)      as cnt, 
       count(distinct NAMES.CUI)/@cnt as percent
from NAMES 
group by source order by cnt desc; 

alter table view_vocab_usage change percent percent Float(2) default 0; 

call log('view_vocab_usage', 'done'); 

-- #################################################################
call log('view_semantic_usage', 'Preferred use of SemanticTypes byGTR/MedGen/etc.');

select count(distinct CUI) into @cnt from NAMES; 

drop  table if exists view_semantic_usage; 

create table view_semantic_usage
select semantic.STY   as SemanticType, 
       count(distinct NAMES.CUI)  as cnt, 
       count(distinct NAMES.CUI)/@cnt  as percent
from  NAMES, 
      MGCONSO as concept, 
      MGSTY   as semantic
where    NAMES.CUI = concept.CUI  and 
         NAMES.CUI = semantic.CUI 
group by SemanticType 
order by cnt desc; 

alter table view_semantic_usage change percent percent Float(2) default 0; 

call log('view_semantic_usage', 'done'); 

-- #################################################################
call log('view_preferred_usage', 'Preferred use of SourceVocab:SemanticType');

select count(distinct CUI) into @cnt from NAMES;

drop  table if exists view_preferred_usage; 

create table view_preferred_usage
select concept.SAB    as SourceVocab, 
       semantic.STY   as SemanticType, 
       count(distinct NAMES.CUI)  as cnt, 
       count(distinct NAMES.CUI)/@cnt  as percent
from  NAMES, 
      MGCONSO as concept, 
      MGSTY   as semantic
where    concept.ISPREF   = 'Y'   and 
	 concept.STT      = 'PF'  and 
 	 concept.SUPPRESS = 'N'   and  
 	 concept.CUI      = NAMES.CUI  and 
 	 concept.CUI      = semantic.CUI 
group by SourceVocab, SemanticType 
order by cnt desc; 

alter table view_preferred_usage change percent percent Float(2) default 0; 

call log('view_preferred_usage', 'done'); 

-- ################################################################
call log('view_concept_usage','count SemanticTypes per concept'); 

drop    table if exists view_concept_usage; 

create  table view_concept_usage
select     CUI as ConceptID, 
           count(distinct STY) as cnt_semtype
from       MGSTY 
group by   CUI
order by   cnt_semtype desc; 

call log('view_concept_usage','done'): 

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
call log('view_usage.sql', 'EOF');
