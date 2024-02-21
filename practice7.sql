EX1:
SELECT 
    EXTRACT (YEAR FROM transaction_date) AS yr
    ,product_id
    ,spend AS curr_year_spend
    ,LAG(spend) OVER(PARTITION BY product_id ORDER BY transaction_date) AS prev_year_spend
    ,ROUND(((spend-LAG(spend) OVER(PARTITION BY product_id ORDER BY transaction_date))
    /LAG(spend) OVER(PARTITION BY product_id ORDER BY transaction_date)*100),2) AS yoy_rate
FROM user_transactions
 
EX2:
SELECT DISTINCT card_name,
  FIRST_VALUE(sum(issued_amount)) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS issued_amount
FROM monthly_cards_issued
GROUP BY card_name, issue_year, issue_month
ORDER BY issued_amount DESC
 
EX3:
SELECT user_id, spend, transaction_date
FROM 
(SELECT user_id, spend, transaction_date
,ROW_NUMBER()OVER(PARTITION BY user_id ORDER BY transaction_date) AS STT
FROM transactions) A
WHERE stt=3

EX4:
WITH Last_transaction
AS (
SELECT 
transaction_date,
user_id,
product_id,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank 
FROM user_transactions
)
SELECT
transaction_date
,user_id
,COUNT(product_id) AS purchase_count
FROM Last_transaction
WHERE transaction_rank =1
GROUP BY 
transaction_date
,user_id
 
EX5:
WITH CTE
AS(
SELECT
  user_id
  ,tweet_date
  ,tweet_count
  ,LAG(tweet_count,1)OVER(PARTITION BY user_id ORDER BY tweet_date) AS lag1
  ,LAG(tweet_count,2)OVER(PARTITION BY user_id ORDER BY tweet_date) AS lag2
FROM tweets
)
SELECT 
  user_id,
  tweet_date,
  CASE 
    WHEN lag1 IS NULL AND lag2 IS NULL THEN ROUND(tweet_count, 2)
    WHEN lag1 IS NULL THEN ROUND((lag2 + tweet_count) /2.0, 2)
    WHEN lag2 IS NULL THEN ROUND((lag1 + tweet_count) /2.0, 2)
    ELSE ROUND((lag1 + lag2 + tweet_count) /3.0, 2)
  END AS rolling_avg_3d
FROM CTE
 
EX6:
WITH CTE1
  AS
(  
SELECT 
  transaction_id
  ,merchant_id
  ,credit_card_id
  ,amount
  ,EXTRACT(EPOCH FROM transaction_timestamp - LAG(transaction_timestamp)OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp)
  )/60 AS minute_difference
FROM transactions
)
SELECT COUNT(*) AS payment_count
FROM CTE1
WHERE minute_difference <=10
 
EX7:
SELECT
category
, product
,total_spend
FROM
(SELECT
category
, product
,SUM(spend) AS total_spend
,RANK()OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS Ranking
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product) tmp
WHERE ranking < 3
 
EX8:
WITH CTE
AS (
SELECT
a.artist_name
,DENSE_RANK()OVER(ORDER BY COUNT(b.song_id)DESC) AS artist_rank
FROM artists AS a
JOIN songs AS b ON b.artist_id = a.artist_id
JOIN global_song_rank AS c ON c.song_id = b.song_id
WHERE C.RANK <=10
GROUP BY a.artist_name
)
SELECT artist_name, artist_rank
FROM CTE
WHERE artist_rank <=5
