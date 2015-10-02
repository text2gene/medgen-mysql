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
call info; 
::

   +--------------------------+------------+---------+----------+----------+
   | TABLE_NAME               | TABLE_ROWS | million | data_MB  | index_MB |
   +--------------------------+------------+---------+----------+----------+
   | log                      |        102 | 0.00    | 0.02M    | 0.00M    |
   | README                   |         22 | 0.00    | 0.02M    | 0.00M    | 
   | count_pubmed             |   11165454 | 11.17   | 138.43M  | 120.43M  |
   | count_pubmed_concept     |     149407 | 0.15    | 4.70M    | 1.39M    |
   | medgen_hpo               |      11634 | 0.01    | 1.14M    | 0.17M    |
   | medgen_hpo_omim          |     118167 | 0.12    | 17.73M   | 3.42M    |
   | medgen_pubmed            |   86626024 | 86.63   | 3679.57M | 1716.03M |
   | MGCONSO                  |     399562 | 0.40    | 39.92M   | 5.12M    |
   | MGDEF                    |      44067 | 0.04    | 13.16M   | 0.42M    |
   | MGHISTORY                |       2225 | 0.00    | 0.04M    | 0.00M    |
   | MGMERGED                 |       2210 | 0.00    | 0.10M    | 0.02M    |
   | MGREL                    |    1452592 | 1.45    | 122.25M  | 27.74M   |
   | MGSAT                    |     377710 | 0.38    | 29.40M   | 5.94M    |
   | MGSTY                    |     393390 | 0.39    | 21.97M   | 9.78M    |
   | NAMES                    |     174348 | 0.17    | 9.56M    | 1.59M    |
   | omim_pubmed              |     177869 | 0.18    | 2.21M    | 3.84M    |
   | view_concept             |     398033 | 0.40    | 39.52M   | 26.02M   |
   | view_concept_def         |      43932 | 0.04    | 13.00M   | 0.54M    |
   | view_concept_tree        |      85812 | 0.09    | 6.58M    | 1.98M    |
   | view_disease_subtype     |       5736 | 0.01    | 0.64M    | 0.00M    |
   | view_disease_tree        |      19112 | 0.02    | 0.87M    | 0.40M    |
   | view_genetic_tests       |      12045 | 0.01    | 0.55M    | 0.00M    |
   | view_medgen_hpo          |      11344 | 0.01    | 1.10M    | 0.26M    |
   | view_medgen_hpo_omim     |     133881 | 0.13    | 23.37M   | 3.50M    |
   | view_medgen_uid          |     149407 | 0.15    | 2.85M    | 2.76M    |
   | view_mode_of_inheritance |       7857 | 0.01    | 1.26M    | 0.00M    |
   | view_semantics           |     240917 | 0.24    | 17.21M   | 3.23M    |
   +--------------------------+------------+---------+----------+----------+


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

   
MGSTY
==========
MedGen Semantic Types
::

   call freq('MGSTY', 'STY');
   
   select STY,count(*) as cnt
   from MGSTY group by STY order by cnt desc

   +-------------------------------------------+--------+
   | STY                                       | cnt    |
   +-------------------------------------------+--------+
   | Pharmacologic Substance                   | 102511 |
   | Finding                                   |  90413 |
   | Organic Chemical                          |  81329 |
   | Disease or Syndrome                       |  47223 |
   | Neoplastic Process                        |  16151 |
   | Amino Acid, Peptide, or Protein           |   9383 |
   | Congenital Abnormality                    |   6536 |
   | Pathologic Function                       |   5655 |
   | Steroid                                   |   3919 |
   | Sign or Symptom                           |   2909 |
   | ...                                       |   ...  |
   +-------------------------------------------+--------+


   
