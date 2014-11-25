call log('view_concept.sql', 'begin');
-- ###################################################

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
-- | SUPPRESS | char(1)      | Suppress

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
call create_index('view_concept','SourceDocumentID');
call create_index('view_concept','TermType');
call create_index('view_concept','SourceCode');
call create_index('view_concept','Name');

-- ###################################################
call log('view_concept', 'done');
