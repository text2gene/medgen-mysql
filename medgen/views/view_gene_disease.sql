call log('view_gene_disease.sql', 'begin');
-- ################################################################

-- +-------------+------------------+------+-----+---------+-------+
-- | Field       | Type             | Null | Key | Default | Extra |
-- +-------------+------------------+------+-----+---------+-------+
-- | GeneID      | int(10) unsigned | YES  |     | NULL    |       |
-- | GeneSymbol  | varchar(25)      | NO   |     | NULL    |       |
-- | ConceptID   | varchar(10)      | NO   |     | NULL    |       |
-- | Name        | varchar(1000)    | NO   |     | NULL    |       |
-- | SourceVocab | varchar(20)      | NO   |     | NULL    |       |
-- | SourceCode  | varchar(50)      | NO   |     | NULL    |       |
-- | DiseaseMIM  | varchar(10)      | YES  |     | NULL    |       |
-- | LastUpdated | text             | YES  |     | NULL    |       |
-- +-------------+------------------+------+-----+---------+-------+

-- ################################################################
call log('view_gene_disease', 'refresh');
drop table if exists view_gene_disease; 
CREATE TABLE         view_gene_disease
(
  GeneID      int(10)        unsigned, 
  GeneSymbol  varchar(25)    not null,     
  ConceptID   char(8)        not null, 
  Name        varchar(1000)  not null, 
  SourceVocab varchar(20)    not null, 
  SourceCode  varchar(50)    not null, 
  DiseaseMIM  varchar(10)        null, 
  LastUpdated Text               null
); 

call utf8_unicode('view_gene_disease'); 

insert  into  view_gene_disease 
select * from clinvar.gene_condition_source_id; 

alter table view_gene_disease add column SemanticType varchar(50) default null; 
alter table view_gene_disease add column cnt_semtype  smallint    default -1; 

call create_index('view_gene_disease', 'GeneID'); 
call create_index('view_gene_disease', 'ConceptID'); 
call create_index('view_gene_disease', 'DiseaseMIM'); 

call log('view_gene_disease.sql', 'end');
-- #####################################################
