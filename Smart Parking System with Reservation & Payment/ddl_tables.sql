🧾 1. Users Table

CREATE TABLE Users (
user_id NUMBER PRIMARY KEY,
name VARCHAR2(50),
email VARCHAR2(50),
phone VARCHAR2(20),
password VARCHAR2(50)
);

—

🧾 2. Vehicle_Types Table

CREATE TABLE Vehicle_Types (
vehicle_type_id NUMBER PRIMARY KEY,
type_name VARCHAR2(20), -- e.g., Bike, Car, EV
rate_per_hour NUMBER
);

—

🧾 3. Vehicles Table

CREATE TABLE Vehicles (
vehicle_id NUMBER PRIMARY KEY,
user_id NUMBER,
vehicle_type_id NUMBER,
license_plate VARCHAR2(20),
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (vehicle_type_id) REFERENCES Vehicle_Types(vehicle_type_id)
);

—

🧾 4. Parking_Lots Table

CREATE TABLE Parking_Lots (
lot_id NUMBER PRIMARY KEY,
name VARCHAR2(50),
location VARCHAR2(100),
total_slots NUMBER
);

—

🧾 5. Slots Table

CREATE TABLE Slots (
slot_id NUMBER PRIMARY KEY,
lot_id NUMBER,
status VARCHAR2(15), -- Available, Reserved, Occupied
slot_number VARCHAR2(10),
FOREIGN KEY (lot_id) REFERENCES Parking_Lots(lot_id)
);

—

🧾 6. Reservations Table

CREATE TABLE Reservations (
reservation_id NUMBER PRIMARY KEY,
user_id NUMBER,
vehicle_id NUMBER,
slot_id NUMBER,
start_time DATE,
end_time DATE,
status VARCHAR2(15), -- Reserved, Completed, Cancelled
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
FOREIGN KEY (slot_id) REFERENCES Slots(slot_id)
);

—

🧾 7. Payments Table

CREATE TABLE Payments (
payment_id NUMBER PRIMARY KEY,
reservation_id NUMBER,
amount NUMBER,
payment_time DATE,
method VARCHAR2(30),
status VARCHAR2(20), -- Paid, Failed, Refunded
FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);

—

🧾 8. Admins Table

CREATE TABLE Admins (
admin_id NUMBER PRIMARY KEY,
username VARCHAR2(50),
password VARCHAR2(50),
email VARCHAR2(50)
);

—

🧾 9. Parking_History Table

CREATE TABLE Parking_History (
history_id NUMBER PRIMARY KEY,
reservation_id NUMBER,
checkout_time DATE,
FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);

ALTER TABLE Reservations
ADD (
  entry_time DATE,
  exit_time DATE,
  calculated_amount NUMBER
);

ALTER TABLE Payments
ADD (
  transaction_id VARCHAR2(30),
  payment_channel VARCHAR2(20)
);

ALTER TABLE PARKING_HISTORY
ADD remarks VARCHAR2(100);
