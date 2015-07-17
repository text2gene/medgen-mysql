call log('create_index.sql','begin'); 
-- ###################################
call create_index('term','CUI');
call create_index('term','Term');
call create_index('term','PreferredNameCHV');
call create_index('term','PreferredNameUMLS');
call create_index('term','PreferredByCHV');
call create_index('term','PreferredByUMLS');
call create_index('term','ScoreCombo');
call create_index('term','ScoreComboTop');
call create_index('term','StringID');
call create_index('term','ConceptID'); 
-- ###################################
call create_index('stop','CUI'); 
call create_index('stop','STR');
-- ###################################
call create_index('wrong','CUI'); 
call create_index('wrong','Wrong'); 
-- ###################################
call log('create_index.sql','done'); 