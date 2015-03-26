#!/bin/bash 

. common.sh 

echo ############################################################################

if [ $# -eq 0 ]
  then
    echo "No dataset passed. example ./unpack gene"
    exit -1
fi

export DATASET=$1
require $DATASET "DATASET=?"

echo "attempting to unpack $DATASET mirror using (gunzip | unzip | tar)"

mkdir -p $DATASET/mirror 

for f in `find $DATASET | grep gz$`;
do
  echo "attempting to gunzip $f" 
  STEM=$(basename "${f}" .gz)  
  gunzip -cq "${f}" > $DATASET/mirror/"${STEM}" || true
done

for f in `find $DATASET | grep zip$`;
do
    echo "attempting to unzip $f" 
    unzip -oq $f -d $DATASET/mirror/. 
done

for f in `find $DATASET | grep tar$`;
do
  echo "attempting to untar $f" 
  #STEM=$(basename "${f}" .tar)
  tar -xvf $f -C $DATASET/mirror/.
done
