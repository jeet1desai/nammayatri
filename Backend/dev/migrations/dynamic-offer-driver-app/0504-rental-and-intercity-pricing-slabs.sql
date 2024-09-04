
ALTER TABLE atlas_driver_offer_bpp.fare_policy_rental_details_pricing_slabs
DROP CONSTRAINT fare_policy_rental_details_pricing_slabs_pkey;


ALTER TABLE atlas_driver_offer_bpp.fare_policy_rental_details_pricing_slabs
DROP COLUMN id;


ALTER TABLE atlas_driver_offer_bpp.fare_policy_rental_details_pricing_slabs
ADD PRIMARY KEY (fare_policy_id, time_percentage, distance_percentage);


ALTER TABLE atlas_driver_offer_bpp.fare_policy_inter_city_details_pricing_slabs
DROP CONSTRAINT fare_policy_inter_city_details_pricing_slabs_pkey;


ALTER TABLE atlas_driver_offer_bpp.fare_policy_inter_city_details_pricing_slabs
DROP COLUMN id;


ALTER TABLE atlas_driver_offer_bpp.fare_policy_inter_city_details_pricing_slabs
ADD PRIMARY KEY (fare_policy_id, time_percentage, distance_percentage);