
# ex-1
USE sakila

SELECT DISTINCT district
FROM address
WHERE district LIKE 'K%' AND district LIKE '%a' AND district NOT LIKE '% %';
####

# ex-2
SELECT * FROM payment
WHERE CAST(payment_date AS DATE) BETWEEN '2005-06-15' AND '2005-06-18' AND amount > 10.00;
####

# ex-3
SELECT * FROM rental
ORDER BY rental_date
DESC
LIMIT 5
OFFSET 1;
#####

# ex-4
SELECT DISTINCT REPLACE(LOWER(first_name), 'll', 'PP'), LOWER(last_name), email
FROM customer
WHERE first_name LIKE '%KELLY%' OR first_name LIKE '%Willie%';
####

# ex-5
SELECT
    SUBSTRING_INDEX(email, '@',  1) AS email_before,
    SUBSTRING_INDEX(email, '.', -2) AS email_after,
    email AS email_full
FROM customer;
####

# ex-6
SELECT
    CONCAT(
        UPPER(SUBSTRING(email, 1, LOCATE('@', email) - 1)),
        LOWER(SUBSTRING(email, LOCATE('@', email) - 1 + 1))
    ) AS email_before,
    CONCAT(
        UPPER(SUBSTRING(email, LOCATE('@', email) + 1, 1)),
        LOWER(SUBSTRING(email, LOCATE('@', email) + 2))
    ) AS email_after
FROM customer;

