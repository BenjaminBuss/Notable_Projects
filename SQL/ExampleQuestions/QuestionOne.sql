SELECT SUM(sold_copies) AS books_sold_sum, a.author_name
FROM authors AS a
INNER JOIN books 
  USING(book_name) 
GROUP BY author_name
ORDER BY books_sold DESC
LIMIT 3;
