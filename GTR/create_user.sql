-- TODO: DRY: FabFile.py 
-- 
-- Create user 

create user 'umls'@'localhost' identified by 'umls';
grant all on GTR.* to 'umls'@'localhost';
grant execute on GTR.* to 'umls'@'localhost';

-- end create user 