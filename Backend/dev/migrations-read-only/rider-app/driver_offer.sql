CREATE TABLE atlas_app.driver_offer ();

ALTER TABLE atlas_app.driver_offer ADD COLUMN bpp_quote_id text NOT NULL;
ALTER TABLE atlas_app.driver_offer ADD COLUMN created_at timestamp with time zone  default CURRENT_TIMESTAMP;
ALTER TABLE atlas_app.driver_offer ADD COLUMN distance_to_pickup integer ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN distance_to_pickup_value integer ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN distance_unit character varying(255) ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN driver_name text NOT NULL;
ALTER TABLE atlas_app.driver_offer ADD COLUMN duration_to_pickup integer ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN estimate_id character varying(36) NOT NULL;
ALTER TABLE atlas_app.driver_offer ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE atlas_app.driver_offer ADD COLUMN merchant_id character varying(36) ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN merchant_operating_city_id character varying(36) ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN rating text ;
ALTER TABLE atlas_app.driver_offer ADD COLUMN status text NOT NULL;
ALTER TABLE atlas_app.driver_offer ADD COLUMN updated_at timestamp with time zone NOT NULL default CURRENT_TIMESTAMP;
ALTER TABLE atlas_app.driver_offer ADD COLUMN valid_till timestamp with time zone NOT NULL;
ALTER TABLE atlas_app.driver_offer ADD PRIMARY KEY ( id);


------- SQL updates -------

ALTER TABLE atlas_app.driver_offer ALTER COLUMN distance_to_pickup_value TYPE double precision;