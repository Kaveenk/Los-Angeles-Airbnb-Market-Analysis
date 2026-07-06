/*
NEIGHBOURHOOD ANALYSIS
Project: Los Angeles Airbnb Market Analysis
*/

/*
Query 1:
Which neighborhoods have the most listings?
*/

SELECT
    neighbourhood,
    COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 15;

/*
Business Insight:

Long Beach, Hollywood, and Venice contain the largest
concentrations of Airbnb listings in the Los Angeles market.

Beach communities and entertainment districts dominate
the short-term rental landscape, indicating strong demand
from tourists and travelers seeking access to major
attractions and coastal areas.
*/


/*
Query 2:
What percentage of total listings does each neighborhood represent?
*/

SELECT
    neighbourhood,
    COUNT(*) AS total_listings,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM listings),
        2
    ) AS market_share_pct
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 15;

/*
Business Insight:

Long Beach alone accounts for 4.18% of all Airbnb listings.

The top five neighborhoods contribute nearly 17% of
the Los Angeles Airbnb inventory, indicating that
short-term rental activity is concentrated in a small
number of highly desirable tourist and coastal markets.
*/

/*
Query 3:
Which neighborhoods have the highest average price?
*/

SELECT
    neighbourhood,
    ROUND(AVG(price), 2) AS avg_price,
    COUNT(*) AS listings
FROM listings
WHERE price IS NOT NULL
GROUP BY neighbourhood
HAVING COUNT(*) >= 20
ORDER BY avg_price DESC
LIMIT 15;

-- SELECT
--     COUNT(price) AS non_null_prices,
--     COUNT(*) AS total_rows
-- FROM listings;

-- SELECT
--     column_name,
--     data_type
-- FROM information_schema.columns
-- WHERE table_name = 'listings'
-- AND column_name = 'price';

-- SELECT
--     price
-- FROM listings
-- WHERE price IS NOT NULL
-- LIMIT 20;

/*
Price Analysis Note:

The summary listings.csv file contains a price column,
but the values are blank in this dataset.

*/

/*
Query 4:
Which neighborhoods have the most reviews?
*/

SELECT
    neighbourhood,
    SUM(number_of_reviews) AS total_reviews,
    COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_reviews DESC
LIMIT 15;

/*
Query 5:
Which neighborhoods generate the most reviews per listing?
*/

SELECT
    neighbourhood,
    SUM(number_of_reviews) AS total_reviews,
    COUNT(*) AS total_listings,
    ROUND(
        SUM(number_of_reviews)::numeric /
        COUNT(*),
        2
    ) AS reviews_per_listing
FROM listings
GROUP BY neighbourhood
HAVING COUNT(*) >= 100
ORDER BY reviews_per_listing DESC
LIMIT 15;

/*
Business Insight:

Neighborhoods such as Del Aire, Topanga, and Lennox
generate the highest number of reviews per listing.

This suggests higher guest engagement and potentially
stronger occupancy rates compared to larger markets
that have more total listings.

Reviews per listing provides a more balanced demand
metric than total review volume alone.
*/
