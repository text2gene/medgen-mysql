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
	# complete.
	-./mirror.sh clinvar/urls
	./unpack.sh clinvar
	./create_database.sh clinvar
	./load_database.sh clinvar
	./index_database.sh clinvar

GTR: FORCE
	# complete.
	-./mirror.sh GTR/urls
	./unpack.sh GTR
	./create_database.sh GTR
	./load_database.sh GTR
	./index_database.sh GTR

gene: FORCE
	# testing
	-./mirror.sh gene/urls
	./unpack.sh gene
	./create_database.sh gene
	./load_database.sh gene
	./index_database.sh gene

GeneReviews: FORCE
	# complete.
	-./mirror.sh GeneReviews/urls
	./unpack.sh GeneReviews
	./create_database.sh GeneReviews
	./load_database.sh GeneReviews
	./index_database.sh GeneReviews
	
hpo: FORCE
	# complete
	-./mirror.sh hpo/urls
	./unpack.sh hpo
	./create_database.sh hpo
	./load_database.sh hpo
	# ./index_database.sh hpo (already indexed) 

hugo: FORCE
	# testing
	-./mirror.sh hugo/urls
	./unpack.sh hugo
	./create_database.sh hugo
	./load_database.sh hugo
	./index_database.sh hugo

LSDB: FORCE
	# complete. (no DB -- copyright issues)
	-./mirror.sh LSDB/urls
	-./mirror.sh LSDB/urls.lovd

medgen: FORCE
	# complete.
	-./mirror.sh medgen/urls
	./unpack.sh medgen
	./create_database.sh medgen
	./load_database.sh medgen
	./index_database.sh medgen

orphanet: FORCE
	# download-only.
	-./mirror.sh orphanet/urls

PersonalGenomes: FORCE
	-./mirror.sh PersonalGenomes/urls
	./unpack.sh PersonalGenomes
	./create_database.sh PersonalGenomes
	./load_database.sh PersonalGenomes
	./index_database.sh PersonalGenomes

pubmed: FORCE
	# testing
	-./mirror.sh pubmed/urls.pmc
	-./mirror.sh pubmed/urls.openaccess
	-./mirror.sh pubmed/urls.medline
	./unpack.sh pubmed
	./create_database.sh pubmed
	./load_database.sh pubmed
	./index_database.sh pubmed

PubTator: FORCE
	# testing
	-./mirror.sh PubTator/urls
	-./mirror.sh PubTator/urls.tmvar
	./unpack.sh PubTator
	./create_database.sh PubTator
	./load_database.sh PubTator
	./index_database.sh PubTator

SETH: FORCE
	# blocked
	-./mirror.sh SETH/urls.emu
	-./mirror.sh SETH/urls.mutationfinder
	# TODO for sasha (turn these on when ready)
	#./unpack.sh SETH
	#./create_database.sh SETH
	#./load_database.sh SETH
	#./index_database.sh SETH

#umls: FORCE
	#TODO 
#	-./mirror.sh umls/urls
#	./unpack.sh umls
#	./create_database.sh umls
#	./load_database.sh umls
#	./index_database.sh umls
	
.PHONY:  FORCE help GTR GTR gene hugo LSDB medgen PubTator SETH 

