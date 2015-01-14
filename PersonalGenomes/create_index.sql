-- ##########################################
call log('articles', 'clean PMID'); 

update articles set article_id = replace(article_id, 'PMID:', ''); 
alter table articles change column article_id PMID int(10) unsigned; 
 
call log('articles', 'ok'); 
-- ##########################################

-- ##########################################
call log('bionotate', 'clean PMID'); 

alter table bionotate change column article_pmid PMID int(10) unsigned; 

call create_index('bionotate', 'PMID'); 
 
call log('articles', 'ok'); 
-- ##########################################
