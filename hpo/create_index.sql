call log('create_index.sql', 'begin'); 

-- ###################################

call create_index('gene2disease', 'GeneID');
call create_index('gene2disease', 'Symbol');
call create_index('gene2disease', 'DiseaseText');

-- ###################################

call create_index('disease2gene', 'GeneID');
call create_index('disease2gene', 'Symbol');
call create_index('disease2gene', 'DiseaseText');

-- ###################################

call create_index('disease2gene2phenotypes', 'GeneID');
call create_index('disease2gene2phenotypes', 'Symbol');
call create_index('disease2gene2phenotypes', 'PhenotypeID');
call create_index('disease2gene2phenotypes', 'PhenotypeName');
call create_index('disease2gene2phenotypes', 'DiseaseText');

-- ###################################

call log('create_index.sql', 'done'); 
