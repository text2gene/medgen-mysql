# First do the backups 
./backup_database.sh clinvar
./backup_database.sh GTR
./backup_database.sh PubTator
./backup_database.sh dbSNP
./backup_database.sh PersonalGenomes
./backup_database.sh gene
./backup_database.sh GeneReviews
./backup_database.sh GO
./backup_database.sh hugo
./backup_database.sh disgenet
./backup_database.sh hpo
./backup_database.sh CHV
./backup_database.sh medgen

# Restart MYSQL
sudo service mysql restart 

# drop databases
./drop_database.sh clinvar
./drop_database.sh GTR
./drop_database.sh PubTator
./drop_database.sh dbSNP
./drop_database.sh PersonalGenomes
./drop_database.sh gene
./drop_database.sh GeneReviews
./drop_database.sh GO
./drop_database.sh hugo
./drop_database.sh disgenet
./drop_database.sh hpo
./drop_database.sh CHV
./drop_database.sh medgen

# make databases 
make clinvar
make GTR
make PubTator
make dbSNP
make PersonalGenomes 
make gene
make GeneReviews
make GO
make hugo
make HPO
make CHV
make medgen


