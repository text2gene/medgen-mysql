 UMLS Relationships
====================
::

   AQ    Allowed qualifier
   CHD   has child relationship in a Metathesaurus source vocabulary
   DEL   Deleted concept
   PAR   has parent relationship in a Metathesaurus source vocabulary
   QB    can be qualified by.
   RB    has a broader relationship
   RL    the relationship is similar or "alike". 
         the two concepts are similar or "alike". 

         In the current edition of the Metathesaurus, 
         most relationships with this attribute are mappings provided by a source, named in SAB and SL; 
         hence concepts linked by this relationship may be synonymous, 
         i.e. self-referential: CUI1 = CUI2. 
         In previous releases, some MeSH Supplementary Concept relationships were represented in this way.

   RN    has a narrower relationship
   RO    has relationship other than synonymous, narrower, or broader
   RQ    related and possibly synonymous.
   RU    Related, unspecified
   SIB   has sibling relationship in a Metathesaurus source vocabulary.
   SY    source asserted synonymy.
   XR    Not related, no mapping
   Empty relationship


   +-----+-------------------+-----+
   | REL | RELA              | cnt |
   +-----+-------------------+-----+
   | RO  | has_manifestation |  93 | 
   | SIB |                   |  14 | Sibling
   | RN  | mapped_to         |  11 | Narrow
   | SY  | has_permuted_term |   8 | Synonym
   | SY  | permuted_term_of  |   8 | Synonym 
   | AQ  |                   |   4 |
   | RN  |                   |   2 |
   | PAR |                   |   2 |
   | PAR | inverse_isa       |   1 | Parent 
   | CHD | isa               |   1 | Child 
   | CHD |                   |   1 |
   | RO  |                   |   1 | Other 
   | SY  | entry_version_of  |   1 | Synonym
   | SY  | has_entry_version |   1 | Synonym
   -- +-----+-------------------+-----+


Hypertrophic Cardiomyopathy

==============================
select 'C0007194' into @CUI; 

isa
::

   select  from MGREL where CUI1 = @CUI and RELA = 'isa';  

Child
::

   select  from MGREL where CUI1 = @CUI and RELA = 'CHD';  

Synonym
::

   select  from MGREL where CUI1 = @CUI and RELA = 'SY';  

Sibling
::

   select  from MGREL where CUI1 = @CUI and RELA = 'SIB';  
