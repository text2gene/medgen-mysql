call log('create_index.sql', 'begin'); 

call create_index('file_list', 'PMCID'); 
call create_index('deleted',   'PMID'); 
call create_index('PMC',       'PMID'); 
call create_index('PMC',       'PMCID'); 

call log('create_index.sql', 'done'); 
