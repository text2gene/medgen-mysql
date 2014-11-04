call log('medgen.view_gene2accession', 'begin');
-- ###################################################

drop table if exists medgen.view_gene2accession; 

create table         medgen.view_gene2accession
select * from gene.gene2accession where RNA_acc_ver like 'NM_%'; 
-- ###################################################
call log('medgen.view_gene2accession', 'end');
