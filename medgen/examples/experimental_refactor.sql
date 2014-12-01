1-- ssh biomed.vpc.locusdev.net 
-- biomed$ mysql -D medgen -u umls -pumls -h localhost

-- ################################################################
-- MedGen  
-- 
-- ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/README.html
-- ################################################################
-- select 'C0007194' into @CUI; 
-- 

use medgen; 


-- select * from medgen.MGCONSO where CUI = 'C1834460'; 
-- select distinct SDUI as SourceDoc from medgen.MGCONSO where SAB = 'GTR' and CUI = 'C1834460'; 
select * from test_condition_gene where GTR_identifier = 'C1834460'; 

-- ################################################################
-- Disease:Gene (Genetic Testing Registry) 

drop table if exists tmp_disease_gene; 
create table tmp_disease_gene 
select distinct gene_or_SNOMED_CT_ID as GeneID
from test_condition_gene where concept_type = 'gene' and 
accession_version in (select distinct accession_version from test_condition_gene where GTR_identifier = 'C1834460' );  

select Gene.gene_info.* 
from 
 GTR.tmp_disease_gene, 
 gene.gene_info 
where 
 GTR.tmp_disease_gene  = gene.GeneID
  

-- ################################################################
-- call log('view_concept_name_hpo', 'refresh');

-- drop table if exists view_concept_name_hpo; 

-- create table view_concept_name_hpo like view_concept_name; 

-- insert into view_concept_name_hpo select STY as SemanticType, MedGenStr_SAB as SourceVocab, CUI as ConceptID, HpoStr as Name from medgen_hpo; 

-- ################################################################
call log('view_concept_gene', 'refresh'); 

update gene.mim2gene_medgen set MedGenCUI='' where MedGenCUI='-' or MedGenCUI is null; 
update gene.mim2gene_medgen set MIM_vocab='' where MIM_vocab='-' or MIM_vocab is null;  

drop table if exists medgen.view_concept_gene; 

