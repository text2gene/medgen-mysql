call log('medgen.view_gene2accession', 'begin');
-- ###################################################

drop table if exists 
medgen.view_gene2accession; 

create table  
medgen.view_gene2accession
select * from gene.gene2accession where RNA_acc_ver like 'NM_%'; 

call medgen.create_index('medgen.view_gene2accession','GeneID'); 
call medgen.create_index('medgen.view_gene2accession','RNA_acc_ver'); 
call medgen.create_index('medgen.view_gene2accession','GeneID, RNA_acc_ver'); 
call medgen.create_index('medgen.view_gene2accession','tax_id'); 
call medgen.create_index('medgen.view_gene2accession','assembly'); 
 
-- ###################################################
call log('medgen.view_gene2accession', 'end');
