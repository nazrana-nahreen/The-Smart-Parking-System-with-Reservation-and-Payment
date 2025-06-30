# 🚗 Smart Parking System with Reservation and Payment

> 📚 A full-featured **Oracle 10g DBMS Project** for managing vehicle parking using real-time reservation, entry/exit tracking, and MFS payment system.

---

## 📌 Project Overview

This project is a **database-backed Smart Parking System** designed to streamline parking slot reservations, vehicle tracking, and secure mobile financial service (MFS) payments like bKash, Nagad, Rocket, etc. It was built for an academic DBMS Lab using **Oracle 10g** and implements proper **ERD design**, **3NF normalization**, **PL/SQL procedures**, **queries**, and **reporting logic**.

---

## 🧱 System Modules

| Module             | Description |
|--------------------|-------------|
| 👤 **Users**        | Register/login, add vehicle, make reservation |
| 🚘 **Vehicles**     | Linked to users and categorized by type |
| 📍 **Parking Lots** | Admin-managed locations with available slots |
| 🅿️ **Slots**        | Each lot contains multiple reservable slots |
| 📅 **Reservations** | Track time, status, entry/exit, payment needed |
| 💳 **Payments**     | MFS-based payment system linked to reservations |
| 🕓 **Parking History** | Logs exit time and remarks post-parking |
| 🛠 **Admin Panel**  | Manage lots, slots, vehicle rates, earnings |

---

## 🗃️ Database Design

- **9 Tables**: USERS, VEHICLES, VEHICLE_TYPES, ADMINS, PARKING_LOTS, SLOTS, RESERVATIONS, PAYMENTS, PARKING_HISTORY
- Fully **Normalized to 3NF**
- Connected through appropriate **Primary Keys and Foreign Keys**
- ERD created using **Chen's Notation**

---

## 🔄 Relationships Overview

| From Table     | To Table        | Relationship   |
|----------------|------------------|----------------|
| Vehicles       | Users            | Many-to-One    |
| Vehicles       | Vehicle_Types    | Many-to-One    |
| Reservations   | Users            | Many-to-One    |
| Reservations   | Vehicles         | Many-to-One    |
| Reservations   | Slots            | Many-to-One    |
| Slots          | Parking_Lots     | Many-to-One    |
| Payments       | Reservations     | One-to-One     |
| Parking_History| Reservations     | One-to-One     |

---

## 💡 Features Implemented

✅ Slot reservation & status update  
✅ Real-time entry & exit tracking  
✅ Automatic hourly bill calculation  
✅ MFS payment (bKash/Nagad style)  
✅ Admin control for lots, rates, slots  
✅ Parking history & reporting  
✅ Derived attributes like entry_time, calculated_amount  
✅ PL/SQL blocks for automation

---


## 🛠 Technologies Used

- 🧮 Oracle 10g SQL
- 🔁 PL/SQL
- 📐 draw.io / diagrams.net for ERD
- 📝 Markdown for documentation

---

## 📌 Future Enhancements (Optional Scope)

- QR Code entry scanning
- Google Maps API for live slot availability
- SMS/email booking confirmations
- Overstay penalty + discount engine
- Auto-cancellation for no-shows

---

## 👩‍💻 Developer

**Nazrana Nahreen**  
Student, CSE  

---

> 🔐 This project is for educational purposes only and was built as part of a DBMS lab assignment.

