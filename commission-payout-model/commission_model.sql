-- Commission payout model, demo data only
-- No real employer or client data is used anywhere in this project.
-- Every rep, deal and amount below is invented for demonstration.
-- The model pays 5 percent on sales up to quota and 8 percent above quota.
-- Cancelled and returned deals pay nothing and are excluded from sales totals.

DROP TABLE IF EXISTS reps;
DROP TABLE IF EXISTS deals;

CREATE TABLE reps (
  rep_name TEXT,
  quota_amount REAL
);

CREATE TABLE deals (
  deal_id TEXT,
  rep_name TEXT,
  sale_amount REAL,
  sale_date TEXT,
  status TEXT
);

INSERT INTO reps VALUES ('Alex Rivera', 50000);
INSERT INTO reps VALUES ('Jordan Lee', 50000);
INSERT INTO reps VALUES ('Sam Patel', 40000);
INSERT INTO reps VALUES ('Taylor Brooks', 60000);

INSERT INTO deals VALUES ('D001', 'Alex Rivera', 18000, '2026-01-05', 'closed won');
INSERT INTO deals VALUES ('D002', 'Alex Rivera', 22000, '2026-01-12', 'closed won');
INSERT INTO deals VALUES ('D003', 'Alex Rivera', 15000, '2026-01-20', 'closed won');
INSERT INTO deals VALUES ('D004', 'Alex Rivera', 5000, '2026-01-22', 'cancelled');
INSERT INTO deals VALUES ('D005', 'Jordan Lee', 12000, '2026-01-08', 'closed won');
INSERT INTO deals VALUES ('D006', 'Jordan Lee', 9000, '2026-01-18', 'closed won');
INSERT INTO deals VALUES ('D007', 'Sam Patel', 20000, '2026-01-10', 'closed won');
INSERT INTO deals VALUES ('D008', 'Sam Patel', 18000, '2026-01-25', 'closed won');
INSERT INTO deals VALUES ('D009', 'Taylor Brooks', 25000, '2026-01-06', 'closed won');
INSERT INTO deals VALUES ('D010', 'Taylor Brooks', 20000, '2026-01-15', 'closed won');
INSERT INTO deals VALUES ('D011', 'Taylor Brooks', 18000, '2026-01-28', 'closed won');
INSERT INTO deals VALUES ('D012', 'Taylor Brooks', 7000, '2026-01-29', 'returned');
INSERT INTO deals VALUES ('D013', 'Jordan Lee', 0, '2026-01-30', 'closed won');

-- Payout by rep. Only closed won deals count toward sales.
-- A zero amount closed won deal is kept in the count so it can be spotted in validation.
SELECT
  r.rep_name AS rep,
  r.quota_amount AS quota,
  COALESCE(SUM(CASE WHEN d.status = 'closed won' THEN d.sale_amount ELSE 0 END), 0) AS sales,
  COUNT(CASE WHEN d.status = 'closed won' THEN 1 END) AS closed_deals,
  ROUND(COALESCE(SUM(CASE WHEN d.status = 'closed won' THEN d.sale_amount ELSE 0 END), 0) * 100.0 / r.quota_amount, 1) AS quota_pct,
  ROUND(
    MIN(COALESCE(SUM(CASE WHEN d.status = 'closed won' THEN d.sale_amount ELSE 0 END), 0), r.quota_amount) * 0.05
    + MAX(COALESCE(SUM(CASE WHEN d.status = 'closed won' THEN d.sale_amount ELSE 0 END), 0) - r.quota_amount, 0) * 0.08
  , 2) AS payout
FROM reps r
LEFT JOIN deals d ON d.rep_name = r.rep_name
GROUP BY r.rep_name, r.quota_amount
ORDER BY payout DESC;
