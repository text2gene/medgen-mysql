call log('count_medgen.sql', 'begin');
-- #################################################################

call log('count_gene_curation', '#genes,#concepts,#omim per clinvar.gene_condition_source_id');

drop   table if exists count_gene_curation; 
create table count_gene_curation
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

insert into count_gene_curation
   select 'NCBI_MEDGEN_CURATION' as Curation, 
     count(distinct GeneID)      as cnt_genes, 
     count(distinct ConceptID)   as cnt_concepts, 
     count(distinct DiseaseMIM)  as cnt_omim
   from 
     clinvar.gene_condition_source_id;

call log('count_gene_curation', 'done');

-- #################################################################

call log('count_vocab', '#concepts per SourceVocab (medgen.NAMES.source)');

drop table if exists count_vocab; 

select count(distinct CUI) into @cnt from NAMES; 

create table count_vocab
select source as SourceVocab, 
       count(distinct CUI)      as cnt_concepts, 
       count(distinct CUI)/@cnt*100 as percent
from NAMES 
group by source order by cnt_concepts desc; 

alter table count_vocab change percent percent Float(2) default 0; 

call log('count_vocab', 'done'); 

-- #################################################################
call log('count_semantics', '#concepts per SemanticType (medgen.MGSTY.STY) .');

select count(*) into @cnt from NAMES; 

drop  table if exists count_semantics; 

create table count_semantics
select semantic.STY   as SemanticType, 
       count(distinct NAMES.CUI)  as cnt_concepts, 
       count(distinct NAMES.CUI)/@cnt*100  as percent
from  NAMES, 
      MGSTY as semantic
where NAMES.CUI = semantic.CUI 
group by SemanticType 
order by cnt_concepts desc; 

alter table count_semantics change percent percent Float(2) default 0; 

call log('count_semantics', 'done'); 

-- #################################################################
call log('count_vocab_semantics', '#concepts per {SourceVocab,SemanticType}');

select count(distinct CUI) into @cnt from NAMES;

drop  table if exists count_vocab_semantics; 

create table count_vocab_semantics
select concept.SAB    as SourceVocab, 
       semantic.STY   as SemanticType, 
       count(distinct NAMES.CUI)  as cnt_concepts, 
       count(distinct NAMES.CUI)/@cnt*100  as percent
from  NAMES, 
      MGCONSO as concept, 
      MGSTY   as semantic
where    concept.CUI  = NAMES.CUI  and 
 	 concept.CUI  = semantic.CUI 
group by SourceVocab, SemanticType 
order by cnt_concepts desc; 

-- alter table count_vocabs_semantics change percent percent Float(2) default 0; 

call log('count_vocabs_semantics', 'done');

-- ################################################################

call log('count_concept','count #SourceVocab, #SemanticType per concept'); 

drop    table if exists count_concept; 

create  table count_concept
select     C.CUI as ConceptID, 
	   count(distinct C.SAB) as cnt_vocabs, 
           count(distinct S.STY) as cnt_semantics,
	   count(distinct C.STR) as cnt_names
from       MGCONSO C,
	   MGSTY   S
where      C.CUI = S.CUI 
group by   C.CUI
order by   cnt_names, cnt_semantics desc; 

call log('count_concept','done'); 

-- ################################################################
call log('count_relations', 'count MedGen relationships');

drop table if exists count_vocab_relations; 

select count(distinct RUI) into @cnt from MGREL ; 

create table count_relations
select REL, RELA, SL as SourceVocab, 
       COUNT(distinct RUI)      as cnt_relations, 
       COUNT(distinct RUI)/@cnt as prct_relations
from  MGREL group by REL,RELA, SL order by SL, REL, RELA; 

call log('count_relations', 'done'); 

-- #################################################################
call log('count_medgen.sql', 'done');
