CREATE DATABASE IF NOT EXISTS shopsphere CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopsphere;
CREATE TABLE IF NOT EXISTS users (
 user_id BIGINT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL, email VARCHAR(160) NOT NULL UNIQUE,
 password_hash VARCHAR(100) NOT NULL, mobile VARCHAR(20), role ENUM('CUSTOMER','ADMIN') NOT NULL DEFAULT 'CUSTOMER',
 status BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS categories (
 category_id BIGINT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL UNIQUE, description VARCHAR(500), status BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS products (
 product_id BIGINT PRIMARY KEY AUTO_INCREMENT, category_id BIGINT NULL, name VARCHAR(160) NOT NULL, brand VARCHAR(100),
 description TEXT, price DECIMAL(10,2) NOT NULL, discount DECIMAL(5,2) NOT NULL DEFAULT 0,
 stock INT NOT NULL DEFAULT 0, image_url VARCHAR(500), status BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_product_category FOREIGN KEY(category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
 CONSTRAINT chk_product_price CHECK(price >= 0), CONSTRAINT chk_product_stock CHECK(stock >= 0)
);
CREATE TABLE IF NOT EXISTS cart (
 cart_id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id BIGINT NOT NULL, product_id BIGINT NOT NULL, quantity INT NOT NULL DEFAULT 1,
 UNIQUE KEY uq_cart_user_product(user_id, product_id), FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE, CHECK(quantity > 0)
);
CREATE TABLE IF NOT EXISTS wishlist (
 wishlist_id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id BIGINT NOT NULL, product_id BIGINT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_wishlist_user_product(user_id, product_id), FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS addresses (
 address_id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id BIGINT NOT NULL, address_line VARCHAR(255) NOT NULL, city VARCHAR(100) NOT NULL,
 state VARCHAR(100) NOT NULL, pincode VARCHAR(12) NOT NULL, address_type VARCHAR(30) DEFAULT 'HOME',
 FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS orders (
 order_id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id BIGINT NOT NULL, address_text VARCHAR(600) NOT NULL,
 total_amount DECIMAL(12,2) NOT NULL, discount DECIMAL(12,2) NOT NULL DEFAULT 0, payment_method VARCHAR(30) NOT NULL DEFAULT 'MOCK',
 payment_status VARCHAR(30) NOT NULL DEFAULT 'SUCCESS', order_status VARCHAR(30) NOT NULL DEFAULT 'PLACED', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(user_id)
);
CREATE TABLE IF NOT EXISTS order_items (
 order_item_id BIGINT PRIMARY KEY AUTO_INCREMENT, order_id BIGINT NOT NULL, product_id BIGINT NULL, product_name VARCHAR(160) NOT NULL,
 quantity INT NOT NULL, price DECIMAL(10,2) NOT NULL, FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS payments (
 payment_id BIGINT PRIMARY KEY AUTO_INCREMENT, order_id BIGINT NOT NULL, payment_method VARCHAR(30) NOT NULL,
 transaction_reference VARCHAR(100), amount DECIMAL(12,2) NOT NULL, payment_status VARCHAR(30) NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS reviews (
 review_id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id BIGINT NOT NULL, product_id BIGINT NOT NULL, rating INT NOT NULL,
 review_text VARCHAR(1000), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UNIQUE KEY uq_review_user_product(user_id,product_id),
 FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE, FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE, CHECK(rating BETWEEN 1 AND 5)
);
CREATE TABLE IF NOT EXISTS coupons (
 coupon_id BIGINT PRIMARY KEY AUTO_INCREMENT, code VARCHAR(40) NOT NULL UNIQUE, discount_type ENUM('PERCENT','FIXED') NOT NULL,
 discount_value DECIMAL(10,2) NOT NULL, minimum_order DECIMAL(10,2) NOT NULL DEFAULT 0, maximum_discount DECIMAL(10,2),
 expiry_date DATE, status BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS coupon_usage (
 usage_id BIGINT PRIMARY KEY AUTO_INCREMENT, coupon_id BIGINT NOT NULL, user_id BIGINT NOT NULL, order_id BIGINT NOT NULL,
 used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(coupon_id) REFERENCES coupons(coupon_id),
 FOREIGN KEY(user_id) REFERENCES users(user_id), FOREIGN KEY(order_id) REFERENCES orders(order_id)
);
INSERT IGNORE INTO categories(name,description) VALUES ('Electronics','Devices and accessories'),('Fashion','Everyday clothing'),('Home','Useful home products');
INSERT INTO products(category_id,name,brand,description,price,discount,stock,image_url) SELECT category_id,'Wireless Headphones','SoundMax','Comfortable wireless headphones with balanced sound.',2499,10,25,'https://images.unsplash.com/photo-1505740420928-5e560c06d30e' FROM categories WHERE name='Electronics' AND NOT EXISTS(SELECT 1 FROM products WHERE name='Wireless Headphones');
INSERT INTO products(category_id,name,brand,description,price,discount,stock,image_url) SELECT category_id,'Everyday Backpack','UrbanCarry','A practical backpack for college and travel.',1599,5,18,'https://images.unsplash.com/photo-1553062407-98eeb64c6a62' FROM categories WHERE name='Fashion' AND NOT EXISTS(SELECT 1 FROM products WHERE name='Everyday Backpack');
INSERT INTO products(category_id,name,brand,description,price,discount,stock,image_url) SELECT category_id,'Desk Lamp','BrightNest','Minimal LED desk lamp for study and work.',999,0,30,'https://images.unsplash.com/photo-1507473885765-e6ed057f782c' FROM categories WHERE name='Home' AND NOT EXISTS(SELECT 1 FROM products WHERE name='Desk Lamp');
