-- View: public.mv_fact_institute

-- DROP MATERIALIZED VIEW IF EXISTS public.mv_fact_institute;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_fact_institute
TABLESPACE pg_default
AS
 SELECT "22_10_22_hls_people_hist_hub_flair"."HLS_ID",
    "22_10_22_hls_people_hist_hub_flair"."HLS_URL",
    "22_10_22_hls_people_hist_hub_flair".first_name,
    "22_10_22_hls_people_hist_hub_flair".last_name,
    "22_10_22_hls_people_hist_hub_flair".published,
    "22_10_22_hls_people_hist_hub_flair".author,
    "22_10_22_hls_people_hist_hub_flair".hhb_ids,
    "22_10_22_hls_people_hist_hub_flair".hhb_forename,
    "22_10_22_hls_people_hist_hub_flair".hhb_surname,
    "22_10_22_hls_people_hist_hub_flair".hhb_sex,
    "22_10_22_hls_people_hist_hub_flair".hhb_birth_date,
    "22_10_22_hls_people_hist_hub_flair".hhb_death_date,
    "22_10_22_hls_people_hist_hub_flair".cleaned_birth_date_formatted,
    "22_10_22_hls_people_hist_hub_flair".cleaned_death_date_formatted,
    unnest(string_to_array("22_10_22_hls_people_hist_hub_flair".flair_organizations, ','::text)) AS institute_id,
    count(1) AS institute_count
   FROM "22_10_22_hls_people_hist_hub_flair"
  GROUP BY "22_10_22_hls_people_hist_hub_flair"."HLS_ID", "22_10_22_hls_people_hist_hub_flair"."HLS_URL", "22_10_22_hls_people_hist_hub_flair".first_name, "22_10_22_hls_people_hist_hub_flair".last_name, "22_10_22_hls_people_hist_hub_flair".published, "22_10_22_hls_people_hist_hub_flair".author, "22_10_22_hls_people_hist_hub_flair".hhb_ids, "22_10_22_hls_people_hist_hub_flair".hhb_forename, "22_10_22_hls_people_hist_hub_flair".hhb_surname, "22_10_22_hls_people_hist_hub_flair".hhb_sex, "22_10_22_hls_people_hist_hub_flair".hhb_birth_date, "22_10_22_hls_people_hist_hub_flair".hhb_death_date, "22_10_22_hls_people_hist_hub_flair".cleaned_birth_date_formatted, "22_10_22_hls_people_hist_hub_flair".cleaned_death_date_formatted, (unnest(string_to_array("22_10_22_hls_people_hist_hub_flair".flair_organizations, ','::text)))
WITH DATA;

ALTER TABLE IF EXISTS public.mv_fact_institute
    OWNER TO postgres;