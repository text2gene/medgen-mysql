#############
# TERMS 
# 
# GO_TERMS="go_weekly-termdb-tables"
# 
GO_TERMS=go_daily-termdb-tables
SKIP=0

$mysql_dataset < mirror/$GO_TERMS/term.sql 
load_table tsv term $GO_TERMS/term.txt $SKIP

$mysql_dataset < mirror/$GO_TERMS/term2term.sql 
load_table tsv term2term $GO_TERMS/term2term.txt  $SKIP

$mysql_dataset < mirror/$GO_TERMS/term_definition.sql
load_table tsv term_definition $GO_TERMS/term_definition.txt  $SKIP

$mysql_dataset < mirror/$GO_TERMS/graph_path.sql 
load_table tsv graph_path $GO_TERMS/graph_path.txt  $SKIP

#############
# ASSOCIATIONS 
# 
GO_ASSOC=$(basename $(ls -t -d mirror/go_*-assocdb-tables | head -1 ))

$mysql_dataset < mirror/$GO_ASSOC/evidence.sql
load_table tsv evidence $GO_ASSOC/evidence.txt  $SKIP

$mysql_dataset < mirror/$GO_ASSOC/gene_product.sql 
load_table tsv gene_product $GO_ASSOC/gene_product.txt  $SKIP

$mysql_dataset < mirror/$GO_ASSOC/association.sql 
load_table tsv association $GO_ASSOC/association.txt  $SKIP

$mysql_dataset < mirror/$GO_ASSOC/gene_product_count.sql
load_table tsv gene_product_count $GO_ASSOC/gene_product_count.txt  $SKIP

#############
# SEQUENCES
# 
GO_SEQ=$(basename $(ls -t -d mirror/go_*-seqdb-tables | head -1 ))

$mysql_dataset < mirror/$GO_SEQ/seq.sql 
load_table tsv seq  $GO_SEQ/seq.txt  $SKIP

$mysql_dataset < mirror/$GO_SEQ/gene_product_seq.sql
load_table tsv gene_product_seq  $GO_SEQ/gene_product_seq.txt  $SKIP


