-- =========================================================
-- File này dùng để IMPORT vào FreeSQLDatabase
-- (đã bỏ dòng USE `travel_tour_booking`)
-- =========================================================

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `payments`;
DELETE FROM `bookings`;
DELETE FROM `schedules`;
DELETE FROM `tours`;
DELETE FROM `users`;
DELETE FROM `destinations`;
DELETE FROM `roles`;
SET FOREIGN_KEY_CHECKS = 1;

-- =========================
-- ROLES
-- =========================

INSERT INTO roles(role_name)
VALUES
('ADMIN'),
('CUSTOMER');

-- =========================
-- USERS (10 records)
-- =========================

INSERT INTO users(full_name,email,password,phone,address,role_id)
VALUES
('Nguyen Van A','a@gmail.com','123456','0901111111','HCM',2),
('Tran Thi B','b@gmail.com','123456','0902222222','Ha Noi',2),
('Le Van C','c@gmail.com','123456','0903333333','Da Nang',2),
('Pham Thi D','d@gmail.com','123456','0904444444','Can Tho',2),
('Hoang Van E','e@gmail.com','123456','0905555555','Hue',2),
('Vo Thi F','f@gmail.com','123456','0906666666','Nha Trang',2),
('Dang Van G','g@gmail.com','123456','0907777777','Quang Ninh',2),
('Bui Thi H','h@gmail.com','123456','0908888888','Hai Phong',2),
('Do Van I','i@gmail.com','123456','0909999999','Vung Tau',2),
('Nguyen Le Dam Van','vannld23@uef.edu.vn','1234','0395540150','Kon Tum',1);

-- =========================
-- DESTINATIONS (10 records)
-- =========================

INSERT INTO destinations(destination_name,country,city,description,image_url)
VALUES
('Da Nang Beach','Vietnam','Da Nang','Beautiful beach','danang.jpg'),
('Ha Long Bay','Vietnam','Quang Ninh','World heritage site','halong.jpg'),
('Nha Trang Beach','Vietnam','Nha Trang','Beautiful sea','nhatrang.jpg'),
('Phu Quoc Island','Vietnam','Kien Giang','Island paradise','phuquoc.jpg'),
('Hoi An Ancient Town','Vietnam','Quang Nam','Ancient town','hoian.jpg'),
('Sapa Mountain','Vietnam','Lao Cai','Mountain trekking','sapa.jpg'),
('Da Lat City','Vietnam','Lam Dong','City of flowers','dalat.jpg'),
('Hue Imperial City','Vietnam','Hue','Historical destination','hue.jpg'),
('Cat Ba Island','Vietnam','Hai Phong','Island tourism','catba.jpg'),
('Moc Chau Plateau','Vietnam','Son La','Green tea hills','mocchau.jpg');

-- =========================
-- TOURS (10 records)
-- =========================

INSERT INTO tours(
tour_name,destination_id,duration_days,
price,max_capacity,start_date,end_date,
description,image_url
)
VALUES
('Da Nang Discovery',1,3,3500000,30,'2026-07-01','2026-07-03','Explore Da Nang','tour1.jpg'),
('Ha Long Cruise',2,2,2800000,25,'2026-07-10','2026-07-11','Ha Long Bay Tour','tour2.jpg'),
('Nha Trang Vacation',3,4,4500000,30,'2026-08-01','2026-08-04','Beach Holiday','tour3.jpg'),
('Phu Quoc Resort',4,5,6500000,20,'2026-08-10','2026-08-14','Luxury Resort','tour4.jpg'),
('Hoi An Heritage',5,2,2500000,25,'2026-08-20','2026-08-21','Ancient Town Visit','tour5.jpg'),
('Sapa Adventure',6,3,3900000,20,'2026-09-01','2026-09-03','Mountain Trekking','tour6.jpg'),
('Da Lat Flower Tour',7,3,3200000,25,'2026-09-10','2026-09-12','Flower Festival','tour7.jpg'),
('Hue Culture Tour',8,2,2700000,20,'2026-09-20','2026-09-21','Historical Tour','tour8.jpg'),
('Cat Ba Escape',9,3,3600000,20,'2026-10-01','2026-10-03','Island Adventure','tour9.jpg'),
('Moc Chau Experience',10,2,2200000,15,'2026-10-15','2026-10-16','Tea Hill Tour','tour10.jpg');

-- =========================
-- SCHEDULES (20 records)
-- =========================

INSERT INTO schedules(tour_id,day_number,activity_description)
VALUES
(1,1,'Arrival and beach visit'),
(1,2,'Ba Na Hills'),
(2,1,'Cruise tour'),
(2,2,'Visit caves'),
(3,1,'Beach activities'),
(3,2,'VinWonders'),
(4,1,'Check-in resort'),
(4,2,'Safari visit'),
(5,1,'Ancient town walk'),
(5,2,'Lantern festival'),
(6,1,'Cat Cat village'),
(6,2,'Fansipan peak'),
(7,1,'Flower garden'),
(7,2,'Xuan Huong lake'),
(8,1,'Imperial Citadel'),
(8,2,'Thien Mu Pagoda'),
(9,1,'Island tour'),
(9,2,'Kayaking'),
(10,1,'Tea plantation'),
(10,2,'Local culture');

-- =========================
-- BOOKINGS (17 records)
-- =========================

INSERT INTO bookings(
user_id,tour_id,number_of_people,
total_price,booking_status
)
VALUES
(2,1,2,7000000,'CONFIRMED'),
(3,2,1,2800000,'CONFIRMED'),
(4,3,2,9000000,'PENDING'),
(5,4,3,19500000,'CONFIRMED'),
(6,5,2,5000000,'COMPLETED'),
(7,6,1,3900000,'PENDING'),
(8,7,2,6400000,'CONFIRMED'),
(9,8,1,2700000,'COMPLETED'),
(2,10,4,8800000,'CONFIRMED');

INSERT INTO bookings (`user_id`, `tour_id`, `booking_date`, `number_of_people`, `total_price`, `booking_status`) VALUES
(1, 1, '2026-01-15 08:00:00', 2, 4500000.00, 'COMPLETED'),
(1, 1, '2026-02-10 09:30:00', 1, 2200000.00, 'COMPLETED'),
(1, 1, '2026-02-25 10:00:00', 2, 4800000.00, 'COMPLETED'),
(1, 1, '2026-03-05 14:00:00', 4, 9000000.00, 'COMPLETED'),
(1, 1, '2026-04-12 09:00:00', 2, 5500000.00, 'COMPLETED'),
(1, 1, '2026-05-08 11:00:00', 3, 7200000.00, 'COMPLETED'),
(1, 1, '2026-05-20 15:00:00', 1, 2500000.00, 'COMPLETED'),
(1, 1, '2026-06-10 09:00:00', 2, 7700000.00, 'COMPLETED');

-- =========================
-- PAYMENTS (9 records)
-- =========================

INSERT INTO payments(
booking_id,
amount,
payment_method,
payment_status
)
VALUES
(1,7000000,'MOMO','PAID'),
(2,2800000,'BANK_TRANSFER','PAID'),
(3,9000000,'MOMO','PENDING'),
(4,19500000,'BANK_TRANSFER','PAID'),
(5,5000000,'CASH','PAID'),
(6,3900000,'MOMO','PENDING'),
(7,6400000,'BANK_TRANSFER','PAID'),
(8,2700000,'CASH','PAID'),
(9,7200000,'MOMO','PENDING');
