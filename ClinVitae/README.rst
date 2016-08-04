what is ClinVitae? 
==================================
CLINVITAE is a database of clinically-observed genetic variants aggregated from public sources, operated and made freely available by INVITAE.

CURRENT DATABASE SOURCES
* Invitae
* ClinVar
* Emory Genetics Laboratory Variant Classification Catalog
* ARUP Mutation Databases
* Carver Mutation Database
* Kathleen Cunningham Foundation Consortium for Research into Familial Breast Cancer


.. contents:: ClinVitae

links
======
* `ClinVitae <http://clinvitae.invitae.com/>`_


info schema
===========
::

   mysql> call info; 

   +--------------+--------+----------------------------+------------+---------+---------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME                 | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +--------------+--------+----------------------------+------------+---------+---------+----------+-----------------+
   | clinvar      | InnoDB | clingen_gene_curation_list |        631 | 0.00    | 0.11M   | 0.02M    | utf8_unicode_ci |
   | clinvar      | InnoDB | clinvar_hgvs               |     414618 | 0.41    | 29.56M  | 38.14M   | utf8_unicode_ci |
   | clinvar      | InnoDB | cross_references           |     172566 | 0.17    | 10.52M  | 0.00M    | utf8_unicode_ci |
   | clinvar      | InnoDB | disease_names              |      27775 | 0.03    | 3.52M   | 4.98M    | utf8_unicode_ci |
   | clinvar      | InnoDB | gene_condition_source_id   |       6169 | 0.01    | 1.52M   | 1.19M    | utf8_unicode_ci |
   | clinvar      | InnoDB | gene_specific_summary      |      26984 | 0.03    | 1.52M   | 0.94M    | utf8_unicode_ci |
   | clinvar      | InnoDB | log                        |        133 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | clinvar      | InnoDB | molecular_consequences     |     127532 | 0.13    | 9.52M   | 11.55M   | utf8_general_ci |
   | clinvar      | InnoDB | README                     |         11 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   | clinvar      | InnoDB | variant_summary            |     308972 | 0.31    | 99.64M  | 74.31M   | utf8_unicode_ci |
   | clinvar      | InnoDB | var_citations              |     117166 | 0.12    | 6.52M   | 15.09M   | utf8_unicode_ci |
   +--------------+--------+----------------------------+------------+---------+---------+----------+-----------------+
  
   
#####################################################################################################


