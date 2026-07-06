/*
MARKET OVERVIEW
Project: Los Angeles Airbnb Market Analysis
*/

/*
Goal:
Understand the Los Angeles Airbnb market by analyzing:
1. Room type distribution
2. Neighborhood popularity
3. Host activity
4. Availability patterns
*/

-- Which room types are most common in Los Angeles?

-- Query 1: Room Type Distribution
SELECT
	room_type,
	COUNT(*) AS total_listings
FROM listings
GROUP BY room_type
ORDER BY total_listings DESC;


-- Which neighborhoods have the most Airbnb listings?

-- Query 2: Top 10 Neighborhoods
SELECT
	neighbourhood,
	COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 10;


/*
Query 3:
Which neighborhoods have the highest average availability?

Business Value:
Identify neighborhoods where hosts have the most open days during the year.
*/

-- Query 3: Average Availability by Neighborhood
SELECT
    neighbourhood,
    ROUND(AVG(availability_365),0) AS avg_available_days,
    COUNT(*) AS listings
FROM listings
GROUP BY neighbourhood
HAVING COUNT(*) >= 100
ORDER BY avg_available_days DESC, listings DESC
LIMIT 10;




	