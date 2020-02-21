 # Attempting some queue analysis and datalinking in SQL instead of R
 # 3 main tables to join: acs_transactions, broadsoft_screenpops, call_log
 # Joining on broadsoft_callid, minute = minute, and minute = minute + 1
 # Additional joining criteria increases amount of data by 40% without sacrificing accuracy
 # Very very inefficient, can't run more than two days
 
 SET @var1 = '2020-01-07', @var2 = '2020-01-10';
 
SELECT DISTINCT call_time, call_id, user_id, acs_transaction_id, screenpop_id, a.contact_id, a.brand_id, a.pro_id, disposition, action_order AS call_action
FROM (SELECT DISTINCT call_id, user_id, acs_transaction_id, c.datestamp AS call_time, c.disposition, b.id AS contact_id, screenpop_id
	FROM call_log AS c
	INNER JOIN broadsoft_screenpops AS b
	ON b.phone = c.number AND DATE(b.datestamp) = DATE(c.datestamp) AND HOUR(b.datestamp) = HOUR(c.datestamp) AND minute(c.datestamp) = minute(b.datestamp) # 
	WHERE call_id NOT IN (SELECT call_id FROM call_log AS c
							INNER JOIN broadsoft_screenpops AS b
							ON c.broadsoft_callid = b.broadsoft_callid
							WHERE c.datestamp > @var1
								AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')
								AND origin = 'out')
		AND c.origin = 'out'
		AND c.datestamp > @var1
		AND b.datestamp > @var1
		AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')
	UNION
	SELECT DISTINCT call_id, user_id, acs_transaction_id, c.datestamp AS call_time, 
		c.disposition, b.id AS contact_id, screenpop_id
	FROM call_log AS c
	INNER JOIN broadsoft_screenpops AS b
	USING (broadsoft_callid) 
	WHERE c.origin = 'out'
		AND c.datestamp > @var1
		AND b.datestamp > @var1
		AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')
	UNION 
    SELECT DISTINCT call_id, user_id, acs_transaction_id, c.datestamp AS call_time, 
		c.disposition, b.id AS contact_id, screenpop_id
	FROM call_log AS c
	INNER JOIN broadsoft_screenpops AS b
	ON b.phone = c.number AND DATE(b.datestamp) = DATE(c.datestamp) AND  HOUR(b.datestamp) = HOUR(c.datestamp) AND minute(ADDTIME(c.datestamp, '00:01:00')) = minute(b.datestamp) #HOUR(b.datestamp) = HOUR(c.datestamp) AND 
	WHERE call_id NOT IN (SELECT call_id FROM call_log AS c
							INNER JOIN broadsoft_screenpops AS b
							ON c.broadsoft_callid = b.broadsoft_callid
							WHERE c.datestamp > @var1
								AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')
								AND origin = 'out')
		AND c.origin = 'out'
		AND c.datestamp > @var1
		AND b.datestamp > @var1
		AND callcenter NOT IN('FSPaintingCC', 'BathSolutionsCC', 'AdvantaCC', '')) AS subquery
INNER JOIN (SELECT id, contact_id, brand_id, acs_event_id, pro_id, date_completed 
			FROM acs_transactions 
            WHERE transaction_status = 'completed'
            AND date_completed > @var1) AS a
ON a.id = subquery.acs_transaction_id AND a.contact_id = subquery.contact_id
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
ON a.acs_event_id = call_order.acs_event_id AND a.brand_id = call_order.brand_id;
