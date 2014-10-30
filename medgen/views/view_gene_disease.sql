use medgen; 

call log('view_gene_disease.sql', 'begin');

desc gene_condition_source_id; 
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
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;	 

insert  into  view_gene_disease 
select * from gene_condition_source_id; 

alter table view_gene_disease add column SemanticType varchar(50) default null; 
alter table view_gene_disease add column cnt_semtype  smallint    default -1; 

alter table view_gene_disease add index (GeneID); 
alter table view_gene_disease add index (ConceptID); 
alter table view_gene_disease add index (DiseaseMIM); 

-- #####################################################
call log('view_gene_disease','set SemanticType'); 

UPDATE  view_gene_disease as gene2disease,
	MGSTY  as semantic
SET     gene2disease.SemanticType = semantic.STY
where   gene2disease.ConceptID    = semantic.CUI; 

-- #####################################################
call log('view_gene_disease','cnt_semtype'); 

UPDATE  view_gene_disease as G,
	view_concept_usage   as C 
SET     G.cnt_semtype      = C.cnt_semtype
where   G.ConceptID        = C.ConceptID; 

-- #####################################################
call log('view_gene_disease','Disese:SemanticType'); 

select SemanticType, count(*) as cnt 
from view_gene_disease 
GROUP BY SemanticType order by cnt desc; 

mysql> select cnt_semtype, count(*) from view_concept_usage group by cnt_semtype; 
-- +---------------+----------+
-- | cnt_semtype | count(*) |
-- +---------------+----------+
-- |             1 |   160162 |
-- |             2 |    92763 |
-- |             3 |     6395 |
-- |             4 |      188 |
-- |             5 |        8 |
-- +---------------+----------+

call log('view_gene_disease.sql', 'end');
-- #####################################################
-- end 
