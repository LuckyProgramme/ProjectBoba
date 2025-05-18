CREATE DATABASE boba;
USE boba;
show tables;
select * from admin;
-- Admin Table
CREATE TABLE admin (
    admin_name VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);
INSERT INTO admin VALUES ("admin", "1234");

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(225) NOT NULL,
    role ENUM('cashier', 'customer'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Ingredients Table (for inventory)
CREATE TABLE ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(100) NOT NULL,
    unit VARCHAR(50),
    stock_quantity DECIMAL(10,2) DEFAULT 0,
    low_stock_threshold DECIMAL(10,2) DEFAULT 0,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP
);
drop table menu_items;
drop table item_sizes;
-- Menu Items Table
-- Menu Items
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    image VARCHAR(255)
);

-- Item Sizes with unique ID (safer referencing)
CREATE TABLE item_sizes (
    item_size_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    size ENUM('Small', 'Medium', 'Large') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE
);


-- Milk Tea Base (Separate if needed for customization)
CREATE TABLE milktea_base (
    base_id INT AUTO_INCREMENT PRIMARY KEY,
    base_name VARCHAR(50) NOT NULL,
    base_price DECIMAL(10,2) NOT NULL
);

-- Sizes with Multiplier
CREATE TABLE sizes (
    size_id INT AUTO_INCREMENT PRIMARY KEY,
    size_name ENUM('Small', 'Medium', 'Large') NOT NULL,
    size_multiplier DECIMAL(4,2) DEFAULT 1.00
);

-- Toppings
CREATE TABLE toppings (
    topping_id INT AUTO_INCREMENT PRIMARY KEY,
    topping_name ENUM('boba','jellies','pudding','oreo') NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    customer_name VARCHAR(100),
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'completed', 'cancelled') DEFAULT 'active',
    payment_status ENUM('pending', 'paid') DEFAULT 'pending',
    total_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Order Items
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_size_id INT NOT NULL, -- points to specific item and size combination
    quantity INT DEFAULT 1,
    item_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_size_id) REFERENCES item_sizes(size_id)
);

-- Order Item Toppings
CREATE TABLE order_item_toppings (
    item_topping_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    topping_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES order_items(item_id),
    FOREIGN KEY (topping_id) REFERENCES toppings(topping_id)
);

-- Payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('cash', 'gcash') NOT NULL DEFAULT 'cash',
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- Sample Menu Data
INSERT INTO menu_items (item_id, name, category, image) VALUES
(1, 'BobaMilk', 'milk-tea', 'Images/t1.jpg'),
(2, 'Okinawa Milk Tea', 'milk-tea', 'Images/t2.jpg'),
(3, 'Wintermelon Milk Tea', 'milk-tea', 'Images/t3.jpg'),
(4, 'Mango Fruit Tea', 'fruit-tea', 'assets/fruit-tea-mango.jpg'),
(5, 'Lychee Fruit Tea', 'fruit-tea', 'assets/fruit-tea-lychee.jpg'),
(6, 'Strawberry Fruit Tea', 'fruit-tea', 'assets/fruit-tea-strawberry.jpg'),
(7, 'Iced Coffee', 'coffee', 'assets/coffee-iced.jpg'),
(8, 'Cappuccino', 'coffee', 'assets/coffee-cappuccino.jpg'),
(9, 'Caramel Macchiato', 'coffee', 'assets/coffee-caramel.jpg'),
(10, 'French Fries', 'snacks', 'assets/snack-fries.jpg'),
(11, 'Chicken Nuggets', 'snacks', 'assets/snack-nuggets.jpg'),
(12, 'Egg Sandwich', 'snacks', 'assets/snack-egg-sandwich.jpg');

-- Corresponding Sizes and Prices
INSERT INTO item_sizes (item_id, size, price) VALUES
(1, 'Small', 100), (1, 'Medium', 120), (1, 'Large', 140),
(2, 'Small', 110), (2, 'Medium', 130), (2, 'Large', 150),
(3, 'Small', 105), (3, 'Medium', 125), (3, 'Large', 145),
(4, 'Small', 105), (4, 'Medium', 125), (4, 'Large', 145),
(5, 'Small', 105), (5, 'Medium', 125), (5, 'Large', 145),
(6, 'Small', 105), (6, 'Medium', 125), (6, 'Large', 145),
(7, 'Small', 105), (7, 'Medium', 125), (7, 'Large', 145),
(8, 'Small', 105), (8, 'Medium', 125), (8, 'Large', 145),
(9, 'Small', 105), (9, 'Medium', 125), (9, 'Large', 145);

select * from item_sizes;
select  * from menu_items;


 SELECT m.item_id, m.name, m.category, m.image, s.size, s.price 
                         FROM menu_items m 
                         JOIN item_sizes s ON m.item_id = s.item_id 
                         ORDER BY m.item_id, FIELD(s.size, 'Small', 'Medium', 'Large');
