-- PROCEDURE: dwh.data_cleaning()

-- DROP PROCEDURE IF EXISTS dwh.data_cleaning();

CREATE OR REPLACE PROCEDURE dwh.data_cleaning(
	)
LANGUAGE 'sql'
AS $BODY$
UPDATE dwh.fact_spread SET birthdate = NULL 
where birthdate IN (
'90010101',
'70010101',
'60010101',
'50010101',
'40010101',
'30010101'
);

UPDATE dwh.fact_spread SET deathdate = NULL 
where deathdate IN (

'70010101'

);
$BODY$;
ALTER PROCEDURE dwh.data_cleaning()
    OWNER TO postgres;
