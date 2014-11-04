-- begin create tables 

call log('create_tables.sql', 'begin');

-- #############################################
call log('CGD', 'Clinical Genomics Database'); 

drop table if exists CGD; 
create table CGD (
       hgnc  	  text, 
       hgnc_id    text, 
       gene_id	  text, 
       cond          text,       
       inheritance   text, 
       age_group     text,
       allelic_cond  text,
       manifestation text,         
       intervention  text,         
       rationale     text,  
       refs          text
)
Engine=InnoDB; 
-- #############################################
call log('create_tables.sql', 'done');
