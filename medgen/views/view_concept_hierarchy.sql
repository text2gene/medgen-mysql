-- ################################################################
call log('view_concept_tree', 'concept child terms');

drop   table if exists view_concept_tree; 
create table           view_concept_tree
(  
  SemanticType       varchar(50) not null, 
  ConceptID          char(8)     not null, 
  AtomID             varchar(9)  not null, 
  ChildSemanticType  varchar(50) not null, 
  ChildConceptID     char(8)     not null, 
  ChildAtomID        varchar(9)  not null, 
  SourceVocab        varchar(40) not null 
); 

call utf8_unicode('view_concept_tree'); 

insert into view_concept_tree ( ConceptID, AtomID, ChildConceptID, ChildAtomID, SourceVocab)       
select distinct CUI1, AUI1, CUI2, AUI2, SL from MGREL where REL = 'CHD';

call create_index('view_concept_tree','ConceptID');
call create_index('view_concept_tree','ChildConceptID');

update view_concept_tree Tree, MGSTY sem 
set    Tree.SemanticType = sem.STY 
where  ConceptID = sem.CUI ; 

update view_concept_tree Tree, MGSTY sem 
set    Tree.ChildSemanticType = sem.STY 
where  ChildConceptID = sem.CUI ; 

call create_index('view_concept_tree','SemanticType');
call create_index('view_concept_tree','ChildSemanticType');
call create_index('view_concept_tree','SourceVocab');

call log('view_concept_tree', 'done');
-- ################################################################
call log('view_concept_tree.sql', 'END'); 
