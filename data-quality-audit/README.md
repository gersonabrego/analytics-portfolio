# Data quality audit

A data quality audit built in SQL on labeled demo data. No real employer or client data is used anywhere in this project. Every customer product rep and amount is invented for demonstration.

## What is in this folder

data_quality_audit.sql holds the tables the demo orders and the audit queries. Run the whole file in DB Browser for SQLite or any SQLite runner and the findings summary is the first result. sample_output.csv holds that result so a recruiter can see it without running anything.

## The demo data

21 sales orders for 20 distinct order ids. Three reps are listed and every order should name one of them. The valid regions are North South East and West.

## What the audit found

8 rows have at least one issue and 13 rows are clean. The issues are one duplicate order id on two rows, one missing customer, one negative quantity, one zero unit price, one invalid region, one invalid date and one order from a rep who is not listed. The total amount across all rows is 2160 dollars. The total amount across clean rows only is 1320 dollars. That gap is the point of the audit. A report built on all rows would overstate sales by 840 dollars.

## How to check it

Run data_quality_audit.sql and compare the findings summary to sample_output.csv. Then run the second query in the file to see the 8 flagged rows. Each flagged row has exactly one issue except the duplicate order which appears twice.

## What this shows

Duplicate detection, missing value checks, range checks on quantity and price, valid value checks on region and date, a lookup check against the reps list, and a clean versus all comparison that puts a dollar amount on bad data.
