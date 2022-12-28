-- PROCEDURE: dwh.update_fact_spread()

-- DROP PROCEDURE IF EXISTS dwh.update_fact_spread();

CREATE OR REPLACE PROCEDURE dwh.update_fact_spread(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO dwh.fact_spread

select 
"HLS_ID",
CAST(CONCAT(right(published, 4), substring(published, 4,2),left(published, 2)) AS INTEGER) as published,

a.author_id, -- convert to author key
g.gender_id, -- convert to gender key
CAST(translate(cleaned_birth_date_formatted, '-', '') as integer) as birthdate, -- convert to date key
CAST(translate(cleaned_death_date_formatted, '-', '') as integer) as deathdate, -- convert to date key
geo.geo_id,
location_count
from public.mv_fact_location l
left join dwh.dim_author a on a.author = l.author
left join dwh.dim_gender g on g.gender = l.hhb_sex
left join dwh.dim_geo geo on geo.location_name = l.location_id

WHERE "HLS_ID" NOT IN (select distinct "HLS_ID" from dwh.fact_spread)
$BODY$;
ALTER PROCEDURE dwh.update_fact_spread()
    OWNER TO postgres;
