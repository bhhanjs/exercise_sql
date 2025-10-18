-- DATABASE ------------------
CREATE DATABASE IF NOT EXISTS `Restaurants`
USE `Restaurants`



-- TABLE USERS ---------------------
CREATE TABLE `Users`(
	`user_id` INT PRIMARY KEY AUTO_INCREMENT,
	`full_name` VARCHAR(255),
	`email` VARCHAR(255),
	`password` VARCHAR(255)
)

INSERT INTO `Users`
	(`full_name`, `email`, `password`) 
VALUES 
	('Anna Nguyen', 'anna@gmail.com', '123'),
	('John Doe', 'john@gmail.com', '123'),
	('Linh Tran', 'linh@gmail.com', '123'),
	('David Le', 'david@gmail.com', '123'),
	('Marie Pham', 'marie@gmail.com', '123'),
	('Tom Phan', 'tom@gmail.com', '123'),
	('Lisa Vu', 'lisa@gmail.com', '123'),
	('Alex Ho', 'alex@gmail.com', '123');

-- TABLE RESTAURANTS ---------------
CREATE TABLE `Restaurants`(
	`res_id` INT PRIMARY KEY AUTO_INCREMENT,
	`res_name` VARCHAR(255),
	`image` VARCHAR(255),
	`desc` VARCHAR(255)
)

INSERT INTO `Restaurants` 
	(`res_name`, `image`, `desc`) 
VALUES
	('Pizza House', 'pizza.jpg', 'Best pizza in town'),
	('Sushi Bar', 'sushi.jpg', 'Fresh sushi daily'),
	('Burger King', 'burger.jpg', 'Juicy burgers'),
	('Vegan Garden', 'vegan.jpg', 'Healthy green meals'),
	('Korean BBQ', 'bbq.jpg', 'Authentic Korean food');

-- TABLE RATE_RES -------------------
CREATE TABLE `Rate_res`(
	`user_id` INT,
	`res_id` INT,
	`amount` INT,
	`date_rate` DATETIME,
	FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
	FOREIGN key (`res_id`) REFERENCES `Restaurants` (`res_id`)
)

INSERT INTO `Rate_res`
	(`user_id`, `res_id`, `amount`, `date_rate`)
VALUES
	(1,1,5,NOW()), (2,2,4,NOW()), (3,1,3,NOW()), 
	(3,2,5,NOW()), (4,3,4,NOW()), (5,4,5,NOW()), 
	(6,5,4,NOW()), (7,2,3,NOW()), (8,1,2,NOW());

-- TABLE LIKE_RES --------------------
CREATE TABLE `Like_res`(
	`user_id` INT,
	`res_id` INT,
	`date_like` DATETIME,
	FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
	FOREIGN KEY (`res_id`) REFERENCES `Restaurants` (`res_id`)
)


INSERT INTO `Like_res`
	(`user_id`, `res_id`, `date_like`)
VALUES
	(8,1,NOW()), (3,3,NOW()), (4,2,NOW()), (1,2,NOW()),
	(6,1,NOW()), (6,5,NOW()), (5,4,NOW()), (3,1,NOW()),
	(4,3,NOW()), (2,2,NOW()), (6,3,NOW()), (3,4,NOW()), 
	(2,1,NOW()), (3,2,NOW()), (3,5,NOW()), (7,2,NOW()),
	(1,5,NOW()), (2,5,NOW()), (2,3,NOW()), (2,4,NOW())
	


-- TABLE FOOD_TYPE -------------------
CREATE TABLE `Food_type`(
	`type_id` INT PRIMARY KEY AUTO_INCREMENT,
	`type_name` VARCHAR(255)
)

INSERT INTO `Food_type`
	(`type_name`)
VALUES
	('Fast Food'), ('Asian'), ('Vegan'), ('Dessert');

