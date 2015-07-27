insert into README values
('memory',   'procedure',  'mem',      'call mem', 'get schema +memory usage'),
('process',  'procedure',  'ps',       'call ps',  'show current sql process'),
('process',  'procedure',  'freq',     'call freq(tablename,colname)',  'show frequency of a term'); 

drop procedure if exists mem;
delimiter //
create procedure mem()
begin
  select
  table_schema,
  ENGINE,
  TABLE_NAME,
  TABLE_ROWS,
  concat( round( TABLE_ROWS / ( 1000 *1000 ) , 2 ) , '' )  million,
  concat( round( data_length / ( 1024 *1024 ) , 2 ) , 'M' )  data_MB,
  concat( round( index_length / ( 1024 *1024 ) , 2 ) , 'M' ) index_MB, 
  TABLE_COLLATION
  from
  information_schema.TABLES
  where
  TABLE_SCHEMA = DATABASE()
  order by
  table_schema, engine, table_name;
end//
delimiter ;

-- alias for "call mem" 
drop procedure if exists info;
delimiter //
create procedure info()
begin
  call mem; 
end//
delimiter ;

drop procedure if exists ps;
delimiter //
create procedure ps()
begin
  select * from information_schema.processlist
  where
  information_schema.processlist.DB=DATABASE() and 
  information_schema.processlist.INFO not like '%information_schema.processlist%';
end//
delimiter ;

drop procedure if exists freq;  

delimiter //
create procedure freq( tablename varchar(100), colname varchar(100))
begin
	select concat('select ',  colname, ',' ,'count(*) as cnt', ' from ', tablename, ' group by ' , colname, ' order by cnt desc') into @sql_cnt; 
	select @sql_cnt; 	

	prepare stmt from @sql_cnt;   execute stmt;
end//
delimiter ;

drop procedure if exists freqdist;  
delimiter //
create procedure freqdist( tablename varchar(100), colname varchar(100), coldistinct varchar(100))
begin
	select concat('select ',  colname, ',' ,'count(distinct ', coldistinct,' ) as cnt', ' from ', tablename, ' group by ' , colname, ' order by cnt desc') into @sql_cnt; 
	select @sql_cnt; 	

	prepare stmt from @sql_cnt;   execute stmt;
end//
delimiter ;


drop procedure if exists create_index;
delimiter //
create procedure create_index( tablename varchar(100), indexcols varchar(100) )
begin
	call log( concat(tablename,':', indexcols), 'index begin');

	select concat('alter table ', tablename, ' add  index (', indexcols, ')') into @idx; 
	prepare stmt from @idx; execute stmt;

	select concat('show index from ', tablename) into @show; 
	prepare stmt from @show; execute stmt;
	
	call log( concat(tablename,':', indexcols), 'index done');
end//
delimiter ;

drop procedure if exists utf8_unicode;
delimiter //
create procedure utf8_unicode( tablename varchar(100))
begin
	select concat('alter table ', tablename, ' convert to CHARSET utf8 collate utf8_unicode_ci') into @idx; 
	prepare stmt from @idx; execute stmt;
	
	call log(tablename, 'utf8_unicode_ci');
end//
delimiter ;

drop procedure if exists less20; 
delimiter // 
create procedure less20(tablename varchar(100)) 
begin 
      select concat('select * from ', tablename, ' limit 20') into @stmt; 
      prepare stmt from @stmt; 
      execute stmt; 
end//
delimiter ; 

