USE sakila;

-- CHALLENGE 1
#1.1 shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

#1.2 average movie duration in hours and minutes
SELECT 
	AVG(length) DIV 60 AS Hours, ROUND(AVG(length) MOD 60, 0) AS Minutes
FROM film;

#2.1 Calculate the number of days that the company has been operating
SELECT MAX(rental_date) AS latest_date, MIN(rental_date) AS first_date
FROM rental; #May 24 2005 to Feb 14 2006

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operational # does not work: MAX(rental_date) - MIN(rental_date)
FROM rental;

#2.2 Retrieve rental information, add two columns to show the month and day of week of the rental. Return 20 rows.
SELECT rental_id, rental_date, DATE_FORMAT(rental_date, '%M') AS month, DAYNAME(rental_date) AS day_of_week
FROM rental
LIMIT 20;

#2.3 Retrieve rental information, add column called DAY_TYPE with values 'weekend' or 'workday', 
# depending on the day of the week
SELECT rental_id, rental_date, 
CASE
	WHEN DAYNAME(rental_date) IN ('Saturday','Sunday') THEN 'weekend'
    ELSE 'workday'
END AS 'day_type'
FROM rental;

#3 Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string
# 'Not Available'. Sort the results of the film title in ascending order. HINT: IFNULL() Function.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;

#4 Retrieve the concatenated first and last names of customers, along with the first 3 characters of their 
# email address, so that you can address them by their first name and use their email address to send 
# personalized recommendations. Order it by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name, '  ', last_name) AS customer_name, SUBSTRING(email, 1, 3) AS first_3_email 
FROM customer
ORDER BY last_name;

-- CHALLENGE 2
#1.1 The total number of films that have been released
SELECT COUNT(film_id) AS number_films_released
FROM film;

#1.2 The number of films for each rating
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

#2.2 Identify which ratings have a mean duration of over two hours
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

#3 Bonus: determine which last names are not repeated in the table actor
SELECT last_name, COUNT(last_name) AS count_last_name
FROM actor
GROUP BY last_name
HAVING count_last_name < 2;

git add .
git commit -m "Solved lab"
git push origin master

