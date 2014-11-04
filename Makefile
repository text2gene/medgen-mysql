#
# Makefile to streamline installation of databases
#
SHELL:=/bin/bash

PKG_NAME:=medgen-mysql

_:=$(shell mkdir -p logs)

help:
	@echo "  Type make setup to install ${PKG_NAME} into the virtualenv"

clinvar: FORCE
	./mirror.sh clinvar/urls
	./unpack.sh clinvar
	./create_database.sh clinvar
	./load_database.sh clinvar
	./index_database.sh clinvar

GTR:
	./mirror.sh GTR/urls
	./unpack.sh GTR
	./create_database.sh GTR
	./load_database.sh GTR
	./index_database.sh GTR

gene:
	./mirror.sh gene/urls
	./unpack.sh gene
	./create_database.sh gene
	./load_database.sh gene
	./index_database.sh gene

hugo:
	./mirror.sh hugo/urls
	./unpack.sh hugo
	./create_database.sh hugo
	./load_database.sh hugo
	./index_database.sh hugo

LSDB:
	./mirror.sh LSDB/urls
	./mirror.sh LSDB/urls.lovd
	./unpack.sh LSDB
	./create_database.sh LSDB
	./load_database.sh LSDB
	./index_database.sh LSDB

medgen:
	./mirror.sh medgen/urls
	./unpack.sh medgen
	./create_database.sh medgen
	./load_database.sh medgen
	./index_database.sh medgen

pubmed:
	./mirror.sh pubmed/urls.pmc
	./mirror.sh pubmed/urls.openaccess
	./mirror.sh pubmed/urls.medline
	./unpack.sh pubmed
	./create_database.sh pubmed
	./load_database.sh pubmed
	./index_database.sh pubmed

PubTator:
	./mirror.sh PubTator/urls
	./mirror.sh PubTator/urls.tmvar
	./unpack.sh PubTator
	./create_database.sh PubTator
	./load_database.sh PubTator
	./index_database.sh PubTator

SETH:
	./mirror.sh SETH/urls.emu
	./mirror.sh SETH/urls.mutationfinder
	./unpack.sh SETH
	./create_database.sh SETH
	./load_database.sh SETH
	./index_database.sh SETH

#clean:  FORCE
#	rm -rf ${VE_DIR}
#	rm -f logs/*

.PHONY:  FORCE help GTR GTR gene hugo LSDB medgen PubTator SETH 
