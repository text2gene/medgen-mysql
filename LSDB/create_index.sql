call log('create_index.sql','Locus Specific Databases'); 
-- #############################################
call log('create_index.sql','cleaning up some cols prior to index....'); 

update bic_brca1 set Codon    = '' where Codon    = '-'; 
update bic_brca1 set AAChange = '' where AAChange = '-'; 
update bic_brca1 set Genotype = '' where Genotype = '-'; 
update bic_brca1 set Evidence = '' where Evidence = '-'; 

-- #############################################
call log('create_index.sql','Locus Specific Databases'); 

call create_index('bic_brca1','HGVS_c_posedit'); 
call create_index('bic_brca1','HGVS_p_posedit'); 
call create_index('bic_brca1','HGVS_g_posedit'); 

call create_index('lovd_installation', 'DbName');
call create_index('lovd_installation', 'DbLocation');


-- #############################################
call log('create_index.sql','done'); 
