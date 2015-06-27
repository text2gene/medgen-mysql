echo "Fixing control line feed characters"
echo "###################################"

tr '\r' '\n' < mirror/CHV_concepts_terms_flatfile_20110204.tsv     | egrep -v "^$" > mirror/term.tsv
tr '\r' '\n' < mirror/stop_concepts_flat_file_2005-Dec-19.tsv      | egrep -v "^$" > mirror/stop.tsv
tr '\r' '\n' < mirror/incorrect_mappings_flat_file_2006-Aug-15.tsv | egrep -v "^$" > mirror/wrong.tsv

echo "###################################"

load_table tsv term  term.tsv 
load_table tsv stop  stop.tsv
load_table tsv wrong wrong.tsv
