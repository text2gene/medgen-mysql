-- begin create tables 


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- DisGeNET tables 
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

call log('create_tables.sql', 'refresh');

call log('disease2gene', 'refresh');

drop table if exists disease2gene;

create table         disease2gene(
       GeneID        int(10) unsigned,
       Symbol        varchar(25),
       ConceptID     varchar(25),
       ConceptName   varchar(255),
       Score         float(5,4),
       PMID_count    int,
       SNP_count     int,
       SourceVocab   varchar(255)
);


call utf8_unicode('disease2gene'); 

call log('create_tables.sql', 'done');

