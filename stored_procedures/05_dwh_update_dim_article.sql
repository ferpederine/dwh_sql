-- PROCEDURE: dwh.update_dim_article()

-- DROP PROCEDURE IF EXISTS dwh.update_dim_article();

CREATE OR REPLACE PROCEDURE dwh.update_dim_article(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO dwh.dim_article

SELECT * from public.mv_dim_name
WHERE "HLS_ID" NOT IN
(SELECT DISTINCT "HLS_ID" from dwh.dim_article)
$BODY$;
ALTER PROCEDURE dwh.update_dim_article()
    OWNER TO postgres;
