call log('create_index.sql','begin'); 

call create_index('genesymbol','NBK_id'); 
call create_index('genesymbol','GR_shortname'); 
call create_index('genesymbol','genesymbol'); 

call create_index('title','NBK_id'); 
call create_index('title','GR_shortname'); 
call create_index('title','GR_title'); 

call create_index('omim','NBK_id'); 
call create_index('omim','GR_shortname'); 
call create_index('omim','OMIM'); 

call log('create_index.sql','done'); 
