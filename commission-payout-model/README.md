# Commission payout model

A tiered commission model built in SQL on labeled demo data. No real employer or client data is used anywhere in this project. Every rep, deal and amount is invented for demonstration.

## How the model pays

The model pays 5 percent on sales up to quota and 8 percent on sales above quota. Only closed won deals count toward sales. Cancelled and returned deals pay nothing and are excluded from sales totals.

## What is in this folder

commission_model.sql holds the tables, the demo deals and the payout query. Run the whole file in DB Browser for SQLite or any SQLite runner and the payout table is the result. sample_output.csv holds that result so a recruiter can see it without running anything.

## The demo data

Four reps and thirteen deals. Eleven deals are closed won, one is cancelled and one is returned. One closed won deal, D013 for Jordan Lee, is for zero dollars. It is kept in the data on purpose so the validation step can flag it. It adds nothing to sales or payout.

## Expected results

Taylor Brooks sold 63000 dollars against a 60000 dollar quota, 105 percent of quota, payout 3240 dollars. Alex Rivera sold 55000 dollars against a 50000 dollar quota, 110 percent of quota, payout 2900 dollars. Sam Patel sold 38000 dollars against a 40000 dollar quota, 95 percent of quota, payout 1900 dollars. Jordan Lee sold 21000 dollars against a 50000 dollar quota, 42 percent of quota, payout 1050 dollars.

Total closed won sales are 177000 dollars. Total payout is 9090 dollars. Total quota across the four reps is 200000 dollars.

## How to check it

Run commission_model.sql and compare the payout table to sample_output.csv. Then run these three validation checks.

Count deals by status and confirm eleven closed won, one cancelled and one returned. Look for duplicate deal ids and confirm there are none. Look for deals with no matching rep and confirm there are none. Look for zero amount deals and confirm the only one is D013.

## What this shows

Tiered payout logic in SQL, cleaning of cancelled and returned deals before any math, quota attainment as a percent, and validation checks that catch a zero amount deal, a duplicate id and an unmatched rep before payout is calculated.
