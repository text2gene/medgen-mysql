call log('gene','transform'); 

set @human:=9606; 
call log('gene2accession', 'human only'); 

drop   table if exists gene2accession_orig; 
alter  table gene2accession rename to gene2accession_orig; 
create table gene2accession like gene2accession_orig; 
insert into  gene2accession select * from gene2accession_orig where tax_id = @human; 

call log('gene2accession', 'done'); 

call log(' tax_id', concat('human=', @human)); 

delete from gene_info 		     where tax_id != @human; 
delete from gene2pubmed 	     where tax_id != @human; 
delete from gene2go 		     where tax_id != @human; 
delete from gene_group 		     where tax_id != @human; 
delete from gene_history         where tax_id != @human;
delete from gene2accession       where tax_id != @human;

call log('tax_id','done'); 

call log('tax_id','drop column '); 

alter table gene_info         drop column tax_id; 
alter table gene2pubmed       drop column tax_id; 
alter table gene2go           drop column tax_id; 
alter table gene_group        drop column tax_id; 
alter table gene_history      drop column tax_id; 
alter table gene2accession    drop column tax_id; 

call log('tax_id','drop column '); 

call log('gene2pubmed','add column Symbol'); 

alter table gene2pubmed add column Symbol varchar(50) not null; 

update gene_info info, gene2pubmed pubmed 
set pubmed.Symbol = info.Symbol
where info.GeneID = pubmed.GeneID; 

alter table gene2pubmed add index (Symbol); 

call log('gene2pubmed','add column Symbol'); 
