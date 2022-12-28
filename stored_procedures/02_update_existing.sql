-- PROCEDURE: public.update_staging_table_existing()

-- DROP PROCEDURE IF EXISTS public.update_staging_table_existing();

CREATE OR REPLACE PROCEDURE public.update_staging_table_existing(
	)
LANGUAGE 'sql'
AS $BODY$
UPDATE public."22_10_22_hls_people_hist_hub_flair" AS t1 
SET first_name = t2.first_name
FROM public.flair_output_updated_articles AS t2
WHERE t1."HLS_ID" = t2."HLS_ID"
$BODY$;
ALTER PROCEDURE public.update_staging_table_existing()
    OWNER TO postgres;
