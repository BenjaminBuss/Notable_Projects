SELECT COUNT(*) AS count, contact_id
FROM (SELECT time_to_sec(timediff(released, datestamp)) AS call_length, callcenter, disposition, contact_id
	FROM call_log
	WHERE origin = 'in' AND callcenter = 'ShelfGenieCC' AND disposition <> 1
	HAVING(call_length > 120)) AS sub
GROUP BY contact_id
ORDER BY count DESC;
