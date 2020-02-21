SELECT COUNT(*) 
FROM (SELECT user_id, COUNT(event_date_time) AS count_inserted 
  FROM event_log
  GROUP BY user_id) AS subquery
 WHERE count_insered BETWEEN(1000, 2000);
