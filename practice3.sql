EX1:
SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID
 
EX2:
SELECT
USER_ID
,CONCAT(UPPER(LEFT(NAME,1)),LOWER(SUBSTRING(NAME,2))) AS Name
FROM USERS
 
EX3:
SELECT 
manufacturer
,CONCAT('$',ROUND(SUM(total_sales)/1000000),' million') AS SALES_MIL
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer
 
EX4:
SELECT
EXTRACT(MONTH FROM SUBMIT_DATE) as mth
,product_id AS PRODUCT
,round(AVG(STARS),2) AS avg_stars
FROM reviews
group by EXTRACT(MONTH FROM SUBMIT_DATE), product_id
ORDER BY MTH, product_id
 
EX5:
SELECT
sender_id
,COUNT(message_id) as count_message
FROM messages
WHERE EXTRACT(month from sent_date) =8
AND EXTRACT(YEAR from sent_date)=2022
GROUP BY sender_id
ORDER BY count_message DESC
LIMIT 2
 
EX6:
SELECT tweet_id
FROM Tweets
WHERE LENGTH(CONTENT)>15
 
EX7:
SELECT
activity_date as day
, COUNT(DISTINCT user_id) as active_users
FROM Activity
WHERE activity_date > "2019-06-27" AND activity_date <= "2019-07-27"
GROUP BY activity_date
 
EX8:
select
count(id) as numer_employee
from employees
where extract(month from joining_date)  between 1 and 7
and extract(year from joining_date) = 2022
 
EX9:
select
Position('a' in first_name) as Position
from worker
where first_name = 'Amitah'
 
EX10:
select
Substring(title,length(winery)+2,4)
from winemag_p2
where country = 'Macedonia'
