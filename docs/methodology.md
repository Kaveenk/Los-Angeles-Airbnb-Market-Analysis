# Methodology

## Project Overview

This project analyzes the Los Angeles Airbnb market using publicly available data from Inside Airbnb.

The project follows an end-to-end analytics workflow:

**Raw Data → PostgreSQL → Data Validation → SQL Analysis → BI Views → Power BI Dashboard → Business Insights**

The analysis focuses on four main areas:

1. Market Overview
2. Neighborhood & Geographic Analysis
3. Reviews & Guest Engagement Analysis
4. Host & Availability Analysis

---

## 1. Data Source

The data used in this project was obtained from Inside Airbnb for the Los Angeles market.

Three source datasets were used:

- `listings.csv`
- `calendar.csv`
- `reviews.csv`

The raw source files were stored separately from analytical outputs so that the original data remained unchanged.

---

## 2. Database Setup

PostgreSQL was used as the primary database for storing, validating, and analyzing the Airbnb data.

Three main tables were created:

- `listings`
- `calendar`
- `reviews`

The table structures and data types were defined before importing the source CSV files.

The `listings` table serves as the primary listing-level dataset, while the `calendar` and `reviews` tables contain multiple records associated with individual listings.

The tables are connected using the listing identifier:

- `listings.id` → `calendar.listing_id`
- `listings.id` → `reviews.listing_id`

This creates one-to-many relationships between listings and their calendar and review records.

---

## 3. Data Validation

Data validation was performed after importing the source files and before beginning the analytical work.

The validation process included:

- Checking table row counts
- Reviewing column names and data types
- Checking key listing and host identifiers
- Identifying missing and NULL values
- Reviewing duplicate and inconsistent records where applicable
- Validating date fields and date ranges
- Checking relationships between listing IDs across tables
- Reviewing calendar availability values
- Examining review-date coverage
- Inspecting pricing fields for missing and inconsistent values

The purpose of this stage was to identify potential data-quality issues before creating analytical metrics and visualizations.

---

## 4. SQL Analysis

SQL was used to transform the source data into business-focused analytical outputs.

### Market Overview

The market-level analysis examined:

- Total number of listings
- Total number of unique hosts
- Total number of reviews
- Average available days
- Listings by room type
- Top neighborhoods by listing count
- Monthly availability trends

These metrics provide an overall view of the size and structure of the Los Angeles Airbnb market represented in the dataset.

### Neighborhood & Geographic Analysis

Neighborhood-level analysis examined:

- Total number of neighborhoods
- Neighborhoods with the largest number of listings
- Geographic distribution of Airbnb listings
- Distribution of room types across locations
- Neighborhoods with the highest total reviews
- Reviews per listing by neighborhood

For the reviews-per-listing analysis, a minimum listing threshold was applied to reduce the influence of neighborhoods with very small listing counts.

This provides a more meaningful comparison between established Airbnb markets.

### Reviews & Guest Engagement Analysis

Historical review data was analyzed as an indicator of guest engagement.

The analysis included:

- Total review activity
- Reviews by year
- Historical review trends
- Peak review year
- Total reviews during the peak year
- Reviews by month
- Peak review month

Review activity is treated as an engagement indicator rather than a direct measure of bookings or occupancy.

### Host & Availability Analysis

Host-level analysis examined:

- Hosts with the largest number of listings
- Top host by listing count
- Hosts with the highest total reviews
- Most reviewed host
- Host portfolio-size distribution
- Listing availability patterns

Host portfolio sizes were grouped into categories to distinguish individual hosts from hosts managing larger portfolios.

---

## 5. Pricing Analysis

Pricing fields were reviewed as part of the exploratory and data-validation process.

However, a reliable pricing analysis was not included in the final dashboard because the pricing data contained substantial missing (`NULL`) values.

Performing market-level pricing calculations using only the available price records could introduce bias and produce potentially misleading conclusions.

In addition, the imported price fields are stored as text and contain formatting that would require cleaning and conversion before numerical analysis.

Rather than presenting potentially unreliable pricing metrics, pricing analysis was excluded from the final analytical dashboard.

Notes related to this investigation are retained in:

`sql/99_price_analysis_notes.sql`

This decision reflects an analytical choice to prioritize data reliability over adding additional metrics.

---

## 6. BI Views

SQL views were created to prepare reporting-ready datasets for Power BI.