-- TABLE FOOD ----------------------
CREATE TABLE `Food`(
	`food_id` INT PRIMARY KEY AUTO_INCREMENT,
	`food_name` VARCHAR(255),
	`image` VARCHAR (255),
	`price` FLOAT,
	`desc` VARCHAR(255),
	`type_id`INT,
	FOREIGN KEY (`type_id`) REFERENCES `Food_type` (`type_id`)
)

INSERT INTO `Food`
	(`food_name`, `image`, 	`price`, `desc`, `type_id`)
VALUES
	('Pepperoni Pizza', 'pizza1.jpg', 12.5, 'Cheesy pizza', 1),
	('California Roll', 'sushi1.jpg', 9.0, 'Fresh roll', 2),
	('Beef Burger', 'burger1.jpg', 8.5, 'Grilled beef burger', 1),
	('Green Salad', 'salad1.jpg', 6.0, 'Vegan fresh salad', 3),
	('Matcha Cake', 'cake1.jpg', 5.0, 'Dessert cake', 4);


-- TABLE SUB_FOOD -----------------
CREATE TABLE `Sub_food`(
	`sub_id` INT PRIMARY KEY AUTO_INCREMENT,
	`sub_name` VARCHAR(255),
	`sub_price` FLOAT,
	`food_id` INT,
	FOREIGN KEY (`food_id`) REFERENCES `Food`(`food_id`)
)

INSERT INTO `Sub_food`
	(`sub_name`, `sub_price`, `food_id`)
VALUES
	('Extra cheese', 2.0, 1),
	('Wasabi', 1.0, 2),
	('French fries', 2.5, 3),
	('Avocado topping', 1.5, 4),
	('Cream sauce', 1.0, 5);

-- TABLE ORDERS -------------------
CREATE TABLE `Oders`(
	`user_id` INT,
	`food_id` INT,
	`amount` INT,
	`code` VARCHAR(255),
	`arr_sub_id` VARCHAR(255),
	FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
	FOREIGN KEY (`food_id`) REFERENCES `Food`(`food_id`)
)

INSERT INTO `Oders`
	(`user_id`, `food_id`, `amount`, `code`, `arr_sub_id`)
VALUES
	(1,1,2,'ORD001','1,3'),
	(2,2,1,'ORD002','2'),
	(3,3,3,'ORD003','2,5'),
	(3,4,2,'ORD004','4,2'),
	(4,1,1,'ORD005','1,2,5'),
	(4,2,1,'ORD006','2'),
	(5,3,1,'ORD007','3,2'),
	(6,1,4,'ORD008','1,5'),
	(6,3,2,'ORD009','3,4'),
	(8,4,1,'ORD010','1,5,3'),
	(6,1,2,'ORD009','3,4')
	


-- HANDLING -----------------------
-- 5 người like nhà hàng nhiều nhất
SELECT `Like_res`.`user_id`, `Users`.`user_id`, `full_name`, COUNT(`Like_res`.`user_id`) AS `count`
FROM `Like_res` 
INNER JOIN `Users` ON `Like_res`.`user_id` = `Users`.`user_id`
GROUP BY `Like_res`.`user_id`
ORDER BY `count` DESC
LIMIT 5


-- 2 nhà hàng có lượt like nhiều nhất
SELECT `Like_res`.`res_id`, `Restaurants`.`res_id`, `Restaurants`.`res_name`, COUNT(`Like_res`.`res_id`) AS `count`
FROM `Like_res`
INNER JOIN `Restaurants` ON `Like_res`.`res_id` = `Restaurants`.`res_id`
GROUP BY `Like_res`.`res_id`
ORDER BY `count` DESC
LIMIT 2

-- Người đã đặt nhà hàng nhiều nhất
SELECT `Oders`.`user_id`, `Users`.`user_id`, `Users`.`full_name`, COUNT(`Oders`.`user_id`) AS `count`
FROM `Oders`
INNER JOIN `Users` ON `Oders`.`user_id` = `Users`.`user_id`
GROUP BY `Oders`.`user_id`
ORDER BY `count` DESC
LIMIT 1
