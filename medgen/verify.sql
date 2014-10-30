-- Vocabs 
-- ###########

select SAB as vocab, count(distinct CUI) as cnt_concepts, count(distinct AUI) as cnt_attributes from MGCONSO group by SAB order by cnt_concepts desc; 

-- +----------+--------------+----------------+
-- | vocab    | cnt_concepts | cnt_attributes |
-- +----------+--------------+----------------+
-- | MSH      |       100202 |         241303 | << medical subjects 
-- | SNOMEDCT |        96379 |         154025 | << clinical terms 
-- | NCI      |        47812 |         135163 | << cancer dictionary (includes comorbidities/non-cancer terms) 
-- | OMIM     |        41350 |          60323 | << OMIM 
-- | HPO      |        10335 |          16859 | << Human Phenotype Ontology 
-- | GTR      |         9758 |          31447 | << Genetic Testing Reference 
-- +----------+--------------+----------------+

-- Vocabs.NAMES
-- ############
select source, count(distinct CUI) as count_concepts_names from NAMES group by source order by count_concepts_names desc;  
-- +---------------+----------------------+
-- | source        | count_concepts_names |
-- +---------------+----------------------+ 
-- | SNOMEDCT      |                88290 | << Clinical Terms
-- | MSH           |                82022 | << Medical Subjects 
-- | OMIM          |                27924 |
-- | NCI           |                23058 | 
-- | GTR           |                10935 | << Genetic Testing Reference 
-- | HPO           |                10220 | << Human Phenotype Ontology 
-- | MTH           |                 8492 |
-- | RXNORM        |                 2158 | << Medications 
-- | MDR           |                 1696 |
-- | PDQ           |                 1022 |
-- | MEDCIN        |                  626 |
-- | MTHSPL        |                  124 |
-- | NDDF          |                  106 |
-- | RCD           |                   64 |
-- | MMSL          |                   61 |
-- | CHV           |                   58 | << Consumer Health Vocabulary 
-- | ICD10         |                   51 |
-- | SNMI          |                   36 |
-- | VANDF         |                   35 |
-- | ICD10AM       |                   24 |
-- | DSM4          |                   15 |
-- | NDFRT         |                   11 |
-- | ICD10AMAE     |                   10 |
-- | LNC           |                    8 | << Lab Tests 
-- | SNM           |                    8 |
-- | GO            |                    7 | << Gene Ontology 
-- 
-- ... 



-- Concepts
-- ###########

select count(distinct CUI) into @cnt_concepts from MGCONSO; 
select * from @cnt_concepts; 

-- +---------------+
-- | @cnt_concepts |
-- +---------------+
-- |       255,447 | +250k concepts 
-- +---------------+

-- Concepts.Attributes 
-- ###################
select count(distinct AUI) into @cnt_attributes from MGCONSO; 
select @cnt_attributes; 

-- select @cnt_attributes;  
-- +-----------------+
-- | @cnt_attributes |
-- +-----------------+
-- |         639,120 | +600k attributes (???) 
-- +-----------------+

-- Concepts{:merged}
-- ###################
select count(distinct CUI) into @num_unique_concepts_merged from MERGED;
select @num_unique_concepts_merged; 

-- +-----------------------------+
-- | @num_unique_concepts_merged |
-- +-----------------------------+
-- |                        2026 | +2000 concepts merged. 
-- +-----------------------------+




-- Definitions
-- ###########
-- 
-- Note that : 
--    Genetic Home Reference exists in MGDEFS but not MGCONSO
-- 
select SAB as vocab, count(distinct CUI) as cnt_concepts, count(distinct DEF) as cnt_definitions 
from MGDEF group by SAB order by cnt_definitions desc; 

-- Genetic Home Reference defines concepts and other vocabs (such as GTR) provide the concept unique ID (CUI) 
select * from MGDEF where CUI = 'C0001529';

