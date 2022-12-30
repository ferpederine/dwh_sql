-- PROCEDURE: public.update_staging_table_new()

-- DROP PROCEDURE IF EXISTS public.update_staging_table_new();
-- Check proc

CREATE OR REPLACE PROCEDURE public.update_staging_table_new(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO public."22_10_22_hls_people_hist_hub_flair"

SELECT * from public.flair_output_new_articles
WHERE "HLS_ID" NOT IN
(SELECT DISTINCT "HLS_ID" from  public."22_10_22_hls_people_hist_hub_flair")
$BODY$;
ALTER PROCEDURE public.update_staging_table_new()
    OWNER TO postgres;
