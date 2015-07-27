==========
templates
==========
Database generation templates.


db.config
=======================
mysql configuration for comand line usage  
::
   
   source db.config
   $mysql_dataset 


create_database.sql
=======================
Ensure UT8 unicode for all databases 
::
   
    CHARACTER SET utf8 COLLATE utf8_unicode_ci


create_logging.sql
=======================
Standard logging for dataload of any database
::

   mysql> select * from log; 
   +---------------------+---------------------------+-------------------+-----------+-----+
   | event_time          | entity_name               | message           | DATASET   | idx |
   +---------------------+---------------------------+-------------------+-----------+-----+
   | 2015-07-26 15:14:44 | log                       | table created     | NULL      |   1 |
   | 2015-07-26 15:14:44 | log                       | procedure created | NULL      |   2 |
   | 2015-07-26 15:14:44 | tail                      | procedure created | NULL      |   3 |
   | 2015-07-26 15:14:44 | head                      | procedure created | NULL      |   4 |
   | 2015-07-26 15:14:44 | etime                     | procedure created | NULL      |   5 |
   | 2015-07-26 15:14:44 | last_loaded               | procedure created | NULL      |   6 |
   | 2015-07-26 15:14:44 | regex_replace             | create function   | NULL      |   7 |
   | 2015-07-26 15:14:44 | regex_replace             | function created  | NULL      |   8 |
   | 2015-07-26 15:14:44 | DATASET                   | templates         | templates |   9 |
   | 2015-07-26 15:14:44 | create_tables.sql         | begin             | templates |  10 |
   | 2015-07-26 15:14:44 | common_medgen_identifiers | utf8_unicode_ci   | templates |  11 |
   | 2015-07-26 15:14:44 | create_tables.sql         | end               | templates |  12 |
   +---------------------+---------------------------+-------------------+-----------+-----+


create_memory.sql
=======================
Memory usage and schema 
::

   mysql> call info;

   +--------------+--------+---------------------------+------------+---------+---------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME                | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +--------------+--------+---------------------------+------------+---------+---------+----------+-----------------+
   | templates    | InnoDB | common_medgen_identifiers |          0 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | templates    | InnoDB | log                       |         12 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | templates    | InnoDB | README                    |         44 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   +--------------+--------+---------------------------+------------+---------+---------+----------+-----------------+

   
load_table.sh
=======================
command line script for running load_table.sql


load_table.sql
=======================
::
   
   load data local infile ... 


   
  
mysql>call etime
------------------
show elapsed time between log entries, *example* time between load_data and "rows loaded #" confirmation. 
::

   mysql> call etime; 
   +-----+---------------------+-------------------+------------------------+---------------------+-------+
   | idx | event_time(start)   | entity_name       | message                | event_time(end)     | etime |
   +-----+---------------------+-------------------+------------------------+---------------------+-------+
   | ... |                     |                   |                        |                     |       |
   |  11 | 2014-05-23 00:12:08 | load_tables       | refresh                | 2014-05-23 00:12:07 |     1 |
   |  12 | 2014-05-23 00:12:08 | mutation2pubtator | load_data              | 2014-05-23 00:12:08 |     0 |
   |  13 | 2014-05-23 00:12:16 | mutation2pubtator | rows loaded 464323     | 2014-05-23 00:12:08 |     8 |
   |  14 | 2014-05-23 00:12:16 | gene2pubtator     | load_data              | 2014-05-23 00:12:16 |     0 |
   |  15 | 2014-05-23 00:30:48 | gene2pubtator     | rows loaded 16035055   | 2014-05-23 00:12:16 |  1112 |
   +-----+---------------------+-------------------+------------------------+---------------------+-------+

|

mysql>call tail
------------------
show recent log entries 
::

   mysql> call tail;
   +---------------------+-------------------+------------------------------------------------------+----------+-----+
   | event_time          | entity_name       | message                                              | DATASET  | idx |
   +---------------------+-------------------+------------------------------------------------------+----------+-----+
   | 2014-05-23 00:12:07 | DATASET           | PubTator                                             | PubTator |   8 |
   | 2014-05-23 00:12:07 | readme            | ftp://ftp.ncbi.nlm.nih.gov/pub/lu/PubTator/readme.txt| PubTator |   9 |
   | 2014-05-23 00:12:07 | PubTator          | load                                                 | PubTator |  10 |
   | 2014-05-23 00:12:08 | load_tables       | refresh                                              | PubTator |  11 |
   | 2014-05-23 00:12:08 | mutation2pubtator | load_data                                            | PubTator |  12 |
   | 2014-05-23 00:12:16 | mutation2pubtator | rows loaded 464323                                   | PubTator |  13 |
   | 2014-05-23 00:12:16 | gene2pubtator     | load_data                                            | PubTator |  14 |
   +---------------------+-------------------+------------------------------------------------------+----------+-----+

|

insert a log message
---------------------
(convenience method) 
::

   mysql> call log(entity_name, message)




mysql>call etime
------------------
show elapsed time between log entries, *example* time between load_data and "rows loaded #" confirmation. 
::

   mysql> call etime; 
   +-----+---------------------+-------------------+------------------------+---------------------+-------+
   | idx | event_time(start)   | entity_name       | message                | event_time(end)     | etime |
   +-----+---------------------+-------------------+------------------------+---------------------+-------+
   | ... |                     |                   |                        |                     |       |
   |  11 | 2014-05-23 00:12:08 | load_tables       | refresh                | 2014-05-23 00:12:07 |     1 |
   |  12 | 2014-05-23 00:12:08 | mutation2pubtator | load_data              | 2014-05-23 00:12:08 |     0 |
   |  13 | 2014-05-23 00:12:16 | mutation2pubtator | rows loaded 464323     | 2014-05-23 00:12:08 |     8 |
   |  14 | 2014-05-23 00:12:16 | gene2pubtator     | load_data              | 2014-05-23 00:12:16 |     0 |
   |  15 | 2014-05-23 00:30:48 | gene2pubtator     | rows loaded 16035055   | 2014-05-23 00:12:16 |  1112 |
   +-----+---------------------+-------------------+------------------------+---------------------+-------+

|

mysql>call tail
------------------
show recent log entries 
::

   mysql> call tail;
   +---------------------+-------------------+------------------------------------------------------+----------+-----+
   | event_time          | entity_name       | message                                              | DATASET  | idx |
   +---------------------+-------------------+------------------------------------------------------+----------+-----+
   | 2014-05-23 00:12:07 | DATASET           | PubTator                                             | PubTator |   8 |
   | 2014-05-23 00:12:07 | readme            | ftp://ftp.ncbi.nlm.nih.gov/pub/lu/PubTator/readme.txt| PubTator |   9 |
   | 2014-05-23 00:12:07 | PubTator          | load                                                 | PubTator |  10 |
   | 2014-05-23 00:12:08 | load_tables       | refresh                                              | PubTator |  11 |
   | 2014-05-23 00:12:08 | mutation2pubtator | load_data                                            | PubTator |  12 |
   | 2014-05-23 00:12:16 | mutation2pubtator | rows loaded 464323                                   | PubTator |  13 |
   | 2014-05-23 00:12:16 | gene2pubtator     | load_data                                            | PubTator |  14 |
   +---------------------+-------------------+------------------------------------------------------+----------+-----+

|

insert a log message
---------------------
(convenience method) 
::

   mysql> call log(entity_name, message)

   
