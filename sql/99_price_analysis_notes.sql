/*
Project: Los Angeles Airbnb Market Analysis
Pricing Data Quality Analysis

Purpose:
Investigate whether pricing data is usable for analysis.
The price column exists in listings.csv and calendar.csv,
but values appear to be missing for the Los Angeles dataset.
*/

-- Check total rows and non-null prices
SELECT
    COUNT(price) AS non_null_prices,
    COUNT(*) AS total_rows
FROM listings;

-- Check data type of price column
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'listings'
AND column_name = 'price';

-- Preview non-null price values
SELECT
    price
FROM listings
WHERE price IS NOT NULL
LIMIT 20;

-- Check calendar price completeness
SELECT
    COUNT(price) AS non_null_calendar_prices,
    COUNT(adjusted_price) AS non_null_adjusted_prices,
    COUNT(*) AS total_calendar_rows
FROM calendar;

-- ===============================================================
-- ===============================================================
/*
Conclusion:

Price columns exist in both listings and calendar tables,
but they contain no usable values for this Los Angeles dataset.

Therefore, pricing analysis is documented in SQL but excluded
from the final Tableau dashboard to avoid misleading insights.
*/

-- ===============================================================
-- ===============================================================

-- /*
-- Which neighborhoods have the highest average price?
-- */

-- SELECT
--     neighbourhood,
--     ROUND(AVG(price), 2) AS avg_price,
--     COUNT(*) AS listings
-- FROM listings
-- WHERE price IS NOT NULL
-- GROUP BY neighbourhood
-- HAVING COUNT(*) >= 20
-- ORDER BY avg_price DESC
-- LIMIT 15;

-- -- SELECT
-- --     COUNT(price) AS non_null_prices,
-- --     COUNT(*) AS total_rows
-- -- FROM listings;

-- -- SELECT
-- --     column_name,
-- --     data_type
-- -- FROM information_schema.columns
-- -- WHERE table_name = 'listings'
-- -- AND column_name = 'price';

-- -- SELECT
-- --     price
-- -- FROM listings
-- -- WHERE price IS NOT NULL
-- -- LIMIT 20;

-- /*
-- Price Analysis Note:

-- The summary listings.csv file contains a price column,
-- but the values are blank in this dataset.

-- */