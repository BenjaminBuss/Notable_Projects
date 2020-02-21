# Attempting some queue analysis and datalinking in SQL instead of R
 # 3 main tables to join: acs_transactopns, broadsoft_screenpop, call_log
 # Additional joining criteria increases amount of data by 66% without sacraficing accuracy
SELECT DISTINCT call_id, b.datestamp AS pop_time, phone, user_id, acs_transaction_id, c.datestamp AS call_time, 
	c.disposition, c.dialed, c.number , broadsoft_user, a.contact_id, a.brand_id, a.pro_id, action_order AS call_action
FROM call_log AS c
INNER JOIN broadsoft_screenpops AS b
ON b.phone = c.number AND DAY(b.datestamp) = DAY(c.datestamp) AND HOUR(b.datestamp) = HOUR(c.datestamp) AND minute(c.datestamp) = minute(b.datestamp)
INNER JOIN acs_transactions AS a
ON a.id = b.acs_transaction_id AND a.contact_id = b.id
INNER JOIN (SELECT id AS acs_event_id, brand_id,
				CASE WHEN action LIKE '%1%' THEN 1
					WHEN action LIKE '%2%' THEN 2
					WHEN action LIKE '%3%' THEN 3
					WHEN action LIKE '%4%' THEN 4
					WHEN action LIKE '%5%' THEN 5
					WHEN action LIKE '%6%' THEN 6
					WHEN action LIKE '%7%' THEN 7
					WHEN action LIKE '%8%' THEN 8
					WHEN action LIKE '%9%' THEN 9
					ELSE NULL
					END AS action_order
				FROM acs_events
				WHERE action_type = 'call' AND is_active = 1 AND lead_status_id <> 13) AS call_order 
ON a.acs_event_id = call_order.acs_event_id AND a.brand_id = call_order.brand_id
WHERE call_id NOT IN (SELECT call_id FROM call_log AS c
						INNER JOIN broadsoft_screenpops AS b
						ON c.broadsoft_callid = b.broadsoft_callid
						WHERE c.datestamp > '2020-01-01'
							AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')
							AND origin = 'out')
	AND c.origin = 'out'
    AND c.datestamp > '2020-01-01'
    AND b.datestamp > '2020-01-01'
    AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')
UNION
SELECT DISTINCT call_id, b.datestamp AS pop_time, phone, user_id, acs_transaction_id, c.datestamp AS call_time, 
	c.disposition, c.dialed, c.number , broadsoft_user, a.contact_id, a.brand_id, a.pro_id, action_order AS call_action
FROM call_log AS c
INNER JOIN broadsoft_screenpops AS b
ON c.broadsoft_callid = b.broadsoft_callid
INNER JOIN acs_transactions AS a
ON a.id = b.acs_transaction_id AND a.contact_id = b.id
INNER JOIN (SELECT id AS acs_event_id, brand_id, 
				CASE WHEN action LIKE '%1%' THEN 1
					WHEN action LIKE '%2%' THEN 2
					WHEN action LIKE '%3%' THEN 3
					WHEN action LIKE '%4%' THEN 4
					WHEN action LIKE '%5%' THEN 5
					WHEN action LIKE '%6%' THEN 6
					WHEN action LIKE '%7%' THEN 7
					WHEN action LIKE '%8%' THEN 8
					WHEN action LIKE '%9%' THEN 9
					ELSE NULL
					END AS action_order
				FROM acs_events
				WHERE action_type = 'call' AND is_active = 1 AND lead_status_id <> 13) AS call_order 
ON a.acs_event_id = call_order.acs_event_id AND a.brand_id = call_order.brand_id
WHERE c.origin = 'out'
    AND c.datestamp > '2020-01-01'
    AND b.datestamp > '2020-01-01'
    AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '');
