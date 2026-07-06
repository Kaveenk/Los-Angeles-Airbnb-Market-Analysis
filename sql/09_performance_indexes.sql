/*
PERFORMANCE INDEXES
Project: Los Angeles Airbnb Market Analysis
*/

/*
Purpose:
Improve join and aggregation performance for larger tables.
*/
-- Index for listing-level analysis
CREATE INDEX idx_listings_id
ON listings(id);

-- Index for host-level analysis
CREATE INDEX idx_listings_host_id
ON listings(host_id);

-- Index for neighbourhood-level analysis
CREATE INDEX idx_listings_neighbourhood
ON listings(neighbourhood);

-- Index for room type analysis
CREATE INDEX idx_listings_room_type
ON listings(room_type);

-- Index for joining calendar to listings
CREATE INDEX idx_calendar_listing_id
ON calendar(listing_id);

-- Index for date-based calendar analysis
CREATE INDEX idx_calendar_date
ON calendar(date);

-- Index for joining reviews to listings
CREATE INDEX idx_reviews_listing_id
ON reviews(listing_id);

-- Index for date-based reviews analysis
CREATE INDEX idx_reviews_date
ON reviews(date);