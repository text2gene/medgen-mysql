call log('create_index.sql', 'begin');

call create_index('variant_results', 'hgvs_text');
call create_index('variant_results', 'gene');

call log('create_index.sql', 'done'); 
