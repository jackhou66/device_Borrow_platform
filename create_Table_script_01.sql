-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema A_rent_database_jiancai
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema A_rent_database_jiancai
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `A_rent_database_jiancai` DEFAULT CHARACTER SET utf8 ;
USE `A_rent_database_jiancai` ;

-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Student` (
  `student_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `department` VARCHAR(45) NULL,
  `password_hash` VARCHAR(255) NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Device_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Device_Category` (
  `category_id` INT NOT NULL,
  `category_name` VARCHAR(50) NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `Device_number` INT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Device` (
  `device_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `type` VARCHAR(50) NULL,
  `brand` VARCHAR(50) NULL,
  `model` VARCHAR(50) NULL,
  `serial_number` VARCHAR(50) NULL,
  `condition` VARCHAR(20) NULL,
  `status` ENUM('available', 'rented', 'maintenance') NOT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `A_rent_database_jiancai`.`Device_Category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Rental_Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Rental_Transaction` (
  `transaction_id` INT NOT NULL,
  `student_id` VARCHAR(45) NULL COMMENT 'FOREIGN KEY (student_id)',
  `device_id` INT NULL,
  `rental_date` DATE NULL,
  `return_date` DATE NULL,
  `due_date` DATE NULL,
  `status` ENUM('ongoing', 'completed', 'overdue') NULL,
  `rental_fee` VARCHAR(45) NULL,
  `Rental_Transactioncol` DECIMAL(8,2) NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `device_id_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `A_rent_database_jiancai`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `device_id`
    FOREIGN KEY (`device_id`)
    REFERENCES `A_rent_database_jiancai`.`Device` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Penalty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Penalty` (
  `penalty_id` INT NOT NULL,
  `transaction_id` INT NULL,
  `amount` DECIMAL(8,2) NULL COMMENT 'Amount of the penalty',
  `reason` VARCHAR(255) NULL,
  `date_imposed` DATE NULL,
  `paid_status` ENUM('paid', 'unpaid') NULL,
  PRIMARY KEY (`penalty_id`),
  INDEX `transaction_id_idx` (`transaction_id` ASC) VISIBLE,
  CONSTRAINT `transaction_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `A_rent_database_jiancai`.`Rental_Transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Staff` (
  `staff_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `position` VARCHAR(50) NULL,
  `department` VARCHAR(50) NULL,
  `contact_number` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`Maintenance_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`Maintenance_log` (
  `log_id` INT NOT NULL,
  `device_id` INT NULL,
  `staff_id` INT NULL,
  `maintenance_date` DATE NULL,
  `issue_description` TEXT NULL,
  `action_taken` TEXT NULL,
  `status` ENUM('repaired', 'pending') NULL,
  PRIMARY KEY (`log_id`),
  INDEX `staff_id_idx` (`staff_id` ASC) VISIBLE,
  INDEX `device_id_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `fk_device_id`
    FOREIGN KEY (`device_id`)
    REFERENCES `A_rent_database_jiancai`.`Device` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staff_id`
    FOREIGN KEY (`staff_id`)
    REFERENCES `A_rent_database_jiancai`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A_rent_database_jiancai`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A_rent_database_jiancai`.`articles` (
  `id` INT NOT NULL,
  `title` VARCHAR(200) NULL,
  `summary` VARCHAR(300) NULL,
  `content` VARCHAR(1000) NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `A_rent_database_jiancai`.`Device_Category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE a_rent_database_jiancai;

select * from  device_category; 
-- DELETE FROM device_category;
insert into device_category(category_id,category_name,description,created_at,updated_at,Device_number)
values (001, 'develop A', 'Devices used for general computing', '2024-08-14 13:56:09', NOW(),100),
(002, 'develop B', 'Devices for developing the IOT product', '2024-10-14 13:56:09', NOW(),100),
(003, 'develop C', 'Devices for developing the IOT product', '2024-06-12 13:56:09', NOW(),100),
(004, 'develop B', 'Devices for developing the IOT product', '2024-06-19 13:56:09', NOW(),100),
(005, 'develop D', 'Devices for developing the IOT product', '2024-05-18 13:56:09', NOW(),100),
(006, 'develop B', 'Devices for developing the IOT product', '2024-04-14 13:56:09', NOW(),100),
(007, 'develop E', 'Devices for developing the IOT product', '2024-03-17 13:56:09', NOW(),100),
(008, 'develop B', 'Devices for developing the IOT product', '2024-03-24 13:56:09', NOW(),100),
(009, 'develop F', 'Devices for developing the IOT product', '2024-01-26 13:56:09', NOW(),100),
(0010, 'develop B', 'Devices for developing the IOT product', '2024-03-24 13:56:09', NOW(),100);

select * from  device;  -- enum('available','rented')   by order insert 
insert into device(device_id,name,type,brand,model,serial_number,`condition`,status,category_id)
values(1, 'develop A', 'Laptop', 'Dell', 'Latitude 5420', 'SN123456', 'Good', 'available', 003),
(2, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(3, 'develop B', 'esp32', 'esp32', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(4, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(5, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(6, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(7, 'develop B', 'esp32', 'esp32', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(8, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(9, 'develop B', 'esp8266', 'esp8266', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(10, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004),
(11, 'develop B', 'arduino', 'Arduino', 'Latitude 5421', 'SN123456', 'Good','rented', 004);

select * from  staff; 
insert into staff(staff_id,name,position,department,contact_number,email)
values (1, 'Hou', 'asistant', 'HRstaff', '555-1234', 'kaola@gmail.com'),
(2, 'Dan', 'Engineer', 'asistant', '555-5678', 'Dan.williams@gmail.com'),
(3, 'Hank', 'asistant', 'HRstaff', '555-1234', 'Hank@gmail.com'),
(4, 'Mark', 'asistant', 'HRstaff', '555-1234', 'Mark@gmail.com'),
(5, 'Li', 'asistant', 'HRstaff', '555-1234', 'Li@gmail.com'),
(6, 'Wang', 'asistant', 'HRstaff', '555-1234', 'Wang@gmail.com'),
(7, 'Ata', 'asistant', 'HRstaff', '555-1234', 'Ata@gmail.com'),
(8, 'Kun', 'asistant', 'HRstaff', '555-1234', 'Kun@gmail.com'),
(9, 'Bai', 'Engineer', 'asistant', '555-5678', 'Bai.williams@gmail.com'),
(10, 'Chao', 'asistant', 'HRstaff', '555-1234', 'Chao@gmail.com');

-- DELETE FROM student;
-- UPDATE student
-- SET student_id = 102
-- WHERE student_id = 2;
-- ALTER TABLE Student MODIFY student_id INT AUTO_INCREMENT;

select * from  student;
-- SET SQL_SAFE_UPDATES = 0;
-- SET FOREIGN_KEY_CHECKS = 0;
-- DELETE FROM rental_transaction;
-- SET FOREIGN_KEY_CHECKS = 1;
insert into student(student_id,name,email,department,password_hash)  -- passward 123456 
values( 'S2023011',' Johnson', 'alice.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023090',' Johnson', 'alice.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023228',' mini', 'mini.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023022',' zhang', 'zhang.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023044',' wang', 'wang.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023055',' atanu', 'atanu.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023066',' make', 'make.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023322',' tuka', 'tuka.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023555',' john', 'john.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2023999',' Li', 'Li.gg@example.com', 'IT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i'),
( 'S2034558',' Liu', 'Liu.kk@example.com', 'IOT', '$2a$12$KIXybxE3Xj.CtCxH5JKt3uWFSOqKIn7iRWi96eNnB5xAvzcbTVa6i');

select * from  articles;
-- DELETE FROM articles;
insert into articles(id,title,summary,content,category_id)
values(1,  'Introduction to IoT', 'Learn about the basics of IoT and its applications.', 
'IoT stands for the Internet of Things, and it refers to a system of interrelated devices that communicate with each other over the internet. These devices collect and exchange data to improve efficiency and automation.', 001),

(2, 'IoT in Healthcare', 'Explore how IoT is transforming the healthcare industry.', 
'IoT devices in healthcare enable real-time monitoring and improved patient care. Smart devices can track vital signs, send alerts, and automate certain treatments.', 005),

(3,  'IoT in Smart Cities', 'Discover how IoT enhances urban infrastructure.', 
'IoT in smart cities involves using connected devices to manage resources efficiently, reduce energy consumption, and improve quality of life for citizens.', 002),

(4,  'Security  in IoT', 'Understand the risks associated with IoT and how to mitigate them.', 
'IoT security challenges include data breaches, unauthorized access, and malware attacks. It is crucial to implement strong security measures like encryption and regular updates.', 006),

(5,  'Security get in IoT', 'Understand the risks associated with IoT and how to mitigate them.', 
'IoT security challenges include data breaches, unauthorized access, and malware attacks. It is crucial to implement strong security measures like encryption and regular updates.', 006),

(6,  'Security problem in IoT', 'Understand the risks associated with IoT and how to mitigate them.', 
'IoT security challenges include data breaches, unauthorized access, and malware attacks. It is crucial to implement strong security measures like encryption and regular updates.', 006),

(7,  'Security issue in IoT', 'Understand the risks associated with IoT and how to mitigate them.', 
'IoT security challenges include data breaches, unauthorized access, and malware attacks. It is crucial to implement strong security measures like encryption and regular updates.', 006),

(8,  'developmengt in IoT', 'Understand the risks associated with IoT and how to mitigate them.', 
'IoT security challenges include data breaches, unauthorized access, and malware attacks. It is crucial to implement strong security measures like encryption and regular updates.', 006),

(9,  'good optunity Challenges in IoT', 'Understand the risks associated with IoT and how to mitigate them.', 
'IoT security challenges include data breaches, unauthorized access, and malware attacks. It is crucial to implement strong security measures like encryption and regular updates.', 006),

(10,  'IoT and Industry 4.0', 'How IoT is revolutionizing manufacturing processes.', 
'IoT plays a key role in Industry 4.0 by enabling smart factories, predictive maintenance, and real-time supply chain management.', 004);

select * from  maintenance_log;  -- status enum('repaired','pending')
insert into maintenance_log(log_id,device_id,staff_id,maintenance_date,issue_description,action_taken,status) 
values (1, 1, 1, '2024-11-14', 'Screen flickering', 'Replaced screen', 'repaired'),
(2, 2, 2, '2024-12-12', 'Screen flickering', 'Replaced screen', 'repaired'),
(3, 3, 3, '2024-11-11', 'Screen flickering', 'Replaced screen', 'repaired'),
(4, 3, 4, '2024-12-13', 'Screen flickering', 'Replaced screen', 'repaired'),
(5, 4, 5, '2024-11-14', 'cable interrupt', 'Replaced screen', 'repaired'),
(6, 5, 6, '2024-12-14', 'light', 'Replaced screen', 'repaired'),
(7, 6, 7, '2023-11-16', 'button', 'Replaced screen', 'repaired'),
(8, 7, 8, '2023-11-20', 'Screen flickering', 'Replaced screen', 'repaired'),
(9, 8, 1, '2024-12-24', 'button problem', 'Replaced screen', 'repaired'),
(10, 5, 2, '2023-11-29', 'Screen flickering', 'Replaced screen', 'repaired'),
(11, 5, 3, '2023-12-22', 'Screen flickering', 'Replaced screen', 'repaired'),
(12, 2, 4, '2023-11-18', 'Battery not charging', 'Checked connections', 'pending');

select * from  rental_transaction; -- status enum('ongoing','completed','overdue')
insert into rental_transaction(transaction_id,student_id,device_id,rental_date,return_date,due_date,status,rental_fee,Rental_Transactioncol)
values (100, 'S2023011', 1, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(101, 'S2023090', 2, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(102, 'S2023228', 3, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(103, 'S2023322', 4, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(104, 'S2023999', 5, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(105, 'S2023066', 6, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(106, 'S2023044', 7, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(107, 'S2023011', 8, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(108, 'S2023022', 9, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00),
(109, 'S2023228', 10, '2024-11-15', '2021-11-22', '2022-11-24', 'completed', 25.00, 25.00);
 
select * from  penalty; -- enum('paid','unpaid')maintenance_log
insert into penalty(penalty_id,transaction_id,amount,date_imposed,paid_status)
values (1,101,20.00, '2024-11-15', 'unpaid'),
(2,102,20.00, '2024-11-15', 'unpaid'),
(3,103, 20.00, '2024-11-15', 'unpaid'),
(4,104,20.00, '2024-11-15', 'paid'),
(5,105, 20.00, '2024-11-15', 'unpaid'),
(6,105, 20.00, '2024-11-15', 'paid'),
(7,107, 20.00, '2024-11-15', 'unpaid'),
(8,108, 20.00, '2024-11-15', 'unpaid'),
(9,109, 20.00, '2024-11-15', 'paid'),
(10,100,15.00, '2024-11-16', 'unpaid');

-- view 
CREATE VIEW student_rental_summary AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.email AS student_email,
    r.transaction_id,
    r.device_id,
    r.rental_date,
    r.return_date,
    r.status AS rental_status,
    r.rental_fee
FROM 
    student s
JOIN 
    rental_transaction r ON s.student_id = r.student_id;

CREATE VIEW device_maintenance_status AS
SELECT 
    d.device_id,
    d.name AS device_name,
    d.type AS device_type,
    d.brand,
    d.`condition`,
    m.maintenance_date,
    m.issue_description,
    m.action_taken,
    m.status AS maintenance_status
FROM 
    device d
JOIN 
    maintenance_log m ON d.device_id = m.device_id;

CREATE VIEW student_device_rental AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.email AS student_email,
    r.transaction_id,
    r.rental_date,
    r.return_date,
    r.status AS rental_status,
    d.device_id,
    d.name AS device_name,
    d.type AS device_type,
    d.brand,
    d.`condition` AS device_condition
FROM 
    student s
JOIN 
    rental_transaction r ON s.student_id = r.student_id
JOIN 
    device d ON r.device_id = d.device_id;

--  normal table select show -- 
select * from  device_category; 
select * from  device; 
select * from  staff; 
select * from  student;
select * from  articles;
select * from  maintenance_log;
select * from  rental_transaction; 
select * from  penalty;

--  joint enquiry table show -- 
select * from  student_rental_summary;
select * from  device_maintenance_status;
select * from  student_device_rental;
