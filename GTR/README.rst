.. contents:: GTR	      
	      
what is the  Genetic Test Reference? 
======================================
The Genetic Testing Registry (`GTR <ftp://ftp.ncbi.nlm.nih.gov/pub/GTR/data/_README.html>`_) provides a central location for voluntary submission of genetic test information by providers. The scope includes the test's purpose, methodology, validity, evidence of the test's usefulness, and laboratory contacts and credentials. The overarching goal of the GTR is to advance the public health and research into the genetic basis of health and disease.

links
======
* GTR links to ClinVar and MedGen Concepts identifiers (**medgen.MGCONSO.CUI**)
* GTR links to gene sources using gene ids and names (**GeneID**, **Symbol**)  
  
info schema
=============
::
   
   +--------------+--------+--------------------------+------------+---------+---------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME               | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +--------------+--------+--------------------------+------------+---------+---------+----------+-----------------+
   | GTR          | InnoDB | labs_tests_by_country    |         40 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | GTR          | InnoDB | log                      |         59 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | GTR          | InnoDB | mode_of_inheritance      |         18 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | GTR          | InnoDB | README                   |         22 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   | GTR          | InnoDB | tests_by_method_category |          0 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | GTR          | InnoDB | test_condition_gene      |     155675 | 0.16    | 19.55M  | 29.13M   | utf8_unicode_ci |
   | GTR          | InnoDB | test_version             |      49224 | 0.05    | 34.56M  | 3.03M    | utf8_unicode_ci |
   +--------------+--------+--------------------------+------------+---------+---------+----------+-----------------+

   
####################################################################################################


*test_condition_gene*
============================
::

  A comprehensive listing of tests, and the conditions and genes they target.
  This file currently includes both tests registered in GTR and tests 
  previously submitted to GeneTests when it was being served from NCBI. 

  The descripion of the test may require more than one line; 
  they lines are linked by the value of the accession_version column.


|
*tests_by_method_category*
===============================
::

  Summary of the number of tests registered in the GTR using specific methods. 
  The file is tab-delimited and regenerated daily. 


*labs_tests_by_country*
============================
::

   Summary of the number of laboratories with tests registered in the GTR, 
   with a breakdown by clinical or research tests. 
   The top data line reports the sum. 
   The file is tab-delimited and regenerated weekly. 
