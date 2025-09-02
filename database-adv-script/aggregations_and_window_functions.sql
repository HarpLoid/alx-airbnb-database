-- AGGREGATION
SELECT u.first_name, COUNT(b.booking_id) as total_bookings
FROM Users as u
INNER JOIN Bookings as b
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name

-- WINDOW FUNCTIONS
SELECT property_id, booking_count,
       RANK() OVER (ORDER BY booking_count DESC) as ranking
FROM (
    SELECT property_id, COUNT(booking_id) as booking_count
    FROM Bookings
    GROUP BY property_id
) as subquery
