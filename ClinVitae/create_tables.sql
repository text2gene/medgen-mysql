call log('ClinVitae Clinical Variants', 'ncbi');

-- begin

call log('version_info', 'create table');

drop table if exists version_info; 

create table version_info
(
  version     varchar(100),
  note        text, 
  last_loaded timestamp default CURRENT_TIMESTAMP
);

call utf8_unicode('version_info');

insert into version_info (version, note)
values (curdate(), 'Updated automatically by MedGen-MySQL'); 
call log('version_info', 'done');


call log('ClinVitae', 'refresh');

-- source TSV looks like this:
-- Gene Nucleotide Change   Protein Change  Other Mappings  Alias   Transcripts Region  Reported Classification Inferred Classification Source  Last Evaluated  Last Updated    URL Submitter Comment   
-- RASA1   NM_002890.1:c.296C>T    p.Ala99Val  NM_002890.1:c.296C>T    -   NM_002890.1 Exon 1  Variant of Uncertain Significance   Variant of uncertain significance   ARUP    -   2015-11-14  http://www.arup.utah.edu/database/RASA1/RASA1_display.php   


drop   table if exists variant_results;
create table           variant_results
(
    gene            varchar(20) default null,   -- 'Gene'
    hgvs_text       varchar(100) not null,      -- 'Nucleotide Change'
    protein_change  varchar(100) default null,  -- 'Protein Change'
    mappings        varchar(255) default null,  -- 'Other Mappings'
    alias           varchar(100) default null,  -- 'Alias'
    transcripts     varchar(255) default null,  -- 'Transcripts'
    region          varchar(50) default null,   -- 'Region'
    reported_classification varchar(100) default null,  -- 'Reported Classification'
    inferred_classification varchar(100) default null,  -- 'Inferred Classification'
    source          varchar(50) default null,   -- 'Source'
    last_evaluated  date default null,          -- 'Last Evaluated'
    last_updated    date default null,          -- 'Last Updated'
    url             varchar(255) default null,  -- 'URL'
    submitter_comment   text default null       -- 'Submitter Comment'  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

call utf8_unicode('variant_results');

call log('create_tables.sql','done');

