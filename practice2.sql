EX1:
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 =0
 
EX2:
SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION
 
EX3:
SELECT ROUND(AVG(Salary),0)-ROUND(AVG(REPLACE(Salary,0,'')))
FROM EMPLOYEES
 
EX4:
WITH CTE AS
(
SELECT 
SUM(CAST(ORDER_OCCURRENCES * ITEM_COUNT AS DECIMAL)) AS Total_items
,SUM(CAST(ORDER_OCCURRENCES AS DECIMAL)) AS Total_orders
FROM items_per_order
)
SELECT
ROUND((Total_items/Total_orders),1) AS MEAN
FROM CTE
 
EX5:
SELECT DISTINCT candidate_id
FROM candidates
WHERE SKILL IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(candidate_id)=3
 
EX6:
SELECT 
user_id
,MAX(DATE(POST_DATE))-MIN(DATE(POST_DATE)) AS DAY_BETWEEN
FROM posts
WHERE DATE_PART('year',POST_DATE) = 2021 
GROUP BY user_id
HAVING MAX(DATE(POST_DATE))-MIN(DATE(POST_DATE)) >0
 
EX7:
SELECT 
Card_name
,MAX(issued_amount) - MIN(issued_amount) AS Difference
FROM monthly_cards_issued
GROUP BY Card_name
ORDER BY MAX(issued_amount) - MIN(issued_amount) DESC
 
EX8:
SELECT Manufacturer
,COUNT(drug) AS drug_count
,ABS(SUM(total_sales - cogs)) AS Total_loss
FROM pharmacy_sales
WHERE total_sales - cogs <= 0
GROUP BY Manufacturer
ORDER BY Total_loss DESC
 
EX9:
SELECT *
FROM CINEMA
WHERE DESCRIPTION <> 'boring'
and id % 2 =1
Order by Rating desc
 
EX10:
SELECT Teacher_id
,count(distinct subject_id) as CNT
FROM Teacher
GROUP BY Teacher_id
 
EX11:
SELECT user_id
,count(follower_id) as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id
 
EX12:
SELECT CLASS
FROM COURSES
GROUP BY CLASS
HAVING COUNT(STUDENT) >=5
