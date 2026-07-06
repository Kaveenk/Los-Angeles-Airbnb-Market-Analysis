/*
REVIEWS ANALYSIS
Project: Los Angeles Airbnb Market Analysis
*/

/*
Goal:
Analyze guest review activity using the reviews table
to understand demand patterns over time and across
different neighbourhoods, room types, and hosts.
*/

SELECT * FROM reviews WHERE 1=0;


/*
Query 1: How have Airbnb reviews changed over time?

*/

SELECT
    DATE_TRUNC('year', r.date)::date AS review_year,
    COUNT(*) AS total_reviews
FROM reviews r
GROUP BY DATE_TRUNC('year', r.date)::date
ORDER BY review_year;

--  Clearner method
SELECT
    EXTRACT(YEAR FROM r.date) AS review_year,
    COUNT(*) AS total_reviews
FROM reviews r
GROUP BY EXTRACT(YEAR FROM r.date)
ORDER BY review_year;

/*
Business Insight:

Airbnb review activity in Los Angeles has grown steadily since 2009,
reflecting the platform's increasing popularity and market expansion.

Review volumes rose rapidly between 2015 and 2019 before declining
significantly in 2020 due to the COVID-19 pandemic and reduced travel demand.

From 2021 onward, review activity recovered strongly, with each year
surpassing the previous one. By 2025, the dataset records the highest
number of reviews, indicating continued growth in guest demand and
strong recovery of the Los Angeles short-term rental market.
*/


/*
Query 2:
How does review activity change by month?
*/

SELECT
    TO_CHAR(date, 'Month') AS month,
    EXTRACT(MONTH FROM date) AS month_number,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY
    TO_CHAR(date, 'Month'),
    EXTRACT(MONTH FROM date)
ORDER BY month_number;


--  Clearner method
SELECT
    TRIM(TO_CHAR(r.date, 'Month')) AS month,
    EXTRACT(MONTH FROM r.date) AS month_number,
    COUNT(*) AS total_reviews
FROM reviews r
GROUP BY
    TRIM(TO_CHAR(r.date, 'Month')),
    EXTRACT(MONTH FROM r.date)
ORDER BY month_number;



/*
Business Insight:

Review activity increases steadily from spring through summer,
peaking in August with over 181,000 reviews.

This suggests that guest demand is strongest during the summer
travel season. Review activity begins to decline after October,
with December and January recording the lowest review volumes.

These seasonal patterns can help hosts optimize pricing,
availability, and marketing strategies during peak demand periods.
*/


/*
Query 3: Query 3: Which neighbourhoods receive the most reviews?

*/

SELECT 
	l.neighbourhood,
	COUNT(*) AS total_reviews,
	COUNT(DISTINCT r.listing_id) AS reviewed_listings
FROM reviews r
JOIN listings l
	ON r.listing_id = l.id
GROUP BY l.neighbourhood
ORDER BY total_reviews DESC
LIMIT 15;

/*
Business Insight:

Long Beach received the highest number of guest reviews,
followed by Venice and Santa Monica.

These neighborhoods combine a large inventory of listings
with consistently high guest activity, indicating they are
among the strongest performing Airbnb markets in Los Angeles.

Comparing total reviews with reviewed listings also helps
identify neighborhoods where guest engagement is concentrated
across many properties rather than driven by only a few listings.
*/



/*
Query 4:Which neighborhoods receive the highest average reviews per listing?

*/

SELECT 
	l.neighbourhood,
	COUNT(*) AS total_reviews,
	COUNT(DISTINCT r.listing_id) AS reviewed_listings,
	ROUND(
		COUNT(*)::numeric /
		COUNT(DISTINCT r.listing_id),
		2
	) AS reviews_per_listing
FROM reviews r
JOIN listings l
	ON r.listing_id = l.id
GROUP BY l.neighbourhood
HAVING COUNT(DISTINCT r.listing_id) >= 100
ORDER BY reviews_per_listing DESC
LIMIT 15;

/*
Business Insight:

Topanga has the highest average number of reviews per listing,
followed by the Unincorporated Santa Monica Mountains and Hawthorne.

Unlike total review counts, reviews per listing measures guest
engagement at the property level, making comparisons more meaningful
across neighborhoods of different sizes.

This metric suggests that listings in these neighborhoods tend to
generate higher guest activity and may experience stronger occupancy
than neighborhoods with larger inventories.
*/



/*
Query 5: Which room types receive the highest average number of reviews per listing?

*/

SELECT 
	l.room_type,
	COUNT(*) AS total_reviews,
	COUNT(DISTINCT r.listing_id) AS reviewed_listings,
	ROUND(
		COUNT(*)::numeric /
		COUNT(DISTINCT r.listing_id),
		2
	) AS reviews_per_listing
FROM reviews r
JOIN listings l
ON r.listing_id = l.id
GROUP BY l.room_type
ORDER BY reviews_per_listing DESC;

/*
Business Insight:

Entire homes/apartments receive the highest average number of
reviews per listing, indicating stronger guest demand and
potentially higher occupancy compared to other room types.

Private rooms also perform well, while shared rooms and hotel
rooms receive considerably fewer reviews per listing.

These findings suggest that guests visiting Los Angeles prefer
entire properties over shared accommodations.
*/

