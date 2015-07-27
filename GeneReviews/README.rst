.. contents:: GeneReviews

what is GeneReviews? 
==================================
GeneReviews is an online database containing standardized peer-reviewed articles that describe specific heritable diseases.

links
======
* GeneReviews.genesymbol links to gene sources (Symbol, GeneID)
* GeneReviews.omim links to OMIM
* GeneReviews.title links to NCBI BOOK content   

info schema
===========
::

   mysql> call info;
   
   +--------------+--------+------------+------------+---------+---------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +--------------+--------+------------+------------+---------+---------+----------+-----------------+
   | genereviews  | InnoDB | genesymbol |       1961 | 0.00    | 0.13M   | 0.00M    | utf8_unicode_ci |
   | genereviews  | InnoDB | log        |         48 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | genereviews  | InnoDB | omim       |       3085 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | genereviews  | InnoDB | README     |         11 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   | genereviews  | InnoDB | title      |        638 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   +--------------+--------+------------+------------+---------+---------+----------+-----------------+
