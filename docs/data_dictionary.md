# Data Dictionary

## Overview

This project uses three primary tables from the Inside Airbnb Los Angeles dataset:

- `listings` — listing, host, location, review, and availability information
- `calendar` — daily availability and pricing information for individual listings
- `reviews` — historical review dates associated with listings

---

## 1. Listings Table

The `listings` table contains one record per Airbnb listing and provides the primary information used for market, neighborhood, host, and listing-level analysis.

| Column | Data Type | Description |
|---|---|---|
| `id` | BIGINT | Unique identifier for an Airbnb listing |
| `name` | TEXT | Name or title of the listing |
| `host_id` | BIGINT | Unique identifier for the host |
| `host_profile_id` | BIGINT | Host profile identifier included in the source data |
| `host_name` | TEXT | Display name of the host |
| `neighbourhood_group` | TEXT | Higher-level geographic grouping where available |
| `neighbourhood` | TEXT | Neighborhood associated with the listing |
| `latitude` | NUMERIC | Geographic latitude of the listing |
| `longitude` | NUMERIC | Geographic longitude of the listing |
| `room_type` | TEXT | Airbnb room category, such as entire home/apartment, private room, shared room, or hotel room |
| `price` | TEXT | Listing price as provided in the source dataset |
| `minimum_nights` | INTEGER | Minimum number of nights required for a booking |
| `number_of_reviews` | INTEGER | Total number of reviews recorded for the listing |
| `last_review` | DATE | Date of the most recent review associated with the listing |
| `reviews_per_month` | NUMERIC | Average number of reviews received per month |
| `calculated_host_listings_count` | INTEGER | Number of listings associated with the host as calculated by Inside Airbnb |
| `availability_365` | INTEGER | Number of days the listing is available within the next 365 days |
| `number_of_reviews_ltm` | INTEGER | Number of reviews received during the last twelve months |
| `license` | TEXT | License or registration information reported for the listing |

---

## 2. Calendar Table

The `calendar` table contains listing-level daily availability and pricing information.

| Column | Data Type | Description |
|---|---|---|
| `listing_id` | BIGINT | Identifier linking the calendar record to an Airbnb listing |
| `date` | DATE | Calendar date represented by the record |
| `available` | BOOLEAN | Indicates whether the listing is available on the specified date |
| `price` | TEXT | Listed price for the specified date as provided by the source |
| `adjusted_price` | TEXT | Adjusted daily price where supplied by the source |
| `minimum_nights` | INTEGER | Minimum-night requirement for the specified calendar date |
| `maximum_nights` | INTEGER | Maximum-night requirement for the specified calendar date |

---

## 3. Reviews Table

The `reviews` table contains historical review activity at the listing level.

| Column | Data Type | Description |
|---|---|---|
| `listing_id` | BIGINT | Identifier linking the review to an Airbnb listing |
| `date` | DATE | Date on which the review was recorded |

---

## Table Relationships

The three tables are connected through the Airbnb listing identifier.

- `listings.id` → `calendar.listing_id`
- `listings.id` → `reviews.listing_id`

The `listings` table acts as the primary listing-level dataset, while `calendar` and `reviews` contain multiple records for an individual listing.

Conceptually, the relationships are:

`listings` **1 → many** `calendar`

`listings` **1 → many** `reviews`

---

## Data Type Notes

Some price fields are stored as `TEXT` rather than numeric values because the source data may contain currency symbols and formatting characters. Price-related analysis therefore requires cleaning and conversion before numerical calculations can be performed.

The current project focuses primarily on market size, neighborhoods, hosts, reviews, and availability. Detailed price analysis is documented separately as a potential extension of the project.