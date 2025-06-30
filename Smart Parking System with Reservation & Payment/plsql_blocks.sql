✅ 1. Show all reservations of a given user (by email)
sql
Copy
Edit
DECLARE
    v_email USERS.email%TYPE := 'nazrana@example.com';
    v_user_id USERS.user_id%TYPE;
BEGIN
    SELECT user_id INTO v_user_id
    FROM USERS
    WHERE email = v_email;

    FOR res IN (
        SELECT reservation_id, start_time, end_time
        FROM RESERVATIONS
        WHERE user_id = v_user_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || res.reservation_id ||
                             ', From: ' || res.start_time ||
                             ' To: ' || res.end_time);
    END LOOP;
END;
/



✅ 2. Calculate and display payment due for a specific reservation
sql
Copy
Edit
DECLARE
    v_reservation_id RESERVATIONS.reservation_id%TYPE := 1;
    v_entry RESERVATIONS.entry_time%TYPE;
    v_exit RESERVATIONS.exit_time%TYPE;
    v_rate VEHICLE_TYPES.rate_per_hour%TYPE;
    v_vehicle_type_id VEHICLES.vehicle_type_id%TYPE;
    v_hours NUMBER;
    v_amount NUMBER;
BEGIN
    SELECT entry_time, exit_time, V.vehicle_type_id
    INTO v_entry, v_exit, v_vehicle_type_id
    FROM RESERVATIONS R
    JOIN VEHICLES V ON R.vehicle_id = V.vehicle_id
    WHERE reservation_id = v_reservation_id;

    SELECT rate_per_hour INTO v_rate
    FROM VEHICLE_TYPES
    WHERE vehicle_type_id = v_vehicle_type_id;

    v_hours := CEIL((v_exit - v_entry) * 24);
    v_amount := v_hours * v_rate;

    DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || v_reservation_id);
    DBMS_OUTPUT.PUT_LINE('Hours Parked: ' || v_hours);
    DBMS_OUTPUT.PUT_LINE('Rate per Hour: ' || v_rate);
    DBMS_OUTPUT.PUT_LINE('Total Amount: ' || v_amount);
END;
/



✅ 3. Show all slots that are currently available
sql
Copy
Edit
BEGIN
    FOR slot_rec IN (
        SELECT slot_id, slot_number, lot_id
        FROM SLOTS
        WHERE status = 'Available'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Slot ID: ' || slot_rec.slot_id ||
                             ', Number: ' || slot_rec.slot_number ||
                             ', Lot: ' || slot_rec.lot_id);
    END LOOP;
END;
/





✅ 4. Insert parking history after exit (simulate system logging)
sql
Copy
Edit
DECLARE
    v_last_res_id RESERVATIONS.reservation_id%TYPE := 11;
BEGIN
    INSERT INTO PARKING_HISTORY (history_id, reservation_id, checkout_time, remarks)
    VALUES (11, v_last_res_id, SYSDATE, 'Auto-logged by system');

    DBMS_OUTPUT.PUT_LINE('History inserted for reservation: ' || v_last_res_id);
END;
/




✅ 5. Check if a user has unpaid payments
sql
Copy
Edit
DECLARE
    v_email USERS.email%TYPE := 'rahim@example.com';
    v_user_id USERS.user_id%TYPE;
    v_unpaid_count NUMBER := 0;
BEGIN
    SELECT user_id INTO v_user_id
    FROM USERS
    WHERE email = v_email;

    SELECT COUNT(*) INTO v_unpaid_count
    FROM PAYMENTS P
    JOIN RESERVATIONS R ON P.reservation_id = R.reservation_id
    WHERE R.user_id = v_user_id
    AND P.status <> 'Paid';

    IF v_unpaid_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('User ' || v_email || ' has ' || v_unpaid_count || ' unpaid bills.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('All bills paid for user: ' || v_email);
    END IF;
END;
/




✅ 6. Change Slot Status Automatically After Reservation is Completed
If reservation status is 'Exited' or 'Completed', set slot status back to 'Available'.


DECLARE
    CURSOR c1 IS
        SELECT R.reservation_id, R.slot_id
        FROM RESERVATIONS R
        WHERE R.status IN ('Exited', 'Completed');

BEGIN
    FOR res IN c1 LOOP
        UPDATE SLOTS
        SET status = 'Available'
        WHERE slot_id = res.slot_id;

        DBMS_OUTPUT.PUT_LINE('Slot ID ' || res.slot_id || 
                             ' updated to Available for reservation ID ' || res.reservation_id);
    END LOOP;
END;
/
