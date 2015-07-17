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

clinvar: FORCE
	-./mirror.sh clinvar/urls
	./unpack.sh clinvar
	-make clinvarxml
	./create_database.sh clinvar
	./load_database.sh clinvar
	./index_database.sh clinvar

clinvarxml: FORCE
	virtualenv ve
	source ve/bin/activate && pip install lxml && python clinvar/clinvar_hgvs.py


dbSNP: FORCE
	-./mirror.sh          dbSNP/urls
	./unpack.sh           dbSNP
	./create_database.sh  dbSNP
	./load_database.sh    dbSNP
	./index_database.sh   dbSNP


CHV: FORCE
	-./mirror.sh         CHV/urls
	./unpack.sh          CHV
	./create_database.sh CHV
	./load_database.sh   CHV
	./index_database.sh  CHV 


disgenet: FORCE
	-./mirror.sh         disgenet/urls
	./unpack.sh          disgenet
	./create_database.sh disgenet
	./load_database.sh   disgenet
	./index_database.sh  disgenet 

GTR: FORCE
	-./mirror.sh         GTR/urls
	./unpack.sh          GTR
	./create_database.sh GTR
	./load_database.sh   GTR
	./index_database.sh  GTR

gene: FORCE
	-./mirror.sh          gene/urls
	./unpack.sh           gene
	./create_database.sh  gene
	./load_database.sh    gene
	./index_database.sh   gene

GeneReviews: FORCE
	# complete.
	-./mirror.sh          GeneReviews/urls
	./unpack.sh           GeneReviews
	./create_database.sh  GeneReviews
	./load_database.sh    GeneReviews
	./index_database.sh   GeneReviews

GO: FORCE
	-./mirror.sh          GO/urls
	./unpack.sh           GO
	./create_database.sh  GO
	./load_database.sh    GO
	./index_database.sh   GO

hpo: FORCE
	-./mirror.sh          hpo/urls
	./unpack.sh           hpo
	./create_database.sh  hpo
	./load_database.sh    hpo
	./index_database.sh   hpo

hugo: FORCE
	-./mirror.sh          hugo/urls
	./unpack.sh           hugo
	./create_database.sh  hugo
	./load_database.sh    hugo
	./index_database.sh   hugo

medgen: FORCE
	-./mirror.sh         medgen/urls
	./unpack.sh          medgen
	./create_database.sh medgen
	./load_database.sh   medgen
	./index_database.sh  medgen
	./medgen/create_views.sh

orphanet: FORCE
	-./mirror.sh         orphanet/urls

PersonalGenomes: FORCE
	-./mirror.sh         PersonalGenomes/urls
	./unpack.sh          PersonalGenomes
	./create_database.sh PersonalGenomes
	./load_database.sh   PersonalGenomes
	./index_database.sh  PersonalGenomes

pubmed: FORCE
	#-./mirror.sh pubmed/urls.medline
	#-./mirror.sh pubmed/urls.fulltext	
	-./mirror.sh         pubmed/urls.pmc	
	./unpack.sh          pubmed
	./create_database.sh pubmed
	./load_database.sh   pubmed
	./index_database.sh  pubmed

PubTator: FORCE
	-./mirror.sh         PubTator/urls
	./unpack.sh          PubTator
	./create_database.sh PubTator
	./load_database.sh   PubTator
	./index_database.sh  PubTator

all: FORCE
	-make clinvar
	-make disgenet
	-make GTR
	-make GeneReviews
	-make GO
	-make hugo
	-make medgen
	-make orphanet
	-make PersonalGenomes
	-make pubmed
	-make PubTator
	-make dbSNP

.PHONY:  FORCE help user all clinvar GTR gene GeneReviews GO hugo medgen orphanet PersonalGenomes pubmed PubTator SETH 
