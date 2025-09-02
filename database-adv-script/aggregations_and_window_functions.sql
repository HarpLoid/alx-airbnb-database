-- AGGREGATION
SELECT u.first_name, COUNT(b.booking_id) as total_bookings
FROM Users as u
INNER JOIN Bookings as b
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name

-- WINDOW FUNCTIONS (RANK)
SELECT property_id, booking_count,
       RANK() OVER (ORDER BY booking_count DESC) as ranking
FROM (
    SELECT property_id, COUNT(booking_id) as booking_count
    FROM Bookings
    GROUP BY property_id
) as subquery

-- WINDOW FUNCTIONS (ROW NUMBER)
SELECT 
    property_id,
    booking_count,
    ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS property_rank
FROM (
    SELECT 
        property_id,
        COUNT(*) AS booking_count
    FROM Bookings
    GROUP BY property_id
) p;

