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
  Name                varchar(255) , 
  Suppress            char(1));

insert into view_concept select * from MGCONSO; 

call utf8_unicode('view_concept'); 
call create_index('view_concept','ConceptID');
call create_index('view_concept','SourceVocab');

call log('view_concept', 'done');
-- ################################################################
call log('view_concept_def', 'MedGen Definitions');

drop   table if exists view_concept_def; 
create table           view_concept_def 
select CUI as ConceptID, 
       DEF as Definition, 
       SAB as SourceVocab
from MGDEF; 

call utf8_unicode('view_concept_def'); 
call create_index('view_concept_def','ConceptID');
call create_index('view_concept_def','SourceVocab');

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
); 

call utf8_unicode('view_concept_child'); 

insert into view_concept_child ( ConceptID, ConceptAttrID, ChildID, ChildAttrID, SourceVocab)       
select distinct CUI1, AUI1, CUI2, AUI2, SL from MGREL where REL = 'CHD'; 

call create_index('view_concept_child','SourceVocab');
call create_index('view_concept_child','ConceptID');
call create_index('view_concept_child','SemanticType');
call create_index('view_concept_child','ChildID');
call create_index('view_concept_child','ChildSemanticType');

update view_concept_child Tree, MGSTY sem 
set    Tree.SemanticType = sem.STY 
where  ConceptID = sem.CUI ; 

update view_concept_child Tree, MGSTY sem 
set    Tree.ChildSemanticType = sem.STY 
where  ChildID = sem.CUI ; 

call log('view_concept_child', 'done');
-- ################################################################
call log('view_concept_hierarchy.sql', 'END'); 
