#!/bin/bash 

. common.sh 

echo ############################################################################

echo unpack mirrored contents "(gunzip | unzip | tar)"

if [ $# -eq 0 ]
  then
    echo "No dataset passed. example ./unpack gene"
    exit -1
fi

export DATASET=$1
require $DATASET "DATASET=?"

mkdir -p $DATASET/mirror 

for f in `find $DATASET | grep gz$`;
do
  ls $f
  STEM=$(basename "${f}" .gz)  
  gunzip -c "${f}" > $DATASET/mirror/"${STEM}"
done

# unzip 
for zip in `find $DATASET | grep zip$`;
do
    unzip $zip 
done

# untar  
for tar in `find $DATASET | grep "tar$"`;
do
    tar -xvf $tar -C $DATASET/mirror/. 
done


