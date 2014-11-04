create user 'medgen'@'%' identified by 'medgen';
grant all on *.* to 'medgen'@'%';
grant execute on *.* to 'medgen'@'%';

select 'SUPERUSER privs!' as note; 
select 'SUPERUSER == SUPERHERO or SUPERVILLIAN. Choose wisely!' as note; 

grant all privileges on pubmed.*       to 'medgen'@'%' with grant option; 
grant all privileges on PubTator.*     to 'medgen'@'%' with grant option; 
grant all privileges on SETH.*         to 'medgen'@'%' with grant option; 

grant all privileges on medgen.*       to 'medgen'@'%' with grant option; 
grant all privileges on umls.*         to 'medgen'@'%' with grant option; 

grant all privileges on clinvar.*      to 'medgen'@'%' with grant option; 
grant all privileges on GTR.*          to 'medgen'@'%' with grant option; 

grant all privileges on gene.*         to 'medgen'@'%' with grant option; 
grant all privileges on hugo.*         to 'medgen'@'%' with grant option; 
grant all privileges on GeneReviews.*  to 'medgen'@'%' with grant option; 
