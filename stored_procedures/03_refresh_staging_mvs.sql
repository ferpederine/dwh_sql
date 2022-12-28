-- PROCEDURE: public.refresh_staging_mvs()

-- DROP PROCEDURE IF EXISTS public.refresh_staging_mvs();

CREATE OR REPLACE PROCEDURE public.refresh_staging_mvs(
	)
LANGUAGE 'plpgsql'
AS $BODY$
begin
 execute 'refresh materialized view public.mv_dim_author';
 execute 'refresh materialized view public.mv_dim_institute';
 execute 'refresh materialized view public.mv_dim_location';
 execute 'refresh materialized view public.mv_dim_name';
 execute 'refresh materialized view public.mv_fact_institute';
 execute 'refresh materialized view public.mv_fact_location';
 execute 'refresh materialized view public.mv_fact_name';
end;
$BODY$;
ALTER PROCEDURE public.refresh_staging_mvs()
    OWNER TO postgres;
