-- View: dwh.network_analysis

-- DROP MATERIALIZED VIEW IF EXISTS dwh.network_analysis;

CREATE MATERIALIZED VIEW IF NOT EXISTS dwh.network_analysis
TABLESPACE pg_default
AS
 WITH temp AS (
         SELECT i."HLS_ID",
            a1."HLS_URL" AS parent_hls_url,
            concat(a1.first_name, ' ', a1.last_name) AS fullname,
            dp.date_actual AS date_published,
            a.author,
            g.gender,
            bd.year_actual AS year_born,
            a2.cleaned_birth_date_formatted,
            dd.year_actual AS year_died,
            bd.century_descriptor AS century_from,
            (i.deathdate - i.birthdate) / 10000 AS age,
                CASE
                    WHEN i.related_hls_id IS NULL THEN 0::bigint
                    ELSE i.related_hls_id
                END AS related_hls_id,
                CASE
                    WHEN a2."HLS_URL" IS NULL THEN 'Not Available'::text
                    ELSE a2."HLS_URL"
                END AS "HLS_URL",
            concat(a2.first_name, ' ', a2.last_name) AS relatedname,
            a1.held_secret_role,
            a2.held_secret_role AS related_held_secret_role,
            sum(i.name_count) AS influence
           FROM dwh.fact_influence i
             LEFT JOIN dwh.dim_article a1 ON a1."HLS_ID" = i."HLS_ID"
             LEFT JOIN dwh.dim_article a2 ON a2."HLS_ID" = i.related_hls_id
             LEFT JOIN dwh.dim_author a ON a.author_id = i.author_id
             LEFT JOIN dwh.dim_gender g ON g.gender_id = i.gender_id
             LEFT JOIN dwh.dim_date dp ON dp.date_dim_id = i.published
             LEFT JOIN dwh.dim_date bd ON bd.date_dim_id = i.birthdate
             LEFT JOIN dwh.dim_date dd ON dd.date_dim_id = i.deathdate
          GROUP BY i."HLS_ID", a1."HLS_URL", (concat(a1.first_name, ' ', a1.last_name)), dp.date_actual, a.author, g.gender, bd.year_actual, a2.cleaned_birth_date_formatted, dd.year_actual, bd.century_descriptor, ((i.deathdate - i.birthdate) / 10000), (
                CASE
                    WHEN i.related_hls_id IS NULL THEN 0::bigint
                    ELSE i.related_hls_id
                END), (
                CASE
                    WHEN a2."HLS_URL" IS NULL THEN 'Not Available'::text
                    ELSE a2."HLS_URL"
                END), (concat(a2.first_name, ' ', a2.last_name)), a1.held_secret_role, a2.held_secret_role
        )
 SELECT temp."HLS_ID" AS "Source",
    temp.parent_hls_url,
    temp.fullname,
    temp.date_published,
    temp.author,
    temp.gender,
    temp.year_born,
    temp.year_died,
    temp.century_from,
    temp.age,
    temp.related_hls_id AS "Target",
    temp."HLS_URL",
    temp.relatedname,
    temp.cleaned_birth_date_formatted,
    temp.held_secret_role,
    temp.related_held_secret_role,
    row_number() OVER (PARTITION BY (concat(temp.relatedname, temp.cleaned_birth_date_formatted)) ORDER BY temp.related_hls_id) AS row_number,
        CASE
            WHEN temp.related_hls_id = 0 THEN 0::numeric
            ELSE temp.influence
        END AS influence
   FROM temp
  WHERE
        CASE
            WHEN temp.related_hls_id = 0 THEN 0::numeric
            ELSE temp.influence
        END <> 0::numeric AND temp."HLS_ID" <> temp.related_hls_id
WITH DATA;

ALTER TABLE IF EXISTS dwh.network_analysis
    OWNER TO postgres;