🔍 1. Single-row Subquery
Get user info who made the most recent reservation:

sql
Copy
Edit
SELECT *
FROM USERS
WHERE user_id = (
    SELECT user_id
    FROM RESERVATIONS
    WHERE start_time = (SELECT MAX(start_time) FROM RESERVATIONS)
);

🔁 2. Multi-row Subquery
Get all users who have made a reservation:

sql
Copy
Edit
SELECT name, email
FROM USERS
WHERE user_id IN (
    SELECT DISTINCT user_id
    FROM RESERVATIONS
);



🔄 3. Correlated Subquery
Find all vehicles that have at least one reservation:

sql
Copy
Edit
SELECT vehicle_id, license_plate
FROM VEHICLES V
WHERE EXISTS (
    SELECT 1
    FROM RESERVATIONS R
    WHERE R.vehicle_id = V.vehicle_id
);



📥 4. Subquery with IN
List all payments for reservations of vehicle type ‘EV’:

sql
Copy
Edit
SELECT *
FROM PAYMENTS
WHERE reservation_id IN (
    SELECT reservation_id
    FROM RESERVATIONS
    WHERE vehicle_id IN (
        SELECT vehicle_id
        FROM VEHICLES
        WHERE vehicle_type_id = (
            SELECT vehicle_type_id
            FROM VEHICLE_TYPES
            WHERE type_name = 'EV'
        )
    )
);


✅ 5. Subquery with EXISTS
Show all parking lots that have slots assigned to reservations:

sql
Copy
Edit
SELECT *
FROM PARKING_LOTS PL
WHERE EXISTS (
    SELECT 1
    FROM SLOTS S
    JOIN RESERVATIONS R ON S.slot_id = R.slot_id
    WHERE S.lot_id = PL.lot_id
);

🧮 6. Subquery in SELECT Clause
List each reservation and how many other reservations that user has made:

sql
Copy
Edit
SELECT 
    reservation_id,
    user_id,
    (SELECT COUNT(*) FROM RESERVATIONS R2 WHERE R2.user_id = R1.user_id) AS total_reservations_by_user
FROM 
    RESERVATIONS R1;



📄 7. Subquery in FROM Clause
Get total payments per user:

sql
Copy
Edit
SELECT U.name, P.total_paid
FROM USERS U
JOIN (
    SELECT R.user_id, SUM(P.amount) AS total_paid
    FROM PAYMENTS P
    JOIN RESERVATIONS R ON P.reservation_id = R.reservation_id
    GROUP BY R.user_id
) P ON U.user_id = P.user_id;



🧹 8. Subquery inside UPDATE / DELETE
Set status = 'Overdue' for reservations that haven’t exited after end_time:

sql
Copy
Edit
UPDATE RESERVATIONS
SET status = 'Overdue'
WHERE end_time < SYSDATE
AND reservation_id NOT IN (
    SELECT reservation_id FROM PARKING_HISTORY
);




🎯 9. Nested Subquery
List vehicles that are not of type 'Car' and have reservations:

sql
Copy
Edit
SELECT license_plate
FROM VEHICLES
WHERE vehicle_id IN (
    SELECT vehicle_id
    FROM RESERVATIONS
    WHERE vehicle_id IN (
        SELECT vehicle_id
        FROM VEHICLES
        WHERE vehicle_type_id <> (
            SELECT vehicle_type_id FROM VEHICLE_TYPES WHERE type_name = 'Car'
        )
    )
);


🧾 10. Subquery as Virtual Column
Show all reservations with the hourly rate of the vehicle used:

sql
Copy
Edit
SELECT 
    R.reservation_id,
    R.start_time,
    (SELECT rate_per_hour
     FROM VEHICLE_TYPES VT
     WHERE VT.vehicle_type_id = (
         SELECT vehicle_type_id
         FROM VEHICLES V
         WHERE V.vehicle_id = R.vehicle_id
     )) AS hourly_rate
FROM RESERVATIONS R;
