-- PARTITIONED QUERY
CREATE TABLE Booking (
    booking_id UUID NOT NULL,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
	total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
	PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Partition for 2023 bookings
CREATE TABLE Booking_2023 PARTITION OF Booking
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Partition for 2024 bookings
CREATE TABLE Booking_2024 PARTITION OF Booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for future bookings
CREATE TABLE Booking_future PARTITION OF Booking
FOR VALUES FROM ('2025-01-01') TO (MAXVALUE);