-- CUI: C0001529 
-- SAB: Genetics Home Reference
-- DEF: Adiposis dolorosa is a condition characterized by painful folds of fatty (adipose) tissue or the growth of multiple noncancerous (benign) fatty tumors called lipomas. This condition occurs most often in women who are overweight or obese, and signs and symptoms typically appear between ages 35 and 50. In people with adiposis dolorosa, abnormal fatty tissue or lipomas can occur anywhere on the body but are most often found on the torso, buttocks, and upper parts of the arms and legs. Lipomas usually feel like firm bumps (nodules) under the skin. The growths cause burning or aching that can be severe. In some people, the pain comes and goes, while in others it is continuous. Movement or pressure on adipose tissue or lipomas can make the pain worse. Other signs and symptoms that have been reported to occur with adiposis dolorosa include general weakness and tiredness (fatigue), depression, irritability, confusion, recurrent seizures (epilepsy), and a progressive decline in intellectual function (dementia). These problems do not occur in everyone with adiposis dolorosa, and it is unclear whether they are directly related to the condition. 


select SAB as vocab, count(distinct CUI) as cnt_concepts, count(distinct DEF) as cnt_definitions 
from MGDEF group by SAB order by cnt_definitions desc; 

-- +----------------------------------------------------+--------------+-----------------+
-- | vocab                                              | cnt_concepts | cnt_definitions |
-- +----------------------------------------------------+--------------+-----------------+
-- | NCI                                                |        22627 |           18246 | << NCI terms 
-- | MSH                                                |         5757 |            5747 | << pubmed subjects 
-- | HPO                                                |         5059 |            5018 | << Human Phenotype Ontology 
-- | OMIM                                               |         1905 |            1801 | << OMIM 
-- | GeneReviews                                        |         1470 |             578 | << Gene Reviews 
-- | CSP                                                |          474 |             474 | 
-- | PDQ                                                |          423 |             423 | << Physician Data Query
-- | Genetics Home Reference                            |          438 |             263 | << GHR 
-- | CHV                                                |          266 |             247 | << Consumer Health Vocab 
-- | JABL                                               |          209 |             207 | 
-- | NOC                                                |          208 |             207 |
-- | SNOMEDCT                                           |          130 |             128 | << Clinical Terms 
-- | MEDLINEPLUS                                        |          123 |             123 | << PubMed consumer health info and education 
-- | NAN                                                |          123 |             122 | 
-- | GO                                                 |          104 |             104 | << Gene Ontology 
-- +----------------------------------------------------+--------------+-----------------+



-- Relations
-- ##############

select STYPE1, count(distinct CUI1) as cnt_concepts from MGREL group by STYPE1 order by cnt_concepts desc;
-- 
-- STYPE1= the name of the column in MRCONSO.RRF that contains the first identifier to which the relationship is attached 
-- 
-- +--------+--------------+
-- | STYPE1 | cnt_concepts |
-- +--------+--------------+
-- | SCUI   |        86189 | << Source Concept Unique Id 
-- | AUI    |        76023 | << Attribute Unique Id
-- | SDUI   |        32322 | << Source Document Unique Id
-- | CUI    |         7769 | << Concept Unique Id
-- +--------+--------------+


select SAB as vocab, REL, count(*) as cnt_vocab_relations from MGREL group by SAB, REL order by cnt_vocab_relations asc;  
-- +-------+-----+---------------------+
-- | vocab | REL | cnt_vocab_relations |
-- +-------+-----+---------------------+
-- | GTR   | RO  |                  80 |
-- | OMIM  | CHD |                 817 |
-- | OMIM  | PAR |                 817 |
-- | GTR   | PAR |                1759 |
-- | GTR   | CHD |                1759 |
-- | MSH   | RO  |                6402 |
-- | NCI   | SY  |                8286 |
-- | MSH   | CHD |                8584 |
-- | MSH   | PAR |                8584 |
-- | OMIM  | SY  |               11722 |
-- | HPO   | PAR |               13575 |
-- | HPO   | CHD |               13575 |
-- | OMIM  | RQ  |               17934 | "Related, Questionable syn?" 
-- | MSH   | AQ  |               21285 | "Allowed Qualifier" 
-- | MSH   | QB  |               21285 | "Qualified By" 
-- | NCI   | CHD |               46770 | "CHilD" 
-- | NCI   | PAR |               46770 | "PARent" 
-- | MSH   | SY  |               89810 | "SY:  source asserted synonymy" 
-- | MSH   | SIB |               90510 | "SIB: Sibling" 
-- | MSH   | RB  |              122787 | "RB:  Broader" 
-- | MSH   | RN  |              122787 | "RN:  Narrower" 
-- | OMIM  | RO  |              165614 |
-- | HPO   | RO  |              224936 |
-- | NCI   | RO  |              345034 | "RO:  Other" 
-- +-------+-----+---------------------+



