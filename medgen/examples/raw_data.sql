-- ssh biomed.vpc.locusdev.net 
-- biomed$ mysql -D medgen -u umls -pumls -h localhost

-- ################################################################
-- MedGen  
-- 
-- ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/README.html
-- ################################################################

-- mysql> call mem; 
-- +--------------+--------+-----------------+------------+---------+-------------+----------+----------+
-- | table_schema | ENGINE | TABLE_NAME      | TABLE_ROWS | million | DATA_LENGTH | data_MB  | index_MB |
-- +--------------+--------+-----------------+------------+---------+-------------+----------+----------+
-- | medgen       | InnoDB | log             |         30 | 0.00    |       16384 | 0.02M    | 0.00M    |
-- | medgen       | InnoDB | medgen_hpo      |      10575 | 0.01    |     1589248 | 1.52M    | 0.00M    |
-- | medgen       | InnoDB | medgen_hpo_omim |     118771 | 0.12    |    22593536 | 21.55M   | 0.00M    |
-- | medgen       | InnoDB | medgen_pubmed   |   75714547 | 75.71   |  5550112768 | 5293.00M | 9388.00M |
-- | medgen       | InnoDB | MERGED          |       1586 | 0.00    |      131072 | 0.13M    | 0.16M    |
-- | medgen       | InnoDB | MGCONSO         |     665181 | 0.67    |    82427904 | 78.61M   | 27.09M   |
-- | medgen       | InnoDB | MGDEF           |      36675 | 0.04    |    15220736 | 14.52M   | 3.03M    |
-- | medgen       | InnoDB | MGREL           |    1285722 | 1.29    |   326107136 | 311.00M  | 321.27M  |
-- | medgen       | InnoDB | MGSAT           |    1705077 | 1.71    |   172703744 | 164.70M  | 181.42M  |
-- | medgen       | InnoDB | MGSTY           |     382573 | 0.38    |    55164928 | 52.61M   | 36.13M   |
-- | medgen       | InnoDB | NAMES           |     257410 | 0.26    |    21544960 | 20.55M   | 11.03M   |
-- | medgen       | InnoDB | README          |         20 | 0.00    |       16384 | 0.02M    | 0.00M    |
-- +--------------+--------+-----------------+------------+---------+-------------+----------+----------+

-- https://invitae.jira.com/browse/CS-1042
-- Auto-populate clinical subtypes from medgen content

-- optional: locus-lib-metamap AKA "What should we call it" tells us the ID for "charcot marie tooth" is C0007959
-- C0007959 score 1000 (100% match) 

-- ################################################################
-- Hypertrophic Cardiomyopathy
-- ################################################################
-- http://www.ncbi.nlm.nih.gov/medgen/2881

select * from autopop_medgen_uid where UID = 2881; 
select 'C0007194' into @CUI; 

-- Concept ID: C0007194
-- MedGen UID: 2881
-- Disease or Syndrome
-- Synonyms: CARDIOMYOPATHY, HYPERTROPHIC
-- SNOMED CT:	
--   Hypertrophic cardiomyopathy (233873004); 
--   HCM - Hypertrophic cardiomyopathy (233873004); 
--   Obstructive cardiomyopathy (45227007); 
--   HOCM - Hypertrophic obstructive cardiomyopathy (45227007); 
--   Hypertrophic obstructive cardiomyopathy (45227007)

-- ===================================================================
-- Hypertrophic Cardiomyopathy 
-- REST: /Define/C0007194
-- ====================================================================
 
select distinct
  semantics.STY as SemanticType, 
  def.SAB       as SourceVocab, 
  def.CUI       as ConceptID,  
  def.DEF       as Definition
from 
 MGCONSO as concept, 
 MGSTY   as semantics, 
 MGDEF   as def
where 
 concept.CUI  = @CUI           and 
 concept.CUI  = semantics.CUI  and 
 concept.CUI = def.CUI           ; 

-- SourceVocab | MSH         
-- COnceptID   | C0007194 
-- Definition  | A form of CARDIAC MUSCLE disease, characterized by left and/or right ventricular hypertrophy (HYPERTROPHY, LEFT VENTRICULAR; HYPERTROPHY, RIGHT VENTRICULAR), frequent asymmetrical involvement of the HEART SEPTUM, and normal or reduced left ventricular volume. Risk factors include HYPERTENSION; AORTIC STENOSIS; and gene MUTATION; (FAMILIAL HYPERTROPHIC CARDIOMYOPATHY). 

