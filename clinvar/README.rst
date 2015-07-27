what is clinvar? 
==================================
ClinVar is the **NCBI Clinical Variants** database.


ClinVar is a freely accessible, public archive of reports of the relationships among human variations and phenotypes, with supporting evidence.

ClinVar thus facilitates access to and communication about the relationships asserted between human variation and observed health status, and the history of that interpretation. ClinVar collects reports of variants found in patient samples, assertions made regarding their clinical significance, information about the submitter, and other supporting data. The alleles described in submissions are mapped to reference sequences, and reported according to the HGVS standard. ClinVar then presents the data for interactive users as well as those wishing to use ClinVar in daily workflows and other local applications. ClinVar works in collaboration with interested organizations to meet the needs of the medical genetics community as efficiently and effectively as possible. 


.. contents:: clinvar

links
======
* `README <ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/README.txt>`_
* `HGVS linkout <http://www.ncbi.nlm.nih.gov/clinvar/docs/hgvs_types/>`_
* `Variation Sequence Ontology <https://www.ncbi.nlm.nih.gov/variation/docs/glossary>`_


info schema
===========
::

   mysql> call info; 

   +--------------+--------+----------------------------+------------+---------+---------+----------+-----------------+
   | table_schema | ENGINE | TABLE_NAME                 | TABLE_ROWS | million | data_MB | index_MB | TABLE_COLLATION |
   +--------------+--------+----------------------------+------------+---------+---------+----------+-----------------+
   | clinvar      | InnoDB | clingen_gene_curation_list |        631 | 0.00    | 0.11M   | 0.02M    | utf8_unicode_ci |
   | clinvar      | InnoDB | clinvar_hgvs               |     414618 | 0.41    | 29.56M  | 38.14M   | utf8_unicode_ci |
   | clinvar      | InnoDB | cross_references           |     172566 | 0.17    | 10.52M  | 0.00M    | utf8_unicode_ci |
   | clinvar      | InnoDB | disease_names              |      27775 | 0.03    | 3.52M   | 4.98M    | utf8_unicode_ci |
   | clinvar      | InnoDB | gene_condition_source_id   |       6169 | 0.01    | 1.52M   | 1.19M    | utf8_unicode_ci |
   | clinvar      | InnoDB | gene_specific_summary      |      26984 | 0.03    | 1.52M   | 0.94M    | utf8_unicode_ci |
   | clinvar      | InnoDB | log                        |        133 | 0.00    | 0.02M   | 0.00M    | utf8_unicode_ci |
   | clinvar      | InnoDB | molecular_consequences     |     127532 | 0.13    | 9.52M   | 11.55M   | utf8_general_ci |
   | clinvar      | InnoDB | README                     |         11 | 0.00    | 0.02M   | 0.00M    | utf8_general_ci |
   | clinvar      | InnoDB | variant_summary            |     308972 | 0.31    | 99.64M  | 74.31M   | utf8_unicode_ci |
   | clinvar      | InnoDB | var_citations              |     117166 | 0.12    | 6.52M   | 15.09M   | utf8_unicode_ci |
   +--------------+--------+----------------------------+------------+---------+---------+----------+-----------------+
  

   
#####################################################################################################


   
ncbi standard terms
==============================
* `disease_names`_ (+GTR, +clinvar)
* `condition_source_id`_ (+GTR +gene +clinvar)


disease_names
=============================
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
-----------
   Full name of the condition 

SourceName
-----------
   UMLS vocabulary, NCBI curation, Office of Rare Disease, etc 

ConceptID
---------
   If C#####, then UMLS; if CN* then "NCBI-based processing" 


SourceID
--------
   ID of SourceName 

DiseaseMIM
----------
   OMIM condition 

LastUpdated
-----------
   Last modified by NCBI staff 


condition_source_id
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
------
   integer, GeneID in NCBI's Gene database   

GeneSymbol
----------
   Preferred symbol corresponding to GeneID. 
   character, comma-separated list of GeneIDs overlapping the variation


gene_specific_summary
======================
Symbol | GeneID  | Submissions  | Alleles


variant_summary
===============

AlleleID
--------
integer value as stored in the AlleleID field in ClinVar


variant_type
------------
character, the type of variation


variant_name
------------
character, the preferred name for the variation


ClinicalSignificance
--------------------
character, comma-separated list of values of clinical significance reported for this variation


RS# (dbSNP) 
------------
integer, rs# in dbSNP

dbvar_nsv
---------
character, the NSV identifier for the region in dbVar


RCVaccession
------------
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
