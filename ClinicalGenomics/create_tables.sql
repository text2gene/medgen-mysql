-- begin create tables 

call log('create_tables.sql', 'begin');

-- #############################################
call log('gene2condition', 'refresh'); 

drop table if exists gene2condition; 
create table gene2condition(
       hgnc  	     varchar(25), 
       hgnc_id       varchar(25), 
       GeneID	     int(10), 
       ClinicalCond  varchar(255),       
       Inheritance   varchar(255),       
       Age           varchar(255),
       AllelicCond   varchar(255),
       Manifestation varchar(255),         
       Intervention  varchar(255),         
       Rationale     varchar(255),  
       Pubmeds       varchar(255)
)
Engine = MyISAM; 

call utf8_unicode('gene2condition');

-- ####################################

drop table if exists codes;
create table         codes
(
	ClinicalCond  varchar(255),
	CUI           varchar(8)
)
Engine = MyISAM; 

-- #############################################
call log('create_tables.sql', 'done');
