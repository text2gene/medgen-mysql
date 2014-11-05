# Temporary (refactor into common.sh) 

# -- #########
# -- TODO: DRY 
# -- DONT REPEAT YOURSELF 
# -- ######### 

. db.config 
mkdir -p archive 
dump_db="mysqldump  $DATASET -u $DB_USER -p$DB_PASS" 

$dump_db mutation2pubtator  > archive/mutation2pubtator.sql 
$dump_db gene2pubmed        > archive/gene2pubmed.sql 
$dump_db gene2pubtator      > archive/gene2pubtator.sql 
$dump_db species2pubtator   > archive/species2pubtator.sql 
$dump_db disease2pubtator   > archive/disease2pubtator.sql 
$dump_db chemical2pubtator  > archive/chemical2pubtator.sql 
$dump_db hgvs_crop          > archive/hgvs_crop.sql 
$dump_db hgvs_crop_comments > archive/hgvs_crop_comments.sql 
