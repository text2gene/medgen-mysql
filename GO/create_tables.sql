call log('create_tables.sql', 'begin'); 

-- file: http://www.geneontology.org/GO.evidence.shtml
--  	  GO Evidence Codes

call log('evidence_codes', 'refresh'); 

drop table if exists GO.evidence_codes; 

create table GO.evidence_codes
(
	EvidenceProvider   text,
	EvidenceCode	   varchar(3), 
	EvidenceText       text
); 
call utf8_unicode('evidence_codes');
--

call log('evidence_provider', 'refresh'); 

drop table if exists GO.evidence_provider; 

create table GO.evidence_provider
as select distinct EvidenceProvider from evidence_codes;

call utf8_unicode('evidence_provider');

call log('evidence_provider', 'done'); 

select 'Experimental Evidence Codes' into @experimental; 
select 'Computational Analysis Evidence Codes' into @computational; 
select 'Automatically-assigned Evidence Codes' into @automatic; 
select 'Author Statement Evidence Codes' into @author; 
select 'Curator Statement Evidence Codes' into @curator; 

insert into GO.evidence_codes values
(@experimental,'EXP', 'Inferred from Experiment'), 
(@experimental,'IDA', 'Inferred from Direct Assay'), 
(@experimental,'IPI', 'Inferred from Physical Interaction'), 
(@experimental,'IMP', 'Inferred from Mutant Phenotype'), 
(@experimental,'IGI', 'Inferred from Genetic Interaction'), 
(@experimental,'IEP', 'Inferred from Expression Pattern'); 

insert into GO.evidence_codes values
(@computational,'ISS', 'Inferred from Sequence or Structural Similarity'),
(@computational,'ISO', 'Inferred from Sequence Orthology'),
(@computational,'ISA', 'Inferred from Sequence Alignment'),
(@computational,'ISM', 'Inferred from Sequence Model'),
(@computational,'IGC', 'Inferred from Genomic Context'),
(@computational,'IBA', 'Inferred from Biological aspect of Ancestor'),
(@computational,'IBD', 'Inferred from Biological aspect of Descendant'),
(@computational,'IKR', 'Inferred from Key Residues'),
(@computational,'IRD', 'Inferred from Rapid Divergence'),
(@computational,'RCA', 'inferred from Reviewed Computational Analysis');

insert into GO.evidence_codes values
(@author,'TAS','Traceable Author Statement'),
(@author,'NAS','Non-traceable Author Statement'); 

insert into GO.evidence_codes values
(@curator,'IC', 'Inferred by Curator'),
(@curator,'ND', 'No biological Data available');

insert into GO.evidence_codes values
(@automatic,'IEA', 'Inferred from Electronic Annotation');

call log('evidence_codes', 'done'); 
-- 
call log('create_tables.sql', 'done'); 
