use pubmed; 

call log('create_tables.sql', 'done');
-- 

call log('file_list', 'create table');

drop table if exists  file_list ; 

create table file_list(
  article_path      text not null,
  journal_volume    text not null,
  PMCID             varchar(10) not null
)
Engine=InnoDB;

call log('file_list', 'done'); 
--
call log('PMC', 'create table');

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
)
Engine=InnoDB;

call log('PMC', 'done');
--
call log('medline', 'http://www.nlm.nih.gov/bsd/licensee/access/medline_pubmed.html');
call log('medline', 'create table');

drop table if exists  medline ; 
create table medline like PMC; 

-- 
call log('create_tables.sql', 'done');
