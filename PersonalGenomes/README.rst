.. contents:: PersonalGenomes

what is PersonalGenomes? 
==================================
Personal Genomes Project at Harvard Medical School (`PGP GET Evidence <http://evidence.pgp-hms.org/guide_upload_and_annotated_file_formats>`_) 

links
======
* TODO  

info schema
===========
::

   mysql> call info;
   
   +-----------------+--------+------------------------------+------------+---------+---------+----------+-----------------+
   | table_schema    | ENGINE | TABLE_NAME                   | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +-----------------+--------+------------------------------+------------+---------+---------+----------+-----------------+
   | PersonalGenomes | InnoDB | bionotate                    |       1685 | 0.00    | 5.52M   | 0.06M    | utf8_unicode_ci |
   | PersonalGenomes | InnoDB | log                          |         28 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | PersonalGenomes | InnoDB | README                       |         33 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | allele_frequency             |      43092 | 0.04    | 2.14M   | 1.53M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | articles                     |       2159 | 0.00    | 0.71M   | 0.03M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | datasets                     |        101 | 0.00    | 0.01M   | 0.01M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | diseases                     |       2293 | 0.00    | 0.10M   | 0.15M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | editor_summary               |        577 | 0.00    | 0.05M   | 0.04M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | edits                        |    1754902 | 1.75    | 152.62M | 185.35M  | utf8_general_ci |
   | PersonalGenomes | MyISAM | flat_summary                 |     146285 | 0.15    | 157.71M | 5.59M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | genetests_genes              |        480 | 0.00    | 0.02M   | 0.01M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | gene_canonical_name          |       8402 | 0.01    | 0.16M   | 0.15M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | gene_disease                 |      10762 | 0.01    | 0.30M   | 0.53M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | genomes                      |        794 | 0.00    | 0.02M   | 0.03M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | snap_latest                  |    1148042 | 1.15    | 96.33M  | 174.57M  | utf8_general_ci |
   | PersonalGenomes | MyISAM | snap_release                 |         99 | 0.00    | 0.07M   | 0.03M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | variants                     |     146264 | 0.15    | 4.91M   | 9.80M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | variant_disease              |       2330 | 0.00    | 0.08M   | 0.10M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | variant_external             |     134877 | 0.13    | 52.12M  | 4.28M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | variant_frequency            |      83159 | 0.08    | 2.30M   | 2.26M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | variant_locations            |        321 | 0.00    | 0.01M   | 0.03M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | variant_occurs               |    1051357 | 1.05    | 51.53M  | 75.64M   | utf8_general_ci |
   | PersonalGenomes | MyISAM | variant_population_frequency |     131144 | 0.13    | 7.94M   | 3.27M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | web_vote                     |        414 | 0.00    | 0.03M   | 0.05M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | web_vote_history             |        559 | 0.00    | 0.09M   | 0.05M    | utf8_general_ci |
   | PersonalGenomes | MyISAM | web_vote_latest              |        425 | 0.00    | 0.06M   | 0.08M    | utf8_general_ci |
   +-----------------+--------+------------------------------+------------+---------+---------+----------+-----------------+
