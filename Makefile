#
# Makefile to streamline installation of databases
#
SHELL:=/bin/bash

PKG_NAME:=medgen-mysql

_:=$(shell mkdir -p logs)

help:
	@echo "  Type make <database> to download, unpack, create mysql store for each individual DB."
	@echo "  (for example: make clinvar)"

user: FORCE
	./create_user.sh

# NCBI ClinVar provides  "Clinical Variants" with phenotypes and gene linkages.
#              ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar
clinvar: FORCE
	-./mirror.sh clinvar/urls
	./unpack.sh clinvar
	-make clinvar-xml
	./create_database.sh clinvar
	./load_database.sh clinvar
	./index_database.sh clinvar

# NCBI clinvar-xml : clinvar IDs to HGVS labels . 
clinvar-xml: FORCE
	virtualenv ve
	source ve/bin/activate && pip install lxml && python clinvar/clinvar_hgvs.py

# NCBI Genetic Testing Registry contains lab information for every genetic test you can order.  
#                               ftp://ftp.ncbi.nlm.nih.gov/pub/GTR/
GTR: FORCE
	-./mirror.sh         GTR/urls
	./unpack.sh          GTR
	./create_database.sh GTR
	./load_database.sh   GTR
	./index_database.sh  GTR

# GTR-xml : GTR Identifiers to PubMed citations and Testing Lab Codes (@@@TODO ) 
GTR-xml: FORCE
	virtualenv ve
	source ve/bin/activate && pip install lxml && python GTR/gtr_xml_gapfill.py

# NCBI PubTator links PubMed PMIDs to Text Mined Variants(tmVar), Genes(GenNorm), and other BioConcepts. 
#               ftp://ftp.ncbi.nlm.nih.gov/pub/lu/PubTator
PubTator: FORCE
	-./mirror.sh         PubTator/urls
	./unpack.sh          PubTator
	./create_database.sh PubTator
	./load_database.sh   PubTator
	./index_database.sh  PubTator

# NCBI dbSNP is deliberately limited to only HGVS mappings to RS# for a full dbSNP dump
#            ftp://ftp.ncbi.nih.gov/snp
dbSNP: FORCE
	-./mirror.sh          dbSNP/urls
	./unpack.sh           dbSNP
	./create_database.sh  dbSNP
	./load_database.sh    dbSNP
	./index_database.sh   dbSNP

# PersonalGenomes loads the MySQL dump
#                  http://evidence.pgp-hms.org
PersonalGenomes: FORCE
	-./mirror.sh         PersonalGenomes/urls
	./unpack.sh          PersonalGenomes
	./create_database.sh PersonalGenomes
	./load_database.sh   PersonalGenomes
	./index_database.sh  PersonalGenomes

#  NCBI Gene is the Entrez Gene Database 
#            ftp://ftp.ncbi.nih.gov/gene/
gene: FORCE
	-./mirror.sh          gene/urls
	./unpack.sh           gene
	./create_database.sh  gene
	./load_database.sh    gene
	./index_database.sh   gene

# NCBI GeneReviews provides BOOK links to Gene Names
#                  ftp://ftp.ncbi.nlm.nih.gov/pub/GeneReviews
GeneReviews: FORCE
	-./mirror.sh          GeneReviews/urls
	./unpack.sh           GeneReviews
	./create_database.sh  GeneReviews
	./load_database.sh    GeneReviews
	./index_database.sh   GeneReviews

# GO Gene Ontology is the grouping of genes 
#                  http://geneontology.org/page/download-ontology
GO: FORCE
	-./mirror.sh          GO/urls
	./unpack.sh           GO
	./create_database.sh  GO
	./load_database.sh    GO
	./index_database.sh   GO

# HUGO Gene Naming Convention provides DB links using standard gene names
#                             http://www.genenames.org/cgi-bin/download
hugo: FORCE
	-./mirror.sh          hugo/urls
	./unpack.sh           hugo
	./create_database.sh  hugo
	./load_database.sh    hugo
	./index_database.sh   hugo

