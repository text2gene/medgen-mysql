call log('create_index.sql', 'begin'); 

call create_index('file_list', 'PMCID'); 
call create_index('deleted',   'PMID');

call create_index('PMC',       'PMID'); 
call create_index('PMC',       'PMCID');
call create_index('PMC',       'DOI');

call create_index('PMC',       'Journal'); 
call create_index('PMC',       'ISSN');
call create_index('PMC',       'eISSN');
call create_index('PMC',       'Issue');
call create_index('PMC',       'Page');
call create_index('PMC',       'Volume');
call create_index('PMC',       'Year');

call create_index('pubmed_xml', 'PMID'); 

call log('create_index.sql', 'done'); 
