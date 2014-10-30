mysql_create_database = \
"""
CREATE DATABASE if NOT EXISTS ?DATASET CHARACTER SET utf8 COLLATE utf8_unicode_ci;
"""

mysql_drop_database = \
"""
DROP DATABASE if EXISTS ?DATASET;
"""

mysql_use_database = \
""" use ?DATASET; """

mysql_create_user = \
"""
create user '?DB_USER'@'localhost' identified by '?DB_PASS';
"""

# http://stackoverflow.com/questions/598190/mysql-check-if-the-user-exists-and-drop-it
mysql_drop_user = \
"""
call log('?DB_USER', 'drop user'); 

GRANT USAGE ON  ?DATASET.* TO '?DB_USER'@'localhost';
DROP USER '?DB_USER'@'localhost';

call log('?DB_USER', 'ok'); 
"""

mysql_grant_user_all = \
"""
call log('?DB_USER', 'grant all'); 

grant all on ?DATASET.* to '?DB_USER'@'localhost';

call log('?DB_USER', 'ok'); 
"""

mysql_grant_execute = \
"""
call log('?DB_USER', 'grant execute'); 

grant execute on ?DATASET.* to '?DB_USER'@'localhost';

call log('?DB_USER', 'ok'); 
"""

bash_header = \
""" #!/bin/bash
"""

bash_write_db_config = \
"""
DATASET=?DATASET
DB_README="?README"

DB_USER=`whoami`
DB_PASS=$SECRET
DB_HOST="localhost" 
DB_PORT="3306"  

mysql_dataset="mysql -D $DATASET -u $DB_USER -p$DB_PASS -h $DB_HOST --port $DB_PORT --local-infile" 
"""

mysql_exists_index="""
SELECT COUNT(1) into @exists FROM INFORMATION_SCHEMA.STATISTICS
WHERE table_schema=DATABASE() AND table_name='?TABLE' AND index_name='?INDEX';
"""

mysql_add_index="""
call log('?TABLE', 'add index(?INDEX)'); 

alter table ?TABLE add index ('?INDEX'); 

call log('?TABLE', 'show index from ?TABLE'); 
"""

mysql_drop_index="""
alter table ?TABLE drop index (?INDEX); 
"""


mysql_load_data_local_infile = """
call log('?TABLE','infile ?FILE'); 

call log('?TABLE','truncate ?TABLE'); 
truncate ?TABLE; 

load data local infile '?FILE' 
into table ?TABLE
fields terminated by '?SEP' ESCAPED BY '' 
lines terminated by '\n' ignore ?SKIP lines;

show warnings; 

select concat('rows loaded ', count(*)) into @num_rows from ?TABLE; 

call log('?TABLE',@num_rows); 
"""
