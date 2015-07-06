echo "TODO: removing GeneID and PSSMID until we hear back from PubTator authors about these unexpected headers...."

LANG=C 

sed -e "s/\"//g" mirror/gene2pubtator > cleanme 

grep -v 'GeneID:' cleanme | grep -v 'PSSMID:' > mirror/gene2pubtator

rm cleanme

echo "OK, now loading the tables...." 

###############################################################

load_table tsv mutation2pubtator  mutation2pubtator
load_table tsv gene2pubtator      gene2pubtator
load_table tsv disease2pubtator   disease2pubtator
load_table tsv chemical2pubtator  chemical2pubtator
load_table tsv species2pubtator   species2pubtator

###############################################################