-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
-- Example: change @Symbol to a HGNC official symbol 
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
select 'FOXP3'  into  @Symbol; 
select  9606    into  @human; 
select  GeneID  into  @GeneID from gene.gene_info where Symbol = 'FOXP3'; 
-- 
select concat('HGNC @Symbol=',@Symbol, '  ', 'NCBI @GeneID=', @GeneID, ' @tax_id=human=', @human) as note; 

-- ##################################################
-- gene:pubmed (GENE mentioned in pubmed abstract) 
-- ##################################################
desc gene.gene2pubmed; 

select * from gene.gene2pubmed where tax_id = @human and GeneID = @GeneID; 

-- +--------+--------+----------+
-- | tax_id | GeneID | PMID     |
-- +--------+--------+----------+
-- |   9606 |  50943 |  8889548 |
-- |   9606 |  50943 | 10677306 |
-- |   9606 |  50943 | 11076863 |
-- |   9606 |  50943 | 11120765 |
-- 
-- +++ more

-- ################################################
-- hgnc:pubmed ( hgnc gene Symbol curation ) 
-- ################################################

desc hugo.hugo2pubmed; 

select * from hugo.hugo2pubmed where Symbol = @Symbol;
-- +-----------+--------+-----------------+----------+--------+--------------------+
-- | hgnc      | Symbol | Name            | Status   | GeneID | pubmeds            |
-- +-----------+--------+-----------------+----------+--------+--------------------+
-- | HGNC:6106 | FOXP3  | forkhead box P3 | Approved |  50943 | 10677306, 11138001 | << pubmeds are cited to curate the GENE:GO relationship 
-- +-----------+--------+-----------------+----------+--------+--------------------+

select GeneType, count(*) as cnt from gene.gene_info 
where tax_id = @human group by GeneType order by cnt asc; 

-- +----------------+-------+
-- | GeneType       | cnt   |
-- +----------------+-------+
-- | rRNA           |    23 |
-- | snRNA          |   114 |
-- | snoRNA         |   391 |
-- | tRNA           |   579 |
-- | other          |   877 |
-- | unknown        |  2832 |
-- | ncRNA          |  8940 |
-- | pseudo         | 13460 |
-- | protein-coding | 20724 | << protein coding 
-- +----------------+-------+

-- hugo.hugo_info
-- ##########################
-- hugo.hugo_info.Synonyms*
-- ##########################
desc hugo.hugo_info; 

select hgnc, PreviousSymbols, PreviousNames, Synonyms, NameSynonyms, DateNameChanged from hugo.hugo_info where Symbol = @Symbol; 
-- +-----------+-----------------+-------------------------------------------------------------------+----------------------------------------+
-- | hgnc      | PreviousSymbols | PreviousNames                                                     | Synonyms                               |
-- +-----------+-----------------+-------------------------------------------------------------------+----------------------------------------+
-- | HGNC:6106 | IPEX            | "immune dysregulation, polyendocrinopathy, enteropathy, X-linked" | JM2, XPID, AIID, PIDX, DIETER, SCURFIN |
-- +-----------+-----------------+-------------------------------------------------------------------+----------------------------------------+

-- hugo.hugo_info
-- ###########################
-- hugo.hugo_info.LocusGroup
-- ###########################

select Symbol, LocusGroup, LocusType, Chromosome  from hugo.hugo_info where Symbol = @Symbol; 
-- +--------+---------------------+---------------------------+------------+
-- | Symbol | LocusGroup          | LocusType                 | Chromosome |
-- +--------+---------------------+---------------------------+------------+
-- | FOXP3  | protein-coding gene | gene with protein product | Xp11.23    |
-- +--------+---------------------+---------------------------+------------+

select LocusGroup, LocusType, count(*) as cnt from hugo.hugo_info group by LocusGroup, LocusType order by LocusGroup, cnt asc; 
-- +---------------------+----------------------------+-------+
-- | LocusGroup          | LocusType                  | cnt   |
-- +---------------------+----------------------------+-------+
-- | non-coding RNA      | RNA, misc                  |     3 |
-- | non-coding RNA      | RNA, small cytoplasmic     |     3 |
-- | non-coding RNA      | RNA, Y                     |     4 |
-- | non-coding RNA      | RNA, vault                 |     4 |
-- | non-coding RNA      | RNA, ribosomal             |    34 |
-- | non-coding RNA      | RNA, small nuclear         |    67 |
-- | non-coding RNA      | RNA, cluster               |   125 |
-- | non-coding RNA      | RNA, small nucleolar       |   458 |
-- | non-coding RNA      | RNA, transfer              |   637 |
-- | non-coding RNA      | RNA, micro                 |  1879 |
-- | non-coding RNA      | RNA, long non-coding       |  2661 |
-- | other               | transposable element       |     4 |
-- | other               | virus integration site     |     8 |
-- | other               | complex locus constituent  |    27 |
-- | other               | protocadherin              |    39 |
-- | other               | region                     |    45 |
-- | other               | endogenous retrovirus      |    97 |
-- | other               | readthrough                |   113 |
-- | other               | fragile site               |   117 |
-- | other               | T cell receptor gene       |   208 |
-- | other               | immunoglobulin gene        |   228 |
-- | other               | unknown                    |   315 |
-- | phenotype           | phenotype only             |   598 |
-- | protein-coding gene | gene with protein product  | 19026 |
-- | pseudogene          | T cell receptor pseudogene |    35 |
-- | pseudogene          | immunoglobulin pseudogene  |   202 |
-- | pseudogene          | RNA, pseudogene            |  3714 |
-- | pseudogene          | pseudogene                 |  8723 |
-- | withdrawn           | withdrawn                  |  3993 |
-- +---------------------+----------------------------+-------+

