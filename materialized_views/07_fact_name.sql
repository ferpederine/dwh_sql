-- View: public.mv_fact_name

-- DROP MATERIALIZED VIEW IF EXISTS public.mv_fact_name;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_fact_name
TABLESPACE pg_default
AS
 WITH temp AS (
         SELECT "22_10_22_hls_people_hist_hub_flair"."HLS_ID",
            "22_10_22_hls_people_hist_hub_flair"."HLS_URL",
            "22_10_22_hls_people_hist_hub_flair".first_name,
            "22_10_22_hls_people_hist_hub_flair".last_name,
            concat("22_10_22_hls_people_hist_hub_flair".first_name, ' ', "22_10_22_hls_people_hist_hub_flair".last_name) AS full_name,
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
            unnest(string_to_array("22_10_22_hls_people_hist_hub_flair".flair_person, ','::text)) AS name_id,
            count(1) AS location_count
           FROM "22_10_22_hls_people_hist_hub_flair"
          GROUP BY "22_10_22_hls_people_hist_hub_flair"."HLS_ID", "22_10_22_hls_people_hist_hub_flair"."HLS_URL", "22_10_22_hls_people_hist_hub_flair".first_name, "22_10_22_hls_people_hist_hub_flair".last_name, "22_10_22_hls_people_hist_hub_flair".published, "22_10_22_hls_people_hist_hub_flair".author, "22_10_22_hls_people_hist_hub_flair".hhb_ids, "22_10_22_hls_people_hist_hub_flair".hhb_forename, "22_10_22_hls_people_hist_hub_flair".hhb_surname, "22_10_22_hls_people_hist_hub_flair".hhb_sex, "22_10_22_hls_people_hist_hub_flair".hhb_birth_date, "22_10_22_hls_people_hist_hub_flair".hhb_death_date, "22_10_22_hls_people_hist_hub_flair".cleaned_birth_date_formatted, "22_10_22_hls_people_hist_hub_flair".cleaned_death_date_formatted, (unnest(string_to_array("22_10_22_hls_people_hist_hub_flair".flair_person, ','::text)))
        )
 SELECT temp."HLS_ID",
    temp."HLS_URL",
    temp.first_name,
    temp.last_name,
    temp.published,
    temp.author,
    temp.hhb_ids,
    temp.hhb_forename,
    temp.hhb_surname,
    temp.hhb_sex,
    temp.hhb_birth_date,
    temp.hhb_death_date,
    temp.cleaned_birth_date_formatted,
    temp.cleaned_death_date_formatted,
    temp.name_id,
    temp.location_count,
    f."HLS_ID" AS related_hls_id,
    f."HLS_URL" AS related_url
   FROM temp
     LEFT JOIN "22_10_22_hls_people_hist_hub_flair" f ON temp.name_id = concat(f.first_name, ' ', f.last_name)
WITH DATA;

ALTER TABLE IF EXISTS public.mv_fact_name
    OWNER TO postgres;