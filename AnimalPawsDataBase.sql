CREATE SCHEMA ap_db;
USE ap_db;

-- -----------------------------------------------------
-- Table Users and profile
-- -----------------------------------------------------
 
CREATE TABLE user(
id INT AUTO_INCREMENT,
first_name VARCHAR(80) NOT NULL,
middle_name VARCHAR(80) DEFAULT(NULL),
surname VARCHAR(80) NOT NULL,
last_name VARCHAR(80) NOT NULL,
profile_img  VARCHAR(120),
profile_banner VARCHAR(120), 
sex ENUM('M', 'F', 'O') NOT NULL,
email VARCHAR(100) NOT NULL,CREATE SCHEMA ap_db;
USE ap_db;
 
-- -----------------------------------------------------
-- Table Users and profile
-- -----------------------------------------------------
 
CREATE TABLE user(
id INT AUTO_INCREMENT,
first_name VARCHAR(80) NOT NULL,
middle_name VARCHAR(80) DEFAULT(NULL),
surname VARCHAR(80) NOT NULL,
last_name VARCHAR(80) NOT NULL,
sex ENUM('M', 'F', 'O') NOT NULL,
email VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
phone_number CHAR(30),
birthdate DATE NOT NULL,
department VARCHAR(60) NOT NULL,
city VARCHAR(70) NOT NULL,
phone_number_verified BOOLEAN DEFAULT(FALSE),
is_blocked BOOLEAN DEFAULT(FALSE),
is_restricted BOOLEAN DEFAULT(FALSE),
created_at DATETIME,
profile_id INT UNIQUE,
UNIQUE(email, phone_number),
PRIMARY KEY (id));
 
CREATE TABLE user_profile(
id INT AUTO_INCREMENT,
username VARCHAR(25) NOT NULL,
picture VARCHAR(120),
biography VARCHAR(150),
notification_id INT,
pet_id INT,
email_verified BOOLEAN DEFAULT(FALSE),
updated_at DATETIME,
UNIQUE(username),
PRIMARY KEY (id));
 
-- FOREIGN KEY
 
# User has profile
ALTER TABLE `user`
ADD CONSTRAINT user_has_profile FOREIGN KEY(profile_id)
REFERENCES `user_profile`(id);
 
-- -----------------------------------------------------
-- Table Entities and profile
-- -----------------------------------------------------
 
CREATE TABLE veterinary(
id INT AUTO_INCREMENT,
name VARCHAR(120) NOT NULL,
email VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
phone_number CHAR(30) NOT NULL,
department VARCHAR(60) NOT NULL,
city VARCHAR(70) NOT NULL,
address VARCHAR(150) NOT NULL,
is_blocked BOOLEAN DEFAULT(FALSE),
is_restricted BOOLEAN DEFAULT(FALSE),
created_at DATETIME,
profile_id INT UNIQUE,
PRIMARY KEY(id),
UNIQUE(email, phone_number));
 
CREATE TABLE veterinary_profile(
id INT AUTO_INCREMENT,
picture BLOB,
about VARCHAR(200),
notification_id INT,
pet_id INT,
updated_at DATETIME,
PRIMARY KEY(id));
 
CREATE TABLE foundation(
id INT AUTO_INCREMENT,
name VARCHAR(120) NOT NULL,
email VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
phone_number CHAR(30) NOT NULL,
department VARCHAR(60) NOT NULL,
city VARCHAR(70) NOT NULL,
address VARCHAR(150) NOT NULL,
is_blocked BOOLEAN DEFAULT(FALSE),
is_restricted BOOLEAN DEFAULT(FALSE),
created_at DATETIME,
profile_id INT UNIQUE,
PRIMARY KEY(id),
UNIQUE(email, phone_number));
 
CREATE TABLE foundation_profile(
id INT AUTO_INCREMENT,
picture BLOB,
about VARCHAR(200),
notification_id INT,
pet_id INT,
updated_at DATETIME,
PRIMARY KEY(id));
 
-- FOREIGN KEYS
 
# Veterinary has profile
ALTER TABLE `veterinary`
ADD CONSTRAINT veterinary_has_profile FOREIGN KEY(profile_id)
REFERENCES `veterinary_profile`(id);
 
# Foundation has profile
ALTER TABLE `foundation`
ADD CONSTRAINT foundation_has_profile FOREIGN KEY(profile_id)
REFERENCES `foundation_profile`(id);
 
-- -----------------------------------------------------
-- Table Token for auth server
-- -----------------------------------------------------
 
CREATE TABLE token(
id INT AUTO_INCREMENT,
is_revoke BOOLEAN DEFAULT(NULL),
created_at DATETIME,
updated_at DATETIME,
PRIMARY KEY(id));
 
-- -----------------------------------------------------
-- Table Roles and permission
-- -----------------------------------------------------
 
CREATE TABLE role(
id INT AUTO_INCREMENT,
name VARCHAR(60) NOT NULL,
permission_id INT,
PRIMARY KEY(id),
UNIQUE(name));
 
# Bridge table N:M
CREATE TABLE profiles_roles(
id INT AUTO_INCREMENT,
role_id INT,
profile_id INT,
PRIMARY KEY(id));
 
CREATE TABLE permission(
id INT AUTO_INCREMENT,
name VARCHAR(60) NOT NULL,
description VARCHAR(100),
PRIMARY KEY(id),
UNIQUE(name));
 
-- FOREIGN KEYS
 
# Profiles has roles
ALTER TABLE `profiles_roles`
ADD CONSTRAINT FK_profile_roleid FOREIGN KEY (role_id)
REFERENCES `role`(id);
 
ALTER TABLE `profiles_roles`
ADD CONSTRAINT FK_role_userid FOREIGN KEY (profile_id)
REFERENCES `user_profile`(id);
 
ALTER TABLE `profiles_roles`
ADD CONSTRAINT FK_role_veterinaryid FOREIGN KEY (profile_id)
REFERENCES `veterinary_profile`(id);
 
ALTER TABLE `profiles_roles`
ADD CONSTRAINT FK_role_foundationid FOREIGN KEY (profile_id)
REFERENCES `foundation_profile`(id);
 
#Role has permissions
ALTER TABLE `role`
ADD CONSTRAINT FK_role_permissionid FOREIGN KEY (permission_id)
REFERENCES `permission`(id);
 
-- -----------------------------------------------------
-- Table Announcement and all associated with it
-- -----------------------------------------------------
CREATE TABLE category(
id INT AUTO_INCREMENT,
name VARCHAR(60) NOT NULL,
description VARCHAR(100),
announcement_id INT,
PRIMARY KEY(id),
UNIQUE(name));
 
# Category 
CREATE TABLE announce(
id INT AUTO_INCREMENT,
profile_id INT,
category_id INT,
title VARCHAR(30) NOT NULL,
description VARCHAR(100) NOT NULL,
image BLOB,
likes INT DEFAULT(0),
created_at DATETIME,
PRIMARY KEY(id)); 
 
# Category
CREATE TABLE adopt(
id INT AUTO_INCREMENT,
profile_id INT,
pet_id INT UNIQUE,
title VARCHAR(40) NOT NULL,
description VARCHAR(100) NOT NULL,
image BLOB,
likes INT DEFAULT(0),
created_at DATETIME,
PRIMARY KEY(id));
 
CREATE TABLE notification(
id INT AUTO_INCREMENT,
profile_id INT,
title VARCHAR(30),
description VARCHAR(60),
image BLOB,
created_at DATETIME,
PRIMARY KEY(id));
 
CREATE TABLE comment(
id INT AUTO_INCREMENT,
id_sender INT,
text VARCHAR(500),
created_at DATETIME,
updated_at DATETIME,
PRIMARY KEY(id));
 
CREATE TABLE comment_reply(
id INT AUTO_INCREMENT,
comment_id INT, 
id_sender INT,
text VARCHAR(500),
created_at DATETIME,
updated_at DATETIME,
PRIMARY KEY(id));
 
-- FOREIGN KEYS
 
/*#Category has announcements
ALTER TABLE `category`
ADD CONSTRAINT FK_category_announceid FOREIGN KEY (id)
REFERENCES `announce`(category_id);
 
ALTER TABLE `category`
ADD CONSTRAINT FK_category_adoptid FOREIGN KEY (id)
REFERENCES `adopt`(category_id);*/
 
#Profile has annonucements (ANNOUNCE)
ALTER TABLE `announce`
ADD CONSTRAINT FK_announce_userid FOREIGN KEY (profile_id)
REFERENCES `user_profile`(id);
 
ALTER TABLE `announce`
ADD CONSTRAINT FK_announce_veterinaryid FOREIGN KEY (profile_id)
REFERENCES `veterinary_profile`(id);
 
ALTER TABLE `announce`
ADD CONSTRAINT FK_announce_foundationid FOREIGN KEY (profile_id)
REFERENCES `foundation_profile`(id);
 
#Profile has announcements (ADOPT)
ALTER TABLE `adopt`
ADD CONSTRAINT FK_adopt_userid FOREIGN KEY (profile_id)
REFERENCES `user_profile`(id);
 
ALTER TABLE `adopt`
ADD CONSTRAINT FK_adopt_veterinaryid FOREIGN KEY (profile_id)
REFERENCES `veterinary_profile`(id);
 
ALTER TABLE `adopt`
ADD CONSTRAINT FK_adopt_foundationid FOREIGN KEY (profile_id)
REFERENCES `foundation_profile`(id);
 
#Profile has notifications
ALTER TABLE `notification`
ADD CONSTRAINT FK_notification_userid FOREIGN KEY (profile_id)
REFERENCES `user_profile`(id);
 
ALTER TABLE `notification`
ADD CONSTRAINT FK_notification_veterinaryid FOREIGN KEY (profile_id)
REFERENCES `veterinary_profile`(id);
 
ALTER TABLE `notification`
ADD CONSTRAINT FK_notification_foundationid FOREIGN KEY (profile_id)
REFERENCES `foundation_profile`(id);
 
#Comment has replies
ALTER TABLE `comment_reply`
ADD CONSTRAINT FK_reply_commentid FOREIGN KEY (comment_id)
REFERENCES `comment`(id);
 
-- -----------------------------------------------------
-- Table Report 
-- -----------------------------------------------------
 
CREATE TABLE report(
id INT AUTO_INCREMENT,
profile_reported_id INT,
subject VARCHAR(40) NOT NULL,
description VARCHAR(120) NOT NULL,
status ENUM('A', 'C', 'S'),
created_at DATETIME,
PRIMARY KEY(id));
 
 -- FOREIGN KEYS
 
# Profile has reports
ALTER TABLE `report`
ADD CONSTRAINT FK_report_userid FOREIGN KEY (profile_reported_id)
REFERENCES `user_profile`(id);
 
ALTER TABLE `report`
ADD CONSTRAINT FK_report_veterinaryid FOREIGN KEY (profile_reported_id)
REFERENCES `veterinary_profile`(id);
 
ALTER TABLE `report`
ADD CONSTRAINT FK_report_foundationid FOREIGN KEY (profile_reported_id)
REFERENCES `foundation_profile`(id);
 
-- -----------------------------------------------------
-- Table Mascot
-- -----------------------------------------------------
 
CREATE TABLE pet(
id INT AUTO_INCREMENT,
name VARCHAR(60) NOT NULL,
age INT(2) NOT NULL,
clinical_history TEXT,
type VARCHAR(30) NOT NULL,
breed VARCHAR(50)  NOT NULL,
profile_id INT,
status ENUM('A', 'U'),
created_at DATETIME,
updated_at DATETIME,
PRIMARY KEY(id));
 
-- FOREIGN KEYS
 
#Profile has pets
ALTER TABLE `pet`
ADD CONSTRAINT FK_pet_userid FOREIGN KEY (profile_id)
REFERENCES `user_profile`(id);
 
ALTER TABLE `pet`
ADD CONSTRAINT FK_pet_veterinaryid FOREIGN KEY (profile_id)
REFERENCES `veterinary_profile`(id);
 
ALTER TABLE `pet`
ADD CONSTRAINT FK_pet_foundationid FOREIGN KEY (profile_id)
REFERENCES `foundation_profile`(id);
 
#Adopt has pet
ALTER TABLE `adopt`
ADD CONSTRAINT FK_adopt_petid FOREIGN KEY (pet_id)
REFERENCES `pet`(id);
 
-- -----------------------------------------------------
-- Table services
-- -----------------------------------------------------
 
/*# Bridge table
CREATE TABLE veterinary_service(
veterinary_id INT,
service_id INT);*/
 
CREATE TABLE service(
id INT AUTO_INCREMENT,
name VARCHAR(60) NOT NULL,
description VARCHAR(150) NOT NULL,
type VARCHAR(50) NOT NULL,
cost DECIMAL(9,2) NOT NULL,
PRIMARY KEY(id));
 
-- -----------------------------------------------------
-- !!Table chat system
-- -----------------------------------------------------
/*
CREATE TABLE chat(
recipient
sender);*/
