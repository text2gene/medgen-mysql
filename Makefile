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
	-make clinvar-xml
	./create_database.sh clinvar
	./load_database.sh clinvar
	./index_database.sh clinvar

clinvar-xml: FORCE
	virtualenv ve
	source ve/bin/activate && pip install lxml && python clinvar/clinvar_hgvs.py

GTR: FORCE
	-./mirror.sh         GTR/urls
	./unpack.sh          GTR
	./create_database.sh GTR
	./load_database.sh   GTR
	./index_database.sh  GTR

# Incomplete (some data in XML not in TSV downloads)
GTR-xml: FORCE
	virtualenv ve
	source ve/bin/activate && pip install lxml && python GTR/gtr_xml_gapfill.py

PubTator: FORCE
	-./mirror.sh         PubTator/urls
	./unpack.sh          PubTator
	./create_database.sh PubTator
	./load_database.sh   PubTator
	./index_database.sh  PubTator

dbSNP: FORCE
	-./mirror.sh          dbSNP/urls
	./unpack.sh           dbSNP
	./create_database.sh  dbSNP
	./load_database.sh    dbSNP
	./index_database.sh   dbSNP

PersonalGenomes: FORCE
	-./mirror.sh         PersonalGenomes/urls
	./unpack.sh          PersonalGenomes
	./create_database.sh PersonalGenomes
	./load_database.sh   PersonalGenomes
	./index_database.sh  PersonalGenomes

gene: FORCE
	-./mirror.sh          gene/urls
	./unpack.sh           gene
	./create_database.sh  gene
	./load_database.sh    gene
	./index_database.sh   gene

GeneReviews: FORCE
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

hugo: FORCE
	-./mirror.sh          hugo/urls
	./unpack.sh           hugo
	./create_database.sh  hugo
	./load_database.sh    hugo
	./index_database.sh   hugo


disgenet: FORCE
	-./mirror.sh         disgenet/urls
	./unpack.sh          disgenet
	./create_database.sh disgenet
	./load_database.sh   disgenet
	./index_database.sh  disgenet 

hpo: FORCE
	-./mirror.sh          hpo/urls
	./unpack.sh           hpo
	./create_database.sh  hpo
	./load_database.sh    hpo
	./index_database.sh   hpo

orphanet: FORCE
	-./mirror.sh         orphanet/urls

CHV: FORCE
	-./mirror.sh         CHV/urls
	./unpack.sh          CHV
	./create_database.sh CHV
	./load_database.sh   CHV
	./index_database.sh  CHV 

medgen: FORCE
	-./mirror.sh         medgen/urls
	./unpack.sh          medgen
	./create_database.sh medgen
	./load_database.sh   medgen
	./index_database.sh  medgen
	./medgen/create_views.sh

pubmed: FORCE
	#-./mirror.sh pubmed/urls.medline
	#-./mirror.sh pubmed/urls.fulltext	
	-./mirror.sh         pubmed/urls.pmc	
	./unpack.sh          pubmed
	./create_database.sh pubmed
	./load_database.sh   pubmed
	./index_database.sh  pubmed

clean: FORCE
	-rm -rf PubTator/mirror
	rm  -rf clinvar/mirror
	rm  -rf GTR/mirror
	rm  -rf dbSNP/mirror
	rm  -rf gene/mirror
	rm  -rf GeneReviews/mirror
	rm  -rf GO/mirror
	rm  -rf hugo/mirror
	rm  -rf pubmed/mirror
	rm  -rf medgen/mirror

cleaner: FORCE
	-./drop_database.sh  PubTator


all-variants: FORCE
	-make PubTator
	make clinvar
	make GTR
	make dbSNP
	make PersonalGenomes

all-genes: FORCE
	-make gene
	make GeneReviews
	make hugo
	make GO

all-phenotypes: FORCE
	-make hpo
	make disgenet
	make CHV
	make orphanet
	make medgen 

all: FORCE
	-make all-phenotypes
	make  all-genes
	make  all-variants
	make  pubmed	

.PHONY:  FORCE help user all clinvar clinvarxml GTR gene GeneReviews GO hugo medgen orphanet PersonalGenomes pubmed PubTator dbSNP
