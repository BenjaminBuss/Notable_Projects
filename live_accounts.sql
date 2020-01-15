SELECT COUNT(DISTINCT pro_id) AS live_accounts, SUM(total) AS billables, year, month 
FROM billing_invoices 
WHERE year > 2016 AND brand_id <> 27
GROUP BY month, year 
ORDER BY year ASC, month ASC