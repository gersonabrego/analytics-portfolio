# Data quality agent

A first AI agent you can build and run for a week, using public data only. No company data is used anywhere in this piece.

## The data

The UCI Online Retail file, a UK online retailer covering 1 Dec 2010 to 9 Dec 2011. It holds 541909 rows. The same file already powers the peak hours piece in this portfolio, so you are not starting from scratch.

After cleaning, 530104 lines remain and total sales are 10666684.54 in the currency recorded in the source file. Cleaning removes lines with a negative quantity, which are cancellations, and lines with a zero price, which carry no sales value.

## The goal

Watch incoming sales lines and flag records that look wrong, then draft the issue list for a human to review. The agent finds candidates. You decide what is real.

## The checks

1 Duplicate invoice and stock code pairs
2 Missing CustomerID
3 Negative quantity
4 Zero unit price
5 Invoice date outside 1 Dec 2010 to 9 Dec 2011
6 Quantity far above the usual range, for review only, never auto removed

## The boundaries

The agent has read only access to a copy of the public file. It cannot change any record. It cannot send anything to a team. It drafts the issue list and stops. You approve every flag before it counts.

## How to set it up

Pick one tool you already have. ChatGPT, Claude, or Copilot all work for this, and the free versions are enough to learn on.

Step 1 Open a new chat in your chosen tool and paste the prompt below.
Step 2 Paste a small sample from the file, 50 lines at most, never the whole file.
Step 3 Read the flags it returns and check each one against the source lines.
Step 4 Correct any flag that is wrong and tell the tool what it got wrong.
Step 5 Save the corrected prompt. That saved prompt is your reusable agent.

## The prompt to paste

You are a data quality agent. Your job is to watch sales lines and flag records that look wrong. Check for duplicate invoice and stock code pairs, missing CustomerID, negative quantity, zero unit price, and invoice dates outside 1 Dec 2010 to 9 Dec 2011. Group every flag by issue type and give the invoice number and the reason for each flag. Do not change any record. Do not guess. If you are unsure about a line, say so and leave it for me to review. End with a short count of clean lines and flagged lines.

## The daily check

Run it once a day for seven days on a fresh 50 line sample. Each run should take about five minutes.

Day 1 Note how many flags it found and how many were real.
Day 2 Correct any repeat mistake in the prompt.
Day 3 Check whether the same issue types appear again.
Day 4 Note one flag you caught that the agent missed, if any.
Day 5 Note one flag the agent raised that was wrong, if any.
Day 6 Run it without changing the prompt and record the result.
Day 7 Decide whether the flags are steady enough to trust for a first pass.

Keep a short log for each day with the date, the sample size, the flags found, the flags confirmed real, and one line on what you corrected. After seven days you have proof you built and managed it, not just a claim.

## The resume line, only after seven days

Built and manage a data quality agent on public retail data that flags duplicate, missing, and invalid sales records for human review.

Do not use that line before the seven day run is done. Before then the honest line is the one already on your resume, AI workflows for flagging data quality issues and drafting summaries with output validation.

## What this proves

Goal setting, tool limits, human review, feedback, and steady improvement over a week. That is managing an AI agent, in the same shape the IHG posting asks for, built on data you can show in an interview.
