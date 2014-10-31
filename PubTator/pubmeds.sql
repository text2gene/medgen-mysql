-- TODO: DRY: FabFile 
-- ################################################################################################

use PubTator; 

call log('pubmeds.sql','begin'); 

-- ################################################################################################
--
call log('PubTator.pubmeds', 'mutation2pubtator.PMID'); 

drop table if exists PubTator.pubmeds; 
create table pubmeds( PMID int(10) not null unique key ) Engine=InnoDB; 

insert into pubmeds 
select distinct PMID from mutation2pubtator order by PMID; 

call log('PubTator.pubmeds', 'done'); 

-- ################################################################################################

drop table if exists PubTator.gene2norm;
drop table if exists PubTator.gene2pubmed;
drop table if exists PubTator.medgen2pubmed;

-- ################################################################################################
-- PubTator.gene2pubtator 
-- 

call log('gene2pubtator','split gene annotators'); 

create table PubTator.gene2Norm          select PMID, GeneID, Mentions  from gene2pubtator where Annotator = 'GenNorm'; 
create table PubTator.gene2pubmed        select PMID, GeneID, Mentions  from gene2pubtator where Annotator = 'gene2pubmed'; 
create table PubTator.medgen2pubmed      select PMID from medgen.pubmeds; 
create table PubTator.medgen2pubmed_cnt  select PMID, count(distinct CUI) as cnt from medgen.medgen_pubmed group by PMID; 

call log('gene2pubtator','done');
call mem; 

call log('GenNorm','PMID');
alter table PubTator.gene2norm      add index(PMID); 

call log('gene2pubmed','PMID');
alter table PubTator.gene2pubmed    add index(PMID); 

call log('medgen2pubmed','PMID');
alter table PubTator.medgen2pubmed  add index(PMID); 

-- -------------------------------------------------------------------------------------------
-- PubTator.pubmeds 
-- 
-- columns: [PMID | gene2pubtator | gene2pubmed | gene2norm | gene2medgen ]
-- -------------------------------------------------------------------------------------------

call log('pubmeds','add columns'); 

alter table pubmeds add column gene2norm boolean null; 
update PubTator.pubmeds P, 
gene2norm Norm set 
P.gene2norm=TRUE where 
Norm.PMID = P.PMID; 

alter table pubmeds add column gene2pubmed boolean null;
update PubTator.pubmeds P, 
gene2pubmed GENE set 
P.gene2pubmed=TRUE where 
GENE.PMID = P.PMID;

alter table pubmeds add column medgen2pubmed boolean null;
update PubTator.pubmeds P, 
medgen2pubmed M set 
P.medgen2pubmed=TRUE where 
M.PMID = P.PMID; 


-- -------------------------------------------------------------------------------------------
-- PubTator.pubmeds 
-- 
-- columns: [cnt_mutation | cnt_gene | cnt_norm | cnt_medgen | cnt_chemical | cnt_disease  ]
-- -------------------------------------------------------------------------------------------

create table mutation2pubtator_cnt select PMID, count(distinct Components) as cnt from PubTator.mutation2pubtator group by PMID; 
create table gene2pubtator_cnt select PMID, count(distinct GeneID) as cnt from PubTator.gene2pubtator group by PMID; 
-- TODO: medgen is above (TODO: FabFile ) 

alter table pubmeds add column cnt_pubtator boolean null;
alter table pubmeds add column cnt_gene     boolean null;
alter table pubmeds add column cnt_norm     boolean null;
alter table pubmeds add column cnt_medgen   boolean null;
alter table pubmeds add column cnt_chemical boolean null;
alter table pubmeds add column cnt_disease  boolean null;

-- ################################################################################################
-- medgen.pubmeds 
-- 

call log('medgen.pubmeds','PMID');

create table pubmeds_medgen select * from medgen.pubmeds ; 

call log('medgen.pubmeds','PMID');
call mem; 

-- ################################################################################################
-- 
-- PubTator.species2pubtator 
-- 
--  This table 
-- 
create table human2pubmed select * from species2pubtator where TaxID = 9606; 

-- ################################################################################################
call log('pubmeds.sql','done'); 
