==============================
GTR Genetic Test Reference 
==============================

readme
----------
* `GTR README <ftp://ftp.ncbi.nlm.nih.gov/pub/GTR/data/_README.html>`_
* see ../clinvar/README.rst 

GTR tables
----------
* `test_condition_gene`_ 
* `tests_by_method_category`_ 
* `labs_tests_by_country`_

------------

*test_condition_gene*
============================
::

  A comprehensive listing of tests, and the conditions and genes they target.
  This file currently includes both tests registered in GTR and tests 
  previously submitted to GeneTests when it was being served from NCBI. 

  The descripion of the test may require more than one line; 
  they lines are linked by the value of the accession_version column.

* `accession_version`_ 
* `GeneTestsID`_ 
* `test_type`_ 
* `concept_type`_ 
* `GTR_identifier`_ 
* `MIM_number`_ 
* `gene_or_SNOMED_CT_ID`_ 


accession_version
--------------------
   GTR accession assigned (current version number). If GeneTests, 'N/A' is reported.

GeneTestsID
-----------------
   Assigned by GeneTests. If GTR, 'N/A' is reported.

test_type
-----------------
   The values are Clinical or Research

concept_type
-----------------
   A description of the object of the test. The values are condition or gene.

GTR_identifier
-----------------
   Identifier GTR uses for the condition. This is concept (CUI) in MedGen.

MIM_number
-----------------
    Identifier assigned by OMIM to this object

gene_or_SNOMED_CT_ID
---------------------
   If  gene, then GeneID from NCBI's gene database; if condtion, then SNOMED_CT identifier if available.



------------


|
*tests_by_method_category*
===============================
::

  Summary of the number of tests registered in the GTR using specific methods. 
  The file is tab-delimited and regenerated daily. 


* `CategoryMajor`_
* `Category`_
* `WithClinicalTests`_  WithClinicalTestsUSA 
* `WithResearchTests`_  WithResearchTestsUSA

|
|


CategoryMajor 
----------------------
Major method category for test 

Category
----------------------
Method category for test 


WithClinicalTests
----------------------
the number of the labs in the second column registering clinical tests

WithResearchTests
----------------------
the number of the labs in the second column registering research tests


------------


*labs_tests_by_country*
============================
::

   Summary of the number of laboratories with tests registered in the GTR, 
   with a breakdown by clinical or research tests. 
   The top data line reports the sum. 
   The file is tab-delimited and regenerated weekly. 


* Country 
* `RegisteredLabs`_  
* `WithClinicalTests`_ 
* `WithResearchTests`_



RegisteredLabs
----------------------
Total laboratories registered in the GTR
