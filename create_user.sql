create user 'medgen'@'%' identified by 'medgen';
grant all on *.* to 'medgen'@'%';
grant execute on *.* to 'medgen'@'%';

-- MedGen directly references to these sources
grant all privileges on clinvar.*      to 'medgen'@'%' with grant option; 
grant all privileges on gene.*         to 'medgen'@'%' with grant option; 
grant all privileges on GeneReviews.*  to 'medgen'@'%' with grant option; 
grant all privileges on GO.*           to 'medgen'@'%' with grant option; 
grant all privileges on GTR.*          to 'medgen'@'%' with grant option; 
grant all privileges on hpo.*          to 'medgen'@'%' with grant option; 
grant all privileges on hugo.*         to 'medgen'@'%' with grant option; 
grant all privileges on medgen.*       to 'medgen'@'%' with grant option; 
grant all privileges on orphanet.*     to 'medgen'@'%' with grant option; 
grant all privileges on pubmed.*       to 'medgen'@'%' with grant option; 
grant all privileges on umls.*         to 'medgen'@'%' with grant option; 

-- MedGen is able to link to Human Genetic Variation Society (HGVS) formatted datasources
-- http://www.hgvs.org/mutnomen
grant all privileges on hgvs.*            to 'medgen'@'%' with grant option;
grant all privileges on hgvsquery.*       to 'medgen'@'%' with grant option;
grant all privileges on PubTator.*        to 'medgen'@'%' with grant option; 
grant all privileges on SETH.*            to 'medgen'@'%' with grant option; 
grant all privileges on PersonalGenomes.* to 'medgen'@'%' with grant option; 
