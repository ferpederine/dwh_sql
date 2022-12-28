-- View: dwh.mv_geographic_footprint

-- DROP MATERIALIZED VIEW IF EXISTS dwh.mv_geographic_footprint;

CREATE MATERIALIZED VIEW IF NOT EXISTS dwh.mv_geographic_footprint
TABLESPACE pg_default
AS
 WITH temp AS (
         SELECT s."HLS_ID",
            concat(a1.first_name, ' ', a1.last_name) AS fullname,
            g.location_name,
            g.latitude,
            g.longitude,
            g.locality,
            g.admin_level_3,
            g.admin_level_2,
            g.admin_level_1,
            g.country_name_long,
            g.country_name,
                CASE
                    WHEN g.country_name = 'CH'::text THEN 'Switzerland'::text
                    ELSE 'Rest of World'::text
                END AS location,
            bd.century_descriptor AS century_from,
            sum(s.location_count) AS loc_count
           FROM dwh.fact_spread s
             LEFT JOIN dwh.dim_geo g ON g.geo_id = s.geo_id
             LEFT JOIN dwh.dim_article a1 ON a1."HLS_ID" = s."HLS_ID"
             LEFT JOIN dwh.dim_date dp ON dp.date_dim_id = s.published
             LEFT JOIN dwh.dim_date bd ON bd.date_dim_id = s.birthdate
             LEFT JOIN dwh.dim_date dd ON dd.date_dim_id = s.deathdate
          GROUP BY s."HLS_ID", (concat(a1.first_name, ' ', a1.last_name)), g.location_name, g.latitude, g.longitude, g.locality, g.admin_level_3, g.admin_level_2, g.admin_level_1, g.country_name_long, g.country_name, bd.century_descriptor
        )
 SELECT temp."HLS_ID",
    temp.fullname,
    temp.location_name,
    temp.latitude,
    temp.longitude,
    temp.locality,
    temp.admin_level_3,
    temp.admin_level_2,
    temp.admin_level_1,
    temp.country_name_long,
    temp.country_name,
    temp.location,
    temp.century_from,
    temp.loc_count
   FROM temp
  WHERE temp.location_name IS NOT NULL
WITH NO DATA;

ALTER TABLE IF EXISTS dwh.mv_geographic_footprint
    OWNER TO postgres;