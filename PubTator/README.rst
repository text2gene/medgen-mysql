.. contents:: PubTator

what is PubTator? 
==================================
PubTator provides indexes of "Text Mined Variants" and other "BioConcepts" relevant for searching PubMed (`PubTator FTP README <ftp://ftp.ncbi.nlm.nih.gov/pub/lu/PubTator/README.txt>`_) 

links
======
* PubTator.gene2pubtator.GeneID    references **gene.GeneID**
* PubTator.gene2pubtator.PMID      references **pubmed.PMID**
* PubTator.mutation2pubtator.PMID  references **pubmed.PMID**
* PubTator provides many coded identifiers. see README.
  

info schema
===========
::

   
   mysql> call info; 
   +--------------+--------+-------------------+------------+---------+----------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME        | TABLE_ROWS | million | data_MB  | index_MB | TABLE_COLLATION |
   +--------------+--------+-------------------+------------+---------+----------+----------+-----------------+
   | PubTator     | InnoDB | chemical2pubtator |   27453916 | 27.45   | 1549.00M | 0.00M    | utf8_unicode_ci |
   | PubTator     | InnoDB | disease2pubtator  |   27825311 | 27.83   | 1870.00M | 0.00M    | utf8_unicode_ci |
   | PubTator     | InnoDB | gene2pubtator     |   10800507 | 10.80   | 657.00M  | 0.00M    | utf8_unicode_ci |
   | PubTator     | InnoDB | log               |         36 | 0.00    | 0.02M    | 0.00M    | utf8_unicode_ci |
   | PubTator     | InnoDB | mutation2pubtator |     537030 | 0.54    | 29.56M   | 23.08M   | utf8_unicode_ci |
   | PubTator     | InnoDB | README            |         11 | 0.00    | 0.02M    | 0.00M    | utf8_general_ci |
   | PubTator     | InnoDB | species2pubtator  |   16563014 | 16.56   | 805.00M  | 0.00M    | utf8_unicode_ci |
   +--------------+--------+-------------------+------------+---------+----------+----------+-----------------+


used by: Variant2Pubmed
=========================
   Variant2Pubmed toolkits assist curation of PubMed Literature sources using state­of­the art Text Mining. 
   The approach is inspired by this review paper and has been customized for clinical signout of rare diseases.  
   Invitae has already made many of our tools Open Source, especially for HGVS parsing and variant mapping to 
   different molecular representations, including “c.” coding sequence, “r.” RNA sequence, “p.” protein amino acid 
   changes. We use our open source HGVS parser and UTA Universal Transcript Archive.

   We then run a process called “Lexical Variant Generation”, which is loosely modeled like the PubMed LexTools.   
   This package is called hgvs­lexicon and we are in the works of packaging for an open­source audience. With a
   minor amount of code, you could mimic much of the LVG behavior with by simply invoking the UTA mapper
   several times.  
