call log('create_tables.sql', 'begin');
-- ###################################

DROP   TABLE IF EXISTS hgvs2dbSNP;
CREATE TABLE           hgvs2dbSNP(
  hgvs     varchar(63) default null,
  snp      int(11)     default null
)
ENGINE=MyISAM;

call utf8_unicode('hgvs2dbSNP');

-- ###################################
call log('create_tables.sql', 'done');
