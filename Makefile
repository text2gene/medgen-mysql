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

gene:
	./mirror.sh gene/urls

hugo:
	./mirror.sh hugo/urls

LSDB:
	./mirror.sh LSDB/urls
	./mirror.sh LSDB/urls.lovd

medgen:
	./mirror.sh medgen/urls
	./mirror.sh medgen/trials

pubmed:
	./mirror.sh pubmed/urls.pmc
	./mirror.sh pubmed/urls.openaccess
	./mirror.sh pubmed/urls.medline

#PubTator:

SETH:
	./mirror.sh SETH/urls.emu
	./mirror.sh SETH/urls.mutationfinder


#clean:  FORCE
#	rm -rf ${VE_DIR}
#	rm -f logs/*

.PHONY:  FORCE help clinvar GTR gene hugo LSDB medgen PubTator SETH 
