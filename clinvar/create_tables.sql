call log('ClinVar Clinical Variants', 'ncbi');

--begin
call log('clinvar_identifiers', 'refresh');

drop   table if exists clinvar_identifiers;
create table           clinvar_identifiers
(
	VariationID      integer not null, 	
	AlleleID	 integer not null,
	RCVaccession	 varchar(200) not null,
        hgvs_text        varchar(100) not null
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

call utf8_unicode('clinvar_identifiers');


-- begin
call log('var_citations', 'refresh');

drop   table if exists var_citations;
create table           var_citations
(
	AlleleID	 integer not null, 
	VariationID      integer not null, 
	rs		 integer null, 
	nsv		 integer null, 
	citation_source  varchar(100),
	citation_id	 integer
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
call utf8_unicode('var_citations');


-- begin
call log('gene_condition_source_id','refresh');

drop table if exists gene_condition_source_id; 

create table gene_condition_source_id(
       GeneID		 int,
       Symbol          varchar(10),
       ConceptID       varchar(40),
       DiseaseName     varchar(200),
       SourceName      varchar(150),
       SourceID        varchar(50),
       DiseaseMIM      varchar(20),
       LastModified    varchar(20)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
call utf8_unicode('gene_condition_source_id'); 

-- end
-- ###################################
-- begin
call log('disease_names','refresh');

drop table if exists disease_names; 

create table disease_names(
     DiseaseName     varchar(255),
     SourceName      varchar(150),
     ConceptID       varchar(20),
     SourceID        varchar(50),
     DiseaseMIM      varchar(100),
     LastModified    varchar(20),
     Category        varchar(100)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

call utf8_unicode('disease_names'); 

-- end
-- ###################################
-- begin
call log('gene_specific_summary','refresh');

drop table if exists gene_specific_summary; 

create table gene_specific_summary (
  Symbol   varchar(20)  not null,  
  GeneID       integer  not null,   
  Submissions  integer  not null, 	
  Alleles      integer  not null,
  Submissions_reporting_this_gene integer
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

call utf8_unicode('gene_specific_summary'); 

-- end
-- ###################################
-- begin

call log('variant_summary','refresh');

drop table if exists variant_summary; 

create table variant_summary (
       AlleleID         integer not null, 
       variant_type     varchar(50) not null, 
       variant_name     varchar(255) null, 
       GeneID           integer  not null,   
       Symbol           varchar(20)  not null,  
       ClinicalSignificance varchar(200), 
       rs                   integer, 
       dbvar_nsv         text, 
       RCVaccession	 text, 
       TestedInGTR       char, 
       PhenotypeIDs      varchar(500), 
       Origin            text, 
       Assembly      	 text, 
       Chromosome        varchar(20),
       Start             integer, 
       Stop              integer, 
       Cytogenetic       text, 
       ReviewStatus      text, 
       HGVS_c            varchar(200), 
       HGVS_p            varchar(200), 
       NumberSubmitters  integer, 
       LastEvaluated     text, 
       Guidelines        text, 
       OtherIDs          varchar(500),
       VariantID         INTEGER
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
call utf8_unicode('variant_summary'); 

-- end 
-- ###################################
-- begin 

drop table if exists molecular_consequences; 

create table molecular_consequences
(
       hgvs_text          varchar(100) not null,
       SequenceOntologyID varchar(20)  not null, 
       Value              varchar(100) not null 
)
  ENGINE=InnoDB DEFAULT CHARSET=utf8;
call utf8_unicode('variant_summary'); 


-- end 
-- ###################################
-- begin 

drop table if exists cross_references; 

create table cross_references
(
	AlleleID       integer, 
	SourceVocab    varchar(20), 
	SourceCode     varchar(20),
	last_updated_  varchar(20)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

call utf8_unicode('cross_references'); 

-- end 
-- ###################################
-- begin 

call log('ClinGen gene_curation_list','refresh'); 

drop table if exists clingen_gene_curation_list; 

create table clingen_gene_curation_list  
(
	Symbol             varchar(50), 
       	GeneID             int(10)  unsigned, 
	cytoBand           text, 
       	g_location         text,
       	haplo_score        text,         
       	haplo_desc         text, 
       	haplo_insuf_pmid1  text,
       	haplo_insuf_pmid2  text,
       	haplo_insuf_pmid3  text,
       	triplosense_score  text, 
       	triplosense_desc   text
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

call log('clinvar_hgvs', 'refresh');

drop   table if exists clinvar_hgvs;
create table           clinvar_hgvs
(
  VariantID      integer not null,
  AlleleID     integer not null,
  RCVaccession     varchar(200) not null,
  hgvs_text        varchar(100) not null
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

call utf8_unicode('clinvar_hgvs');


call utf8_unicode('clingen_gene_curation_list');
call log('ClinGen gene_curation_list','done'); 
-- ###################################
call log('ClinGen gene_curation_list','done'); 


call log('create_tables.sql','done');
