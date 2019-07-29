-- begin create tables 


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Decipher tables
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

CALL log('create_tables.sql', 'refresh');

CALL log('gene2phenotype', 'refresh');

DROP TABLE IF EXISTS gene2phenotype;

CREATE TABLE gene2phenotype (
  Symbol               VARCHAR(25),
  GeneMIM              INT(10) UNSIGNED,
  DiseaseName          TEXT,
  DiseaseMIM           INT(10) UNSIGNED,
  DDDCategory          VARCHAR(64),
  AllelicRequirement   VARCHAR(64),
  MutationConsequence  VARCHAR(64),
  Phenotypes           TEXT,
  OrganSpecificityList TEXT,
  PMIDS                TEXT,
  Panel                VARCHAR(64),
  Prev_symbols         VARCHAR(64),
  Hgnc_id              INT(10) UNSIGNED,
  Pair_entry_date      DATETIME
);

CALL utf8_unicode('gene2phenotype');

CALL log('create_tables.sql', 'done');

