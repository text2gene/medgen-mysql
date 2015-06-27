call log('create_tables.sql', 'begin');

-- ###################################
call log('term','refresh'); 

drop   table if exists term; 
create table            term(
       CUI               char(8)	NOT NULL, -- UMLS concept id 
       Term              varchar(255) 	NOT NULL, -- UMLS concept string
       ConsumerText      varchar(255) 	NOT NULL, -- CHV  Name (what patients say) 
       MedicalText       varchar(255) 	NOT NULL, -- UMLS Name (what doctors  say)
       Explanation       text,
       MedicalPreferred  enum('yes', 'no') null, --  is UMLS preferred  
       ConsumerPreferred enum('yes', 'no') null, --  is CHV  preferred  
       Disparaged        enum('yes', 'no') null, --  is mispelled or other problem
       ScoreFreq         float,      -- Estimate of the difficulty of the term based on its frequency in several large text corpora
       ScoreContext      float,      -- Context based estimate of the difficulty of the term
       ScoreCUI          float,      -- Derived from determining how closely related the concept is to known examples of easy and difficult concepts
       ScoreComboTop     float,      -- Combination of frequency, context and CUI scores
       ScoreCombo        float,      -- No top words: A slight modification to Combo score that ignores top word criterion
       StringID          varchar(20),
       ConceptID         varchar(20)
);
call utf8_unicode('term');

-- ###################################
call log('stop','refresh'); 

drop   table if exists stop; 
create table           stop(
       CUI       char(8)	NOT NULL, -- UMLS concept id 
       STR       varchar(255) 	NOT NULL  -- UMLS concept string 
);
call utf8_unicode('stop');


-- ###################################
call log('wrong','refresh'); 

drop   table if exists wrong; 
create table           wrong(
       CUI	       char(8)	        NOT NULL, -- UMLS concept id 
       Preferred       varchar(255) 	NOT NULL, -- UMLS PreferredName 
       Wrong	       varchar(255) 	NOT NULL  -- Wrong/Incorrect mapping  
);
call utf8_unicode('wrong');

-- ###################################
call log('create_tables.sql', 'end');
