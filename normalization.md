# Normalization Steps

## Step 1: Check 1NF (First Normal Form)

    Rule: No repeating groups, no multi-valued attributes, all values must be atomic.
    
    Process:
    Checked if any table had a repeating group → none did (all are single-valued).
    tables are in 1NF.

## Step 2: Check 2NF (Second Normal Form)

    Rule: Already in 1NF + every non-key attribute must depend on the whole primary key (not just part of it).

    Process:
    Checked if any table had a composite primary key → none did (all use UUIDs).
    Looked at Booking.total_price. Asked: “Does this depend on the booking itself, or on property price?”
    Answer: It depends on the booking (since the price is fixed at booking time)
    no partial dependencies.

## Step 3: Check 3NF (Third Normal Form)

    Rule: Already in 2NF + no transitive dependencies (non-key attributes should not depend on other non-key attributes).

    Process:
    Checked the User table. Verified that attributes like email, phone_number, role depend only on user_id and not on each other.
    Did the same check for other tables (Property, Booking, Payment, Review, Message).
    Confirmed that no non-key attribute depends on another non-key attribute.

### Confirmed Normalization

    All tables are in 3NF.
