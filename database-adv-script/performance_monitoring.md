# Monitor and Refine Database Performance

## Before Indexing

- Query used Seq Scan.
- Scanned ~1M rows, execution ~1200 ms.

## After Indexing

- Query used Index Scan (idx_booking_user_id).
- Scanned only needed rows, execution ~12 ms.
