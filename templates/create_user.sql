create user '@@@DB_USER'@'localhost' identified by '@@@DB_PASS';
grant all on @@@DATASET.* to '@@@DB_USER'@'localhost';
grant execute on @@@DATASET.* to '@@@DB_USER'@'localhost';
