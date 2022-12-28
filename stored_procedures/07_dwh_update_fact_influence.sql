-- PROCEDURE: dwh.update_fact_influence()

-- DROP PROCEDURE IF EXISTS dwh.update_fact_influence();

CREATE OR REPLACE PROCEDURE dwh.update_fact_influence(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO dwh.fact_influence

select 
n."HLS_ID",
CAST(CONCAT(right(n.published, 4), substring(n.published, 4,2),left(n.published, 2)) AS INTEGER) as published,

a.author_id, -- convert to author key
g.gender_id, -- convert to gender key
CAST(translate(n.cleaned_birth_date_formatted, '-', '') as integer) as birthdate, -- convert to date key
CAST(translate(n.cleaned_death_date_formatted, '-', '') as integer) as deathdate, -- convert to date key

location_count as name_count
from  public.mv_fact_name n
left join dwh.dim_author a on a.author = n.author
left join dwh.dim_gender g on g.gender = n.hhb_sex
left join dwh.dim_article art on art.name_id = n.name_id

WHERE n."HLS_ID" NOT IN (
SELECT distinct "HLS_ID" FROM dwh.fact_influence)
$BODY$;
ALTER PROCEDURE dwh.update_fact_influence()
    OWNER TO postgres;
