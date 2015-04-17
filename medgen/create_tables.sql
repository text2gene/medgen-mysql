-- file: MGCONSO.RRF 
-- 	 Concepts related to medical genetics 

drop table if exists MGCONSO; 

CREATE TABLE MGCONSO (
       CUI       char(8)	NOT NULL,
       TS        char(1)    	NOT NULL,
       STT       varchar(3) 	NOT NULL,
       ISPREF    char(1)    	NOT NULL,
       AUI       varchar(9) 	NOT NULL,
       SAUI      varchar(50) 	DEFAULT NULL,
       SCUI      varchar(100) 	DEFAULT NULL,
       SDUI      varchar(100) 	DEFAULT NULL,
       SAB       varchar(40)  	NOT NULL,
       TTY       varchar(40)  	NOT NULL,
       CODE      varchar(100) 	NOT NULL,
       STR       text 	       	NOT NULL,
       SUPPRESS  char(1)   	NOT NULL
); 
call utf8_unicode('MGCONSO'); 

--  file: MERGED.RRF 
--  	  Merged concepts
drop table if exists MGMERGED; 

CREATE TABLE MGMERGED (
       CUI   char(8) NOT NULL,
       toCUI char(8) NOT NULL
); 

call utf8_unicode('MGMERGED'); 

--  file: MedGen_CUI_history.txt
--  	  Concept history 
drop table if exists MGHISTORY; 

create table MGHISTORY(
     Previous_CUI    char(8),
     Current_CUI     char(8),
     Date_Of_Action  text 
); 

call utf8_unicode('MGHISTORY'); 

-- file: MGDEF.RRF 
-- 	 Definitions of medical concepts and their sources 
-- 
-- 
drop table if exists MGDEF; 

create table MGDEF( 
  CUI char(8) NOT NULL,
  DEF text NOT NULL,
  SAB varchar(75) NOT NULL,
  SUPPRESS char(1) NOT NULL
); 

call utf8_unicode('MGDEF'); 

--  file: MGREL.RRF 
--  	  Relationships between concepts, concept can be 
-- 
--		disease:gene 
--   		disease:phenotype
--  		disease:disease
--   		gene:phenotype 
--   		gene:gene
-- 		umls:umls 

drop table if exists MGREL; 

create table MGREL(
  CUI1 char(8) NOT NULL,
  AUI1 varchar(9) DEFAULT NULL,
  STYPE1 varchar(50) NOT NULL,
  REL varchar(4) NOT NULL,
  CUI2 char(8) NOT NULL,
  AUI2 varchar(9) DEFAULT NULL,
  -- STYPE2 varchar(50) NOT NULL,
  RELA varchar(100) DEFAULT NULL,
  RUI varchar(10) NOT NULL,
  -- SRUI varchar(50) DEFAULT NULL,
  SAB varchar(40) NOT NULL,
  SL varchar(40) NOT NULL,
  -- RG varchar(10) DEFAULT NULL,
  -- DIR varchar(1) DEFAULT NULL,
  SUPPRESS char(1) NOT NULL,
  -- CVF int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (RUI),
  KEY X_MRREL_CUI1 (CUI1),
  KEY X_MRREL_AUI1 (AUI1),
  KEY X_MRREL_CUI2 (CUI2),
  KEY X_MRREL_AUI2 (AUI2),
  KEY X_MRREL_SAB (SAB) 
); 

call utf8_unicode('MGREL'); 

drop table if exists MGREL;  -- TODO: UMLS link 

create table MGREL(
  CUI1 char(8) NOT NULL,
  AUI1 varchar(9) DEFAULT NULL,
  STYPE1 varchar(50) NOT NULL,
  REL varchar(4) NOT NULL,
  CUI2 char(8) NOT NULL,
  AUI2 varchar(9) DEFAULT NULL,
  RELA varchar(100) DEFAULT NULL,
  RUI varchar(10) NOT NULL,
  SAB varchar(40) NOT NULL,
  SL varchar(40) NOT NULL,
  SUPPRESS char(1) NOT NULL
); 

call utf8_unicode('MGREL'); 

-- file: MGSAT.RRF 
-- 	 Attributes of Medical Genetics Concepts ( Links in UMLS ) 

drop table if exists MGSAT; 