The BI views separate analytical logic from the visualization layer and provide reusable outputs for dashboard development.

This approach provides several benefits:

- Centralizes business logic in SQL
- Reduces transformation complexity inside Power BI
- Makes calculations easier to validate
- Improves consistency between SQL results and dashboard metrics
- Makes the analytical workflow easier to reproduce

The SQL logic used to create these reporting views is documented in:

`sql/08_bi_views.sql`

---

## 7. Power BI Dashboard

Power BI was used as the final reporting and visualization layer.

The report contains four analytical pages.

### Page 1 — Executive Overview

Provides a high-level summary of the Airbnb market, including:

- Total listings
- Total hosts
- Total reviews
- Average available days
- Listings by room type
- Top neighborhoods by listings
- Monthly availability trend

### Page 2 — Neighborhood & Geographic Analysis

Examines the geographic structure of the market through:

- Total neighborhoods
- Top neighborhood
- Top neighborhood listing count
- Geographic listing distribution
- Room-type distribution by location
- Top neighborhoods by total reviews
- Top neighborhoods by reviews per listing

### Page 3 — Reviews & Guest Engagement Analysis

Examines historical guest engagement through:

- Total reviews
- Peak review year
- Peak-year review volume
- Peak review month
- Yearly review trend
- Monthly review trend

### Page 4 — Host & Availability Analysis

Examines host concentration and portfolio structure through:

- Top host by listings
- Top host listing count
- Most reviewed host
- Highest host review count
- Top hosts by listings
- Top hosts by total reviews
- Host portfolio-size distribution

---

## 8. Dashboard Design Approach

A consistent visual design was applied across all four Power BI pages.

The report uses:

- Consistent page headers
- Standardized KPI cards
- Consistent typography
- Repeated color conventions
- Bar charts for ranked comparisons
- Line charts for time-series analysis
- Geographic mapping for location analysis
- Data labels for important values
- Consistent spacing and visual hierarchy

The dashboard was designed to allow users to move from high-level market information to more detailed neighborhood, review, and host analysis.

---

## 9. Data Coverage

The database was examined to determine the actual date coverage of the calendar and review tables.

### Calendar Data

Calendar records range from:

**December 4, 2025 to December 10, 2026**

### Review Data

Historical review records range from:

**May 26, 2009 to December 9, 2025**

These dates describe the coverage found within the respective tables.

They should not automatically be interpreted as the publication date, download date, or official snapshot date of the Inside Airbnb dataset.

---

## 10. Limitations

Several limitations should be considered when interpreting the analysis:

- Airbnb availability does not necessarily represent actual occupancy or confirmed bookings.
- Review counts are used as an indicator of guest engagement but do not represent actual booking volume.
- A guest may complete a stay without leaving a review, so review activity should not be interpreted as total demand.
- Calendar data includes future availability dates and therefore should not be interpreted as historical occupancy.
- Listings and host information may change over time.
- The analysis reflects the records available within the source datasets used for this project.
- Reliable pricing analysis could not be performed because the pricing fields contain substantial missing (`NULL`) values. Calculating market-level pricing metrics from only the available records could produce incomplete or misleading results.
- Price fields were imported as text and would require additional cleaning and conversion before numerical analysis.
- Neighborhoods vary significantly in listing count. For selected neighborhood comparisons, minimum listing thresholds were therefore applied to reduce the influence of very small markets.
- Review activity may be influenced by how long a listing has been active, so high cumulative review counts do not necessarily indicate stronger current performance.

---

## 11. Tools Used

- **PostgreSQL** — relational database storage and management
- **SQL** — data validation, transformation, aggregation, analysis, and BI view creation
- **pgAdmin** — PostgreSQL administration and query development
- **Power BI** — dashboard development and data visualization
- **Git** — version control
- **GitHub** — project hosting and portfolio documentation

---

## 12. Analytical Workflow

The project was designed to demonstrate the complete analytics process rather than dashboard creation alone.

The workflow follows:

**Business Questions → Raw Data → Database Design → Data Validation → SQL Analysis → BI Views → Power BI Visualization → Business Insights**

This approach ensures that the metrics presented in the dashboard are supported by documented and reproducible SQL logic.

Where the available data was not considered reliable enough to support an analysis, such as pricing, the limitation was documented rather than presenting potentially misleading results.