use pubmed; 

call log('create_tables.sql', 'done');
-- 

-- ###################################
call log('file_list', 'refresh');

drop table if exists  file_list ; 

create table file_list(
  article_path      text not null,
  journal_volume    text not null,
  PMCID             varchar(10) not null
)
call utf8_unicode('file_list'); 

-- ###################################
call log('PMC', 'refresh');

drop table if exists  PMC ; 

create table PMC (
  Journal	       text, 
  ISSN		       text, 
  eISSN                text, 
  Year                 text, 
  Volume 	       text, 
  Issue		       text, 
  Page		       text, 
  DOI		       text, 
  PMCID		       varchar(20) null, 
  PMID		       int(10) unsigned null, 
  ManuscriptID	       text null, 
  ReleaseDate	       text null
);
call utf8_unicode('PMC'); 


-- ###################################

call log('deleted', 'refresh');
drop table if exists deleted; 

create table deleted
(
  PMID int(10) unsigned null
); 

call utf8_unicode('deleted');


-- ###################################

call log('pubmed_xml', 'refresh');
drop table if exists pubmed_xml; 

create table pubmed_xml
(
  PMID int(10) unsigned null,
  XML  longtext null, 
  Tstamp   timestamp  not null default CURRENT_TIMESTAMP  
); 

call utf8_unicode('pubmed_xml'); 

-- ###################################

call log('create_tables.sql', 'done');
