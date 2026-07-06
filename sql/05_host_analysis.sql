/*
HOST ANALYSIS
Project: Los Angeles Airbnb Market Analysis
*/

/*
Query 1:
Which hosts manage the most Airbnb listings?
*/

SELECT
    host_id,
    host_name,
    COUNT(*) AS total_listings
FROM listings
GROUP BY host_id, host_name
ORDER BY total_listings DESC
LIMIT 20;

/*
Business Insight:

Blueground dominates the Los Angeles Airbnb market with
593 listings, significantly higher than any other host.

Several top hosts appear to be commercial operators
rather than individual homeowners, suggesting that
professional property managers play a major role in
the Los Angeles Airbnb ecosystem.
*/


/*
Query 2
How many hosts have more than 10 listings?
*/
SELECT
	COUNT(*) AS hosts_with_more_than_10_listings
FROM
(
SELECT
	host_id,
	COUNT(*) AS total_listings
FROM listings
GROUP BY host_id
HAVING COUNT(*) >10

) t;

-- More cleaner way
SELECT
    COUNT(*) AS hosts_with_more_than_10_listings
FROM
(
    SELECT
        host_id
    FROM listings
    GROUP BY host_id
    HAVING COUNT(*) > 10
) t;

-- ANOTHER WAY
-- Using CTE's

WITH host_counts AS
(

SELECT 
	host_id
	FROM listings
	GROUP BY host_id
	HAVING COUNT(*) >10

)
SELECT COUNT(*)
FROM host_counts;


/*
Business Insight:

423 hosts manage more than 10 Airbnb listings.

This suggests that a substantial portion of the Los Angeles
Airbnb market is operated by professional hosts and property
management companies rather than individual homeowners.
*/



/*
Query 3:
Which hosts have the highest average availability?
*/

SELECT
    host_name,
    ROUND(AVG(availability_365),0) AS avg_available_days,
    COUNT(*) AS listings
FROM listings
GROUP BY host_name
HAVING COUNT(*) >= 20
ORDER BY avg_available_days DESC, listings DESC
LIMIT 20;

/*
Business Insight:

Several hosts maintain availability close to
365 days per year, indicating either low occupancy,
newly listed properties, or hosts keeping inventory
continuously available for booking.

Filtering hosts with larger portfolios helps identify
commercial operators and provides more reliable
market-level insights.
*/


-- Include hosts market share