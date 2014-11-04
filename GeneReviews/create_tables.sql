call log('create_tables.sql', 'begin'); 

drop table if exists genesymbol;
create table genesymbol(
  NBK_id          varchar(20) not null,
  GR_shortname    varchar(20) not null,
  genesymbol      varchar(20) not null
); 

call utf8_unicode('genesymbol');
-- 

--
drop table if exists title;
create table title(
  GR_shortname   varchar(20) not null,
  GR_Title       varchar(1000) not null,
  NBK_id         varchar(20)
);
call utf8_unicode('title');
-- 

--
drop table if exists omim;
create table omim(
  NBK_id          varchar(20) not null,
  GR_shortname    varchar(20) not null,
  OMIM            varchar(1000) not null
); 
call utf8_unicode('omim');
--

call log('create_tables.sql', 'done'); 