-- hugo.hugo_info
-- #####################################
-- hugo.hugo_info.LocusSpecificDatabases
-- #####################################

desc hugo.hugo_info; 
select LocusSpecificDatabases from hugo.hugo_info where Symbol = @Symbol;   

-- +-------------------------------------------------------------------------------------------------------------------------------------------------+
-- | LocusSpecificDatabases                                                                                                                          |
-- +-------------------------------------------------------------------------------------------------------------------------------------------------+
-- FOXP3base: Mutation registry for Immunodysregulation, polyendocrinopathy, and enteropathy, X-linked; IPEX |
-- http://rna.uta.fi/FOXP3base/","Mental Retardation database |
-- http://grenada.lumc.nl/LOVD2/MR/home.php?select_db=FOXP3","LRG_62 |
-- http://www.lrg-sequence.org/LRG/LRG_62" |
-- +-------------------------------------------------------------------------------------------------------------------------------------------------+

select SpecialistDB from hugo.hugo_info where Symbol = @Symbol;   
-- <a href="http://www.sanger.ac.uk/perl/genetics/CGP/cosmic?action=gene&amp;ln=FOXP3">COSMIC</a>
-- <a href="http://www.orpha.net/consor/cgi-bin/OC_Exp.php?Lng=GB&Expert=121913">Orphanet</a>

-- ###################
-- gene (GENE GROUP) 
-- ###################

select relationship, count(*) as cnt from gene.gene_group group by relationship order by cnt asc; 
-- +-------------------------------+---------+
-- | relationship                  | cnt     |
-- +-------------------------------+---------+
-- | Readthrough parent            |     307 |
-- | Readthrough child             |     307 |
-- | Readthrough sibling           |     310 |
-- | Region parent                 |    1024 |
-- | Region member                 |    1024 |
-- | Potential readthrough sibling |    1310 |
-- | Related pseudogene            |   18222 |
-- | Related functional gene       |   18222 |
-- | Ortholog                      | 1191510 |
-- +-------------------------------+---------+

-- ###################
-- gene (GO ) 
-- ###################

desc gene.gene2go; 

select * from gene.gene2go where tax_id = @human and GeneID = @GeneID and PUBMEDS != '-'; 

-- +--------+--------+------------+----------+-----------+------------------------------------------------------------------------------------+----------+-----------+
-- | tax_id | GeneID | GO_id      | Evidence | Qualifier | GO_term                                                                            | PUBMEDS  | Category  |
-- +--------+--------+------------+----------+-----------+------------------------------------------------------------------------------------+----------+-----------+
-- |   9606 |  50943 | GO:0002725 | IDA      | -         | negative regulation of T cell cytokine production                                  | 15466453 | Process   |
-- |   9606 |  50943 | GO:0003700 | IDA      | -         | sequence-specific DNA binding transcription factor activity                        | 11483607 | Function  |
-- |   9606 |  50943 | GO:0003700 | NAS      | -         | sequence-specific DNA binding transcription factor activity                        | 11138001 | Function  |
-- |   9606 |  50943 | GO:0005515 | IPI      | -         | protein binding                                                                    | 16652169 | Function  |
-- |   9606 |  50943 | GO:0005634 | IDA      | -         | nucleus                                                                            | 11483607 | Component |
-- 
-- ++ More 

