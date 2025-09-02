-- INNER JOIN QUERY
SELECT *
FROM Users as u
INNER JOIN Bookings as b
    ON u.user_id = b.user_id;

-- LEFT JOIN QUERY
SELECT *
FROM Properties as p
LEFT JOIN Reviews as r
    ON p.property_id = r.property_id
ORDER BY p.property_id DESC;

-- FULL OUTER JOIN QUERY
SELECT * FROM Users as u
FULL OUTER JOIN Bookings as b
    ON u.user_id = b.user_id;
