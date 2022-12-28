-- View: public.mv_dim_name

-- DROP MATERIALIZED VIEW IF EXISTS public.mv_dim_name;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_dim_name
TABLESPACE pg_default
AS
 SELECT "22_10_22_hls_people_hist_hub_flair"."HLS_ID",
    "22_10_22_hls_people_hist_hub_flair"."HLS_URL",
    "22_10_22_hls_people_hist_hub_flair".first_name,
    "22_10_22_hls_people_hist_hub_flair".last_name,
    concat_ws(' '::text, "22_10_22_hls_people_hist_hub_flair".first_name, "22_10_22_hls_people_hist_hub_flair".last_name) AS name_id,
    "22_10_22_hls_people_hist_hub_flair".published,
    "22_10_22_hls_people_hist_hub_flair".author,
    "22_10_22_hls_people_hist_hub_flair".hhb_ids,
    "22_10_22_hls_people_hist_hub_flair".cleaned_birth_date_formatted,
    "22_10_22_hls_people_hist_hub_flair".cleaned_death_date_formatted,
    to_tsvector("22_10_22_hls_people_hist_hub_flair".text) @@ to_tsquery('Geheimer | Bürgermeister | Schultheiss | Landammann | Oberstzunftmeister | Venner | Landesfähnrich | Seckelmeister'::text) AS heldsecretrole
   FROM "22_10_22_hls_people_hist_hub_flair"
WITH DATA;

ALTER TABLE IF EXISTS public.mv_dim_name
    OWNER TO postgres;