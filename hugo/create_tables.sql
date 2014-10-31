--  file: hugo2pubmed.txt 
--  	  HGNC Symbols to PUBMED articles

 call log('hugo2pubmed','refresh');

drop table if exists hugo2pubmed; 

create table hugo2pubmed(
       hgnc	 varchar(20), 
       Symbol    varchar(50), 
       Name      text,
       Status    text, 
       GeneID    int(10) unsigned,
       pubmeds   text
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- end 
-- begin
call log('hugo2entrez','refresh');

--  file: hugo2entrez.txt
--  	  HGNC Symbols to ncbi ENTREZ Symbol/GeneID

drop table if exists hugo2entrez; 

create table hugo2entrez(
       hgnc	 varchar(20), 
       Symbol    varchar(50), 
       Name      text,
       Status    text, 
       GeneID    int(10) unsigned
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- end 
-- begin
call log('hugo2entrez2omim','refresh');

--  file: hugo2entrez2omim.txt
--  	  HGNC Symbols to ncbi ENTREZ Symbol/GeneID and OMIM 

drop table if exists hugo2entrez2omim; 

create table hugo2entrez2omim(
       hgnc	 varchar(25), 
       Symbol    varchar(25), 
       Name      text,
       Status    text, 
       GeneID    int(10) unsigned, 
       omim      int(10) null
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- end 
-- begin 
call log('hugo_info','refresh');

--  file: hugo_info.txt
--  	  HGNC standard annotations 

drop table if exists hugo_info; 

create table hugo_info(
       hgnc	 varchar(25), 
       Symbol    varchar(50), 
       Name      text,
       Status    text, 
       LocusType         text, 
       LocusGroup        text, 
       PreviousSymbols   text, 
       PreviousNames     text, 
       Synonyms          text, 
       NameSynonyms      text,
       Chromosome        text,
       DateNameChanged   text,
       AccessionNumbers  text,
       EnsemblGeneID     int(10),
       SpecialistDB      text,
       pubmeds           text, 
       RefSeqIDs         text, 
       GeneFamilyTag     text, 
       RecordType        text, 
       PrimaryIDs        text,
       LocusSpecificDatabases text 
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

call log('create_tables','done');
