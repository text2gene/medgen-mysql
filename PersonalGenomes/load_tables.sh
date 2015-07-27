#######################################################

load_table csv  bionotate  bionotate.csv

#######################################################

echo 'PGP provides a direct mysqldump! loading now....' 

$mysql_dataset -e "call log('mirror/PGP.mysqldump','begin') " 

$mysql_dataset < mirror/PGP.mysqldump

$mysql_dataset -e "call log('mirror/PGP.mysqldump','done') " 

#######################################################

