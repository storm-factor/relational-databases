

## ex-1
SELECT 
    (SUM(index_length) / NULLIF(SUM(data_length + index_length), 0)) * 100 AS index_size
FROM 
    information_schema.TABLES
WHERE 
    TABLE_SCHEMA = 'sakila';
    
## ex-2
CREATE INDEX idx_payment_date ON payment(payment_date);   
   
explain analyze   
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p
JOIN rental r ON p.payment_date = r.rental_date
JOIN customer c ON r.customer_id = c.customer_id 
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE p.payment_date >= '2005-07-30' AND p.payment_date < DATE_ADD('2005-07-30', INTERVAL 1 DAY);

-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=0.0225..0.0225 rows=0 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=0.0216..0.0216 rows=0 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=0.0176..0.0176 rows=0 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=0.016..0.016 rows=0 loops=1)
                -> Stream results  (cost=1.75 rows=1) (actual time=0.0122..0.0122 rows=0 loops=1)
                    -> Nested loop inner join  (cost=1.75 rows=1) (actual time=0.0117..0.0117 rows=0 loops=1)
                        -> Nested loop inner join  (cost=1.4 rows=1) (actual time=0.0114..0.0114 rows=0 loops=1)
                            -> Nested loop inner join  (cost=1.05 rows=1) (actual time=0.0113..0.0113 rows=0 loops=1)
                                -> Nested loop inner join  (cost=0.7 rows=1) (actual time=0.0112..0.0112 rows=0 loops=1)
                                    -> Index lookup on p using idx_payment_date (payment_date=TIMESTAMP'2005-07-30 00:00:00')  (cost=0.35 rows=1) (actual time=0.0109..0.0109 rows=0 loops=1)
                                    -> Covering index lookup on r using rental_date (rental_date=TIMESTAMP'2005-07-30 00:00:00')  (cost=0.35 rows=1) (never executed)
                                -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.35 rows=1) (never executed)
                            -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.35 rows=1) (never executed)
                        -> Single-row index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.35 rows=1) (never executed)

SELECT *
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_NAME='payment';