create table MGSAT(

  CUI char(8) NOT NULL,
  -- LUI varchar(10) DEFAULT NULL,
  -- SUI varchar(10) DEFAULT NULL,
  METAUI varchar(100) DEFAULT NULL,
  STYPE varchar(50) NOT NULL,
  CODE varchar(100) DEFAULT NULL,
  ATUI varchar(11) NOT NULL,
  -- SATUI varchar(50) DEFAULT NULL,
  ATN varchar(100) NOT NULL,
  SAB varchar(40) NOT NULL,
  ATV text,
  SUPPRESS char(1) NOT NULL,
  -- CVF int(10) unsigned DEFAULT NULL,
  KEY X_MRSAT_CUI (CUI),
  KEY X_MRSAT_METAUI (METAUI),
  KEY X_MRSAT_SAB (SAB),
  KEY X_MRSAT_ATN (ATN)
); 

call utf8_unicode('MGSAT'); 

-- file: MGSTY.RRF 
-- 	 Semantic types for Medical Genetics Concepts ( Links in UMLS ) 

drop table if exists MGSTY; 

create table MGSTY(
  CUI char(8) NOT NULL,
  TUI char(4) NOT NULL,
  STN varchar(100) NOT NULL,
  STY varchar(50) NOT NULL,
  ATUI varchar(11) NOT NULL,
  -- CVF int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (ATUI),
  KEY X_MRSTY_CUI (CUI),
  KEY X_MRSTY_STY (STY)
); 

call utf8_unicode('MGSTY'); 

--  file: NAMES
--  	  Names and summary data for concepts 

drop table if exists NAMES; 

create table NAMES(
  CUI char(8) NOT NULL,
  name   varchar(1000) not null, 
  source varchar(20)   not null, 
  SUPPRESS char(1) NOT NULL
); 

call utf8_unicode('NAMES'); 

--  file: medgen_pubmed
--  	  Pubmed references to medgen concepts 

drop table if exists medgen_pubmed; 

create table medgen_pubmed(
       UID varchar(10) not null, 
       CUI char(8) NOT NULL,
       NAME varchar(1000) not null, 
       PMID int(10) unsigned 
) ;

call utf8_unicode('medgen_pubmed'); 

-- file: pubmed_cited
-- 	 OMIM pubmed citations

drop   table if exists omim_pubmed;
create table           omim_pubmed(
       MIM           int null,
       refnumber     int null,
       PMID    int(10) unsigned
);
call utf8_unicode('omim_pubmed'); 

--  file: MedGen_HPO_Mapping.txt 
--  	  HPO references to medgen concepts 

drop table if exists medgen_hpo; 

create table medgen_hpo(
       CUI       char(8)        NOT NULL,
       SDUI      varchar(100) 	DEFAULT NULL,
       HpoStr	 text           not null, 
       MedGenStr text           not null, 
       MedGenStr_SAB            varchar(20) not null, 
       STY varchar(50)          not null
); 

call utf8_unicode('medgen_hpo'); 

--  file: MedGen_HPO_OMIM_Mapping.txt
--  	  MedGen processing of HPO and OMIM terms uniformly 

-- OMIM_CUI	 concept unique identifier assigned to a record from OMIM
-- MIM_number	 MIM number defining the record from OMIM
-- OMIM_name	 preferred term from OMIM
-- relationship	 relationship of the term from HPO to the record from OMIM. 
--   		 Constructions like 'not_manifestation_of' are used to represent the 'not' qualifier for a relationship.

-- HPO_CUI	 Concept UID (CUI) assiged to the term from HPO
-- HPO_name	 preferred term from HPO
-- HPO_CUI	 Concept UID (CUI) assiged to the term from HPO
-- MedGen_name	 preferred term used in MedGen
-- MedGen_source	 source of the term used preferentially by MedGen
-- STY	 semantic type

drop table if exists medgen_hpo_omim; 

create table medgen_hpo_omim(
       -- omim 
       OMIM_CUI char(8) NOT NULL,
       MIM_number varchar(20) null, 
       OMIM_name  text null, 
       -- relationship
       relationship varchar(50) null, 
       -- hpo 
       HPO_CUI char(8) NOT NULL,
       HPO_ID  varchar(20) null, 
       HPO_name text null, 
       -- medgen 
       MedGen_name  text null, 
       MedGen_source  varchar(20) null, 
       -- semantic type 
       STY varchar(50) NOT NULL
);

call utf8_unicode('medgen_hpo_omim'); 
