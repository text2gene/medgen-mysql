#!/bin/bash
# 
echo ############################################################################
echo NCBI mirror
echo 
echo "$./mirror pubmed/urls       <== PubMed annotations (daily)"
echo "$./mirror medgen/urls       <== Medical Genetics "
echo "$./mirror GTR/urls          <== Genetic Testing Reference" 
echo "$./mirror GeneReviews/urls  <== Gene Reviews" 
echo "$./mirror gene/urls         <== Gene annotations (ncbi)" 
echo "$./mirror clinvar/urls      <== Clinical Variants (public)" 
echo "$./mirror pgp/urls          <== Personal Genome Project variant annotations" 
echo "$./mirror PubTator/urls     <== HGVS:pubmed (tmVar)" 
echo "$./mirror snp/urls          <== snp:HGVS mappings" 
echo "$./mirror eqtl/urls         <== snp:expression evidence" 
echo "$./mirror gapplus/urls      <== genotype:phenotype "
echo 
echo ############################################################################

export NCBI_FTP="ftp.ncbi.nlm.nih.gov"
export TODAY="$(date +%F)"
export BATCH="batch__$TODAY" 

echo =================================================
echo "Environment:" 
echo 
echo "NCBI_FTP= $NCBI_FTP"

echo "TODAY is $TODAY"
echo "BATCH is $BATCH"
echo 
echo =================================================
echo "CHECK url file inputs for wget..."

if [ $# -eq 0 ]
  then
    echo "No urls passed. try ./mirror pubmed/urls"
    exit 0
fi

# mkdir -p $BATCH

for urls in $*; do 
    echo "checking for file: $urls" 

    if [ ! -f $urls ]; then
	echo "$urls file not found!"
	exit 0
    fi            

    # cp $urls $BATCH/. 
    echo "MIRROR urls with wget..."
    source $urls 

done
