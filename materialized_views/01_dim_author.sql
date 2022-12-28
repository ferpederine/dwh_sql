-- View: public.mv_dim_author

-- DROP MATERIALIZED VIEW IF EXISTS public.mv_dim_author;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_dim_author
TABLESPACE pg_default
AS
 SELECT DISTINCT "22_10_22_hls_people_hist_hub_flair".author
   FROM "22_10_22_hls_people_hist_hub_flair"
  ORDER BY "22_10_22_hls_people_hist_hub_flair".author
WITH DATA;

ALTER TABLE IF EXISTS public.mv_dim_author
    OWNER TO postgres;