call log('count_pubmed.sql', 'begin'); 

-- ###################################################
call log('count_pubmed', 'PMID count');

drop table if exists count_pubmed;

create table count_pubmed
select PMID, count(*) as cnt_concepts
from   medgen_pubmed
group by PMID order by cnt_concepts desc; 

call utf8_unicode('count_pubmed'); 
call create_index('count_pubmed', 'PMID'); 

call log('count_pubmed', 'done'); 

-- ###################################################
call log('count_pubmed_concept', 'Concept Term Frequency');

drop table if exists count_pubmed_concept;

create table count_pubmed_concept
select   CUI as ConceptID, count(*) as cnt_pmid                 
from     medgen_pubmed 
group by ConceptID order by cnt_pmid desc;

call utf8_unicode('count_pubmed_concept'); 
call create_index('count_pubmed_concept', 'ConceptID'); 

call log('count_pubmed_concept', 'done');

-- ###################################################
-- call log('count_pubmed_semantics', 'SemanticType Frequency');

-- -- 'Finding'
-- -- 'Disease or Syndrome'
-- -- 'Pathologic Function'
-- -- 'Neoplastic Process'
-- -- 'Congenital Abnormality'
-- -- 'Cell or Molecular Dysfunction'

-- drop table if exists count_pubmed_semantics ; 

-- create table count_pubmed_semantics
-- select   SemanticType, 	 
-- 	 count(*)             as cnt,
-- 	 count(distinct PMID) as cnt_pmid,                 
-- 	 count(distinct CUI)  as cnt_CUI               	 
-- from     medgen_pubmed  as P, 	 
-- 	 view_semantics as S
-- where    P.CUI = S.ConceptID 	
-- group by SemanticType       	 
-- order by cnt_pmid desc;

-- call utf8_unicode('count_pubmed_concept'); 
-- call create_index('count_pubmed_concept', 'SemanticType'); 

-- call log('count_pubmed_semantics', 'done');
-- ###################################################

-- ###################################################
call log('count_pubmed.sql', 'Done'); 
