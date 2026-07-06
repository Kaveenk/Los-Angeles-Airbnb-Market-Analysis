/*
CREATE TABLES
Project: Los Angeles Airbnb Market Analysis
*/

-- Create listings table

CREATE TABLE listings (
    id BIGINT,
    name TEXT,
    host_id BIGINT,
    host_profile_id BIGINT,
    host_name TEXT,
    neighbourhood_group TEXT,
    neighbourhood TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    room_type TEXT,
    price TEXT,
    minimum_nights INTEGER,
    number_of_reviews INTEGER,
    last_review DATE,
    reviews_per_month NUMERIC,
    calculated_host_listings_count INTEGER,
    availability_365 INTEGER,
    number_of_reviews_ltm INTEGER,
    license TEXT
);



-- Create calendar table

CREATE TABLE calendar (
    listing_id BIGINT,
    date DATE,
    available BOOLEAN,
    price TEXT,
    adjusted_price TEXT,
    minimum_nights INTEGER,
    maximum_nights INTEGER
);



-- Create reviews table

CREATE TABLE reviews (
	listing_id BIGINT,
	date DATE
);
