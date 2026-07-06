/*
BI VIEWS
Project: Los Angeles Airbnb Market Analysis
*/

-- View 1 — Executive KPIs

CREATE OR REPLACE VIEW vw_kpi_summary AS

SELECT
    COUNT(*) AS total_listings,
    COUNT(DISTINCT host_id) AS total_hosts,
    SUM(number_of_reviews) AS total_reviews,
    ROUND(AVG(availability_365),0) AS avg_available_days
FROM listings;

-- View 2: Room type summary

CREATE OR REPLACE VIEW vw_room_type_summary AS

SELECT
    room_type,
    COUNT(*) AS total_listings,
    SUM(number_of_reviews) AS total_reviews,
    ROUND(AVG(availability_365),0) AS avg_available_days
FROM listings
GROUP BY room_type;


-- View 3: Neighbourhood summary

CREATE OR REPLACE VIEW vw_neighbourhood_summary AS

SELECT
    neighbourhood,
    COUNT(*) AS total_listings,
    COUNT(DISTINCT host_id) AS total_hosts,
    SUM(number_of_reviews) AS total_reviews,
    ROUND(
        SUM(number_of_reviews)::numeric /
        COUNT(*),
        2
    ) AS reviews_per_listing,
    ROUND(AVG(availability_365),0) AS avg_available_days
FROM listings
GROUP BY neighbourhood;

-- View 4 — Host Summary

CREATE OR REPLACE VIEW vw_host_summary AS

SELECT
    host_id,
    host_name,
    COUNT(*) AS total_listings,
    SUM(number_of_reviews) AS total_reviews,
    ROUND(AVG(availability_365),0) AS avg_available_days
FROM listings
GROUP BY host_id, host_name;

-- View 5 — Monthly Availability

CREATE OR REPLACE VIEW vw_monthly_availability AS

SELECT
    DATE_TRUNC('month',date)::date AS month,
    COUNT(*) AS total_calendar_days,
    SUM(CASE WHEN available THEN 1 ELSE 0 END) AS available_days,
    ROUND(
        SUM(CASE WHEN available THEN 1 ELSE 0 END)::numeric
        /
        COUNT(*) *100,
        2
    ) AS availability_rate_pct
FROM calendar
WHERE date >= '2026-01-01'
AND date < '2026-12-01'
GROUP BY DATE_TRUNC('month',date)::date
ORDER BY month;

-- View 6 — Yearly Review Trend

CREATE OR REPLACE VIEW vw_review_yearly_trend AS

SELECT
    EXTRACT(YEAR FROM date) AS review_year,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY review_year;

-- View 7 — Monthly Review Seasonality

CREATE OR REPLACE VIEW vw_review_month_seasonality AS

SELECT
    TRIM(TO_CHAR(date,'Month')) AS month,
    EXTRACT(MONTH FROM date) AS month_number,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY
    TRIM(TO_CHAR(date,'Month')),
    EXTRACT(MONTH FROM date)
ORDER BY month_number;

-- View 8 — Listing Map

CREATE OR REPLACE VIEW vw_listing_map AS

SELECT
    id AS listing_id,
    neighbourhood,
    latitude,
    longitude,
    room_type,
    host_name,
    availability_365,
    number_of_reviews
FROM listings;

