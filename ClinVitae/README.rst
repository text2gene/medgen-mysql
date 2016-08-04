what is ClinVitae? 
==================================
CLINVITAE is a database of clinically-observed genetic variants aggregated from public sources, operated and made freely available by INVITAE.

CURRENT DATABASE SOURCES::
    Invitae
    ClinVar
    Emory Genetics Laboratory Variant Classification Catalog
    ARUP Mutation Databases
    Carver Mutation Database
    Kathleen Cunningham Foundation Consortium for Research into Familial Breast Cancer

.. contents:: ClinVitae

links
======
* `ClinVitae <http://clinvitae.invitae.com/>`_


info schema
===========
::
        mysql> call info;
        +--------------+--------+-----------------+------------+---------+---------+----------+-----------------+
        | table_schema | ENGINE | TABLE_NAME      | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
        +--------------+--------+-----------------+------------+---------+---------+----------+-----------------+
        | clinvitae    | InnoDB | log             |         32 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
        | clinvitae    | InnoDB | README          |         77 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
        | clinvitae    | InnoDB | variant_results |     166786 | 0.17    | 47.58M  | 11.03M   | utf8_unicode_ci |
        | clinvitae    | InnoDB | version_info    |          1 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
        +--------------+--------+-----------------+------------+---------+---------+----------+-----------------+
      
   
#####################################################################################################


