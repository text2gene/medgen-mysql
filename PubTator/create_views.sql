-- Pubmeds about humans 
-- #################################################################
select 9606 into @human; 

drop table if exists view_pubtator2human; 
create table         view_pubtator2human
select   distinct PMID
from     PubTator.species2pubtator 
where    TaxID = @human;

call create_index('view_pubtator2human','PMID'); 
-- #################################################################


-- PMID count Gene(s) 
-- #################################################################
drop table if exists count_pubtator2gene; 
create table         count_pubtator2gene
select   PMID, count(*) as gene_mentions
from     PubTator.gene2pubmed 
group by PMID order by gene_mentions desc;

call create_index('count_pubtator2gene','PMID'); 
-- #################################################################


-- PMID count Mutation(s) 
-- #################################################################
drop table if exists count_pubtator2mutation; 
create table         count_pubtator2mutation
select   PMID, count(*) as mutation_mentions
from     PubTator.mutation2pubtator
group by PMID order by mutation_mentions desc;
--
call create_index('count_pubtator2mutation','PMID'); 
-- #################################################################


-- PMID count disease(s) 
-- #################################################################
drop table if exists count_pubtator2disease; 
create table         count_pubtator2disease
select   PMID, count(*) as disease_mentions
from     PubTator.disease2pubtator
group by PMID order by disease_mentions desc;
-- 
call create_index('count_pubtator2disease', 'PMID');
-- #################################################################


-- PMID count chemical(s) 
-- #################################################################
drop table if exists view_pubtator2chemical; 
create table         view_pubtator2chemical
select   PMID, count(*) as chemical
from     PubTator.chemical2pubtator
group by PMID order by chemical desc;

call log('view_pubtator2chemical', 'PMID');
-- #################################################################






-- Drop down, increase speed, and reverse direction ! 
--      Futurama 





-- Gene count PMID(s) 
-- #################################################################
drop table if exists count_gene2pubtator; 
create table         count_gene2pubtator
select   GeneID, count(distinct PMID) as count_pubmed
from     PubTator.gene2pubmed 
group by GeneID order by count_pubmed desc;

call create_index('count_gene2pubtator','GeneID'); 
-- #################################################################


-- Mutation count PMID(s)
-- #################################################################
drop table if exists count_mutation2pubtator; 
create table         count_mutation2pubtator
select   Components as Mutation, count(distinct PMID) as count_pubmed 
from     PubTator.mutation2pubtator
group by Mutation order by count_pubmed desc;

call create_index('count_mutation2pubtator','Mutation'); 
-- #################################################################





-- #################################################################
-- TODO: Later integrate with MedGen Concepts 
-- 
-- #################################################################

-- -- PMID count disease(s) 
-- -- #################################################################
-- drop table if exists count_pubtator2disease; 
-- create table         count_pubtator2disease
-- select   PMID, count(*) as disease_mentions
-- from     PubTator.disease2pubtator
-- group by PMID order by disease_mentions desc;
-- -- 
-- call create_index('count_pubtator2disease', 'PMID');
-- -- #################################################################


-- -- chemical count PMID(s) 
-- -- #################################################################
-- drop table if exists count_chemical2pubtator; 
-- create table         count_chemical2pubtator
-- select   MeshID, count(*) as pubtator
-- from     PubTator.chemical2pubtator
-- group by MeshID order by pubtator desc;
-- call log('view_chemical2pubtator', 'MeshID');
-- -- #################################################################
