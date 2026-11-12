-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS Skincare_Shop_db;
USE Skincare_Shop_db;
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    subject VARCHAR(50),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 2. Create the unified table for everyone (Admins, Staff, and Customers)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,  -- Maps to 'Full Name' or 'Username'
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    password_hash VARCHAR(255) NOT NULL,    -- Extra length for Bcrypt/Werkzeug hashes
    role ENUM('admin', 'staff', 'customer') DEFAULT 'customer',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;