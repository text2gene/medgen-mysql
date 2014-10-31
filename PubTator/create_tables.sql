-- begin create tables 


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- PubTator tables 
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- PMID | Components | Mentions

-- #mutation2pubtator results are from tmVar.
-- #tmVar: http://www.ncbi.nlm.nih.gov/CBBresearch/Lu/pub/tmVar/
-- #please go to the link below to see our mutation normalization format:
-- #http://www.ncbi.nlm.nih.gov/CBBresearch/Lu/Demo/PubTator/tutorial/tmVar.html

drop table if exists mutation2pubtator; 

create table mutation2pubtator(
       PMID        integer unsigned null, 
       Components  varchar(200), 
       Mentions    Text not null
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

        
-- PMID | EntrezGeneID | Annotator | Mentions

-- #gene2PubTator integrates results from both GenNorm and gene2pubmed
-- #GenNorm: http://ikmbio.csie.ncku.edu.tw/GN/
-- #gene2pubmed: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene2pubmed.gz

-- select count(*) from gene2pubtator where PMID not RLIKE '^[0-9]+$';
-- alter table mutation2pubtator change PMID PMID int(10) unsigned null


drop table if exists gene2pubtator;
create table gene2pubtator( 
       PMID      int(10) unsigned null, 
       GeneID    int(10) unsigned, 
       Annotator varchar(50), 
       Mentions    Text not null
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;  

drop table if exists gene2norm;
drop table if exists gene2pubmed;

create table gene2norm   like gene2pubtator;
create table gene2pubmed like gene2pubtator;
        
-- PMID | MeshID | Mentions

-- #disease2pubtator results are from DNorm 
-- #DNorm: http://www.ncbi.nlm.nih.gov/CBBresearch/Lu/Demo/DNorm/

drop table if exists disease2pubtator; 

create table disease2pubtator(
       PMID      int(10) unsigned null, 
       MeshID    varchar(100), 
       Mentions  Text
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- PMID | MeshID | Mentions
-- 
-- #chemical2pubtator results are based on dictionary match. 

drop table if exists chemical2pubtator; 

create table chemical2pubtator(
       PMID      varchar(10) not null, 
       MeshID    varchar(100), 
       Mentions  Text 
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- PMID    TaxID   Mentions
--
drop table if exists species2pubtator;
create table species2pubtator(
       PMID      varchar(10) not null,
       TaxID     varchar(10),
       Mentions  Text 
)
Engine = InnoDB;
