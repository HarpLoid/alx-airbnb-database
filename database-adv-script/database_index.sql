-- Users table indexes
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_user_id ON Users(user_id);

-- Bookings table indexes
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);

-- Properties table indexes
CREATE INDEX idx_properties_property_id ON Properties(property_id);
CREATE INDEX idx_properties_host_id ON Properties(host_id);
CREATE INDEX idx_properties_location ON Properties(location);
CREATE INDEX idx_properties_pricepernight ON Properties(price_per_night);

EXPLAIN ANALYZE
SELECT * FROM Bookings
WHERE user_id = '660e8400-e29b-41d4-a716-446655440008'
