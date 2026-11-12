USE Shop_db;

-- ១. បិទការត្រួតពិនិត្យ Foreign Key ជាបណ្ដោះអាសន្ន (វិធីងាយស្រួលបំផុត)
SET FOREIGN_KEY_CHECKS = 0;

-- ២. លុប Table ទាំងអស់ដែលពាក់ព័ន្ធនឹង Order
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;

-- ៣. បើកការត្រួតពិនិត្យ Foreign Key ឡើងវិញ
SET FOREIGN_KEY_CHECKS = 1;

-- ៤. បង្កើត Table orders ឡើងវិញឱ្យត្រឹមត្រូវ
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    total DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'paid', 'shipped', 'completed', 'cancelled') DEFAULT 'pending',
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE SET NULL
);

-- ៥. បង្កើត Table order_items ឡើងវិញ
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);