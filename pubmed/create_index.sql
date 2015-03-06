call log('create_index.sql', 'begin'); 

call create_index('file_list', 'PMCID'); 
call create_index('deleted',   'PMID');

call create_index('PMC',       'PMID'); 
call create_index('PMC',       'PMCID');
call create_index('PMC',       'DOI');
call create_index('PMC',       'Year');
call create_index('PMC',       'Journal'); 

call create_index('medline_xml', 'PMID'); 

call log('create_index.sql', 'done'); 
