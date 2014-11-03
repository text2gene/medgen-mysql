create user 'medgen'@'%' identified by 'medgen';
grant all on *.* to 'medgen'@'%';
grant execute on *.* to 'medgen'@'%';

select 'SUPERUSER privs!' as note; 
select 'SUPERUSER == SUPERHERO or SUPERVILLIAN. Choose wisely!' as note; 

GRANT ALL PRIVILEGES ON *.* TO 'medgen'@'%' WITH GRANT OPTION; 