-- ===================================================================
-- Hypertrophic Cardiomyopathy 
-- REST: /Concept/C0007194/Preferred
-- ====================================================================
-- Prefer MSH Medical Subjects 

select distinct
  semantics.STY as SemanticType, 
  concept.SAB  as VocabSource, 
  concept.CODE as VocabCode, 
  concept.CUI  as ConceptID,
  concept.STR  as ConceptText , 
  concept.* 
from 
 MGCONSO as concept, 
 MGSTY   as semantics, 
 MGDEF   as def
where 
 concept.CUI      = @CUI          and 
 concept.STT      = 'PF'          and 
 concept.ISPREF   = 'Y'           and 
 concept.SUPPRESS = 'N'           and  
 concept.CUI      = semantics.CUI and 
 concept.CUI      = def.CUI         ;    

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Summary
-- ====================================================================

select 
 REL  , 
 RELA , 
 count(*) as cnt 
from  MGREL as Relate 
where CUI1 = 'C0007194' 
group by REL, RELA order by cnt desc; 

-- UMLS Relationships

--   AQ    Allowed qualifier
--   CHD   has child relationship in a Metathesaurus source vocabulary
--   DEL   Deleted concept
--   PAR   has parent relationship in a Metathesaurus source vocabulary
--   QB    can be qualified by.
--   RB    has a broader relationship
--   RL    the relationship is similar or "alike". 
--         the two concepts are similar or "alike". 

--         In the current edition of the Metathesaurus, 
--         most relationships with this attribute are mappings provided by a source, named in SAB and SL; 
--         hence concepts linked by this relationship may be synonymous, 
--         i.e. self-referential: CUI1 = CUI2. 
--         In previous releases, some MeSH Supplementary Concept relationships were represented in this way.

--   RN    has a narrower relationship
--   RO    has relationship other than synonymous, narrower, or broader
--   RQ    related and possibly synonymous.
--   RU    Related, unspecified
--   SIB   has sibling relationship in a Metathesaurus source vocabulary.
--   SY    source asserted synonymy.
--   XR    Not related, no mapping
--   Empty relationship

-- +-----+-------------------+-----+
-- | REL | RELA              | cnt |
-- +-----+-------------------+-----+
-- | RO  | has_manifestation |  93 | 
-- | SIB |                   |  14 | Sibling
-- | RN  | mapped_to         |  11 | Narrow
-- | SY  | has_permuted_term |   8 | Synonym
-- | SY  | permuted_term_of  |   8 | Synonym 
-- | AQ  |                   |   4 |
-- | RN  |                   |   2 |
-- | PAR |                   |   2 |
-- | PAR | inverse_isa       |   1 | Parent 
-- | CHD | isa               |   1 | Child 
-- | CHD |                   |   1 |
-- | RO  |                   |   1 | Other 
-- | SY  | entry_version_of  |   1 | Synonym
-- | SY  | has_entry_version |   1 | Synonym
-- +-----+-------------------+-----+

select 'C0007194' into @CUI; 

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Parent/
-- ====================================================================

select  from MGREL where CUI1 = @CUI and RELA = 'isa';  

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Child/
-- ====================================================================

select * from MGREL where CUI1 = @CUI and REL = 'CHD';  

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Synonym/
-- ====================================================================

select * from MGREL where CUI1 = @CUI and REL = 'SY';  

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Sibling/*
-- ====================================================================

select * from MGREL where CUI1 = @CUI and REL = 'SIB';  

-- ====================================================================
-- Hypertrophic Cardiomyopathy
-- REST: /Relate/C0007194/Manifestation/*
-- ====================================================================
-- TODO: Finish (MESH) 

select distinct 
  semantics.STY as SemanticType, 
  concept.CUI   as ConceptID, 
  concept.STR   as ConceptText 
from 
  MGCONSO as concept, 
  MGREL   as relate, 
  MGSTY   as semantics
where 
  relate.RELA      = 'has_manifestation'   and 
  relate.CUI1      = 'C0007194'            and 
  relate.CUI2      = concept.CUI           and 
  relate.CUI2      = semantics.CUI         and   
  semantics.STY    = 'Disease or Syndrome' and 
  concept.SAB      = 'MSH'                 and 
  concept.STT      = 'PF'                  and 
  concept.ISPREF   = 'Y'                   and 
  concept.SUPPRESS = 'N'                    ; 
