Tables
========================================

- **MRSAB**: "Source vocabulary abbreviations"
- **MRCONSO**: "Concepts, Concept Names, and their sources" 
- **MRDOC**: "Doc information schema" 
- *+MORE*   

| 
|
HOWTO: Get Concepts, Names, and Sources
========================================

Get Concept IDs and vocab sources for the string 'AAAS' which is a known gene name. 
-----------------------------------------------------------------------------------

- **SAB**  is the "vocabulary source abbreviation" (such as OMIM) |
- **CODE** is the "Unique code for string in vocabulary source"
- **CUI**  is the "umls Concept Unique Id across all vocabularies"
- **STR**  is the "string term in the source, in this case 'AAAS' "

|
mysql> select SAB as SourceVocab, CODE as Code, CUI, STR as StringTerm from MRCONSO where str ='AAAS';
:: 

	+-------+----------+--------+
	| vocab | id       | string |
	+-------+----------+--------+
	| OMIM  | C1422135 | AAAS   |
	| OMIM  | C0271742 | AAAS   |
	| HGNC  | C1422135 | AAAS   |
	| NCI   | C1515935 | AAAS   |
	+-------+----------+--------+


Get lexical terms, strings, and atoms for 'AAAS' (Triple-A syndrome, AAAS Gene) 
--------------------------------------------------------------------------------
::
 
	select 
	   -- Source 
	   SAB  as vocab,
	   code as vocab_code, 

	   -- Concept 
	   STR, -- as string 
	   CUI as concept_ui, -- as unique id 

	   -- Concept lexical, string, and atom properties (get unique IDs) Unique
	   LUI as lexical_ui,  -- Lexical 
	   AUI as atom_ui,     -- Atom 
	   SUI as string_ui,   -- String 
	   STT as string_type  -- string type

	from MRCONSO 
	where STR='AAAS' order by CUI, SAB; 


	+-------+------------+------+------------+------------+-----------+-----------+-------------+
	| vocab | vocab_code | STR  | concept_ui | lexical_ui | atom_ui   | string_ui | string_type |
	+-------+------------+------+------------+------------+-----------+-----------+-------------+
	| OMIM  | 231550     | AAAS | C0271742   | L1217664   | A20273939 | S6125833  | PF          |
	| HGNC  | HGNC:13666 | AAAS | C1422135   | L1217664   | A20714030 | S6125833  | PF          |
	| OMIM  | 605378     | AAAS | C1422135   | L1217664   | A11925916 | S6125833  | PF          |
	| NCI   | C39307     | AAAS | C1515935   | L1217664   | A7646129  | S6125833  | PF          |
	+-------+------------+------+------------+------------+-----------+-----------+-------------+

- **SAB**   is the "vocabulary source" 
- **CODE**  is the "vocabulary code" mapped to the UMLS concept
- **CUI**   is the "Concept" unique id
- **LUI**   is the "Lexical term" unique id 
- **SUI**   is the "String" unique id 
- **AUI**   is the "Atom" unique id
- **STT**   is the "String Term Type"


CARDINALITY
-----------

- atom     1:* string  
- atom     1:* terms   
- atom     1:* concept 

- concept  1:* atom     
- concept  1:* string
- concept  1:* term  

VARIATION
---------

- Every CUI (concept) is linked to at least one AUI (atom), SUI (string), and LUI (term), but can also be linked to many of each of these. 
- Every AUI (atom) is linked to a single SUI (string), a single LUI (term), and a single CUI (concept). 
- Each SUI (string) can be linked to many AUIs (atoms), to a single LUI (term), and to more than one CUI (concept)  although the typical case is one CUI. 
- Each LUI (term) can be linked to many AUIs (atoms), many SUIs (strings), and more than one CUI (concept) although the typical case is one CUI.

- But what does STT String Term Type "PF" mean? 
- See the next example to query the UMLS information schema. 


|
|
`UMLS Information Schema <http://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/release/columns_data_elements.html>`_
====================================================================================================================================

Describe schema ... (sort of)
----------------------------
|

mysql> select DOCKEY, count(*) as cnt from MRDOC group by DOCKEY order by cnt desc; 
::

	+----------+------+
	| DOCKEY   | cnt  |
	+----------+------+
	| RELA     | 1363 |
	| ATN      |  482 |
	| TTY      |  451 |
	| REL      |  120 |
	| LAT      |   21 |
	| SRL      |   12 |
	| RELEASE  |    9 |
	| TOTYPE   |    6 |
	| STYPE    |    6 |
	| STYPE2   |    5 |
	| SUPPRESS |    5 |
	| STYPE1   |    5 |
	| CXTY     |    5 |
	| STT      |    5 |
	| FROMTYPE |    4 |
	| TS       |    4 |
	| MAPATN   |    1 |
	+----------+------+

|

mysql> select * from MRDOC where DOCKEY = 'STT'; 
::

	+--------+-------+---------------+---------------------------------------------------+
	| DOCKEY | VALUE | TYPE          | EXPL                                              |
	+--------+-------+---------------+---------------------------------------------------+
	| STT    | PF    | expanded_form | Preferred form of term                            |
	| STT    | VCW   | expanded_form | Case and word-order variant of the preferred form |
	| STT    | VC    | expanded_form | Case variant of the preferred form                |
	| STT    | VO    | expanded_form | Variant of the preferred form                     |
	| STT    | VW    | expanded_form | Word-order variant of the preferred form          |
	+--------+-------+---------------+---------------------------------------------------+

|	

This tells us that the 'AAAS' terms int the  above example all use the same preferred (PF) form. 
