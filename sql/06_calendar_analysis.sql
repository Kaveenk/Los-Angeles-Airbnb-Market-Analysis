/*
CALENDAR ANALYSIS
Project: Los Angeles Airbnb Market Analysis
*/
/*
Goal:
Analyze listing availability patterns using the calendar table.
*/

-- Query 1:
-- What is the overall availability rate?

SELECT
    COUNT(*) AS total_calendar_days,
    SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END) AS available_days,
    SUM(CASE WHEN available = FALSE THEN 1 ELSE 0 END) AS unavailable_days,
    ROUND(
        SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS availability_rate_pct
FROM calendar;

/*
Business Insight:

Across all Los Angeles Airbnb listings, properties are
available for booking 58.69% of calendar days.

Approximately 41.31% of calendar days are unavailable,
which may indicate guest bookings, owner blocks, or
other host restrictions.

This suggests that a significant portion of Airbnb
inventory is actively utilized throughout the year.
*/


/*
Query 2:
How does availability change by month?
*/

SELECT
    DATE_TRUNC('month', date) AS month,
    COUNT(*) AS total_calendar_days,
    SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END) AS available_days,
    ROUND(
        SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS availability_rate_pct
FROM calendar
GROUP BY DATE_TRUNC('month', date)
ORDER BY month;


SELECT
    -- DATE_TRUNC('month', date) AS month,
	TO_CHAR(date, 'YYYY-MM') AS month,
    COUNT(*) AS total_calendar_days,
    SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END) AS available_days,
    ROUND(
        SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS availability_rate_pct
FROM calendar
-- GROUP BY DATE_TRUNC('month', date)
GROUP BY month
ORDER BY month;

-- SELECT
-- 	DATE_TRUNC('month', date)::date AS month,
--     COUNT(*) AS total_calendar_days,
--     SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END) AS available_days,
--     ROUND(
--         SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END)::numeric
--         / COUNT(*) * 100,
--         2
--     ) AS availability_rate_pct
-- FROM calendar
-- GROUP BY DATE_TRUNC('month', date)::date
-- ORDER BY month;




/*
Business Insight:

Availability peaks during the first half of 2026,
reaching its highest level in February (68.69%).

Availability gradually declines throughout the year,
falling below 50% from September onward.

This suggests stronger booking demand during the
second half of the year, as fewer calendar days
remain available for reservation.

The sharp decline toward year-end may indicate
seasonal demand patterns and holiday travel activity.
*/

/*
Query 3:
Which neighborhoods have the highest availability rate?
*/

-- To check the column names
SELECT * FROM calendar WHERE 1=0;
SELECT * FROM listings WHERE 1=0;

SELECT l.neighbourhood,
COUNT(*)AS total_calender_days,
COUNT(DISTINCT l.id) AS total_listings,
SUM(CASE WHEN c.available = TRUE THEN 1 ELSE 0 END) AS available_days,
ROUND(
(SUM(CASE WHEN c.available = TRUE THEN 1 ELSE 0 END):numeric
/ COUNT(*))*100,
2
) AS availability_rate_pct
FROM calendar c
JOIN listings l
ON c.listing_id = l.listing_id
GROUP BY neighbourh
	
