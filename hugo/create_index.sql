call log('create_index.sql','NCBI Entrez Gene'); 

call create_index('hugo2pubmed','hgnc'); 
call create_index('hugo2pubmed','Symbol'); 
call create_index('hugo2pubmed','GeneID'); 

call create_index('hugo2entrez','hgnc'); 
call create_index('hugo2entrez','Symbol'); 
call create_index('hugo2entrez','GeneID'); 

call create_index('hugo2entrez2omim','hgnc'); 
call create_index('hugo2entrez2omim','Symbol'); 
call create_index('hugo2entrez2omim','GeneID'); 
call create_index('hugo2entrez2omim','omim'); 

call create_index('hugo_info','hgnc'); 
call create_index('hugo_info','Symbol'); 

call log('create_index.sql','done'); 
