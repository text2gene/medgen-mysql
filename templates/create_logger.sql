-- MySQL application logging procedures 
-- use DATASET; 

create table if not exists README
(
   entity_topic  varchar(50)   default '',
   entity_type   varchar(50)   default '',
   entity_name   varchar(50)   default '',
   example       varchar(50)   default '',
   description   varchar(100)  default ''
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

insert into README values
('logging', 'table',     'log',   'select * from log', 'application log'),
('logging', 'procedure', 'log',   'call log (tablename, message)', 'write to application log'),
('logging', 'procedure', 'head',  'call head',  'print head of log'),
('logging', 'procedure', 'tail',  'call tail',  'print tail of log'),
('logging', 'procedure', 'etime', 'call etime', 'print elapsed time between log events');

insert into README values
('dataset', 'procedure', 'DATASET',   'call DATASET(my_dataset)', 'stamp log messages with my_dataset'); 

insert into README values
('user_prefs', 'variable',  '@LOG_LINES',  'select 10 into @LOG_LINES', 'how many log rows do you want to see with (head|tail)'),
('user_prefs', 'variable',  '@LOG_LEVEL',  'select 1 into @LOG_LEVEL',            'turn on printing log to console'); 


drop procedure if exists README;
delimiter //
create procedure README()
begin
  select * from README;
end//
delimiter ;

-- drop procedure if exists README_ENTRY;
-- delimiter //
-- create procedure README()
-- begin
--   select * from README;
-- end//
-- delimiter ;


drop procedure if exists LOG_LINES;
delimiter //
create procedure LOG_LINES(numlines int)
begin
     select numlines into @LOG_LINES; 
end//
delimiter ;

drop procedure if exists user_prefs;
delimiter //
create procedure user_prefs()
begin

   if @DATASET is null then
     select DATASET from log order by idx desc limit 1 into @DATASET;
   end if;
   -- select @DATASET; 

   if @LOG_LINES is null then
     select 50 into @LOG_LINES; 
   end if;
   -- select @LOG_LINES; 

   if @LOG_LEVEL is null then
     select 1 into @LOG_LEVEL; 
   end if;
   -- select @LOG_LEVEL; 

end//
delimiter ;

drop table if exists log;
CREATE TABLE log
(
  event_time   timestamp    default now(),
  entity_name  varchar(100) NOT NULL,
  message      varchar(100) NULL,
  DATASET      varchar(30)  null
);

ALTER TABLE log add idx smallint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY;

drop procedure if exists log;
delimiter //
create procedure log(log_entity_name varchar(100), log_message varchar(100))
begin
   call user_prefs; 
   insert into log
   (DATASET, entity_name,     message) select
   @DATASET, log_entity_name, log_message;

   if @LOG_LEVEL > 0 then
    select concat(DATASET, ',', entity_name, ',',message) as '' from log order by idx desc limit 1;
   end if;
end//
delimiter ;

call log('log', 'table created');
call log('log', 'procedure created');

drop procedure if exists DATASET;
delimiter //
create procedure DATASET(dataset varchar(10))
begin
     select dataset into @DATASET; 
     call LOG('DATASET',@DATASET); 
end//

delimiter ;

-- call log('log_select', 'http://forums.mysql.com/read.php?98,126379,133966#msg-133966');

drop function if exists log_select;

delimiter //
create function log_select(asc_or_desc varchar(4))
returns varchar(1000) 
	return concat('select log.* from (', 'select * from log order by idx ',asc_or_desc, ' LIMIT ', @LOG_LINES, ') as log order by idx asc');// 

delimiter ;


drop procedure if exists tail;

delimiter //
create procedure tail()
begin
	call user_prefs; 
	select log_select('desc') into @tail; 
	prepare stmt from @tail; 
	execute stmt;
end//
delimiter ;

call log('tail', 'procedure created');

drop procedure if exists head;
delimiter //
create procedure head()
begin
	call user_prefs; 
	select log_select('asc') into @tail; 
	prepare stmt from @tail; 
	execute stmt;
end//
delimiter ;

call log('head', 'procedure created');  


drop procedure if exists etime;
delimiter //
create procedure etime()
begin
  select l1.idx, l1.event_time as 'event_time(start)', l1.entity_name, l1.message, 
  	 	 l2.event_time as 'event_time(end)',
  UNIX_TIMESTAMP(l1.event_time)-UNIX_TIMESTAMP(l2.event_time) as etime
  from log l1, log l2
  where l1.idx = l2.idx+1
  order by l1.idx asc;
end//
delimiter ;


call log('etime', 'procedure created');  

call DATASET( DATABASE() ); 
