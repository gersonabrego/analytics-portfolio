# Peak Hours SQL Analysis

## The question
Which hours of the day drive the most sales, and how should staffing follow the demand.

## The data
Public data from UCI Online Retail, a UK based online retailer, covering Dec 2010 to Dec 2011. The file holds 541,909 order lines. After removing cancelled orders, returns, and rows with no price, 530,104 lines remain, covering 19,960 distinct invoices and about 10.67 million dollars in sales. The per hour order counts add to 19,961 because one invoice has lines in two hours.

## The method
1. The hour is pulled from the order timestamp, and each line is valued as quantity times unit price.
2. Cancelled orders, returns, and zero price rows are removed first.
3. Sales and order counts are summed by hour, with each hour shown as a share of all sales.

## What I found
1. Sales concentrate hard in the daytime. The hours from 9 in the morning to 4 in the afternoon hold 90.71 percent of all sales.
2. The three busiest hours are 10 in the morning, noon, and 3 in the afternoon, together 39.79 percent of all sales.
3. Noon has the most orders at 3,220, while 10 in the morning has the most revenue at about 1.45 million dollars.
4. Mornings before 8 and evenings after 6 are quiet. The 6 in the morning hour holds a single order worth 4.25 dollars.

Sample output, top 8 hours by sales.

```
Hour  Orders  Sales         Share
10    2,361   1,446,742.70  13.56%
12    3,220   1,444,245.88  13.54%
15    2,336   1,352,972.18  12.68%
13    2,753   1,265,736.30  11.87%
11    2,396   1,239,954.44  11.62%
14    2,457   1,181,812.37  11.08%
9     1,484   990,267.82    9.28%
16    1,335   754,006.56    7.07%
```

## What I would do with it
Staff heaviest from 9 in the morning to 4 in the afternoon, with peak cover from 10 in the morning to 3 in the afternoon, and keep early mornings and evenings lean. This is the same logic I used in my own work, finding peak sales hours and setting rep hours at stores to match them.

## How to run it
1. Download [the Online Retail file](https://archive.ics.uci.edu/ml/machine-learning-databases/00352/Online%20Retail.xlsx) from the UCI Machine Learning Repository.
2. Open the file in Excel and save it as CSV.
3. Open DB Browser for SQLite, make a new database, and import the CSV into a table named online_retail.
4. Open peak_hours.sql in DB Browser and run it.

## Files
peak_hours.sql holds the full script, a view plus two queries. This README holds the question, the method, and the findings. No real employer or client data is used here. The data is public, and the analysis is my own.
