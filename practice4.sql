--EX1:
SELECT
COUNT(CASE 
  WHEN device_type = 'laptop' THEN 'laptop'
END) AS laptop_reviews,
COUNT(CASE 
  WHEN device_type IN ('tablet', 'phone') THEN 'mobile'
END) AS mobile_reviews
FROM viewership;
--EX2:
SELECT *,
CASE
    WHEN abs(x-y)<z and z<x+y THEN 'Yes'
    ELSE 'No'
END triangle
FROM Triangle
--EX3:
SELECT
    ROUND(SUM(CASE 
      WHEN call_category IS NULL THEN 1 
      WHEN call_category = 'n/a' THEN 1
      ELSE 0
    END) * 100.0 / COUNT(case_id), 1) AS call_percentage
FROM callers
--EX4:
SELECT NAME
FROM CUSTOMER
WHERE NOT REFEREE_ID = 2 OR REFEREE_ID IS NULL
--EX5:
select
survived,
sum(case when pclass = 1 then 1 else 0 end) as first_class,
sum(case when pclass = 2 then 1 else 0 end) as second_class,
sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived
