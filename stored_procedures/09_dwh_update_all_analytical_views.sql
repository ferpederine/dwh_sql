-- PROCEDURE: dwh.refresh_analytical_mvs()

-- DROP PROCEDURE IF EXISTS dwh.refresh_analytical_mvs();

CREATE OR REPLACE PROCEDURE dwh.refresh_analytical_mvs(
	)
LANGUAGE 'plpgsql'
AS $BODY$
begin
 execute 'refresh materialized view dwh.mv_geographic_footprint';
 execute 'refresh materialized view dwh.mv_influential_figures';
 execute 'refresh materialized view dwh.mv_secret_council';

end;
$BODY$;
ALTER PROCEDURE dwh.refresh_analytical_mvs()
    OWNER TO postgres;
