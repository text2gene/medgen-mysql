# First do the backups 
./backup_database.sh clinvar
./backup_database.sh GTR
./backup_database.sh PubTator
./backup_database.sh PersonalGenomes
./backup_database.sh gene
./backup_database.sh hugo
./backup_database.sh GeneReviews
./backup_database.sh GO
./backup_database.sh HPO
./backup_database.sh medgen

# Restart MYSQL
sudo service mysql restart 

# drop databases
./drop_database.sh clinvar
./drop_database.sh GTR
./drop_database.sh PubTator
./drop_database.sh PersonalGenomes
./drop_database.sh gene
./drop_database.sh hugo
./drop_database.sh GeneReviews
./drop_database.sh GO
./drop_database.sh HPO
./drop_database.sh medgen

# make databases 
make clinvar
make GTR
make PubTator
make PersonalGenomes 
make gene
make hugo
make GeneReviews
make GO
make HPO
make medgen



