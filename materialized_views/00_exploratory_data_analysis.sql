-- View: public.master_view_eda

-- DROP MATERIALIZED VIEW IF EXISTS public.master_view_eda;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.master_view_eda
TABLESPACE pg_default
AS
 WITH temp AS (
         SELECT "22_10_22_hls_people_hist_hub_flair"."HLS_ID",
            "22_10_22_hls_people_hist_hub_flair"."HLS_URL",
            "22_10_22_hls_people_hist_hub_flair".first_name,
            "22_10_22_hls_people_hist_hub_flair".last_name,
            "22_10_22_hls_people_hist_hub_flair".published,
            "22_10_22_hls_people_hist_hub_flair".author,
            "22_10_22_hls_people_hist_hub_flair".translator,
            "22_10_22_hls_people_hist_hub_flair".hhb_ids,
            "22_10_22_hls_people_hist_hub_flair".hhb_forename,
            "22_10_22_hls_people_hist_hub_flair".flair_person,
            "22_10_22_hls_people_hist_hub_flair".hhb_relation_name,
            "22_10_22_hls_people_hist_hub_flair".hhb_relation_type,
            "22_10_22_hls_people_hist_hub_flair".flair_locations,
            unnest(string_to_array("22_10_22_hls_people_hist_hub_flair".flair_organizations, ','::text)) AS org_id,
            unnest(string_to_array("22_10_22_hls_people_hist_hub_flair".flair_locations, ','::text)) AS location_id
           FROM "22_10_22_hls_people_hist_hub_flair"
        )
 SELECT t."HLS_ID",
    t."HLS_URL",
    t.first_name,
    t.last_name,
    t.published,
    t.author,
    t.translator,
    t.hhb_ids,
    t.hhb_forename,
    t.flair_person,
    t.hhb_relation_name,
    t.hhb_relation_type,
    p."Kantonskürzel",
    p."Ortschaftsname",
    p."Gemeindename",
    t.location_id,
    count(1) AS location_count
   FROM temp t
     LEFT JOIN "PLZO_CSV_LV03" p ON p."Ortschaftsname" = t.location_id
  GROUP BY t."HLS_ID", t."HLS_URL", t.first_name, t.last_name, t.published, t.author, t.translator, t.hhb_ids, t.hhb_forename, t.flair_person, t.hhb_relation_name, t.hhb_relation_type, p."Kantonskürzel", p."Ortschaftsname", p."Gemeindename", t.location_id
  ORDER BY t."HLS_ID"
WITH DATA;

ALTER TABLE IF EXISTS public.master_view_eda
    OWNER TO postgres;