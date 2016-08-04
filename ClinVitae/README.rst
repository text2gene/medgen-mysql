what is ClinVitae? 
==================================
CLINVITAE is a database of clinically-observed genetic variants aggregated from public sources, operated and made freely available by INVITAE.

.. contents:: ClinVitae

CURRENT DATABASE SOURCES
========================

Invitae

ClinVar

Emory Genetics Laboratory Variant Classification Catalog

ARUP Mutation Databases

Carver Mutation Database

Kathleen Cunningham Foundation Consortium for Research into Familial Breast Cancer


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

        mysql> describe variant_results;
        +-------------------------+--------------+------+-----+---------+-------+
        | Field                   | Type         | Null | Key | Default | Extra |
        +-------------------------+--------------+------+-----+---------+-------+
        | gene                    | varchar(20)  | YES  | MUL | NULL    |       |
        | hgvs_text               | varchar(100) | NO   | MUL | NULL    |       |
        | protein_change          | varchar(100) | YES  |     | NULL    |       |
        | mappings                | varchar(255) | YES  |     | NULL    |       |
        | alias                   | varchar(100) | YES  |     | NULL    |       |
        | transcripts             | varchar(255) | YES  |     | NULL    |       |
        | region                  | varchar(50)  | YES  |     | NULL    |       |
        | reported_classification | varchar(100) | YES  |     | NULL    |       |
        | inferred_classification | varchar(100) | YES  |     | NULL    |       |
        | source                  | varchar(50)  | YES  |     | NULL    |       |
        | last_evaluated          | date         | YES  |     | NULL    |       |
        | last_updated            | date         | YES  |     | NULL    |       |
        | url                     | varchar(255) | YES  |     | NULL    |       |
        | submitter_comment       | text         | YES  |     | NULL    |       |
        +-------------------------+--------------+------+-----+---------+-------+

          
   
#####################################################################################################

gene
----
HGNC symbol

hgvs_text
---------
HGVS name for variant

protein_change
--------------
Protein result of variant

mappings
--------
variant "synonyms" for hgvs_text

alias
-----
?

transcripts
-----------
current and historical transcripts for gene region of this variant

reported_classification
-----------------------
variant pathogenicity as provided by this entry's source

inferred_classification
-----------------------
?
 
source
------
data source that provided this variant entry

last_evaluated
--------------
date on which this variant was last evaluated by source

last_updated
------------
date at which ClinVitae last received data about this entry from source

url
---
site providing information on this variant

submitter_comment 
-----------------
qualifying comments on this variant, especially pertaining to its classification


