call log('create_index.sql', 'begin'); 

call create_index('gene_condition_source_id', 'GeneID');
call create_index('gene_condition_source_id', 'Symbol');
call create_index('gene_condition_source_id', 'ConceptID');
call create_index('gene_condition_source_id', 'DiseaseName');
call create_index('gene_condition_source_id', 'SourceName');
call create_index('gene_condition_source_id', 'SourceID');
call create_index('gene_condition_source_id', 'DiseaseMIM');

call create_index('disease_names','DiseaseName');
call create_index('disease_names','SourceName');
call create_index('disease_names','SourceID');
call create_index('disease_names','DiseaseMIM');

call create_index('molecular_consequences', 'hgvs_text'); 
call create_index('molecular_consequences', 'SequenceOntologyID'); 
call create_index('molecular_consequences', 'Value');

call create_index('gene_specific_summary','GeneID');
call create_index('gene_specific_summary','Symbol');

call create_index('variant_summary','GeneID');
call create_index('variant_summary','Symbol');
call create_index('variant_summary','variant_type');
call create_index('variant_summary','AlleleID');
call create_index('variant_summary','rs');
call create_index('variant_summary','TestedInGTR');
call create_index('variant_summary','HGVS_c'); 
call create_index('variant_summary','HGVS_p'); 

call create_index('clingen_gene_curation_list','GeneID'); 

call log('create_index.sql', 'done'); 
