call log('view_pubmed.sql', 'begin'); 

-- ###################################################
call log('view_pubmed', 'PMID count');

drop table if exists view_pubmed;

create table view_pubmed
select PMID, count(*) as cnt 
from   medgen_pubmed
group by PMID order by cnt desc; 

call utf8_unicode('view_pubmed'); 
call create_index('view_pubmed', 'PMID'); 

call log('view_pubmed', 'done'); 

-- ###################################################
-- end 
-- optional: 

-- begin 
-- ###################################################
call log('view_pubmed_concept', 'Concept Term Frequency');

drop table if exists view_pubmed_concept;

create table view_pubmed_concept 
select   CUI as ConceptID, count(*) as TF                 
from     medgen_pubmed 
group by CUI order by TF desc;

call utf8_unicode('view_pubmed_concept'); 
call create_index('view_pubmed_concept', 'ConceptID'); 

call log('view_pubmed_concept', 'done');

-- begin 
-- ###################################################
call log('view_pubmed_concept_preferred','preferred pubmed concept and semantics'); 

drop   table if exists view_pubmed_concept_preferred; 
create table           view_pubmed_concept_preferred
select distinct PUBMED.TF, Prefer.* from 
       view_pubmed_concept    as PUBMED, 
       view_concept_preferred as Prefer
where  
       PUBMED.ConceptID = Prefer.ConceptID; 

call utf8_unicode('view_pubmed_concept_preferred'); 
call create_index('view_pubmed_concept_preferred', 'ConceptID'); 

-- 
-- end 

-- ###################################################
call log('view_pubmed_disease', 'TF');
drop table if exists view_pubmed_disease; 

create table view_pubmed_disease 
select * from view_pubmed_concept_preferred 
where SemanticType = 'Disease or Syndrome'; 

-- ###################################################
call log('view_pubmed_finding', 'TF');
drop table if exists view_pubmed_disease; 

create table view_pubmed_disease like view_pubmed_concept;
insert into  view_pubmed_disease select * from view_pubmed_concept_preferred
where SemanticType = 'Finding'; 

-- ###################################################
call log('view_pubmed_neoplastic', 'TF');
drop table if exists view_pubmed_neoplastic; 

create table view_pubmed_neoplastic
select * from view_pubmed_concept_preferred 
where SemanticType = 'Neoplastic Process'; 

-- ###################################################
call log('view_pubmed_congenital', 'TF');
drop table if exists view_pubmed_congenital; 

create table view_pubmed_congenital
select * from view_pubmed_concept_preferred 
where SemanticType = 'Congenital Abnormality'; 

-- ###################################################
call log('view_pubmed_cell_dysfunction', 'TF');
drop table if exists view_pubmed_cell_dysfunction; 

create table view_pubmed_cell_dysfunction
select * from view_pubmed_concept_preferred 
where SemanticType = 'Cell or Molecular Dysfunction'; 

-- ###################################################
call log('view_pubmed_pathologic_function', 'TF');
drop table if exists view_pubmed_pathologic_function; 

create table view_pubmed_pathologic_function
select * from view_pubmed_concept_preferred 
where SemanticType = 'Pathologic Function'; 

-- ###################################################
call log('view_pubmed.sql', 'Done'); 