select 'evidence for known biological process, component, or function' as note; 
select * from GO.evidence_codes; 
-- +---------------------------------------+--------------+-------------------------------------------------+
-- | EvidenceSource                        | EvidenceCode | EvidenceText                                    |
-- +---------------------------------------+--------------+-------------------------------------------------+
-- | Experimental Evidence Codes           | EXP          | Inferred from Experiment                        |
-- | Experimental Evidence Codes           | IDA          | Inferred from Direct Assay                      |
-- | Experimental Evidence Codes           | IPI          | Inferred from Physical Interaction              |
-- | Experimental Evidence Codes           | IMP          | Inferred from Mutant Phenotype                  |
-- | Experimental Evidence Codes           | IGI          | Inferred from Genetic Interaction               |
-- | Experimental Evidence Codes           | IEP          | Inferred from Expression Pattern                |
-- | Computational Analysis Evidence Codes | ISS          | Inferred from Sequence or Structural Similarity |
-- | Computational Analysis Evidence Codes | ISO          | Inferred from Sequence Orthology                |
-- | Computational Analysis Evidence Codes | ISA          | Inferred from Sequence Alignment                |
-- | Computational Analysis Evidence Codes | ISM          | Inferred from Sequence Model                    |
-- | Computational Analysis Evidence Codes | IGC          | Inferred from Genomic Context                   |
-- | Computational Analysis Evidence Codes | IBA          | Inferred from Biological aspect of Ancestor     |
-- | Computational Analysis Evidence Codes | IBD          | Inferred from Biological aspect of Descendant   |
-- | Computational Analysis Evidence Codes | IKR          | Inferred from Key Residues                      |
-- | Computational Analysis Evidence Codes | IRD          | Inferred from Rapid Divergence                  |
-- | Computational Analysis Evidence Codes | RCA          | inferred from Reviewed Computational Analysis   |
-- | Author Statement Evidence Codes       | TAS          | Traceable Author Statement                      |
-- | Author Statement Evidence Codes       | NAS          | Non-traceable Author Statement                  |
-- | Curator Statement Evidence Codes      | IC           | Inferred by Curator                             |
-- | Curator Statement Evidence Codes      | ND           | No biological Data available                    |
-- | Automatically-assigned Evidence Codes | IEA          | Inferred from Electronic Annotation             |
-- +---------------------------------------+--------------+-------------------------------------------------+

select Qualifier, count(*) as cnt from gene.gene2go group by Qualifier order by cnt asc;

-- +----------------------+---------+
-- | Qualifier            | cnt     |
-- +----------------------+---------+
-- | NOT contributes_to   |       6 |
-- | NOT colocalizes_with |      20 |
-- | colocalizes_with     |    3560 |
-- | contributes_to       |    3969 |
-- | NOT                  |    6519 |
-- | -                    | 1517299 |
-- +----------------------+---------+ 


select 'GO terms, associations, and sequences (official index IDs)' as note; 
call GO.mem; 
-- +--------------+--------+--------------------+------------+---------+-------------+---------+----------+
-- | table_schema | ENGINE | TABLE_NAME         | TABLE_ROWS | million | DATA_LENGTH | data_MB | index_MB |
-- +--------------+--------+--------------------+------------+---------+-------------+---------+----------+
-- | GO           | MyISAM | association        |    4394197 | 4.39    |   127431713 | 121.53M | 548.06M  |
-- | GO           | MyISAM | evidence           |    4562096 | 4.56    |   168381436 | 160.58M | 449.27M  |
-- | GO           | MyISAM | gene_product       |     838403 | 0.84    |    41600728 | 39.67M  | 122.43M  |
-- | GO           | MyISAM | gene_product_count |    1941444 | 1.94    |    43712996 | 41.69M  | 93.35M   |
-- | GO           | MyISAM | gene_product_seq   |     512039 | 0.51    |     6656507 | 6.35M   | 16.96M   |
-- | GO           | MyISAM | graph_path         |    1047544 | 1.05    |    26188600 | 24.98M  | 162.71M  |
-- | GO           | MyISAM | seq                |     412771 | 0.41    |   253103092 | 241.38M | 57.30M   |
-- | GO           | MyISAM | term               |      40703 | 0.04    |     3341924 | 3.19M   | 10.99M   |
-- | GO           | MyISAM | term2term          |      79803 | 0.08    |     1675863 | 1.60M   | 5.89M    |
-- | GO           | MyISAM | term_definition    |      40673 | 0.04    |     8101156 | 7.73M   | 1.28M    |
-- +--------------+--------+--------------------+------------+---------+-------------+---------+----------+

-- ###################
-- GO (evidence) 
-- ###################

select term_type, count(*) as cnt from term group by term_type order by cnt asc; 
-- +--------------------+-------+
-- | term_type          | cnt   |
-- +--------------------+-------+
-- | universal          |     1 |
-- | relationship       |     1 |
-- | metadata           |     2 |
-- | synonym_type       |     2 |
-- | external           |     4 |
-- | synonym_scope      |     4 |
-- | subset             |    17 |
-- | cellular_component |  3618 |
-- | molecular_function | 10588 |
-- | biological_process | 26466 |
-- +--------------------+-------+


