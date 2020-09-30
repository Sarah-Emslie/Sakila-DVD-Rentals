/*Q2.1*/
SELECT DATE_PART('month', sub.rental_month) AS rental_month,
      sub.rental_year,
      i.store_id,
      COUNT(*) AS rental_count
  FROM (
        SELECT DATE_TRUNC('month', rental_date) AS rental_month,
              DATE_PART('year', rental_date) AS rental_year,
              inventory_id
        FROM rental
        ) sub
JOIN inventory i
ON sub.inventory_id = i.inventory_id
GROUP BY 1,2,3
ORDER BY 4 DESC
