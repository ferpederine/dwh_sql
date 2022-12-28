-- View: public.mv_dim_location

-- DROP MATERIALIZED VIEW IF EXISTS public.mv_dim_location;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_dim_location
TABLESPACE pg_default
AS
 SELECT "22_10_22_flair_locations_base_gmaps".flair_location_name AS location_name,
    "22_10_22_flair_locations_base_gmaps".gmaps_location_lat AS latitude,
    "22_10_22_flair_locations_base_gmaps".gmaps_location_lng AS longitude,
    "22_10_22_flair_locations_base_gmaps".gmaps_locality_long_name AS locality,
    "22_10_22_flair_locations_base_gmaps".gmaps_administrative_area_level_3_long_name AS admin_level_3,
    "22_10_22_flair_locations_base_gmaps".gmaps_administrative_area_level_2_long_name AS admin_level_2,
    "22_10_22_flair_locations_base_gmaps".gmaps_administrative_area_level_1_long_name AS admin_level_1,
    "22_10_22_flair_locations_base_gmaps".gmaps_country_long_name AS country_name_long,
    "22_10_22_flair_locations_base_gmaps".gmaps_country_short_name AS country_name
   FROM "22_10_22_flair_locations_base_gmaps"
WITH DATA;

ALTER TABLE IF EXISTS public.mv_dim_location
    OWNER TO postgres;