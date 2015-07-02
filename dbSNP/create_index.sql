call log('create_index.sql', 'begin');
-- ###################################

call create_index('hgvs2dbSNP', 'hgvs');
call create_index('hgvs2dbSNP', 'snp');

-- ###################################
call log('create_index.sql', 'done');
