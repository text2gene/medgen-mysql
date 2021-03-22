-- Drop user if exists 
-- http://stackoverflow.com/questions/598190/mysql-check-if-the-user-exists-and-drop-it 
DROP USER IF EXISTS 'medgen'@'localhost';

-- MySQL anonymous user can really screw things up.
-- http://bugs.mysql.com/bug.php?id=31061
-- Ensure we delete this user or else you may see strange permissions on Mac OSX. 
-- GRANT USAGE ON  mysql.* TO ''@'localhost';
-- DROP USER ''@'localhost';

create user 'medgen'@'localhost' identified by 'medgen';

grant all on *.* to 'medgen'@'localhost';
grant execute on *.* to 'medgen'@'localhost';

-- MedGen directly references to these sources
grant all privileges on clinvar.*      to 'medgen'@'localhost' with grant option; 
grant all privileges on gene.*         to 'medgen'@'localhost' with grant option; 
grant all privileges on GeneReviews.*  to 'medgen'@'localhost' with grant option; 
grant all privileges on GO.*           to 'medgen'@'localhost' with grant option; 
grant all privileges on GTR.*          to 'medgen'@'localhost' with grant option; 
grant all privileges on hpo.*          to 'medgen'@'localhost' with grant option; 
grant all privileges on hugo.*         to 'medgen'@'localhost' with grant option; 
grant all privileges on medgen.*       to 'medgen'@'localhost' with grant option; 
grant all privileges on orphanet.*     to 'medgen'@'localhost' with grant option; 
grant all privileges on pubmed.*       to 'medgen'@'localhost' with grant option; 
grant all privileges on umls.*         to 'medgen'@'localhost' with grant option;

-- MedGen is able to link to Human Genetic Variation Society (HGVS) formatted datasources
-- http://www.hgvs.org/mutnomen
grant all privileges on v2p.*             to 'medgen'@'localhost' with grant option;
grant all privileges on PubTator.*        to 'medgen'@'localhost' with grant option; 
grant all privileges on SETH.*            to 'medgen'@'localhost' with grant option; 
grant all privileges on PersonalGenomes.* to 'medgen'@'localhost' with grant option; 

-- MedGen add-on package for indication2gene (clinical text processing with gene association) 
grant all privileges on indication2gene.* to 'medgen'@'localhost' with grant option; 
