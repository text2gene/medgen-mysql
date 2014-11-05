-- Drop user if exists 
-- http://stackoverflow.com/questions/598190/mysql-check-if-the-user-exists-and-drop-it 
GRANT USAGE ON  *.* TO 'medgen'@'%';
DROP USER 'medgen'@'%';
