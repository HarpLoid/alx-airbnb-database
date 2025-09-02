# Indexes for Optimization

## Before Indexing

``` sql

EXPLAIN ANALYZE
SELECT * FROM Bookings
WHERE user_id = '660e8400-e29b-41d4-a716-446655440008'

```

### Results (Before)

"Seq Scan on bookings  (cost=0.00..16.12 rows=2 width=138) (actual time=0.069..0.069 rows=0 loops=1)"
"  Filter: (user_id = '660e8400-e29b-41d4-a716-446655440008'::uuid)"
"  Rows Removed by Filter: 20"

## After Indexing

``` sql

EXPLAIN ANALYZE
SELECT * FROM Bookings
WHERE user_id = '660e8400-e29b-41d4-a716-446655440008'

```

### Results (After)

"Seq Scan on bookings  (cost=0.00..1.25 rows=1 width=138) (actual time=0.021..0.021 rows=0 loops=1)"
"  Filter: (user_id = '660e8400-e29b-41d4-a716-446655440008'::uuid)"
"  Rows Removed by Filter: 20"
