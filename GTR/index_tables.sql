call log('index_tables.sql', 'begin');

call create_index('test_condition_gene', 'GeneTestsID');
call create_index('test_condition_gene', 'test_type');
call create_index('test_condition_gene', 'GTR_identifier');
call create_index('test_condition_gene', 'MIM_number');
call create_index('test_condition_gene', 'concept_type');
call create_index('test_condition_gene', 'concept_type, gene_or_SNOMED_CT_ID');

call log('index_tables.sql', 'done');
