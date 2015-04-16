call log('create_index.sql', 'begin'); 
--
call log('call utf8 unicode', 'begin');  
--
call utf8_unicode('gene_product');
call utf8_unicode('gene_product_count');
call utf8_unicode('gene_product_seq');
--
call utf8_unicode('association');
call utf8_unicode('evidence');
call utf8_unicode('graph_path');
--
call utf8_unicode('seq');
create table term_copy select * from term;
drop table term;
alter table term_copy rename to term;
call create_index('term', 'name');
call create_index('term', 'term_type');
call utf8_unicode('term');

call utf8_unicode('term2term');
call utf8_unicode('term_definition');

call utf8_unicode('evidence_codes'); 
call utf8_unicode('evidence_provider'); 
--
call log('call utf8 unicode', 'done');  
--
call log('create_index.sql', 'done'); 
