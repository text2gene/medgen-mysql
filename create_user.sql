create user 'medgen'@'%' identified by 'medgen';
grant all on *.* to 'medgen'@'%';
grant execute on clinvar.* to 'medgen'@'%';
