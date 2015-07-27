.. contents:: GO
	      
What is the Gene Ontology? 
===========================
http://GeneOntology.org groups and relates genes into functional groups. GO is a major source of relationships in HPO (Human Phenotype Ontology). 


links
======
* hugo gene naming conventions (GeneID, Symbol) 
* pubmed identifiers (PMID) 


info schema
===========
::

   mysql> call info;

   +--------------+--------+--------------------+------------+---------+---------+----------+-------------------+
   | table_schema | ENGINE | TABLE_NAME         | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION   |
   +--------------+--------+--------------------+------------+---------+---------+----------+-------------------+
   | GO           | InnoDB | evidence_codes     |         21 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci   |
   | GO           | InnoDB | evidence_provider  |          0 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci   |
   | GO           | InnoDB | log                |         31 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci   |
   | GO           | InnoDB | README             |         33 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci   |
   | GO           | MyISAM | association        |    6878037 | 6.88    | 190.22M | 857.85M  | utf8_unicode_ci   |
   | GO           | MyISAM | evidence           |          0 | 0.00    | 0.00M   | 0.00M    | latin1_swedish_ci |
   | GO           | MyISAM | gene_product       |    1001078 | 1.00    | 47.28M  | 146.07M  | utf8_unicode_ci   |
   | GO           | MyISAM | gene_product_count |    2238975 | 2.24    | 47.49M  | 105.87M  | utf8_unicode_ci   |
   | GO           | MyISAM | gene_product_seq   |     568907 | 0.57    | 7.05M   | 18.84M   | utf8_unicode_ci   |
   | GO           | MyISAM | graph_path         |    1218243 | 1.22    | 29.05M  | 189.22M  | latin1_swedish_ci |
   | GO           | MyISAM | seq                |     482603 | 0.48    | 299.60M | 59.33M   | utf8_unicode_ci   |
   | GO           | MyISAM | term               |      43520 | 0.04    | 3.44M   | 11.88M   | latin1_swedish_ci |
   | GO           | MyISAM | term2term          |      88604 | 0.09    | 1.77M   | 6.53M    | latin1_swedish_ci |
   | GO           | MyISAM | term_definition    |      43484 | 0.04    | 8.22M   | 1.36M    | latin1_swedish_ci |
   +--------------+--------+--------------------+------------+---------+---------+----------+-------------------+

|
|

####################################################################################################

|
|

termdb
======
GO termdb TABLES: 

* **term**:                        GO controlled vocab terms
* **term2term**:                   relationships between GO terms
* **term_definition**:             definitions of terms
* **graph_path**:                  transitive closure (all paths) in graph

|
|

term
--------
| `GO.termdb.term <http://www.geneontology.org/GO.database.schema.shtml#go-graph.table.term>`_  \
| ( id  | name | term_type | acc | is_obsolete | is_root | is_relation ) 
| 

*GO.termdb.term.term_type* ::

  select term_type, count(*) as cnt from term group by term_type order by cnt asc; 
  +--------------------+-------+
  | term_type          | cnt   |
  +--------------------+-------+
  | universal          |     1 |
  | relationship       |     1 |
  | metadata           |     2 |
  | synonym_type       |     2 |
  | external           |     4 |
  | synonym_scope      |     4 |
  | subset             |    17 |
  | cellular_component |  3618 |
  | molecular_function | 10588 |
  | biological_process | 26466 |
  +--------------------+-------+

|
::

  select id,name,acc from term where term_type = 'molecular_function' 
  and is_obsolete = 0 limit 5; 

  +----+--------------------------------------------------------------+------------+
  | id | name                                                         | acc        |
  +----+--------------------------------------------------------------+------------+
  | 33 | protein binding involved in protein folding                  | GO:0044183 |
  | 34 | unfolded protein binding                                     | GO:0051082 |
  | 35 | high affinity zinc uptake transmembrane transporter activity | GO:0000006 |
  | 36 | low-affinity zinc ion transmembrane transporter activity     | GO:0000007 |
  | 38 | protein disulfide isomerase activity                         | GO:0003756 |
  +----+--------------------------------------------------------------+------------+


