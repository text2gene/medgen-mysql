-- "GTR Genetic Test Registry ... "
-- 
--  ftp.ncbi.nlm.nih.gov/pub/GTR/_README.html
-- 

call log('test_condition_gene','refresh'); 
-- 
drop table if exists test_condition_gene; 

create table test_condition_gene(
       test_accession_ver varchar(20),
       GeneTestsID  	  varchar(20),
       test_type          varchar(20),
       concept_type	  varchar(20), 
       GTR_identifier     varchar(20), 
       MIM_number         varchar(20), 
       umls_name     	  varchar(1000), 
       gene_or_SNOMED_CT_ID varchar(20)
); 
call utf8_unicode('test_condition_gene'); 
-- end

-- begin 
call log('test_version', 'refresh'); 

drop table if exists test_version; 
create table         test_version(
	test_accession_ver       varchar(20), 
	name_of_laboratory       text null, 
	name_of_institution      text null, 
	facility_state           text null,   
	facility_postcode        text null,        
	facility_country         text null,         
--	genetests_laboratory_id  text null, 
	CLIA_number              text null,      
	state_licenses           text null,   
	state_license_numbers    text null,    
	lab_test_id              text null,       
	last_touch_date          text null,    
	lab_test_name		 text null,    
	manufacturer_test_name   text null,   
	test_development         text null,         
	lab_unique_code          text null, 
	condition_identifiers    text null,     
	indication_types         text null,         
	inheritances             text null,     
	method_categories        text null,        
	methods                  text null,        
	platforms                text null,        
	genes                    text null,    
	drug_responses           text null,    
	now_current              smallint null,    
	test_currStat            smallint null,    
	test_pubStat             smallint null,    
	lab_currStat             smallint null,    
	lab_pubStat              smallint null,    
	test_create_date         smallint null
); 
call utf8_unicode('test_version'); 
-- end 

-- begin
call log('tests_by_method_category','refresh'); 

drop table if exists tests_by_method_category; 
     
-- MajorMethodCategory   "Molecular Genetics" 
-- Method category 	 "Microsatellite instability testing (MSI)" 
-- Total Labs with clinical tests  12
-- US Labs with clinical tests     4
-- Total Labs with research tests  0 
-- US Labs with research tests     0

create table tests_by_method_category(
       CategoryMajor                varchar(50), 
       Category	    		    varchar(50),
       WithClinicalTests   	    int, 
       WithClinicalTestsUSA   	    int, 
       WithResearchTests   	    int,
       WithResearchTestsUSA   	    int
); 
-- end 



-- begin
call log('labs_tests_by_country','refresh'); 

drop table if exists labs_tests_by_country; 

create table labs_tests_by_country(
       Country             varchar(20), 
       RegisteredLabs	   int,
       WithClinicalTests   int, 
       WithResearchTests   int
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 
-- end

-- begin 
call log('mode_of_inheritance', 'refresh'); 

drop table if exists mode_of_inheritance; 

create table mode_of_inheritance(
     HPO_name  varchar(100), 
     HPO_ID    varchar(10)
); 

call utf8_unicode('mode_of_inheritance'); 
-- end 

call log('create_tables','done'); 