select SAB as vocab, STYPE, count(*) as cnt_vocab_source_type from MGSAT group by SAB, STYPE order by SAB asc;

-- +-------+-------+-----------------------+
-- | vocab | STYPE | cnt_vocab_source_type |
-- +-------+-------+-----------------------+
-- | GTR   | AUI   |                275873 |
-- | HPO   | AUI   |                  3373 |
-- | MSH   | AUI   |                450201 |
-- | MSH   | SCUI  |                 97731 |
-- | MSH   | SDUI  |                547397 |
-- | NCI   | AUI   |                242882 |
-- | OMIM  | SDUI  |                 44071 |
-- +-------+-------+-----------------------+

select STY, count(distinct CUI) as count_concepts from MGSTY group by STY order by count_concepts desc; 

-- +-------------------------------------------+----------------+
-- | STY                                       | count_concepts |
-- +-------------------------------------------+----------------+
-- | Pharmacologic Substance                   |          99119 |
-- | Finding                                   |          81924 |
-- | Organic Chemical                          |          69584 |
-- | Disease or Syndrome                       |          42771 |
-- | Neoplastic Process                        |          15750 |
-- | Amino Acid, Peptide, or Protein           |           9450 |
-- | Congenital Abnormality                    |           5936 |
-- | Pathologic Function                       |           4966 |
-- | Steroid                                   |           3813 |
-- | Immunologic Factor                        |           2906 |
-- | Sign or Symptom                           |           2754 |
-- | Nucleic Acid, Nucleoside, or Nucleotide   |           2579 |
-- | Carbohydrate                              |           2414 |
-- | Mental or Behavioral Dysfunction          |           2338 |
-- | Biologically Active Substance             |           1908 |
-- | Cell or Molecular Dysfunction             |           1689 |
-- | Lipid                                     |           1643 |
-- | Anatomical Abnormality                    |           1478 |
-- | Hormone                                   |           1307 |
-- | Inorganic Chemical                        |           1124 |
-- | Indicator, Reagent, or Diagnostic Aid     |           1085 |
-- | Organophosphorus Compound                 |           1060 |
-- | Molecular Function                        |            797 |
-- | Hazardous or Poisonous Substance          |            578 |
-- | Eicosanoid                                |            494 |
-- | Acquired Abnormality                      |            464 |
-- | Enzyme                                    |            436 |
-- | Vitamin                                   |            398 |
-- | Biomedical or Dental Material             |            314 |
-- | Clinical Drug                             |            182 |
-- | Antibiotic                                |            124 |
-- | Element, Ion, or Isotope                  |            119 |
-- | Neuroreactive Substance or Biogenic Amine |            111 |
-- | Injury or Poisoning                       |             79 |
-- | Cell                                      |             62 |
-- | Clinical Attribute                        |             37 |
-- | Functional Concept                        |             35 |
-- | Experimental Model of Disease             |             26 |
-- | Laboratory or Test Result                 |             24 |
-- | Gene or Genome                            |             23 |
-- .... 

select count(distinct CUI) as count_concepts, count(distinct PMID) from medgen_pubmed; 

select REL, count(*) from medgen.MGREL group by REL; 


