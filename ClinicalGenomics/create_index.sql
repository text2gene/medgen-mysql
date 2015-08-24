-- #########################################################

call create_index('gene2condition', 'hgnc');
call create_index('gene2condition', 'hgnc_id');
call create_index('gene2condition', 'GeneID');
call create_index('gene2condition', 'ClinicalCond');
call create_index('gene2condition', 'Inheritance');
call create_index('gene2condition', 'Age');
call create_index('gene2condition', 'Manifestation');

-- #########################################################

call create_index('codes', 'CUI');
call create_index('codes', 'ClinicalCond');

-- #########################################################
