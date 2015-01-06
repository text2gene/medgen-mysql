================
MedGen Views 
================
MedGen views were created to provide convenience tables for cross referencing **disease** to **gene** relationships referenced in **pubmed**. 

|
* A **disease** may relate to 1 or more **genes** directly or though one or more **phenotypes**. 
* A **gene** ... 
* A **phenotype** ... 

|
.. contents:: Views

-----------------

|
view_concept 
=============
| Each Medical Genetics `ConceptID`_ is defined in one or more "dictionaries", also called `SourceVocab`_. 
| Lets count how many conceptual terms descriptions there are in each MedGen dictionary (`SourceVocab`_)
::

   mysql> call freq('view_concept', 'SourceVocab'); 

   -- select SourceVocab,count(*) as cnt 
   -- from view_concept  
   -- group by SourceVocab order by cnt desc   

::

   +-------------+---------+
   | SourceVocab | cnt     |
   +-------------+---------+
   | MSH         | 245,435 | << MeSH Medical Subject Headings 
   | SNOMEDCT_US | 156,105 | << SNOMED Clinical Terms 
   | NCI         | 136,888 | << NCI Cancer Thesaurus
   | OMIM        |  61,499 | << OMIM 
   | GTR         |  49,449 | << Genetic Testing Registry 
   | HPO         |  17,509 | << Human Phenotype Ontology 
   | ORDO        |  16,557 | << Orphanet rare diseases 
   +-------------+---------+

|
| Concepts often have a different `Name` in each `SourceVocab`_. 
| Here is "CLL", or **"Chronic lymphocytic leukemia"** in `GTR` *Genetic Testing Registry*. 

::

   select distinct SourceVocab from view_concept 
   where ConceptID = 'C0023434'; 
   +-------------+
   | SourceVocab |
   +-------------+
   | GTR         | << Genetic Testing Registry 
   | MSH         | << Medical Subjects 
   | NCI         | << Cancer
   | OMIM        | << OMIM 
   | ORDO        | << Orphanet rare diseases
   | SNOMEDCT_US | << SNOMED Clinical Terms 
   +-------------+


|
|  Lets get a list of all the ways **"Chronic lymphocytic leukemia"** is listed 
|  in the Genetic Testing Registry (GTR). 

::

   select TermType, Name from view_concept    
   where SourceVocab = 'GTR'      and 
         ConceptID   = 'C0023434'; 

   +----------+---------------------------------------+
   | TermType | Name                                  |
   +----------+---------------------------------------+
   | PT       | Chronic lymphocytic leukemia          |
   | SYN      | LEUKEMIA, CHRONIC LYMPHATIC           |
   | ACR      | CLL                                   |
   | SYN      | Leukemia, B-cell, chronic             |
   | SYN      | Familial Chronic Lymphocytic Leukemia |
   | SYN      | B-cell chronic lymphocytic leukemia   |
   | SYN      | Chronic lymphoblastic leukemia        |
   | SYN      | HCL                                   |
   | SYN      | Hairy Cell Leukemia                   |
   +----------+---------------------------------------+


| 
| MedGen is cool because it links  **ConceptID** across more than one **SourceVocab**. 
| Lets find the frequency of **unique** `ConceptID`_ per `SourceVocab`_. 

::

   mysql> call freqdist('view_concept', 'SourceVocab', 'ConceptID') ; 

   -- select SourceVocab,count(distinct ConceptID ) as cnt 
   -- from view_concept 
   -- group by SourceVocab order by cnt desc

   +-------------+--------+
   | SourceVocab | cnt    |
   +-------------+--------+
   | MSH         | 101483 | -- Medical Subject Headings 
   | SNOMEDCT_US |  97339 | -- SNOMED Clinical Terms
   | NCI         |  47885 | -- Cancer thesaurus 
   | OMIM        |  41423 | -- OMIM 
   | GTR         |  20409 | -- Genetic testing reference
   | HPO         |  10616 | -- Human Phenotype Ontology 
   | ORDO        |   6908 | -- Orphanet 
   +-------------+--------+

|
view_concept_def
=================
* "Summary data for definitions and sources of concepts" 
* ( `ConceptID`_ , `SourceVocab`_, `Definition`_  ) 


|
view_medgen_uid
================
| `MedGenUID`_ can be related directly to `ConceptID`_ using this view table. 
| Note: `MedGenUID`_ are **only available** for `ConceptID`_  if there is a **pubmed link**! 
| 