# Disease Gene Network is a near-comprehensive map of Gene:Disease relationships with scoring.
#                      http://disgenet.org/web/DisGeNET/menu/downloads#all
disgenet: FORCE
	-./mirror.sh         disgenet/urls
	./unpack.sh          disgenet
	./create_database.sh disgenet
	./load_database.sh   disgenet
	./index_database.sh  disgenet 

# Human Phenotype Ontology is used to associate phenotypes, even across organisms.
#                          http://human-phenotype-ontology.org
hpo: FORCE
	-./mirror.sh          hpo/urls
	./unpack.sh           hpo
	./create_database.sh  hpo
	./load_database.sh    hpo
	./index_database.sh   hpo

# Orphanet is a rare-disease ontology ( LICENSE required for commercial use)
#                              http://www.orphadata.org/
orphanet: FORCE
	-./mirror.sh         orphanet/urls

# CHV Consumer Health Vocabulary links MedGen to phrases in common language. 
#                                 http://consumerhealthvocab.org
CHV: FORCE
	-./mirror.sh         CHV/urls
	./unpack.sh          CHV
	./create_database.sh CHV
	./load_database.sh   CHV
	./index_database.sh  CHV 

# NCBI medgen links phenotypes and genes to entries in pubmed, clinvar, the genetic testing registry, and 30+ sources. 
medgen: FORCE
	-./mirror.sh         medgen/urls
	./unpack.sh          medgen
	./create_database.sh medgen
	./load_database.sh   medgen
	./index_database.sh  medgen
	./medgen/create_views.sh

# NCBI pubmed we provide links only to PubMedCentral.
#             https://www.nlm.nih.gov/databases/license/weblic/index.html  
pubmed: FORCE
	#-./mirror.sh pubmed/urls.medline
	#-./mirror.sh pubmed/urls.fulltext	
	-./mirror.sh         pubmed/urls.pmc	
	./unpack.sh          pubmed
	./create_database.sh pubmed
	./load_database.sh   pubmed
	./index_database.sh  pubmed

# backup all existing databases
backup: FORCE
	-./backup_database.sh clinvar
	./backup_database.sh GTR
	./backup_database.sh PubTator
	./backup_database.sh dbSNP
	./backup_database.sh PersonalGenomes
	./backup_database.sh gene
	./backup_database.sh GeneReviews
	./backup_database.sh GO
	./backup_database.sh hugo
	./backup_database.sh disgenet
	./backup_database.sh hpo
	./backup_database.sh CHV
	./backup_database.sh medgen

# clean mirror download zip contents and uncompressed files 
clean: FORCE
	-rm -rf clinvar/mirror
	rm  -rf GTR/mirror
	rm  -rf PubTator/mirror
	rm  -rf dbSNP/mirror
	rm  -rf PersonalGenomes/mirror
	rm  -rf gene/mirror
	rm  -rf GeneReviews/mirror
	rm  -rf GO/mirror
	rm  -rf hugo/mirror
	rm  -rf disgenet/mirror
	rm  -rf hpo/mirror
	rm  -rf CHV/mirror
	rm  -rf medgen/mirror
	rm  -rf pubmed/mirror

# cleaner drops the databases and removes mirror files  
cleaner: FORCE	 
	-./make clean 
	./drop_database.sh  clinvar
	./drop_database.sh  PubTator

# all-variants : convenience function  
all-variants: FORCE
	-make PubTator
	make  clinvar
	make  GTR
	make  dbSNP
	make  PersonalGenomes

# all-genes : convenience function  
all-genes: FORCE
	-make gene
	make  GeneReviews
	make  hugo
	make  GO

# all-phenotypes : convenience function  
all-phenotypes: FORCE
	-make hpo
	make  disgenet
	make  CHV
	make  orphanet
	make  medgen

# all : convenience function  
all: FORCE
	-make all-phenotypes
	make  all-genes
	make  all-variants
	make  pubmed	


.PHONY:  FORCE help user all clinvar clinvarxml GTR gene GeneReviews GO hugo medgen orphanet PersonalGenomes pubmed PubTator dbSNP
