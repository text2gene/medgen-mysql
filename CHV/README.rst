.. contents:: CHV

what is the Consumer Health Vocab? 
==================================
This vocabulary links terms that are more commonly used in consumer language.
Think "heart attack" vs "Acute Myocardial Infarction".

links
======
CHV.**term** is linked to medgen by way of MedGen concepts (**medgen.MGCONSO.CUI**) 


info schema
===========
::

   mysql> call info;
   
   +--------------+--------+------------+------------+---------+---------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +--------------+--------+------------+------------+---------+---------+----------+-----------------+
   | chv          | InnoDB | log        |         61 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | chv          | InnoDB | README     |         11 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   | chv          | MyISAM | stop       |       2107 | 0.00    | 0.08M   | 0.09M    | utf8_unicode_ci |
   | chv          | MyISAM | term       |     158518 | 0.16    | 17.95M  | 15.95M   | utf8_unicode_ci |
   | chv          | MyISAM | wrong      |       4943 | 0.00    | 0.25M   | 0.15M    | utf8_unicode_ci |
   +--------------+--------+------------+------------+---------+---------+----------+-----------------+