|
Example: get `ConceptID`_ (CUI) for `MedGenUID`_
::

   select * from view_medgen_uid where MedGenUID = 18145; 
   +-----------+-----------+
   | MedGenUID | ConceptID |
   +-----------+-----------+
   | 18145     | C0028860  |
   +-----------+-----------+

|
|
Example: get `Name`_ and **preferred** `SourceVocab`_ for `ConceptID`_
::

   select name, source as SourceVocab from NAMES 
   where CUI = 'C0028860'; 

   +---------------+-------------+
   | name          | SourceVocab |
   +---------------+-------------+
   | Lowe syndrome | GTR         |  -- Preferred name comes from 
   +---------------+-------------+  -- Genetic Test Registry (GTR)

|
|
view_concept_tree
==================
| MedGen term hierarchy contains many "parent:child" relationships
| "parent to child" relationships derived from **medgen.MGREL** are stored in this table. 
| 


|
|
view_disease_tree
==================
| MedGen term hierarchy of diseases, more formally `SemanticType`_ **Disease or Syndrome**
| View is a subset of `view_concept_tree`_
| Parent


|
|
view_disease_subtype
======================
| MedGen term hierarchy of diseases, more formally `SemanticType`_ **Disease or Syndrome**
| View is a subset of `view_disease_tree`_
| 

|
|
view_genetic_tests
==================
| **GTR** Genetic Testing Registry concepts 

::

   call freq('view_genetic_tests', 'SemanticType'); 
   
   -- select SemanticType,count(*) as cnt 
   -- from view_genetic_tests 
   -- group by SemanticType order by cnt desc

   +----------------------------------+-------+
   | SemanticType                     | cnt   |
   +----------------------------------+-------+
   | Disease or Syndrome              | 65299 |
   | Congenital Abnormality           |  7073 |
   | Neoplastic Process               |  3044 |
   | Finding                          |  1314 |
   | Pathologic Function              |   271 |
   | Mental or Behavioral Dysfunction |   169 |
   | Sign or Symptom                  |    66 |
   | Gene or Genome                   |    29 |
   | Anatomical Abnormality           |    18 |
   | Cell or Molecular Dysfunction    |     7 |
   | Body System                      |     2 |
   | Acquired Abnormality             |     1 |
   +----------------------------------+-------+

|
|
MedGenUID
=========
* Alias for `medgen_pubmed.UID`
* MedGenUID are sequential and almost always have a 1:1 mapping to `ConceptID`_

|
ConceptID
=========
* Alias for `MGCONSO.CUI`
* Each ConceptID exists in at least one `SourceVocab`
* Each ConceptID has one or more attributes 

|
TermType
=========
* **PT**   means "Preferred Term". 
* **ACR**  means "Acryonymn". 
*  **SYN**  means "Synonym". 
* http://www.ncbi.nlm.nih.gov/medgen/docs/properties 

|
Name
=========
* Alias for `medgen.NAMES.name`
* Alias for `clinvar.disease_names.DiseaseName`
* This is **NCBI preferred disease naming used throughout medgen, including GTR Genetic Testing Registry**

|
Definition
===========
* "Summary data for sources of concepts" 
* See NCBI Readme: ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/README.html

|
SourceVocab
============
* Alias for `MGCONSO.SAB`
* Each SourceVocab is a dictionary of concepts 
* Each SourceVocab can be mapped in whole or in part to other source vocabs using the `ConceptID`

|
SemanticType 
=============
* Alias for `MGSTY.STY`
* Example: 'Disease or Syndrome' 

|
|
MAPPINGS
=========

- Every CUI (concept) is linked to at least one AUI (atom), SUI (string), and LUI (term), but can also be linked to many of each of these. 
- Every AUI (atom) is linked to a single SUI (string), a single LUI (term), and a single CUI (concept). 
- Each SUI (string) can be linked to many AUIs (atoms), to a single LUI (term), and to more than one CUI (concept)  although the typical case is one CUI. 
- Each LUI (term) can be linked to many AUIs (atoms), many SUIs (strings), and more than one CUI (concept) although the typical case is one CUI.

|
CARDINALITY
============ 

- concept  1:* atom     
- concept  1:* string
- concept  1:* term  

- atom     1:* string  
- atom     1:* terms   
- atom     1:* concept
