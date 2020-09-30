/*Q2.3 including the final query on customer with the largest payment difference*/
WITH top10 AS (SELECT SUM(amount), customer_id
							FROM payment
							GROUP BY 2
							ORDER BY 1 DESC
							LIMIT 10),
		top10cust AS (SELECT top10.customer_id, c.first_name || ' ' || c.last_name AS full_name
							FROM top10
							JOIN customer c
							ON top10.customer_id = c.customer_id)
SELECT full_name, MAX(run_difference)
FROM (
			SELECT pay_mth, full_name, pay_amount,
			LEAD(pay_amount) OVER (PARTITION BY full_name) - pay_amount AS run_difference
      FROM (
						SELECT DATE_TRUNC('month', payment_date) AS pay_mth,
							     full_name,
						       COUNT(*) AS pay_countpermth,
						       SUM(amount) AS pay_amount
						FROM top10cust
						JOIN payment p
						ON top10cust.customer_id = p.customer_id
						WHERE DATE_PART('year', payment_date) = '2007'
						GROUP BY 1,2
						ORDER BY 2,1) sub
			) diff
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*Without the final query on max difference*/
WITH top10 AS (SELECT SUM(amount), customer_id
							FROM payment
							GROUP BY 2
							ORDER BY 1 DESC
							LIMIT 10),
		top10cust AS (SELECT top10.customer_id, c.first_name || ' ' || c.last_name AS full_name
							FROM top10
							JOIN customer c
							ON top10.customer_id = c.customer_id)

SELECT pay_mth, full_name, pay_amount,
		   LEAD(pay_amount) OVER (PARTITION BY full_name) - pay_amount AS run_difference
       FROM (
						SELECT DATE_TRUNC('month', payment_date) AS pay_mth,
							     full_name,
						       COUNT(*) AS pay_countpermth,
						       SUM(amount) AS pay_amount
						FROM top10cust
						JOIN payment p
						ON top10cust.customer_id = p.customer_id
						WHERE DATE_PART('year', payment_date) = '2007'
						GROUP BY 1,2
						ORDER BY 2,1
						) sub;
