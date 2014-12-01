call log('view_semantics.sql', 'begin'); 
-- ###################################################

-- mysql> desc MGSTY; 
-- +-------+--------------+------+-----+---------+-------+
-- | Field | Type         | Null | Key | Default | Extra |
-- +-------+--------------+------+-----+---------+-------+
-- | CUI   | char(8)      | NO   | MUL | NULL    |       | ConceptID
-- | TUI   | char(4)      | NO   |     | NULL    |       | semantic type unique identifier
-- | STN   | varchar(100) | NO   |     | NULL    |       | semantic type tree number
-- | STY   | varchar(50)  | NO   | MUL | NULL    |       | semantic type
-- | ATUI  | varchar(11)  | NO   | PRI | NULL    |       | attribute unique identifier
-- +-------+--------------+------+-----+---------+-------+

drop table if exists view_semantics; 

create table view_semantics as 
select MGSTY.STY    as SemanticType, 
       MGSTY.TUI    as SemanticTypeID, 
       NAMES.source as SourceVocab, 
       NAMES.CUI    as ConceptID, 
       NAMES.name   as Name
from   MGSTY, NAMES
where  MGSTY.CUI = NAMES.CUI; 
            
call utf8_unicode('view_semantics'); 
call create_index('view_semantics', 'SemanticType'); 
call create_index('view_semantics', 'SourceVocab'); 
call create_index('view_semantics', 'ConceptID'); 

-- ###################################################
call log('view_semantics.sql', 'done'); 
