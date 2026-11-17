# Dashboard Sample

## The question
How is the business performing, and where is the revenue coming from

## The data
Public data from UCI Online Retail, a UK based online retailer, covering Dec 2010 to Dec 2011. Download [the Online Retail file](https://archive.ics.uci.edu/ml/machine-learning-databases/00352/Online%20Retail.xlsx) from the UCI Machine Learning Repository. The file holds 541,909 order lines. After cleaning, 530,104 lines remain, covering 19,960 distinct invoices and about 10.67 million dollars in sales. Cleaning removes lines with a negative quantity, which are cancellations, and lines with a zero price, which carry no sales value. No real employer or client data is used here. The data is public, and the analysis is my own.

## The method
1. Each line is valued as quantity times unit price.
2. Cancelled orders, returns, and zero price rows are removed first.
3. Revenue and order counts are summed by month, and the top products, top customers, and revenue by country are ranked from the same cleaned data.

## What I found
1. Total revenue is 10,666,684.54 dollars across 19,960 orders, an average order value of 534.40 dollars.
2. Revenue peaks late in the year. Nov 2011 is the strongest month at 1,509,496.33 dollars, 14.2 percent of the full year. Sep 2011 and Oct 2011 are the next strongest. Dec 2011 looks low only because the data ends on 9 Dec 2011.
3. The United Kingdom drives 84.6 percent of revenue. The next largest country is the Netherlands at 285,446.34 dollars.
4. The top product by revenue is DOTCOM POSTAGE at 206,248.77 dollars, which is a shipping charge. The top product for sale is REGENCY CAKESTAND 3 TIER at 174,484.74 dollars.
5. The top customer is 14646 at 280,206.02 dollars. The top 10 customers together drive 14.4 percent of revenue.

## Takeaway
Revenue is highly concentrated. The United Kingdom drives 84.6 percent of revenue, and the top 10 customers drive 14.4 percent. Protect the United Kingdom base and the top 10 customers first, and plan inventory and staffing for the Sep to Nov peak, since that is when demand is highest.

## How to view it
Open index.html in a browser. The file is self contained, with inline CSS and inline SVG charts and no external dependencies. It shows the KPI cards, the monthly revenue trend, the top 10 products, the top 10 customers, and revenue by country.

## Files
index.html holds the full dashboard. This README holds the question, the method, and the findings.
