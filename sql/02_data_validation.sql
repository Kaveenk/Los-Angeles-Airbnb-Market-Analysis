/*
DATA VALIDATION
Project: Los Angeles Airbnb Market Analysis
*/

-- =========================
-- Listings table validation
-- =========================

-- Count total rows in listings table
SELECT COUNT(*)
FROM listings;

-- 45585

-- Preview first 10 rows
SELECT *
FROM listings
LIMIT 10;

-- Check room types
SELECT DISTINCT room_type
FROM listings;

-- Count distinct hosts
SELECT COUNT(DISTINCT host_id)
FROM listings;

-- =========================
-- Calendar table validation
-- =========================

-- Count total number of rows
SELECT COUNT(*)
FROM calendar;
-- 16,638,552

-- Check unique listings
SELECT COUNT(DISTINCT listing_id)
FROM calendar;

-- This is the same as listing table column number
-- 45,585

SELECT
	MIN(date) AS start_date,
	MAX(date) AS end_date
FROM calendar;
-- This wil shows the bookings from december 2025-12-04 to 2026-12-10

SELECT
	available,
	COUNT(*)
	FROM calendar
GROUP BY available;

-- =========================
-- Reviews table validation
-- =========================

SELECT COUNT(*)
FROM reviews;
-- Total rewiews = 1,785,848

SELECT COUNT(DISTINCT listing_id)
FROM reviews;
-- 33375

SELECT 
	MIN(date) AS first_review_date,
	MAX(date) AS latest_review_date
FROM reviews;
-- 2009-05-26
-- 2025-12-09

SELECT * 
FROM reviews
LIMIT 10;

