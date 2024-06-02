
# exercise 1

USE sakila

SELECT DISTINCT district
FROM address 
WHERE district LIKE 'K%' AND district LIKE '%a' AND district NOT LIKE '% %';
####


# ex 2 

SELECT * FROM payment
WHERE CAST(payment_date AS DATE) BETWEEN '2005.06.15' AND '2005.06.18' AND amount > 10.00;
####

# ex 3 

