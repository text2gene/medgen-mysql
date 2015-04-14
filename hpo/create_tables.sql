call log('create_tables.sql', 'begin'); 

-- ###################################
call log('gene2disease','begin'); 

drop table if exists gene2disease; 

create table gene2disease( 
       GeneID       int(10) unsigned default 0, 
       Symbol       varchar(25)      default null, 
       DiseaseText  varchar(25)      default null
); 

call utf8_unicode('gene2disease');

-- ###################################
call log('disease2gene','begin'); 

drop table if exists disease2gene; 

create table disease2gene( 
       DiseaseText  varchar(25)      default null,
       GeneID       int(10) unsigned default 0, 
       Symbol       varchar(25)      default null 
); 

call utf8_unicode('disease2gene');

-- ###################################
call log('disease2gene2phenotypes','begin'); 

drop table if exists disease2gene2phenotypes; 

create table disease2gene2phenotypes( 
       DiseaseText    varchar(25)      default null,
       Symbol         varchar(25)      default null, 
       GeneID         int(10) unsigned default 0, 
       PhenotypeID    varchar(25)      default null, 
       PhenotypeName  varchar(200)     default null
); 

call utf8_unicode('disease2gene2phenotypes');
-- ###################################

call log('phenotype2gene', 'begin');

drop table if exists phenotype2gene; 

create table phenotype2gene(
       PhenotypeID    varchar(25)      default null, 
       PhenotypeName  varchar(200)     default null,
       GeneID         int(10) unsigned default 0, 
       Symbol         varchar(25)      default null
); 

call utf8_unicode('phenotype2gene');


-- ###################################

call log('gene2phenotype', 'begin');

drop table if exists gene2phenotype; 

create table gene2phenotype(
       GeneID         int(10) unsigned default 0,
       Symbol         varchar(25)      default null,
       PhenotypeName  varchar(200)     default null,
       PhenotypeID    varchar(25)      default null
); 

call utf8_unicode('gene2phenotype');

-- ###################################

call log('create_tables.sql', 'done'); 
