call log('create_index.sql','NCBI PubTator'); 

call log('mutation2pubtator', 'create index'); 

call create_index('mutation2pubtator','PMID'); 
call create_index('mutation2pubtator','Components'); 

-- #################################################################

call log('gene2pubtator', 'index'); 
--
call create_index('gene2pubtator','PMID'); 
call create_index('gene2pubtator','GeneID'); 
call create_index('gene2pubtator','PMID, GeneID'); 
--
call log('gene2pubtator', 'done');

-- #################################################################

call log('disease2pubtator', 'create index'); 
--
call create_index('disease2pubtator','PMID'); 
call create_index('disease2pubtator','PMID,MeshID'); 
call create_index('disease2pubtator','MeshID'); 
--
call log('disease2pubtator', 'done'); 

-- #################################################################

call log('species2pubtator', 'create index'); 
-- 
call create_index('species2pubtator','PMID'); 
call create_index('species2pubtator','PMID,TaxID'); 
--
call log('species2pubtator', 'done'); 

-- #################################################################

call log('chemical2pubtator', 'create index'); 
--
call create_index('chemical2pubtator','PMID'); 
call create_index('chemical2pubtator','PMID,MeshID'); 
call create_index('chemical2pubtator','MeshID'); 
--
call log('chemical2pubtator', 'done'); 

-- #################################################################
call log('create_index.sql','done'); 
