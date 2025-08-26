-- User Table
CREATE TABLE User (
    user_id Primary Key UUID,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    email VARCHAR(128) UNIQUE NOT NULL,
    password_hash VARCHAR(128) NOT NULL,
    phone_number VARCHAR(128) NULL,
    role ENUM ("guest", "host", "admin") NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Property Table
CREATE TABLE Property (
    property_id Primary Key UUID,
    host_id UUID NOT NULL,
    name VARCHAR(128) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(128) NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    FOREIGN KEY (host_id) REFERENCES User(user_id),
)

-- Booking Table
CREATE TABLE Booking (
    booking_id Primary Key UUID,
    property_id UUID UNIQUE NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM ("pending", "confirmed", "canceled") NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)

-- Payment Table
CREATE TABLE Payment(
    payment_id Primary Key UUID,
    booking_id UUID UNIQUE NOT NULL,
    amount DECIMAL NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM ("credit card", "paypal", "stripe") NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
)

-- Review Table
CREATE TABLE Review (
    review_id Primary Key UUID,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
    comment TEXT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)

-- Message Table
CREATE TABLE Message(
    message_id Primary Key UUID,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
)
