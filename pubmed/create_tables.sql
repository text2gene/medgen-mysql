call log('file_list', 'refresh');

drop table if exists  file_list ; 

create table file_list (
  article_path      text not null,
  journal_volume    text not null,
  PMCID             varchar(10) not null
); 
call utf8_unicode('file_list'); 

-- ###################################
call log('PMC', 'refresh');

drop table if exists  PMC ; 

create table PMC (
  Journal	       varchar(100), 
  ISSN		       varchar(10), 
  eISSN                varchar(10), 
  Year                 varchar(9), 
  Volume 	       varchar(25), 
  Issue		       varchar(150), 
  Page		       varchar(200), 
  DOI		       varchar(100), 
  PMCID		       varchar(20) null, 
  PMID		       int(10) unsigned null, 
  ManuscriptID	       varchar(20) null, 
  ReleaseDate	       varchar(20) null
);
call utf8_unicode('PMC');


-- ###################################
call log('PMC', 'refresh');

drop table if exists  DOAJ ; 

create table DOAJ (
  Title	     	       varchar(200) not null, 
  TitleAlt	       varchar(200)     null, 
  Identifier           varchar(255)     null, 
  Publisher            varchar(200)     null, 
  Language 	       varchar(100)	null,
  ISSN 		       varchar(10)      null,
  EISSN 	       varchar(10),
  Keyword 	       varchar(255)     null, 
  StartYear 	       int(4)           null,
  EndYear 	       int(4)           null,
  AddedDate 	       varchar(20)      null,      
  Subjects 	       text             null, 
  Country 	       varchar(50)      null,
  PublicationFee       text             null,
  FurtherInfo	       text             null,
  CreativeCommons      varchar(10)      null,
  ContentInDOAJ        varchar(200)     null 
);
call utf8_unicode('DOAJ'); 


-- ###################################

call log('deleted', 'refresh');
drop table if exists deleted; 

create table deleted
(
  PMID int(10) unsigned null
); 

call utf8_unicode('deleted');


-- ###################################

call log('medline_xml', 'refresh');
drop table if exists medline_xml; 

create table medline_xml
(
  PMID int(10) unsigned null,
  XML  longtext null, 
  Tstamp   timestamp  not null default CURRENT_TIMESTAMP  
); 

call utf8_unicode('medline_xml'); 

-- ###################################

call log('create_tables.sql', 'done');
