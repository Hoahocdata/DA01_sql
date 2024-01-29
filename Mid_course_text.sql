Question 1:
SELECT 
DISTINCT FILM_ID
,MIN (replacement_cost) MIN_replacement_cost
FROM FILM
GROUP BY FILM_ID
HAVING replacement_cost=(SELECT MIN (replacement_cost)
FROM FILM)
ORDER BY film_id
 
Question 2:
SELECT 
CASE 
  WHEN replacement_cost between 9.99  and 19.99 THEN 'Low'
  WHEN replacement_cost between 20.00 and 24.99 THEN 'Medium'
  ELSE 'High'
END category
,COUNT () as so_luong
FROM film
GROUP BY category
 
Question 3:
SELECT 
a.title, a.length, c.name
FROM film a
JOIN film_category b ON a.film_id = b.film_id
JOIN category c ON b.category_id = c.category_id
WHERE c.name in ('Drama','Sports')
ORDER BY length desc
 
Question 4:
SELECT 
c.name
,COUNT (a.title) AS so_luong
FROM film a
JOIN film_category b ON a.film_id = b.film_id
JOIN category c ON b.category_id = c.category_id
GROUP BY c.name
ORDER BY so_luong DESC
 
Question 5:
SELECT 
CONCAT(a.first_name,' ',a.last_name) AS Name
,COUNT (b.film_id) AS so_luong
FROM actor a
JOIN film_actor b ON a.actor_id = b.actor_id
GROUP BY name
ORDER BY so_luong DESC
 
Question 6:
SELECT COUNT ()
FROM address a
LEFT JOIN customer b
ON a.address_id = b.address_id
WHERE b.address_id is null
 
Question 7:
SELECT a.city
,sum(d.amount) as doanh_thu
FROM city a
JOIN address b ON a.city_id = b.city_id
JOIN customer c ON b.address_id = c.address_id
JOIN payment d ON c.customer_id = d.customer_id
GROUP BY a.city
ORDER BY doanh_thu DESC
 
Question 8:
SELECT 
CONCAT(a.country,', ',b.city) AS City_of_Country
,sum(e.amount) as doanh_thu
FROM Country a
JOIN city b ON a.country_id = b.country_id
JOIN address c ON b.city_id = c.city_id
JOIN customer d ON c.address_id = d.address_id
JOIN payment e ON d.customer_id = e.customer_id
GROUP BY City_of_Country
ORDER BY doanh_thu
