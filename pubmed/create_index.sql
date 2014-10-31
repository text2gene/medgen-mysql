call log('create_index.sql', 'begin'); 

call log('file_list', 'index'); 

alter table file_list add index (PMCID);

call log('file_list', 'done'); 
--
--
call log('PMC', 'index'); 

alter table PMC  add index (PMID);
alter table PMC  add index (PMCID, PMID);
alter table PMC  add index (PMID, PMCID);

call log('PMC', 'index done'); 

call log('create_index.sql', 'done'); 
