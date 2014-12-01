call log('view_disease_subtype.sql', 'begin');
-- ################################################################

drop table   if exists view_disease_subtype; 
CREATE TABLE           view_disease_subtype
(
  DiseaseID      char(8)      not null, 
  DiseaseName    varchar(500) not null, 
  DiseaseSource  varchar(20)  not null, 
  Relation       varchar(100) not null, 
  SubtypeID      char(8)      not null, 
  SubtypeName    varchar(500) not null, 
  SubtypeSource  varchar(20)  not null
); 

call utf8_unicode('view_disease_subtype'); 

insert into view_disease_subtype
select distinct 
  CUI1      as DiseaseID, 
  N1.name   as DiseaseName,  
  N1.source as DiseaseSource, 
  R.RELA    as Relation, 
  CUI2      as SubTypeID, 
  N2.name   as SubtypeName, 
  N2.source as SubtypeSource
from 
  MGREL   R,  -- Relate
  MGCONSO C1, -- Parent concept 
  MGCONSO C2, -- Child  concept 
  MGSTY   S1, -- Disease 
  MGSTY   S2, -- Subtype 
  NAMES   N1, -- parent preferred term 
  NAMES   N2  -- child  preferred term 
where 
  R.REL  = 'CHD'   and 
  R.CUI1 = C1.CUI  and 
  R.CUI2 = C2.CUI  and 
  C1.CUI = N1.CUI  and 
  C2.CUI = N2.CUI  and 
  C1.CUI = S1.CUI  and 
  C2.CUI = S2.CUI  and 
  S1.STY = 'Disease or Syndrome' and 
  S2.STY = 'Disease or Syndrome'   ; 

-- ################################################################
call log('view_disease_subtype.sql', 'done');
