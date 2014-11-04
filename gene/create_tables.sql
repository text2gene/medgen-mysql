-- begin create tables 

call log('create_tables.sql', 'begin');

-- ###################################
call log('gene_info','Homo_sapiens.gene_info'); 

drop table if exists gene_info; 
create table gene_info( 
       tax_id   int(5) unsigned, 
       GeneID   int(10) unsigned, 
       Symbol    varchar(25), 
       LocusTag  varchar(20), 
       Synonyms	 text, 
       dbXrefs   text, 
       chromosome varchar(50), 
       map_loc    varchar(20), 
       GeneDesc  text, 
       GeneType  varchar(20), 
       Nomen_symbol varchar(25), 
       Nomen_source varchar(20), 	
       Nomen_status varchar(20), 	
       GeneOther    text, 
       LastModified varchar(10)
);
call utf8_unicode('gene_info');
-- end


-- begin 
call log('gene2pubmed','gene2pubmed.gz'); 

drop table if exists gene2pubmed; 
create table gene2pubmed( 
       tax_id int(5)   unsigned, 
       GeneID int(10)  unsigned, 
       PMID   int(10)  unsigned
);
call utf8_unicode('gene2pubmed');
-- end

-- begin
call log('mim2gene_medgen','mim2gene_medgen'); 

drop table if exists mim2gene_medgen; 
create table mim2gene_medgen( 
       MIM    int(10)  unsigned, 
       GeneID int(10)  unsigned, 
       MIM_type varchar(20), 
       MIM_vocab varchar(20), 
       MedGenCUI varchar(20)
); 
call utf8_unicode('clingen_gene_curation_list');

-- end
-- begin
call log('gene2go','gene2go.gz'); 

drop table if exists gene2go; 
create table gene2go( 
       tax_id int(5)  unsigned, 
       GeneID int(10)  unsigned, 
       GO_id varchar(20), 
       Evidence varchar(20), 
       Qualifier varchar(20),
       GO_term varchar(200), 
       PUBMEDS   text, 
       Category varchar(20) 
); 
call utf8_unicode('gene2go');

-- end
-- begin
call log('gene_group','gene_group.gz') ;

-- TODO: ? gene_neighbors.gz 

drop table if exists gene_group; 
create table gene_group( 
       tax_id int(5)  unsigned, 
       GeneID int(10)  unsigned, 
       relationship text null, 
       tax_id_other int(5)  unsigned, 
       GeneID_other int(10)  unsigned
); 
call utf8_unicode('gene_group');

-- end
-- begin
call log('gene_history','gene_history.gz'); 

drop table if exists gene_history; 
create table gene_history( 
       tax_id int(5)  unsigned, 
       GeneID int(10)  unsigned, 
       GeneID_old int(10)  unsigned, 
       Symbol_old varchar(25)  null, 
       date_old varchar(10)  null
); 
call utf8_unicode('gene_history');

-- end
-- begin
call log('gene2accession', 'gene2accession.gz'); 

-- TODO: how to stay consitent with UTA? 
-- https://pypi.python.org/pypi/uta 
-- gene2ensembl.gz 
-- gene2refseq.gz 

-- gene2accession
-- ==============
-- #Format: 
-- tax_id 
-- GeneID 
-- status 
-- RNA_nucleotide_accession.version 
-- RNA_nucleotide_gi 
-- protein_accession.version protein_gi 
-- genomic_nucleotide_accession.version 
-- genomic_nucleotide_gi 
-- start_position_on_the_genomic_accession 
-- end_position_on_the_genomic_accession 
-- orientation 
-- assembly 
-- mature_peptide_accession.version 
-- mature_peptide_gi 

drop table if exists gene2accession; 
create table gene2accession(
       tax_id     int(5)  unsigned, 
       GeneID     int(10)  unsigned, 
       STATUS     varchar(20), 
       RNA_acc_ver	    varchar(20), 
       RNA_acc_gi 	    varchar(20), 
       Protein_acc_ver	    varchar(20), 
       Protein_acc_gi	    varchar(20), 
       Genomic_acc_ver	    varchar(20),  
       Genomic_acc_gi 	    varchar(20), 
       Genomic_acc_start    varchar(20),  
       Genomic_acc_end	    varchar(20), 
       orientation	    varchar(20), 
       assembly	    	    varchar(20), 
       peptide_acc_ver	    varchar(20), 
       peptide_acc_gi	    varchar(20)
); 
call utf8_unicode('gene2accession');

-- end
-- begin
call log('stopwords_gene','stopwords_gene'); 

drop table if exists stopwords_gene; 
create table stopwords_gene(
       stopword text
); 
call utf8_unicode('stopwords_gene');

-- end
-- begin
call log('generifs_basic','generifs_basic.gz'); 

drop table if exists generifs_basic; 
create table generifs_basic( 
       tax_id   int(5) unsigned, 
       GeneID   int(10) unsigned, 
       pubmeds  text, 
       LastModified varchar(20),
       GeneRIF  text 
);
call utf8_unicode('generifs_basic');

-- end
-- begin
-- call log('interactions','interactions.gz'); 

-- @TODO: ?interaction_sources? 

-- drop table if exists interactions;
-- create table interactions(

--        tax_id     int(5) unsigned,
--        GeneID     int(10) unsigned,
--        acc        varchar(20),
--        label      text null,
--        keyphrase  text null,

--        tax_id_assoc   int(5) unsigned,
--        GeneID_assoc   int(10) unsigned,
--        type_assoc     text null,
--        acc_assoc      varchar(20),
--        label_assoc    text null,

--        complex_id           text,
--        complex_id_type      text,
--        complex_name         text,
--        pubmed_id_list       text,
--        last_mod             text,

--        generif_text         text,
--        interaction_id       text,
--        interaction_id_type  text
-- )
-- Engine = InnoDB;

-- ###################################

call log('create_tables.sql', 'end');