|
::

  select id,name,acc from term where term_type = 'biological_process' 
  and is_obsolete = 0 limit 5; 
  +----+----------------------------------+------------+
  | id | name                             | acc        |
  +----+----------------------------------+------------+
  | 25 | mitochondrion inheritance        | GO:0000001 |
  | 27 | mitochondrial genome maintenance | GO:0000002 |
  | 28 | reproduction                     | GO:0000003 |
  | 32 | ribosome biogenesis              | GO:0042254 |
  | 42 | vacuole inheritance              | GO:0000011 |
  +----+----------------------------------+------------+


| 

*GO.termdb.term.name* ::

  select id,name,acc from term 
  where name like '%transcript%' and name not like '%regulation%'  
  and is_obsolete = 0 order by rand() limit 3;

| 
::

   +-------+---------------------------------------------------------+------------+
   | id    | name                                                    | acc        |
   +-------+---------------------------------------------------------+------------+
   |   769 | snoRNA transcription from an RNA polymerase II promoter | GO:0001015 |
   | 15598 | transcription antitermination                           | GO:0031564 |
   |   908 | TFIIIA-class transcription factor binding               | GO:0001155 |
   +-------+---------------------------------------------------------+------------+


|
|




-----------------


term2term
----------
`GO.termdb.term2term <http://www.geneontology.org/GO.database.schema.shtml#go-graph.table.term2term>`_  
( relationship_type_id  | term1_id | term2_id | complete ) 


select 
term1.term_type, term1.name, 
relationship_type_id, 
term2.term_type, term2.name
from  term2term as t2t, term as term1, term as term2 
where t2t.term1_id = term1.id and t2t.term2_id = term2.id 
and   term1.is_obsolete = 0 and term2.is_obsolete = 0      
limit 5; 

-----------------

|
|


term_definition
--------------------
::

   select * from term_definition where term_id = 769; 
   +---------+---------------------------------------------------------------------------------------------------------------------------------------+
   | term_id | term_definition                                                                                                                       |
   +---------+---------------------------------------------------------------------------------------------------------------------------------------+
   |     769 | The synthesis of small nucleolar RNA (snoRNA) from a DNA template by RNA polymerase II, originating at an RNA polymerase II promoter. |
   +---------+---------------------------------------------------------------------------------------------------------------------------------------+


|
|

-----------------

|
|

assocdb
========
**GO.termdb.tables**: 
GO vocabulary and associations between GO terms and gene products. 
This database subsumes termdb. 

|

* **gene_product**:                 gene or protein or entity annotated
* **association**:                  link between gene product and GO term
* **evidence**:                     evidence provider and reference for an assoc
* `evidence_provider`_:             evidence provider
* **gene_product_count**:           recursive product counts per GO term

-----------------

*evidence_provider*
--------------------

mysql> ::

  select * from evidence_provider; 

  +---------------------------------------+
  | EvidenceProvider                      |
  +---------------------------------------+
  | Experimental Evidence Codes           |
  | Computational Analysis Evidence Codes |
  | Author Statement Evidence Codes       |
  | Curator Statement Evidence Codes      |
  | Automatically-assigned Evidence Codes |
  +---------------------------------------+


-----------------




assocseq
========


seq
---
:id: 
   autoincrement 

:display_id:
   the primary label used for identifying the sequence for humans. 
   Not guaranteed to be globally unique. 
   typically corresponds to the first part of a FASTA header. 

:description: 
   textual information for humans concerning this sequence. 
   typically corresponds to the part after the ID in the FASTA header.

:seq: 
   standard IUPAC alphabetic codes are used. 

:seq_len: 
   number of residues in sequence. should always correspond to length(seq), where seq is populated. 

:md5checksum: 
   md5(seq) 

:moltype: 
   DNA or AA (implicitly, other Amino Acid)

:timestamp: 
   updated daily. 


