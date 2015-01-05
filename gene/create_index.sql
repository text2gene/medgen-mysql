call log('create_index.sql','NCBI Entrez Gene'); 

call log('create_index.sql','cleaning up some cols prior to index....'); 

update gene.mim2gene_medgen set MIM_vocab='' where MIM_vocab = '-'; 
update gene.mim2gene_medgen set MedGenCUI='' where MedGenCUI = '-'; 

call log('create_index.sql' ,'OK, continuing...'); 

call create_index('gene2pubmed','tax_id'); 
call create_index('gene2pubmed','GeneID'); 
call create_index('gene2pubmed','PMID'); 

call create_index('mim2gene_medgen','MIM');
call create_index('mim2gene_medgen','GeneID'); 
call create_index('mim2gene_medgen','MedGenCUI'); 

call create_index('gene2go','tax_id'); 
call create_index('gene2go','GeneID'); 

call create_index('gene_group','tax_id'); 
call create_index('gene_group','GeneID'); 

call create_index('gene_info','tax_id'); 
call create_index('gene_info','GeneID'); 

call create_index('gene2accession','tax_id'); 
call create_index('gene2accession','GeneID'); 

call create_index('gene2accession','RNA_acc_ver'); 
call create_index('gene2accession','Protein_acc_ver'); 
call create_index('gene2accession','Genomic_acc_ver'); 

call create_index('generifs_basic','tax_id'); 
call create_index('generifs_basic','GeneID'); 

call log('create_index.sql','done'); 
