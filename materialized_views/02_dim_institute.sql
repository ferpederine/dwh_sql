-- View: public.mv_dim_institute

-- DROP MATERIALIZED VIEW IF EXISTS public.mv_dim_institute;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_dim_institute
TABLESPACE pg_default
AS
 WITH temp AS (
         SELECT row_number() OVER (ORDER BY mv_fact_institute.institute_id) AS institute_id,
            lower(mv_fact_institute.institute_id) AS institute_name,
                CASE
                    WHEN lower(mv_fact_institute.institute_id) ~~ '%univ%'::text OR lower(mv_fact_institute.institute_id) ~~ '%schule%'::text OR (lower(mv_fact_institute.institute_id) = ANY (ARRAY['eth'::text, 'eth zürich'::text, 'polytechnikum zürich'::text, 'kollegium st. michael'::text, 'ecole des beaux-arts'::text, 'eidg . polytechnikum'::text, 'eidg . polytechnikum zürich'::text, 'akad . lausanne'::text, 'technikum winterthur'::text, 'genfer akademie'::text, 'akad'::text, 'polytechnikum'::text])) THEN 'Education'::text
                    WHEN (lower(mv_fact_institute.institute_id) = ANY (ARRAY['sp'::text, 'sp schweiz'::text, 'fdp'::text, 'cvp'::text, 'svp'::text, 'sps'::text, 'konservativen volkspartei'::text, 'rat'::text])) OR lower(mv_fact_institute.institute_id) ~~ '%partei%'::text THEN 'Political Party'::text
                    WHEN (lower(mv_fact_institute.institute_id) = ANY (ARRAY['nzz'::text, 'gazette de lausanne'::text, 'bbc'::text, 'appenzeller zeitung'::text])) OR lower(mv_fact_institute.institute_id) ~~ '%zeitung%'::text OR lower(mv_fact_institute.institute_id) ~~ '%radio%'::text THEN 'Media'::text
                    WHEN (lower(mv_fact_institute.institute_id) = ANY (ARRAY['sbb'::text, 'eidg'::text, 'nordostbahn'::text, 'gesellschaft'::text, 'swissair'::text, 'nestlé'::text, 'suva'::text, 'ag'::text, 'orell füssli'::text])) OR lower(mv_fact_institute.institute_id) ~~ '%gmbh%'::text THEN 'State Company / Co-operative / Business'::text
                    WHEN lower(mv_fact_institute.institute_id) ~~ '%kantonalbank%'::text OR lower(mv_fact_institute.institute_id) ~~ '%bank%'::text THEN 'Banking / Finance'::text
                    WHEN lower(mv_fact_institute.institute_id) ~~ '%verein%'::text OR lower(mv_fact_institute.institute_id) ~~ '%gesellschaft%'::text OR lower(mv_fact_institute.institute_id) ~~ '%society%'::text OR lower(mv_fact_institute.institute_id) ~~ '%association%'::text THEN 'Club / Society'::text
                    ELSE 'Not Defined'::text
                END AS typeins,
            sum(mv_fact_institute.institute_count) AS sum
           FROM mv_fact_institute
          WHERE NOT (mv_fact_institute.institute_id IN ( SELECT DISTINCT mv_dim_location.location_name
                   FROM mv_dim_location))
          GROUP BY mv_fact_institute.institute_id, (
                CASE
                    WHEN lower(mv_fact_institute.institute_id) ~~ '%univ%'::text THEN 'University'::text
                    ELSE NULL::text
                END)
          ORDER BY (row_number() OVER (ORDER BY mv_fact_institute.institute_id))
        )
 SELECT temp.institute_id,
    temp.institute_name,
    temp.typeins AS institute_type
   FROM temp
WITH DATA;

ALTER TABLE IF EXISTS public.mv_dim_institute
    OWNER TO postgres;