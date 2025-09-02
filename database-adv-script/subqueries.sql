-- NON-CORRELATED QUERY
SELECT * FROM Properties
WHERE Properties.property_id IN (
    SELECT Reviews.property_id FROM Reviews
    GROUP BY Reviews.property_id
    HAVING AVG(Reviews.rating) > 4.0
)

-- CORRELATED QUERY
SELECT Users.first_name FROM Users
WHERE (
    SELECT COUNT(*) FROM Bookings
    WHERE Bookings.user_id = Users.user_id
) > 3
