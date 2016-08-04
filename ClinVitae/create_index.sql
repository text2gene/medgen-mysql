call log('create_index.sql', 'begin');

call create_index('clinvitae_hgvs', 'hgvs_text');
call create_index('clinvitae_hgvs', 'gene');

call log('create_index.sql', 'done'); 
