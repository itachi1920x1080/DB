USE Shop_db;

-- ១. បន្ថែម Column 'category' ទៅក្នុង Table products ប្រសិនបើមិនទាន់មាន
-- នេះសម្រាប់មុខងារ Dropdown Filter (Clothing, Accessories, Shoes)
ALTER TABLE products ADD COLUMN category VARCHAR(50) DEFAULT 'clothing' AFTER image;

-- ២. បន្ថែម Column 'stock' ប្រសិនបើមិនទាន់មាន (សម្រាប់គ្រប់គ្រងចំនួនទំនិញ)
ALTER TABLE products ADD COLUMN stock INT DEFAULT 0 AFTER price;

-- ៣. កែសម្រួល Table orders ឱ្យមាន Column 'total_amount' 
-- (អ្នកបានសរសេររួចហើយ តែនេះជាការធានាថាវាមាន Type ត្រឹមត្រូវ)
ALTER TABLE orders MODIFY COLUMN total_amount DECIMAL(10, 2) DEFAULT 0.00;

-- ៤. បង្កើត Table order_items (សំខាន់ខ្លាំង៖ សម្រាប់ផ្ទុកទំនិញច្រើនមុខក្នុង Order តែមួយ)
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);