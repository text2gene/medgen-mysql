--
-- ncbi-data-mirrors/medgen/geneticus.sql ---
--
-- Commentary:
-- * This sql builds the "view_" tables used by "locus-rest-medgen"
--   https://bitbucket.org/locusdevelopment/locus-rest-medgen

-- ssh biomed.vpc.locusdev.net 
-- biomed$ mysql -D medgen -uumls -pumls -h localhost
--   OR
-- mysql -D medgen -u medgenserver -pmedgen -h biomed.vpc.locusdev.net
-- \. geneticus.sql
--   OR
-- running "make _mysql_rebuild_views" in the "locus-rest-medgen" project.

-- ################################################################
-- MedGen  
-- 
-- ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/README.html
-- ################################################################

use medgen; 

call log('view_medgen_uid', 'refresh');

drop table if exists view_medgen_uid;  

create table view_medgen_uid 
select distinct 
  UID as MedGenUID, CUI as ConceptID from medgen_pubmed; 

alter table view_medgen_uid ENGINE=InnoDB DEFAULT CHARSET=utf8; 
alter table view_medgen_uid 
      add column id int not null auto_increment first, 
      add primary key (id) 
;
alter table view_medgen_uid add index (MedGenUID); 
alter table view_medgen_uid add index (ConceptID); 

call log('view_medgen_uid', 'view created.');

-- select 'C0007194' into @CUI; 
-- ################################################################
call log('view_concept_name', 'refresh');

drop table if exists view_concept_name; 

create table view_concept_name
select distinct
  semantics.STY   as SemanticType, 
  names.source    as SourceVocab, 
  names.CUI       as ConceptID,  
  names.name      as Name
from 
 MGCONSO as concept, 
 MGSTY   as semantics, 
 NAMES   as names
where 
 concept.STT      = 'PF'          and 
 concept.ISPREF   = 'Y'           and 
 concept.SUPPRESS = 'N'           and  
 concept.CUI  = semantics.CUI     and 
 concept.CUI  = names.CUI           ; 

alter table view_concept_name ENGINE=InnoDB DEFAULT CHARSET=utf8; 
alter table view_concept_name 
      add column id int not null auto_increment first, 
      add primary key (id) 
;
alter table view_concept_name add index (SemanticType); 
alter table view_concept_name add index (ConceptID); 
alter table view_concept_name add index (SourceVocab); 

call log('view_concept_name', 'created view');

-- ################################################################

select 'SemanticType statistics' as note; 
select SemanticType, count(*) 
from view_concept_name 
group by SemanticType; 

select 'SourceVocab statistics' as note; 
select SourceVocab, count(*) 
from view_concept_name 
group by SourceVocab; 

-- ################################################################

call log('view_disease_name', 'refresh');

drop table if exists view_disease_name; 

create table view_disease_name like view_concept_name; 
alter  table view_disease_name change ConceptID Disease char(8); 

insert into view_disease_name (SemanticType,SourceVocab,Disease,Name)
select SemanticType,SourceVocab,ConceptID, Name from view_concept_name 
where SemanticType = 'Disease or Syndrome'; 

call log('view_name_disease', 'created view.');

-- ################################################################

call log('view_disease_subtype', 'refresh');

drop table if exists view_disease_subtype; 

