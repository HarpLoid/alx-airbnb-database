# Optimize Complex Queries

## Before Optimization

``` sql
SELECT *
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON pay.booking_id = b.booking_id
ORDER BY b.start_date;
```

### EXPLAIN ANALYZE Result (Before Optimization)

"Sort  (cost=48.86..50.29 rows=570 width=2660) (actual time=0.141..0.143 rows=20 loops=1)"
"  Sort Key: b.start_date"
"  Sort Method: quicksort  Memory: 31kB"
"  ->  Hash Right Join  (cost=4.36..22.77 rows=570 width=2660) (actual time=0.097..0.107 rows=20 loops=1)"
"        Hash Cond: (pay.booking_id = b.booking_id)"
"        ->  Seq Scan on payments pay  (cost=0.00..15.70 rows=570 width=114) (actual time=0.006..0.007 rows=13 loops=1)"
"        ->  Hash  (cost=4.11..4.11 rows=20 width=2546) (actual time=0.082..0.083 rows=20 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 14kB"
"              ->  Hash Join  (cost=2.79..4.11 rows=20 width=2546) (actual time=0.060..0.071 rows=20 loops=1)"
"                    Hash Cond: (b.property_id = p.property_id)"
"                    ->  Hash Join  (cost=1.45..2.71 rows=20 width=1660) (actual time=0.030..0.036 rows=20 loops=1)"
"                          Hash Cond: (b.user_id = u.user_id)"
"                          ->  Seq Scan on bookings b  (cost=0.00..1.20 rows=20 width=138) (actual time=0.010..0.010 rows=20 loops=1)"
"                          ->  Hash  (cost=1.20..1.20 rows=20 width=1522) (actual time=0.012..0.012 rows=20 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                                ->  Seq Scan on users u  (cost=0.00..1.20 rows=20 width=1522) (actual time=0.007..0.007 rows=20 loops=1)"
"                    ->  Hash  (cost=1.15..1.15 rows=15 width=886) (actual time=0.024..0.025 rows=15 loops=1)"
"                          Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                          ->  Seq Scan on properties p  (cost=0.00..1.15 rows=15 width=886) (actual time=0.017..0.017 rows=15 loops=1)"
"Planning Time: 6.723 ms"
"Execution Time: 0.218 ms"

## After Optimization

``` sql
SELECT
b.booking_id,
b.start_date,
b.end_date,
b.total_price AS booking_total,
b.status AS booking_status,
u.user_id,
u.first_name,
u.last_name,
u.email,
p.property_id,
p.name AS property_name,
p.location AS property_location,
pay.payment_id,
pay.amount AS payment_amount,
pay.payment_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON pay.booking_id = b.booking_id
ORDER BY b.start_date;
```

### EXPLAIN ANALYZE Result (After Optimization)

"Sort  (cost=48.86..50.29 rows=570 width=1826) (actual time=0.179..0.181 rows=20 loops=1)"
"  Sort Key: b.start_date"
"  Sort Method: quicksort  Memory: 28kB"
"  ->  Hash Right Join  (cost=4.36..22.77 rows=570 width=1826) (actual time=0.110..0.123 rows=20 loops=1)"
"        Hash Cond: (pay.booking_id = b.booking_id)"
"        ->  Seq Scan on payments pay  (cost=0.00..15.70 rows=570 width=56) (actual time=0.016..0.017 rows=13 loops=1)"
"        ->  Hash  (cost=4.11..4.11 rows=20 width=1786) (actual time=0.087..0.088 rows=20 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"              ->  Hash Join  (cost=2.79..4.11 rows=20 width=1786) (actual time=0.062..0.076 rows=20 loops=1)"
"                    Hash Cond: (b.property_id = p.property_id)"
"                    ->  Hash Join  (cost=1.45..2.71 rows=20 width=996) (actual time=0.031..0.041 rows=20 loops=1)"
"                          Hash Cond: (b.user_id = u.user_id)"
"                          ->  Seq Scan on bookings b  (cost=0.00..1.20 rows=20 width=130) (actual time=0.007..0.008 rows=20 loops=1)"
"                          ->  Hash  (cost=1.20..1.20 rows=20 width=882) (actual time=0.018..0.019 rows=20 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                ->  Seq Scan on users u  (cost=0.00..1.20 rows=20 width=882) (actual time=0.009..0.011 rows=20 loops=1)"
"                    ->  Hash  (cost=1.15..1.15 rows=15 width=806) (actual time=0.025..0.025 rows=15 loops=1)"
"                          Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                          ->  Seq Scan on properties p  (cost=0.00..1.15 rows=15 width=806) (actual time=0.016..0.018 rows=15 loops=1)"
"Planning Time: 0.254 ms"
"Execution Time: 0.225 ms"
