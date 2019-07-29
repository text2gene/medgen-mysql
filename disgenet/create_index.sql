call create_index('disease2gene', 'GeneID');
call create_index('disease2gene', 'Symbol');

update disease2gene set ConceptID = replace(ConceptID, 'umls:', ''); 

call create_index('disease2gene', 'ConceptID'); 
call create_index('disease2gene', 'ConceptName');
call create_index('disease2gene', 'GeneID,ConceptID');