create table view_disease_subtype
(
  id        int     not null auto_increment,
  Disease   char(8) not null, 
  Subtype   char(8) not null,
  primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8; 

insert into view_disease_subtype
  (Disease, Subtype)
select distinct 
  CUI1 as Disease, 
  CUI2 as SubType
from 
  MGREL   relate, 
  MGCONSO concept, 
  MGSTY   semantic
where 
  relate.REL   = 'CHD'         and 
  relate.CUI2  = concept.CUI   and 
  concept.CUI  = semantic.CUI  and 
  semantic.STY = 'Disease or Syndrome'; 

call log('view_disease_subtype', 'created view.');

select * from view_disease_name    where Disease in ('C0007194','C0949658') ; 
select * from view_disease_subtype where Disease in ('C0007194','C0949658') ; 

-- select * from view_disease_name where ConceptID in ('C0007194','C0949658') ; 
-- +---------------------+-------------+-----------+----------------------------------------------+
-- | SemanticType        | SourceVocab | Disease   | Name                                         |
-- +---------------------+-------------+-----------+----------------------------------------------+
-- | Disease or Syndrome | MTH         | C0007194  | Hypertrophic Cardiomyopathy                  | Disease  
-- | Disease or Syndrome | GTR         | C0949658  | Primary familial hypertrophic cardiomyopathy | Subtype 
-- +---------------------+-------------+-----------+----------------------------------------------+

drop table if exists view_disease_subtype_name ; 

create table view_disease_subtype_name
select distinct
 D.SemanticType as SemanticType, 
 D.SourceVocab  as DiseaseVocab, 
 D.Disease      as Disease, 
 D.Name         as DiseaseName, 
 D.SourceVocab  as SubtypeVocab, 
 D.Disease      as Subtype, 
 D.Name         as SubtypeName 
from 
 view_disease_subtype as Tree, 
 view_disease_name    as D, 
 view_disease_name    as S 
where 
 -- Tree.Disease = @CUI       and 
 Tree.Disease = D.Disease  and 
 Tree.Subtype = S.Disease 
order by 
 DiseaseName, SubtypeName; 

alter table view_disease_subtype_name
      add column id int not null auto_increment first, 
      add primary key (id) 
;

-- ===================================================================
-- Hypertrophic Cardiomyopathy 
-- ====================================================================

-- select 'C0007194' into @CUI; 
-- select 'C0949658' into @CUI; 

select 
 REL  , 
 RELA , 
 count(*) as cnt 
from  MGREL as Relate 
where CUI1 = @CUI
group by REL, RELA order by cnt desc; 

select 'C0007194' into @CUI; 
-- +-----+-------------------+-----+
-- | REL | RELA              | cnt |
-- +-----+-------------------+-----+
-- | RO  | has_manifestation |  93 |
-- | SIB |                   |  14 |
-- | RN  | mapped_to         |  11 |
-- | SY  | permuted_term_of  |   8 |
-- | SY  | has_permuted_term |   8 |
-- | AQ  |                   |   4 |
-- | RN  |                   |   2 |
-- | PAR |                   |   2 |
-- | PAR | inverse_isa       |   1 |
-- | CHD | isa               |   1 |
-- | CHD |                   |   1 |
-- | RO  |                   |   1 |
-- | SY  | entry_version_of  |   1 |
-- | SY  | has_entry_version |   1 |
-- +-----+-------------------+-----+



select 'C0949658' into @CUI; 
-- +-----+-------------------+-----+
-- | REL | RELA              | cnt |
-- +-----+-------------------+-----+
-- | SIB |                   |  48 |
-- | RN  | mapped_to         |  27 |
-- | CHD |                   |  21 |
-- | SY  | has_permuted_term |  12 |
-- | SY  | permuted_term_of  |  12 |
-- | RO  | manifestation_of  |   5 |
-- | AQ  |                   |   4 |
-- | RQ  | alias_of          |   3 |
-- | PAR |                   |   3 |
-- | RO  |                   |   2 |
-- | PAR | inverse_isa       |   2 |
-- | RO  | related_to        |   1 |
-- | SY  | expanded_form_of  |   1 |
-- | RQ  | has_alias         |   1 |
-- | SY  | has_expanded_form |   1 |
-- +-----+-------------------+-----+

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Sibling
-- ====================================================================

select 'C0007194' into @CUI; 
select 'C0949658' into @CUI; 
 
select distinct D.*
from  MGREL as Relate, view_disease_name as D
where Relate.CUI1 = @CUI and Relate.REL = 'CHD' and Relate.CUI2 = D.Disease ; 
-- +---------------------+-------------+----------+----------------------------------------------+
-- | SemanticType        | SourceVocab | Disease  | Name                                         |
-- +---------------------+-------------+----------+----------------------------------------------+
-- | Disease or Syndrome | GTR         | C0949658 | Primary familial hypertrophic cardiomyopathy |
-- +---------------------+-------------+----------+----------------------------------------------+

select distinct D.*
from  view_disease_subtype as Relate, view_disease_name as D
where Relate.Disease = @CUI and Relate.Subtype = D.Disease ; 
-- +---------------------+-------------+----------+----------------------------------------------+
-- | SemanticType        | SourceVocab | Disease  | Name                                         |
-- +---------------------+-------------+----------+----------------------------------------------+
-- | Disease or Syndrome | GTR         | C0949658 | Primary familial hypertrophic cardiomyopathy |
-- +---------------------+-------------+----------+----------------------------------------------+

-- +---------------------+-------------+----------+-------------------------------------------------------+
-- | SemanticType        | SourceVocab | Disease  | Name                                                  |
-- +---------------------+-------------+----------+-------------------------------------------------------+
-- | Disease or Syndrome | GTR         | C1834460 | Familial hypertrophic cardiomyopathy 10               |
-- | Disease or Syndrome | GTR         | CN029460 | Familial hypertrophic cardiomyopathy 12               |
-- | Disease or Syndrome | GTR         | C1861864 | Familial hypertrophic cardiomyopathy 2                |
-- | Disease or Syndrome | GTR         | C1861863 | Familial hypertrophic cardiomyopathy 3                |
-- | Disease or Syndrome | GTR         | C1837471 | Familial hypertrophic cardiomyopathy 8                |
-- | Disease or Syndrome | GTR         | C2677506 | Familial hypertrophic cardiomyopathy 11               |
-- | Disease or Syndrome | GTR         | CN030093 | Familial hypertrophic cardiomyopathy 1                |
-- | Disease or Syndrome | GTR         | C1861862 | Familial hypertrophic cardiomyopathy 4                |
-- | Disease or Syndrome | GTR         | C1833236 | Familial hypertrophic cardiomyopathy 6                |
-- | Disease or Syndrome | GTR         | C2750472 | Familial hypertrophic cardiomyopathy 13               |
-- | Disease or Syndrome | GTR         | C2750467 | Familial hypertrophic cardiomyopathy 14               |
-- | Disease or Syndrome | GTR         | C2750459 | Familial hypertrophic cardiomyopathy 15               |
-- | Disease or Syndrome | GTR         | CN068809 | Cardiomyopathy, hypertrophic, midventricular, digenic |
-- | Disease or Syndrome | GTR         | CN069699 | Familial hypertrophic cardiomyopathy 7                |
-- | Disease or Syndrome | GTR         | C1861065 | Familial hypertrophic cardiomyopathy 9                |
-- | Disease or Syndrome | GTR         | C3151265 | Familial hypertrophic cardiomyopathy 18               |
-- | Disease or Syndrome | GTR         | C3151267 | Familial hypertrophic cardiomyopathy 20               |
-- | Disease or Syndrome | GTR         | C3151204 | Familial hypertrophic cardiomyopathy 16               |
-- | Disease or Syndrome | GTR         | CN128717 | Familial hypertrophic cardiomyopathy 21               |
-- | Disease or Syndrome | GTR         | C3151266 | Familial hypertrophic cardiomyopathy 19               |
-- | Disease or Syndrome | GTR         | C3151264 | Familial hypertrophic cardiomyopathy 17               |
-- +---------------------+-------------+----------+-------------------------------------------------------+

-- select * from medgen.MGCONSO where CUI = 'C1834460'; 
-- select distinct SDUI as SourceDoct from medgen.MGCONSO where SAB = 'GTR' and CUI = 'C1834460'; 
-- select * from test_condition_gene where GTR_identifier = 'C1834460'; 

-- Is this for testing?
--
-- drop table if exists tmp_disease_gene; 
-- 
-- create table tmp_disease_gene 
-- select distinct gene_or_SNOMED_CT_ID as GeneID
-- from test_condition_gene where concept_type = 'gene' and 
-- accession_version in (select distinct accession_version from test_condition_gene where GTR_identifier = 'C1834460' );  
-- 
-- select Gene.gene_info.* 
-- from 
--  GTR.tmp_disease_gene, 
--  gene.gene_info 
-- where 
--  GTR.tmp_disease_gene  = gene.GeneID
