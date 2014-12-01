call log('view_disease_tree.sql', 'begin');
-- ################################################################
drop table if exists view_disease_tree; 

create table view_disease_tree like view_concept_tree; 
alter  table view_disease_tree change ConceptID DiseaseID char(8); 
alter  table view_disease_tree drop column SemanticType; 
alter  table view_disease_tree drop column AtomID; 
alter  table view_disease_tree drop column ChildAtomID; 
alter  table view_disease_tree change ChildSemanticType SemanticType varchar(50) not null; 

call utf8_unicode('view_disease_tree'); 

insert into  view_disease_tree (DiseaseID, ChildConceptID, SemanticType, SourceVocab) 
select distinct ConceptID, ChildConceptID, ChildSemanticType, SourceVocab from view_concept_tree 
where SemanticType = 'Disease or Syndrome'; 

-- ################################################################
call log('view_disease_tree.sql', 'done');
