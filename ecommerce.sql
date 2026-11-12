
drop database ecommerce;

CREATE DATABASE IF NOT EXISTS ecommerce
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ecommerce;

SET FOREIGN_KEY_CHECKS = 0;


-- ============================================================
-- AUTH & IDENTITY
-- ============================================================

CREATE TABLE roles (
    id          CHAR(36)     NOT NULL DEFAULT (UUID()),
    name        VARCHAR(100) NOT NULL,
    inserted_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_roles_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE users (
    id            CHAR(36)     NOT NULL DEFAULT (UUID()),
    email         VARCHAR(255) NOT NULL,
    first_name    VARCHAR(255) NOT NULL,
    last_name     VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    address VARCHAR(255), 
    city VARCHAR(100),
    state VARCHAR(50),    
    zip_code INT,
    active        TINYINT(1)   NOT NULL DEFAULT 1,
    inserted_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ២. បង្កើតតារាងអាសយដ្ឋាន (User Addresses Table)
CREATE TABLE user_addresses (
    id           CHAR(36)     NOT NULL DEFAULT (UUID()),
    user_id      CHAR(36)     NOT NULL,
    address_type VARCHAR(20)  NOT NULL DEFAULT 'shipping',
    full_name    VARCHAR(255) NOT NULL,
    phone        VARCHAR(30)  DEFAULT NULL,
    address      VARCHAR(255) NOT NULL,
    city         VARCHAR(100) NOT NULL,
    state        VARCHAR(100) DEFAULT NULL,
    zip_code     VARCHAR(20)  DEFAULT NULL,
    country      CHAR(2)      NOT NULL DEFAULT 'KH',
    is_default   TINYINT(1)   NOT NULL DEFAULT 0,
    inserted_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_ua_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT chk_addr_type CHECK (address_type IN ('shipping', 'billing'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- បង្កើត Index រួមគ្នាដើម្បីល្បឿនស្វែងរក user_id និងអាសយដ្ឋានចម្បង (Composite Index)
CREATE INDEX idx_ua_user_default ON user_addresses(user_id, is_default);


CREATE TABLE user_roles (
    user_id     CHAR(36)  NOT NULL,
    role_id     CHAR(36)  NOT NULL,
    inserted_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_ur_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- CATALOG
-- ============================================================

CREATE TABLE categories (
    id          CHAR(36)     NOT NULL DEFAULT (UUID()),
    name        VARCHAR(255) NOT NULL,
    slug        VARCHAR(300) NOT NULL,
    description TEXT,
    parent_id   CHAR(36)     DEFAULT NULL,
    inserted_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_categories_slug (slug),
    CONSTRAINT fk_cat_parent FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE product_statuses (
    id          CHAR(36)    NOT NULL DEFAULT (UUID()),
    name        VARCHAR(50) NOT NULL,
    inserted_at DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_ps_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE products (
    id                CHAR(36)       NOT NULL DEFAULT (UUID()),
    sku               VARCHAR(255)   NOT NULL,
    name              VARCHAR(255)   NOT NULL,
    slug              VARCHAR(300)   NOT NULL,
    description       TEXT,
    product_status_id CHAR(36)       DEFAULT NULL,
    regular_price     DECIMAL(12,2)  NOT NULL DEFAULT 0.00,
    discount_price    DECIMAL(12,2)  NOT NULL DEFAULT 0.00,
    is_free           TINYINT(1)     NOT NULL DEFAULT 0,
    taxable           TINYINT(1)     NOT NULL DEFAULT 0,
    currency          CHAR(3)        NOT NULL DEFAULT 'USD',
    inserted_at       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_products_sku  (sku),
    UNIQUE KEY uq_products_slug (slug),
    CONSTRAINT chk_regular_price   CHECK (regular_price  >= 0),
    CONSTRAINT chk_discount_price  CHECK (discount_price >= 0),
    CONSTRAINT chk_discount_lte    CHECK (discount_price <= regular_price),
    CONSTRAINT fk_prod_status FOREIGN KEY (product_status_id)
        REFERENCES product_statuses(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE product_categories (
    product_id  CHAR(36)  NOT NULL,
    category_id CHAR(36)  NOT NULL,
    inserted_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, category_id),
    CONSTRAINT fk_pc_product  FOREIGN KEY (product_id)  REFERENCES products(id)   ON DELETE CASCADE,
    CONSTRAINT fk_pc_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE tags (
    id          CHAR(36)     NOT NULL DEFAULT (UUID()),
    name        VARCHAR(100) NOT NULL,
    slug        VARCHAR(120) NOT NULL,
    inserted_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_tags_name (name),
    UNIQUE KEY uq_tags_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE product_tags (
    product_id  CHAR(36)  NOT NULL,
    tag_id      CHAR(36)  NOT NULL,
    inserted_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, tag_id),
    CONSTRAINT fk_pt_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_pt_tag     FOREIGN KEY (tag_id)     REFERENCES tags(id)     ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE product_files (
    id               CHAR(36)     NOT NULL DEFAULT (UUID()),
    product_id       CHAR(36)     NOT NULL,
    filename         VARCHAR(255) NOT NULL,
    storage_key      VARCHAR(512) NOT NULL,
    file_size_bytes  BIGINT       NOT NULL,
    mime_type        VARCHAR(127) NOT NULL,
    checksum_sha256  CHAR(64)     DEFAULT NULL,
    version          VARCHAR(50)  NOT NULL DEFAULT '1.0',
    inserted_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_pf_storage_key (storage_key),
    CONSTRAINT chk_file_size CHECK (file_size_bytes > 0),
    CONSTRAINT fk_pf_product FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- PROMOTIONS
-- ============================================================

CREATE TABLE coupons (
    id          CHAR(36)      NOT NULL DEFAULT (UUID()),
    code        VARCHAR(255)  NOT NULL,
    description TEXT,
    value       DECIMAL(12,2) NOT NULL,
    value_type  VARCHAR(10)   NOT NULL DEFAULT 'fixed',
    active      TINYINT(1)    NOT NULL DEFAULT 1,
    usage_limit INT           DEFAULT NULL,
    used_count  INT           NOT NULL DEFAULT 0,
    start_date  DATETIME      DEFAULT NULL,
    end_date    DATETIME      DEFAULT NULL,
    inserted_at DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_coupons_code (code),
    CONSTRAINT chk_coupon_value      CHECK (value > 0),
    CONSTRAINT chk_coupon_used       CHECK (used_count >= 0),
    CONSTRAINT chk_coupon_value_type CHECK (value_type IN ('fixed','percent')),
    CONSTRAINT chk_coupon_percent    CHECK (value_type <> 'percent' OR value <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- ORDERS & PAYMENTS
-- ============================================================

CREATE TABLE sales_orders (
    id          CHAR(36)      NOT NULL DEFAULT (UUID()),
    order_date  DATE          NOT NULL DEFAULT (CURRENT_DATE),
    total       DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    status      VARCHAR(20)   NOT NULL DEFAULT 'pending',
    user_id     CHAR(36)      DEFAULT NULL,
    coupon_id   CHAR(36)      DEFAULT NULL,
    inserted_at DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT chk_order_total  CHECK (total >= 0),
    CONSTRAINT chk_order_status CHECK (status IN ('pending','paid','refunded','disputed','cancelled')),
    CONSTRAINT fk_so_user   FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE SET NULL,
    CONSTRAINT fk_so_coupon FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE order_products (
    id          CHAR(36)      NOT NULL DEFAULT (UUID()),
    order_id    CHAR(36)      NOT NULL,
    product_id  CHAR(36)      DEFAULT NULL,
    sku         VARCHAR(255)  NOT NULL,
    name        VARCHAR(255)  NOT NULL,
    description TEXT,
    price       DECIMAL(12,2) NOT NULL,
    quantity    INT           NOT NULL DEFAULT 1,
    subtotal    DECIMAL(12,2) NOT NULL,
    inserted_at DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT chk_op_price    CHECK (price    >= 0),
    CONSTRAINT chk_op_qty      CHECK (quantity >  0),
    CONSTRAINT chk_op_subtotal CHECK (subtotal >= 0),
    CONSTRAINT fk_op_order   FOREIGN KEY (order_id)   REFERENCES sales_orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_op_product FOREIGN KEY (product_id) REFERENCES products(id)     ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE cc_transactions (
    id                 CHAR(36)      NOT NULL DEFAULT (UUID()),
    order_id           CHAR(36)      NOT NULL,
    transdate          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    processor          VARCHAR(100)  DEFAULT NULL,
    processor_trans_id VARCHAR(255)  DEFAULT NULL,
    amount             DECIMAL(12,2) NOT NULL,
    cc_last4           CHAR(4)       DEFAULT NULL,
    cc_type            VARCHAR(50)   DEFAULT NULL,
    status             VARCHAR(20)   NOT NULL DEFAULT 'pending',
    response           TEXT,
    inserted_at        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT chk_cct_amount CHECK (amount >= 0),
    CONSTRAINT chk_cct_status CHECK (status IN ('pending','success','failed','refunded')),
    CONSTRAINT fk_cct_order FOREIGN KEY (order_id) REFERENCES sales_orders(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE downloads (
    id                 CHAR(36)     NOT NULL DEFAULT (UUID()),
    order_id           CHAR(36)     NOT NULL,
    product_file_id    CHAR(36)     NOT NULL,
    token              VARCHAR(128) NOT NULL,
    download_count     INT          NOT NULL DEFAULT 0,
    max_downloads      INT          NOT NULL DEFAULT 5,
    expires_at         DATETIME     NOT NULL,
    last_downloaded_at DATETIME     DEFAULT NULL,
    inserted_at        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_dl_token              (token),
    UNIQUE KEY uq_dl_order_file         (order_id, product_file_id),
    CONSTRAINT chk_dl_count   CHECK (download_count >= 0),
    CONSTRAINT chk_dl_max     CHECK (max_downloads  >  0),
    CONSTRAINT chk_dl_lte     CHECK (download_count <= max_downloads),
    CONSTRAINT fk_dl_order FOREIGN KEY (order_id)        REFERENCES sales_orders(id)  ON DELETE CASCADE,
    CONSTRAINT fk_dl_file  FOREIGN KEY (product_file_id) REFERENCES product_files(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- REVIEWS
-- ============================================================

CREATE TABLE reviews (
    id            CHAR(36)   NOT NULL DEFAULT (UUID()),
    product_id    CHAR(36)   NOT NULL,
    user_id       CHAR(36)   NOT NULL,
    rating        TINYINT    NOT NULL,
    body          TEXT,
    is_published  TINYINT(1) NOT NULL DEFAULT 0,
    helpful_count INT        NOT NULL DEFAULT 0,
    inserted_at   DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_review_user_product (product_id, user_id),
    CONSTRAINT chk_rev_rating  CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT chk_rev_helpful CHECK (helpful_count >= 0),
    CONSTRAINT fk_rev_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_rev_user    FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- TRIGGERS
-- ============================================================

DELIMITER $$

-- Auto-increment coupon used_count when order is paid
CREATE TRIGGER trg_coupon_usage
AFTER UPDATE ON sales_orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'paid' AND OLD.status <> 'paid' AND NEW.coupon_id IS NOT NULL THEN
        UPDATE coupons
        SET used_count = used_count + 1
        WHERE id = NEW.coupon_id
          AND (usage_limit IS NULL OR used_count < usage_limit);
    END IF;
END$$


-- Auto-generate download tokens when order is paid
CREATE TRIGGER trg_generate_downloads
AFTER UPDATE ON sales_orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'paid' AND OLD.status <> 'paid' THEN
        INSERT IGNORE INTO downloads
            (id, order_id, product_file_id, token, expires_at)
        SELECT
            UUID(),
            NEW.id,
            pf.id,
            SHA2(CONCAT(UUID(), NOW(), RAND()), 256),
            DATE_ADD(NOW(), INTERVAL 30 DAY)
        FROM order_products op
        JOIN product_files  pf ON pf.product_id = op.product_id
        WHERE op.order_id = NEW.id;
    END IF;
END$$

DELIMITER ;


-- ============================================================
-- VIEWS
-- ============================================================

-- Quick ownership check: has user X purchased product Y?
CREATE VIEW user_purchases AS
SELECT
    so.user_id,
    op.product_id,
    so.id          AS order_id,
    so.order_date,
    op.price       AS price_paid
FROM sales_orders   so
JOIN order_products op ON op.order_id = so.id
WHERE so.status = 'paid'
  AND op.product_id IS NOT NULL;


-- Full order summary with payment and coupon info
CREATE VIEW order_summary AS
SELECT
    so.id                                        AS order_id,
    so.order_date,
    so.status,
    so.total,
    u.email                                      AS customer_email,
    CONCAT(u.first_name, ' ', u.last_name)       AS customer_name,
    c.code                                       AS coupon_code,
    c.value                                      AS coupon_value,
    c.value_type                                 AS coupon_type,
    ct.processor,
    ct.processor_trans_id,
    ct.cc_last4,
    ct.cc_type,
    ct.status                                    AS payment_status
FROM sales_orders so
LEFT JOIN users           u  ON u.id       = so.user_id
LEFT JOIN coupons         c  ON c.id       = so.coupon_id
LEFT JOIN cc_transactions ct ON ct.order_id = so.id
                              AND ct.status  = 'success';


-- ============================================================
-- INDEXES (additional)
-- ============================================================

CREATE INDEX idx_products_status   ON products(product_status_id);
CREATE INDEX idx_products_is_free  ON products(is_free);
CREATE INDEX idx_so_user           ON sales_orders(user_id);
CREATE INDEX idx_so_status         ON sales_orders(status);
CREATE INDEX idx_so_coupon         ON sales_orders(coupon_id);
CREATE INDEX idx_op_order          ON order_products(order_id);
CREATE INDEX idx_op_product        ON order_products(product_id);
CREATE INDEX idx_cct_order         ON cc_transactions(order_id);
CREATE INDEX idx_cct_status        ON cc_transactions(status);
CREATE INDEX idx_dl_expires        ON downloads(expires_at);
CREATE INDEX idx_rev_product       ON reviews(product_id);
CREATE INDEX idx_rev_published     ON reviews(is_published);
CREATE INDEX idx_pf_product        ON product_files(product_id);
CREATE INDEX idx_pc_category       ON product_categories(category_id);
CREATE INDEX idx_pt_tag            ON product_tags(tag_id);
CREATE INDEX idx_ur_user_idx       ON user_roles(user_id);
CREATE INDEX idx_ur_role_idx       ON user_roles(role_id);


-- ============================================================
-- SEED DATA
-- ============================================================

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO roles (id, name) VALUES
    (UUID(), 'admin'),
    (UUID(), 'customer'),
    (UUID(), 'moderator');

INSERT INTO product_statuses (id, name) VALUES
    (UUID(), 'draft'),
    (UUID(), 'active'),
    (UUID(), 'archived');