-- clinvar
-- ################################
-- clinvar.gene_condition_source_id
-- ################################

select * from clinvar.gene_condition_source_id where GeneID=@GeneID 
order by DiseaseName,SourceName;  
-- +--------+--------+-----------+--------------------------------------------------------+--------------------------+------------+------------+--------------+
-- | GeneID | Symbol | ConceptID | DiseaseName                                            | SourceName               | SourceID   | DiseaseMIM | LastModified |
-- +--------+--------+-----------+--------------------------------------------------------+--------------------------+------------+------------+--------------+
-- |   4683 | NBN    | C0023449  | Acute lymphoid leukemia                                | SNOMED CT                | 91857003   | 613065     | 11 Jan 2012  |
-- |   4683 | NBN    | C0002874  | Aplastic anemia                                        | Human Phenotype Ontology | HP:0001915 | 609135     | 11 Jun 2011  |
-- |   4683 | NBN    | C0002874  | Aplastic anemia                                        | Office of Rare Diseases  | 5836       | 609135     | 11 Jun 2011  |
-- |   4683 | NBN    | C0002874  | Aplastic anemia                                        | SNOMED CT                | 306058006  | 609135     | 11 Jun 2011  |
-- |   4683 | NBN    | C0398791  | Microcephaly, normal intelligence and immunodeficiency | SNOMED CT                | 234638009  | 251260     | 16 May 2011  |
-- +--------+--------+-----------+--------------------------------------------------------+--------------------------+------------+------------+--------------+

select * from clinvar.gene_specific_summary where GeneID=@GeneID ; 
-- +--------+--------+-------------+---------+
-- | Symbol | GeneID | Submissions | Alleles |
-- +--------+--------+-------------+---------+
-- | NBN    |   4683 |          19 |      17 |
-- +--------+--------+-------------+---------+


select * from disease_names where ConceptID in ('C0023449','C0002874','C0398791'); 
-- +--------------------------------------------------------+--------------------------+-----------+------------+------------+--------------+
-- | DiseaseName                                            | SourceName               | ConceptID | SourceID   | DiseaseMIM | LastModified |
-- +--------------------------------------------------------+--------------------------+-----------+------------+------------+--------------+
-- | Acute lymphoid leukemia                                | SNOMED CT                | C0023449  | 91857003   | 613065     | 11 Jan 2012  |
-- | Aplastic anemia                                        | SNOMED CT                | C0002874  | 306058006  | 609135     | 11 Jun 2011  |
-- | Aplastic anemia                                        | Office of Rare Diseases  | C0002874  | 5836       | 609135     | 11 Jun 2011  |
-- | Aplastic anemia                                        | Human Phenotype Ontology | C0002874  | HP:0001915 | 609135     | 11 Jun 2011  |
-- | Microcephaly, normal intelligence and immunodeficiency | SNOMED CT                | C0398791  | 234638009  | 251260     | 16 May 2011  |
-- +--------------------------------------------------------+--------------------------+-----------+------------+------------+--------------+

-- @@@TODO sanity

-- GTR 
-- 
-- population_group
-- 
-- 1. MedGen:C0085756 African American
-- 2. MedGen:C1515945 American Indian or Alaska Native
-- 3. MedGen:C0337704 Ashkenazi Jew
-- 4. MedGen:C0043157 Causasians
-- 5. MedGen:C0152035 Chinese
-- 6. MedGen:C0682087 European Caucasoid
-- 7. MedGen:C0019576 Hispanic Americans
-- 8. MedGen:C1513907 Native Hawaiian or Other Pacific Islander 9. MedGen:C0238697 South East Asian
-- 10. MedGen:C0682086 mixed ethnic group 11. none
-- 12. unspecified

-- Evidence codes FOR the disease:gene relationship 




select * from GTR.test_condition_gene where gene_or_SNOMED_CT_ID =@GeneID; 
-- +-------------------+-------------+-----------+--------------+----------------+------------+-----------+----------------------+
-- | accession_version | GeneTestsID | test_type | concept_type | GTR_identifier | MIM_number | umls_name | gene_or_SNOMED_CT_ID |
-- +-------------------+-------------+-----------+--------------+----------------+------------+-----------+----------------------+
-- | GTR000326160.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000500361.8    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000500362.6    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000500363.8    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000501012.2    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000501115.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000503512.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000503513.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000505384.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000505587.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000505644.6    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000505665.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000506138.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000506373.6    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000507764.2    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000507913.2    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000507930.2    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000508339.2    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000509427.3    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000509442.5    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000509520.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- | GTR000509692.1    | N/A         | Clinical  | gene         | C1334862       | 602667     | nibrin    | 4683                 |
-- +-------------------+-------------+-----------+--------------+----------------+------------+-----------+----------------------+
