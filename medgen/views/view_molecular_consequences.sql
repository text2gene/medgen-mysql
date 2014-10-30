call log('view_molecular_consequences.sql', 'begin'); 
-- ################################################################
drop table if exists view_molecular_consequences; 
CREATE TABLE         view_molecular_consequences(
       HGVS   	           varchar(1000), 
       SequenceOntologyID  varchar(20), 
       Consequence         varchar(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

select 'HGVS variants should be parseable with HGVS/UTA' as fyi; 

alter table view_molecular_consequences add index ( HGVS ); 
alter table view_molecular_consequences add index ( SequenceOntologyID ); 
alter table view_molecular_consequences add index ( Consequence ); 
-- ################################################################
call log('view_molecular_consequences.sql', 'end'); 

