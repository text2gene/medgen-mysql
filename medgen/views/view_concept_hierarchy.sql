call log('view_concept_hierarchy.sql', 'BEGIN');
-- ################################################################
call log('view_concept', 'refresh');

-- +----------+--------------+
-- | Field    | Type         | Human readable name  
-- +----------+--------------+
-- | CUI      | char(8)      | ConceptID  
-- | TS       | char(1)      | TermStatus 
-- | STT      | varchar(3)   | StringTermType 
-- | ISPREF   | char(1)      | Preferred
-- | AUI      | varchar(9)   | AttributeID
-- | SAUI     | varchar(50)  | SourceAttributeID
-- | SCUI     | varchar(100) | SourceConceptID
-- | SDUI     | varchar(100) | SourceDocumentID
-- | SAB      | varchar(40)  | SourceVocab 
-- | TTY      | varchar(40)  | TermType
-- | CODE     | varchar(100) | SourceCode
-- | STR      | text         | Name
-- | SUPPRESS | char(1)      | Supress

drop table if exists  view_concept; 
create table          view_concept ( 
  ConceptID           char(8)      , 
  TermStatus          char(1)      , 
  StringTermType      varchar(3)   , 
  Preferred           char(1)      , 
  AttributeID         varchar(9)   , 
  SourceAttributeID   varchar(50)  , 
  SourceConceptID     varchar(100) , 
  SourceDocumentID    varchar(100) , 
  SourceVocab         varchar(40)  , 
  TermType            varchar(40)  , 
  SourceCode          varchar(100) , 
  Name                text, 
  Suppress            char(1) ) 
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

insert into view_concept select * from MGCONSO; 

alter table view_concept add index (ConceptID); 
alter table view_concept add index (SourceVocab); 

call log('view_concept', 'done');
-- ################################################################
call log('view_concept_def', 'MedGen Definitions');

drop   table if exists view_concept_def; 
create table           view_concept_def 
select CUI as ConceptID, 
       DEF as Definition, 
       SAB as SourceVocab
from MGDEF; 

alter table view_concept_def add index (ConceptID); 
alter table view_concept_def add index (SourceVocab); 

call log('view_concept_def', 'done');
-- ################################################################
call log('view_concept_child', 'concept child terms');

drop   table if exists view_concept_child; 
create table           view_concept_child
(  
  SemanticType       varchar(50) not null, 
  ConceptID          char(8)     not null, 
  ConceptAttrID      varchar(9)  not null, 
  ChildSemanticType  varchar(50) not null, 
  ChildID            char(8)     not null, 
  ChildAttrID        varchar(9)  not null, 
  SourceVocab        varchar(40) not null 
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

insert into view_concept_child ( ConceptID, ConceptAttrID, ChildID, ChildAttrID, SourceVocab)       
select distinct CUI1, AUI1, CUI2, AUI2, SL from MGREL where REL = 'CHD'; 

alter table view_concept_child add index (ConceptID); 
alter table view_concept_child add index (ChildID); 
alter table view_concept_child add index (SemanticType); 
alter table view_concept_child add index (ChildSemanticType); 

update view_concept_child Tree, MGSTY sem 
set    Tree.SemanticType = sem.STY 
where  ConceptID = sem.CUI ; 

update view_concept_child Tree, MGSTY sem 
set    Tree.ChildSemanticType = sem.STY 
where  ChildID = sem.CUI ; 

call log('view_concept_child', 'done');
-- ################################################################
call log('view_concept_hierarchy.sql', 'END'); 

