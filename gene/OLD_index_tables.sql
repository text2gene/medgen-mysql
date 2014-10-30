-- NCBI.gene.gene_info 
select 9606 into @human; 

call log('gene*', 'NCBI gene tables will now only include human genes.'); 

create table ORIG_gene_info      select * from gene_info; 
create table ORIG_gene2go        select * from gene2go; 
create table ORIG_gene2pubmed    select * from gene2pubmed; 
create table ORIG_gene_group     select * from gene_group; 
create table ORIG_gene_history   select * from gene_history; 
create table ORIG_gene2accession select * from gene2accession; 
create table ORIG_generifs_basic select * from generifs_basic; 

delete from gene_info          where tax_id != @human ; 
delete from gene2go            where tax_id != @human ; 
delete from gene2pubmed        where tax_id != @human ; 
delete from gene_group         where tax_id != @human ; 
delete from gene_history       where tax_id != @human ; 
delete from gene_accession     where tax_id != @human ; 
delete from generifs_basic     where tax_id != @human ; 
