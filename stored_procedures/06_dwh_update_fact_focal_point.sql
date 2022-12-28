-- PROCEDURE: dwh.update_fact_focal_point()

-- DROP PROCEDURE IF EXISTS dwh.update_fact_focal_point();

CREATE OR REPLACE PROCEDURE dwh.update_fact_focal_point(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO dwh.fact_focal_point

select 
"HLS_ID",
CAST(CONCAT(right(published, 4), substring(published, 4,2),left(published, 2)) AS INTEGER) as published,

a.author_id, -- convert to author key
g.gender_id, -- convert to gender key
CAST(translate(cleaned_birth_date_formatted, '-', '') as integer) as birthdate, -- convert to date key
CAST(translate(cleaned_death_date_formatted, '-', '') as integer) as deathdate, -- convert to date key
ins.institute_id, -- convert to inst. id
institute_count

from public.mv_fact_institute i
left join dwh.dim_author a on a.author = i.author
left join dwh.dim_gender g on g.gender = i.hhb_sex
left join dwh.dim_institute ins on ins.institute_name = lower(i.institute_id)

WHERE "HLS_ID" NOT IN  (SELECT distinct "HLS_ID" from dwh.fact_focal_point)

$BODY$;
ALTER PROCEDURE dwh.update_fact_focal_point()
    OWNER TO postgres;