create table medgen.view_concept_gene
( 
  SemanticType       varchar(50) null, 
  ConceptID          char(8) not null, 
  GeneID             int(10) unsigned, 
  MIM                int(10) unsigned
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

insert into medgen.view_concept_gene
select distinct 
  semantics.STY   as SemanticType,
  MedGenCUI       as ConceptID, 
  GeneID          as GeneID, 
  mim2gene.MIM    as MIM 
from 
  gene.mim2gene_medgen  as mim2gene,
  medgen.MGCONSO        as concept, 
  medgen.MGSTY          as semantics
where 
  semantics.CUI       = concept.CUI and 
  mim2gene.MedGenCUI  = concept.CUI and 
  mim2gene.GeneID    != 0   and 
  mim2gene.MedGenCUI != ''  ;

-- TODO: multiple attributes? :: GENE:DISEASE

alter table view_concept_gene add index (ConceptID); 
alter table view_concept_gene add index (GeneID); 
alter table view_concept_gene add index (AttributeID); 
alter table view_concept_gene add index (SemanticType); 

select SemanticType, count(*) as cnt from view_concept_gene group by SemanticType order by cnt desc; 

use medgen; 
update view_concept_gene as G, 
       MGSAT 		 as attr, 
       MGSTY		 as semantic
set    G.SemanticType    = semantic.STY
where  G.AttributeID     = attr.ATUI and 
       attr.ATUI         = semantic.ATUI; 

select SemanticType, count(*) as cnt from view_concept_gene group by SemanticType order by cnt desc; 


-- select * from gene.mim2gene_medgen limit 20 ; 
-- select * from medgen.view_concept_gene limit 20 ; 

update view_concept_gene as G, MGSAT as attr, MGSTY as semantic
set    G.SemanticType = semantic.STY

select count(*) 
from   
  view_concept_gene as G, 
  MGSAT as attr, 
  MGSTY as semantic
where  G.AttributeID  = attr.ATUI and 
       attr.ATUI      = semantic.ATUI; 

select count(*) 
from   
  view_concept_gene as G, 
  MGSAT as attr
where  G.AttributeID  = attr.ATUI 
       attr.ATUI      = semantic.ATUI; 

-- ################################################################

-- # Diabetes mellitus type 2
-- #Most annotated OMIM:MedGen entry 
-- 
-- http://www.ncbi.nlm.nih.gov/medgen/C0011860
-- 
select MedGenCUI, count(*) as cnt from gene.mim2gene_medgen group by MedGenCUI having cnt > 1 order by cnt asc; 

select * from gene.mim2gene_medgen where MedGenCUI = 'C0011860'; 

select G.MedGenCUI, count(*) as cnt
from gene.mim2gene_medgen G, MGCONSO C
where G.MedGenCUI = C.CUI 
group by G.MedGenCUI 
having cnt > 1 order by cnt asc; 

| C0035334  |    10 |
| C0002395  |    11 |
| C1834752  |    11 |
| C0376358  |    12 |
| C0032897  |    12 |
| C1869116  |    13 |
| C1838021  |    13 |
| C0085580  |    13 |
| C1836230  |    14 |
| C0036341  |    15 |
| C0023264  |    15 |
| C0028754  |    16 |
| C1970028  |    16 |
| C0684249  |    16 |
| C0162671  |    17 |
| C1838979  |    18 |
| C0752166  |    19 |
| C0346153  |    24 |
| CN029768  |    25 |
| C0011860  |    29 |



drop table if exists gene2phenotype; 

create table gene2phenotype
(
       GeneID     int(10)  unsigned, 
       Symbol     varchar(25), 
       Phenotype  text, 
       HP         varchar(25)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- # @@@ @@@ @@@@

-- -- =====================================
-- select 'SemanticType counts' as note; 
-- -- =====================================
-- select SemanticType, count(distinct ConceptID) as cnt 
-- from view_preferred_concept
-- group by SemanticType 
-- having count(*) > 10 order by cnt desc; 

-- -- =====================================
-- select 'SourceVocab counts' as note; 
-- -- =====================================
-- select SourceVocab, count(distinct ConceptID) as cnt 
-- from view_preferred_concept
-- group by SourceVocab 
-- having count(*) > 1000 order by cnt desc; 

-- -- #################################################################
-- call log('view_preferred_semantics_count', 'NCBI preferred terms for GTR/MedGen/etc.');

-- create table view_preferred
-- select distinct
--   semantics.STY   as SemanticType, 
--   names.source    as SourceVocab, 
--   names.CUI       as ConceptID,  
--   names.name      as Name
-- from 
--  MGCONSO as concept, 
--  MGSTY   as semantics, 
--  NAMES   as names
-- where 
--  concept.STT      = 'PF'          and 
--  concept.ISPREF   = 'Y'           and 
--  concept.SUPPRESS = 'N'           and  
--  concept.CUI  = names.CUI         and 
--  concept.CUI  = semantics.CUI     and 
--  concept.ATUI = semantics.ATUI      ; 

-- alter table view_preferred_concept ENGINE=InnoDB DEFAULT CHARSET=utf8; 
-- alter table view_preferred_concept add index (SemanticType); 
-- alter table view_preferred_concept add index (ConceptID); 
-- alter table view_preferred_concept add index (SourceVocab); 

-- call log('view_preferred_concept', 'created view');

-- -- ################################################################
-- call log('view_concept_child', 'refresh');

-- drop table if exists view_concept_child; 

-- create table view_concept_child
-- (  
--   SemanticType       varchar(50) not null, 
--   ConceptID          char(8)     not null, 
--   ConceptAttrID      varchar(9)  not null, 
--   ChildSemanticType  varchar(50) not null, 
--   ChildID            char(8)     not null, 
--   ChildAttrID        varchar(9)  not null  
-- )
-- ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- insert into view_concept_child 
--     ( ConceptID, ConceptAttrID, 
--       ChildID,     ChildAttrID) 
-- select distinct CUI1, CUI2 from MGREL where REL = 'CHD'; 

-- alter table view_concept_child add index (ConceptID); 
-- alter table view_concept_child add index (ChildID); 
-- alter table view_concept_child add index (SemanticType); 
-- alter table view_concept_child add index (ChildSemanticType); 

-- update view_concept_child Tree, MGSTY sem 
-- set    Tree.SemanticType = sem.STY 
-- where  ConceptID = sem.CUI ; 

-- update view_concept_child Tree, MGSTY sem 
-- set    Tree.ChildSemanticType = sem.STY 
-- where  ChildID = sem.CUI ; 


-- call log('view_disease_tree_name', 'refresh');

-- -- TODO: count(*) is smaller than view_disease_tree

-- drop table if exists view_disease_tree_name ; 

-- CREATE TABLE view_disease_tree_name
-- (
--   DiseaseVocab       varchar(20), 
--   Disease            char(8),
--   DiseaseName        varchar(1000),
--   ChildSemanticType  varchar(50), 
--   ChildVocab         varchar(20),
--   ChildID            char(8), 
--   ChildName          varchar(1000) 
-- ) 
-- ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci; 

-- insert into view_disease_tree_name
-- select 
--  D.SourceVocab  as DiseaseVocab, 
--  D.ConceptID    as Disease, 
--  D.Name         as DiseaseName, 
--  C.SemanticType as ChildSemanticType, 
--  C.SourceVocab  as ChildVocab, 
--  C.ConceptID    as Child, 
--  C.Name         as ChildName 
-- from 
--  view_disease_tree    as Tree, 
--  view_preferred_concept  as D, 
--  view_preferred_concept  as C 
-- where 
--  Tree.Disease   = D.ConceptID   and 
--  Tree.ChildID   = C.ConceptID 
-- order by 
--  DiseaseName, ChildName; 

-- alter table view_disease_tree_name ENGINE=InnoDB DEFAULT CHARSET=utf8; 
-- alter table view_disease_tree_name add index (Disease); 
-- alter table view_disease_tree_name add index (DiseaseVocab); 
-- alter table view_disease_tree_name add index (DiseaseName); 
-- alter table view_disease_tree_name add index (ChildID); 
-- alter table view_disease_tree_name add index (ChildSemanticType); 
-- alter table view_disease_tree_name add index (ChildVocab); 
-- alter table view_disease_tree_name add index (ChildName); 
