EX1:
WITH job_count_cte
AS
(SELECT company_id, title, description
,COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count>1
 
EX2:
WITH total_spend_cte
AS
(SELECT category
, product
,SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT (YEAR FROM transaction_date) = 2022
GROUP BY category, product)
(SELECT category
, product
,total_spend
FROM total_spend_cte
WHERE category = 'appliance'
ORDER BY total_spend DESC
LIMIT 2)
UNION ALL
(SELECT category
, product
,total_spend
FROM total_spend_cte
WHERE category = 'electronics'
ORDER BY total_spend DESC
LIMIT 2)
 
EX3:
WITH TMP
AS(
SELECT policy_holder_id
,COUNT(case_id) AS count_call
FROM callers
GROUP BY policy_holder_id)
SELECT COUNT(policy_holder_id) AS member_count
FROM TMP
WHERE count_call >=3
 
EX4:
SELECT a.page_id 
FROM pages A
LEFT JOIN page_likes B
ON a.page_id = b.page_id
WHERE B.liked_date is NULL
ORDER BY a.page_id
 
EX5:
SELECT 
    EXTRACT(MONTH FROM event_date) AS month
    ,COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE 
    EXTRACT(MONTH FROM event_date) = 7
    AND user_id IN (
        SELECT user_id
        FROM user_actions
        WHERE EXTRACT(MONTH FROM event_date) = 6
    )
GROUP BY
      month
 
EX6:
SELECT
    LEFT(trans_date,7) AS month
    ,country
    ,COUNT(trans_date) AS trans_count
    ,SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count
    ,SUM(amount) AS trans_total_amount
    ,SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY
    month
    ,country
 
EX7:
SELECT
    product_id
    ,year as first_year
    ,quantity
    ,price
FROM sales
WHERE
    (product_id, year) IN (
    SELECT
        product_id,
        MIN(year)
        FROM sales
        GROUP BY product_id
    )
 
EX8:
SELECT
    customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product)
 
EX9:
SELECT
    employee_id
FROM Employees
WHERE salary <30000
AND manager_id NOT IN (SELECT employee_id FROM Employees)
 
EX10: trùng Link với EX1
 
EX11:
(SELECT B.name AS results
FROM movieRating A
LEFT JOIN users B ON B.user_id = A.user_id
GROUP BY A.user_id
ORDER BY COUNT(rating) DESC, B.name ASC
LIMIT 1)
 
UNION
 
(SELECT C.title AS results
FROM movieRating A
LEFT JOIN movies C ON C.movie_id  = A.movie_id
WHERE LEFT(A.created_at,7)='2020-02'
GROUP BY C.title
ORDER BY AVG(RATING) DESC, C.title ASC
LIMIT 1)
 
EX12:
SELECT tmp.id, COUNT(*) AS num
FROM (SELECT requester_id AS id FROM RequestAccepted
UNION ALL
SELECT accepter_id AS id FROM RequestAccepted
) AS tmp
GROUP BY tmp.id
ORDER BY num DESC
LIMIT 1
