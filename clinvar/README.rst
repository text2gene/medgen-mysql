=================================
clinvar (NCBI clinical variants) 
=================================

Contents
---------------
* `README <ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/README.txt>`_
* `HGVS linkout <http://www.ncbi.nlm.nih.gov/clinvar/docs/hgvs_types/>`_
* `Variation Sequence Ontology <https://www.ncbi.nlm.nih.gov/variation/docs/glossary>`_

|
ncbi standard terms
==============================
* `disease_names`_ (+GTR, +clinvar)
* `condition_source_id`_ (+GTR +gene +clinvar)
* `population_group`_ (+clinvar)

|
clinvar tables 
==============================
* `gene_specific_summary`_
* `variant_summary`_

------------
|
*disease_names*
======================================
:: 

  This document is updated daily, and is provided to report the names and
  identifiers used in GTR and ClinVar. Please note there may be more than one
  line per condition, when a name is used by more than one source. This
  differs from the gene_condition_source_id file because it is comprehensive,
  and does not require knowledge of any gene-to-disease relationship.

`DiseaseName`_ | 
`SourceName`_  | 
`ConceptID`_   |
`SourceID`_    |
`DiseaseMIM`_  |
`LastUpdated`_ 


DiseaseName
-----------------
   Full name of the condition 

SourceName
-----------------
   UMLS vocabulary, NCBI curation, Office of Rare Disease, etc 

ConceptID
-----------------
   If C#####, then UMLS; if CN* then "NCBI-based processing" 


SourceID
-----------------
   ID of SourceName 

DiseaseMIM
-----------------
   OMIM condition 

LastUpdated
-----------------
   Last modified by NCBI staff 



------------

*condition_source_id*
=================================================
::

   (ClinVar, +GTR)
   The scope of disorders reported is a subset of the 
   disease_names because a gene-to-disease relationship is required.


`GeneID`_ | 
`GeneSymbol`_ |
`ConceptID`_ | 
`DiseaseName`_ |
`SourceName`_ |
`SourceID`_ |
`DiseaseMIM`_ |
`LastUpdated`_ |



GeneID
-----------------
   integer, GeneID in NCBI's Gene database

GeneSymbol
-----------------
   Preferred symbol corresponding to GeneID. 
   character, comma-separated list of GeneIDs overlapping the variation


*gene_specific_summary*
============================
Symbol | GeneID  | Submissions  | Alleles

------------


*variant_summary*
============================

AlleleID 
-------------
integer value as stored in the AlleleID field in ClinVar

variant_type
--------------------
character, the type of variation

variant_name
--------------------
character, the preferred name for the variation


ClinicalSignificance
--------------------
character, comma-separated list of values of clinical significance reported for this variation

RS# (dbSNP) 
--------------------
integer, rs# in dbSNP

dbvar_nsv
--------------------                       
character, the NSV identifier for the region in dbVar


RCVaccession
--------------------
character, list of RCV accessions that report this variant

TestedInGTR            
--------------------
character, Y/N for Yes/No if there is a test registerd as specific to this variation in the NIH Genetic Testing Registry (GTR)

PhenotypeIDs
--------------------
character, list of db names and identifers for phenotype(s) reported for this variant

Origin
--------------------
character, list of all allelic origins for this variation

Assembly
--------------------
character, name of the assembly on which locations are baed

Chromosome
--------------------
character, chromosomal location

Start
--------------------
integer, starting location, in pter->qter orientation

Stop
--------------------
integer, end location, in pter->qter orientation

Cytogenetic
--------------------
character, ISCN band

ReviewStatus
--------------------
character, highest review status for reporting this measure

HGVS_c
--------------------
character, RefSeq cDNA-based HGVS expression

HGVS_p
--------------------
character, RefSeq protein-based HGVS expression

NumberSubmitters
--------------------
integer, number of submissions with this variant

LastEvaluated
--------------------
datetime, the latest time any submitter reported clinical significance

Guidelines
--------------------
character, ACMG only right now, for the reporting of incidental variation in a Gene (NOTE: if ACMG, not a specific to the allele but to the Gene)

OtherIDs
--------------------
character, list of other identifiers or sources of information about this Gene



------------

population_group
----------------------------------
#.  MedGen:C0085756 African American
#.  MedGen:C1515945 American Indian or Alaska Native
#.  MedGen:C0337704 Ashkenazi Jew
#.  MedGen:C0043157 Causasians
#.  MedGen:C0152035 Chinese 
#.  MedGen:C0682087 European Caucasoid
#.  MedGen:C0019576 Hispanic Americans
#.  MedGen:C1513907 Native Hawaiian or Other Pacific Islander
#.  MedGen:C0238697 South East Asian
#.  MedGen:C0682086 mixed ethnic group
#.  none
#.  unspecified
