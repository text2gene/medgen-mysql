call log('@@@TABLE','load_data'); 

truncate @@@TABLE; 

load data local infile '@@@FILE' 
into table @@@TABLE
fields terminated by '@@@SEP'
optionally enclosed by '"' 
ESCAPED BY '' 
lines terminated by '\n' 
ignore @@@SKIP lines;

show warnings; 

select concat('rows loaded ', count(*)) into @num_rows from @@@TABLE; 

call log('@@@TABLE',@num_rows); 

