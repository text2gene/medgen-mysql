========
medgen
======== 
   **MedGen is NCBI's portal for Medical Genetics**
* `BOOK <http://www.ncbi.nlm.nih.gov/books/NBK159970>`_ 
* `list of data elements aggregated in MedGen  <http://www.ncbi.nlm.nih.gov/books/NBK159970/table/MedGen.T.a_list_of_data_elements_aggrega/?report=objectonly>`_

|
|
view_pubmed
=========================
::

   mysql> use medgen; 

   call freq('view_concept', 'SourceVocab'); `
   +-------------+--------+
   | SourceVocab | cnt    |
   +-------------+--------+
   | MSH         | 245435 | Medical Subject Headings 
   | SNOMEDCT_US | 156105 | SNOMED Clinical Terms 
   | NCI         | 136888 | NCI Cancer Terms 
   | OMIM        |  61499 | OMIM 
   | GTR         |  31623 | Genetic Test Registry
   | HPO         |  17357 | Human Phenotype Ontology 
   +-------------+--------+

|
|
medgen_pubmed
=========================
::

   +-------+---------------+------+-----+---------+-------+
   | Field | Type          | Null | Key | Default | Extra |
   +-------+---------------+------+-----+---------+-------+
   | UID   | varchar(10)   | NO   | MUL | NULL    |       | MedGenUID 
   | CUI   | char(8)       | NO   | MUL | NULL    |       | ConceptID 
   | NAME  | varchar(1000) | NO   | MUL | NULL    |       | Name 
   | PMID  | varchar(10)   | NO   | MUL | NULL    |       | PMID
   +-------+---------------+------+-----+---------+-------+
   
|
|
   
MedGen provides links to resources
==================================

* Genetic tests registered in the NIH Genetic Testing Registry (GTR)
* GeneReviews
* OMIM
* Related genes
* Disorders with similar clinical features
* Medical and research literature
* Practice guidelines
* Consumer resources
* Ontologies


::


   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   list of data elements aggregated in MedGen
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

|

.. contents::


Clinical and research tests
----------------------------
* [GTR] Genetic Test Reference 

Clinical features
----------------------------
* [HPO] Human Phenotype Ontology 


Clinical trials
----------------------------
*  [ClinicalTrials.gov]

Concept id
----------------------------
*  [UMLS] Unified Medical Language System 
*  [GTR] Genetic Testing Reference 

Consumer resources
----------------------------
*    [GHR] Genetics Home Reference, 
*    Genetic Alliance, 
*    [GARD] Genetic and Rare Diseases Information Center, 
*    [MedlinePlus]

Cytogenetic location
----------------------------
*   NCBI annotation

GENE
----------------------------
*   NCBI Gene

Links to other NCBI’s resources
--------------------------------------------------------
* [Gene], 
* [MeSH] pubmed article subjects, 
* [ClinVar] clinical variants, 
* NCBI Bookshelf, BioSystems, etc.


MedGen Identifier
----------------------------
   **MedGen**

Medical encyclopedia
----------------------------
   A.D.A.M. Medical encyclopedia via PubMed Health

Mode of inheritance
----------------------------
* [OMIM] mendelian disorders 
* [ClinVar] clinical variants 
* [GTR] Genetic Testing Reference 

Molecular resources
----------------------------
* Coriell Institute for Medical Research (?) 

Professional Guidelines
----------------------------
* NCBI curation (?) 

RefSeqGene
----------------------------
* RefSeqGene ( how used?) 
		
Reviews
----------------------------
*   [GeneReviews] 
*   PubMed Clinical Queries (?) 

Semantic types
----------------------------
* [UMLS] Unified Medical Language System 

Clinical terms 
----------------------------
* [SNOMED-CT]

Source Identifiers
----------------------------
* Various sources, such as **OMIM**, **HPO**, etc.

Terms definition
----------------------------
* [GeneReviews], 
* [Medical Genetics] Summaries, etc.

Terms, acronyms, synonyms
----------------------------
*   Defined vocabularies (?) 

Terms hierarchies
----------------------------
* [GTR] Genetic Testing Reference 
* [MedGen] Medical Genetics 

Variations
----------------------------
* ClinVar


----------------------------

FAQ
===

When I search by a MIM number, why do I sometimes get multiple records? ::

  There are two major data flows that manage relationships between 
  MIM numbers and records in MedGen.  

  One is the daily update provided by GTR- and ClinVar-related data flows from OMIM.  

  The second is the semi-annual update from UMLS to MedGen.  
  In the former data flow, the relationship of MedGen record to MIM number is 1:1.  
  In the latter data flow the MIM number may be reported for more than one concept UID or CUI.





SCHEMA 
=========================
::

   ---------------------------+------------+---------+----------+----------+-----------------+
   TABLE_NAME                 | TABLE_ROWS | million | data_MB  | index_MB | TABLE_COLLATION |
   ---------------------------+------------+---------+----------+----------+-----------------+
   log                        |        119 | 0.00    | 0.02M    | 0.00M    |                 | 

   medgen_hpo                 |      10302 | 0.01    | 1.52M    | 0.58M    | utf8_general_ci |
   medgen_hpo_omim            |     120969 | 0.12    | 21.55M   | 27.61M   | utf8_general_ci |
   medgen_pubmed              |   74905477 | 74.91   | 5390.00M | 6668.00M | utf8_general_ci |
   medgen_uid                 |     147881 | 0.15    | 6.52M    | 7.03M    |

   MERGED                     |       1938 | 0.00    | 0.13M    | 0.08M    | utf8_general_ci |
   MGCONSO                    |     638644 | 0.64    | 78.61M   | 13.55M   | utf8_general_ci |
   MGDEF                      |      49381 | 0.05    | 14.52M   | 1.52M    | utf8_general_ci |
   MGREL                      |    1371039 | 1.37    | 155.69M  | 56.63M   | utf8_general_ci |
   MGSAT                      |    1698563 | 1.70    | 164.70M  | 180.42M  | utf8_general_ci |
   MGSTY                      |     396405 | 0.40    | 52.61M   | 36.13M   | utf8_general_ci |
   NAMES                      |     264101 | 0.26    | 20.55M   | 5.52M    | utf8_general_ci |

   README                     |         30 | 0.00    | 0.02M    | 0.00M    | utf8_general_ci |

   view_pubmed                |   10552219 | 10.55   | 445.95M  | 204.83M  |  
   view_pubmed_concept        |     146772 | 0.15    | 6.52M    | 0.00M    |  
   view_pubmed_disease        |      17585 | 0.02    | 1.52M    | 1.13M    |  

   view_concept               |     589246 | 0.59    | 79.61M   | 26.09M   | utf8_general_ci |
   view_concept_child         |      71464 | 0.07    | 11.52M   | 11.06M   | utf8_general_ci |
   view_concept_gtr           |      32066 | 0.03    | 4.52M    | 3.03M    | utf8_general_ci |
   view_concept_preferred     |     276090 | 0.28    | 27.56M   | 6.52M    | 
   view_concept_usage         |     259869 | 0.26    | 11.52M   | 0.00M    | 

   view_curation_usage        |         21 | 0.00    | 0.02M    | 0.00M    | 
   view_definition            |      35690 | 0.04    | 14.52M   | 0.00M    | 

   view_disease_child         |      11185 | 0.01    | 1.52M    | 1.13M    | utf8_general_ci |
   view_disease_preferred     |      22556 | 0.02    | 2.52M    | 0.50M    | 
   view_disease_subtype       |      11815 | 0.01    | 1.52M    | 0.00M    | utf8_general_ci |

   view_medgen_hpo            |       9420 | 0.01    | 1.52M    | 0.92M    | utf8_general_ci |
   view_medgen_hpo_omim       |     119536 | 0.12    | 48.56M   | 23.09M   | utf8_general_ci |
   view_medgen_hpo_omim_usage |        443 | 0.00    | 0.08M    | 0.00M    |  
   view_medgen_uid            |     145893 | 0.15    | 6.52M    | 7.03M    | utf8_general_ci |

   view_mode_of_inheritance   |       7527 | 0.01    | 1.52M    | 0.20M    |  
   view_preferred_usage       |        237 | 0.00    | 0.05M    | 0.00M    |

   view_relate_usage          |        134 | 0.00    | 0.02M    | 0.00M    | 
   view_semantic_usage        |         87 | 0.00    | 0.02M    | 0.00M    | 
   view_vocab_usage           |         47 | 0.00    | 0.02M    | 0.00M    | 
   ---------------------------+------------+---------+----------+----------+-----------------+


MGREL
=======
MedGen Relationships
::

   mysql> call freq('MGREL', 'REL');
   
   mysql>
   select REL,count(*) as cnt
   from MGREL group by REL order by cnt desc; 

   +-----+--------+
   | REL | cnt    |
   +-----+--------+
   | RO  | 734050 | Relate other
   | RB  | 137350 | Relate broader
   | RN  | 137350 | Relate narrower
   | SY  | 112920 | Synonym
   | SIB |  92898 | Sibling 
   | CHD |  84123 | Child
   | PAR |  84123 | Parent 
   | AQ  |  21376 | Allowed Qualifier 
   | QB  |  21376 | can be qualified by 
   | RQ  |  18942 | related and possibly synonymous
   +-----+--------+
   
   select RELA, count(*) as cnt from MGREL where REL = 'RO'
   group by RELA order by cnt desc;

   
   

   
