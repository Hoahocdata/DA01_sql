EX1:
SELECT b.continent AS continent
, floor(avg(a.population)) as Avg_population
FROM City AS a
INNER JOIN Country AS b
ON a.countrycode=b.code
GROUP BY b.continent
 
EX2:
SELECT ROUND(CAST(COUNT(b.email_id) AS decimal)/COUNT(DISTINCT a.email_id),2) AS activation_rate
FROM emails AS a
LEFT JOIN texts AS b
ON a.email_id=b.email_id
AND b.signup_action = 'Confirmed'
 
EX3:
SELECT 
b.age_bucket AS age_bucket
,ROUND(SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) /SUM(a.time_spent)*100,2) AS send_perc
,ROUND(SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) /SUM(a.time_spent)*100,2) AS open_perc
FROM activities a
INNER JOIN age_breakdown b
ON a.user_id=b.user_id
WHERE a.activity_type IN ('send', 'open') 
GROUP BY b.age_bucket
 
EX4:
SELECT a.customer_id 
FROM customer_contracts AS a 
LEFT JOIN products AS b  
ON a.product_id = b.product_id
GROUP BY a.customer_id
HAVING COUNT(DISTINCT(b.product_category)) = (SELECT COUNT(DISTINCT product_category) FROM products)
 
EX5:
SELECT a.employee_id,a.name
,COUNT(b.reports_to) reports_count
,ROUND(AVG(b.age))average_age
FROM Employees a
JOIN Employees b
ON a.employee_id = b.reports_to
GROUP BY a.employee_id,a.name
ORDER BY a.employee_id
 
EX6:
SELECT a.product_name
,SUM(b.unit) Unit
FROM Products a
LEFT JOIN Orders b
ON a.product_id = b.product_id
WHERE b.order_date like '2020-02%'
GROUP BY a.product_name
HAVING SUM(b.unit)>=100
 
EX7:
SELECT a.page_id 
FROM pages A
LEFT JOIN page_likes B
ON a.page_id = b.page_id
WHERE B.liked_date is NULL
ORDER BY a.page_id
