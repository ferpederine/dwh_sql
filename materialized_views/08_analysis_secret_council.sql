-- View: dwh.mv_secret_council

-- DROP MATERIALIZED VIEW IF EXISTS dwh.mv_secret_council;

CREATE MATERIALIZED VIEW IF NOT EXISTS dwh.mv_secret_council
TABLESPACE pg_default
AS
 SELECT s."HLS_ID",
    a."HLS_URL",
    a2."HLS_URL" AS related_url,
    dp.date_actual AS date_published,
    g.gender,
    bd.year_actual AS year_born,
    bd.date_actual AS birth_date,
    dd.year_actual AS year_died,
    dd.date_actual AS death_date,
    bd.century_descriptor AS century_from,
    a.held_secret_role,
    geo.location_name,
    geo.latitude,
    geo.longitude,
    geo.locality,
    geo.admin_level_3,
    geo.admin_level_2,
    geo.admin_level_1,
    geo.country_name_long,
        CASE
            WHEN geo.country_name = 'CH'::text THEN 'Switzerland'::text
            ELSE 'Rest of World'::text
        END AS switz_row,
    sum(s.location_count) AS location_count
   FROM dwh.fact_spread s
     LEFT JOIN dwh.dim_article a ON a."HLS_ID" = s."HLS_ID"
     LEFT JOIN dwh.dim_article a2 ON a2."HLS_ID" = s."HLS_ID"
     LEFT JOIN dwh.dim_gender g ON g.gender_id = s.gender_id
     LEFT JOIN dwh.dim_date dp ON dp.date_dim_id = s.published
     LEFT JOIN dwh.dim_date bd ON bd.date_dim_id = s.birthdate
     LEFT JOIN dwh.dim_date dd ON dd.date_dim_id = s.deathdate
     LEFT JOIN dwh.dim_geo geo ON geo.geo_id = s.geo_id
  GROUP BY s."HLS_ID", a."HLS_URL", a2."HLS_URL", dp.date_actual, g.gender, bd.year_actual, bd.date_actual, dd.year_actual, dd.date_actual, bd.century_descriptor, a.held_secret_role, geo.location_name, geo.latitude, geo.longitude, geo.locality, geo.admin_level_3, geo.admin_level_2, geo.admin_level_1, geo.country_name_long, (
        CASE
            WHEN geo.country_name = 'CH'::text THEN 'Switzerland'::text
            ELSE 'Rest of World'::text
        END)
WITH NO DATA;

ALTER TABLE IF EXISTS dwh.mv_secret_council
    OWNER TO postgres;

COMMENT ON MATERIALIZED VIEW dwh.mv_secret_council
    IS 'A view of the data whose text contained keywords from the config file';