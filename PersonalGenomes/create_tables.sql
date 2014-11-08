call log('bionotate', 'refresh');

drop table if exists bionotate; 
create table bionotate
(
      edit_timestamp       text,
      edit_oid             text,
      variant_id           text,
      variant_gene         text,
      variant_aa_del       text,
      variant_aa_pos       text,
      variant_aa_ins       text,
      variant_rsid         text,
      article_pmid         text,
      bionotate_xml        text
)
Engine=InnoDB;
