-- PHASE 2: ADVANCED DATABASE FEATURES (MySQL 8.x)
-- Run SEMANTIC_ECOMMERCE_FINAL_DATABASE.sql first.
USE semantic_ecommerce_hub;

-- ============================================================
-- FEATURE 1: VIEWS
-- ============================================================
CREATE OR REPLACE VIEW vw_order_fulfillment_summary AS
SELECT co.order_id, c.customer_id, c.name AS customer_name,
       co.order_date, co.order_status, co.total_amount,
       s.shipment_id, s.carrier, s.tracking_no, s.shipment_status,
       d.delivery_id, d.delivery_date, d.delivery_status, d.delivered_to
FROM CUSTOMER_ORDER co
JOIN CUSTOMER c ON c.customer_id = co.customer_id
LEFT JOIN SHIPMENT s ON s.order_id = co.order_id
LEFT JOIN DELIVERED d ON d.shipment_id = s.shipment_id;

CREATE OR REPLACE VIEW vw_inventory_reorder_alert AS
SELECT w.warehouse_id, w.warehouse_name, p.product_id, p.product_name,
       i.quantity_on_hand, i.reorder_level, i.last_restocked
FROM INVENTORY i
JOIN WAREHOUSE w ON w.warehouse_id = i.warehouse_id
JOIN PRODUCT p ON p.product_id = i.product_id
WHERE i.quantity_on_hand <= i.reorder_level;

SELECT * FROM vw_order_fulfillment_summary ORDER BY order_id;
SELECT * FROM vw_inventory_reorder_alert;

-- ============================================================
-- FEATURE 2: INDEXING
-- Run each CREATE INDEX only once.
-- ============================================================
CREATE INDEX idx_customer_order_date ON CUSTOMER_ORDER (customer_id, order_date);
CREATE INDEX idx_customer_order_status ON CUSTOMER_ORDER (order_status);
CREATE INDEX idx_payment_order ON PAYMENT (order_id);
CREATE INDEX idx_shipment_tracking ON SHIPMENT (tracking_no);
CREATE INDEX idx_product_category_name ON PRODUCT (category, product_name);
CREATE INDEX idx_inventory_quantity ON INVENTORY (quantity_on_hand);

EXPLAIN
SELECT order_id, order_date, order_status, total_amount
FROM CUSTOMER_ORDER
WHERE customer_id = 101
ORDER BY order_date;

EXPLAIN
SELECT shipment_id, order_id, tracking_no, shipment_status
FROM SHIPMENT
WHERE tracking_no = 'BD501001';

-- ============================================================
-- FEATURE 3: TRIGGER
-- Business rule: reviews are allowed only after delivery is completed.
-- ============================================================
DELIMITER $$
CREATE TRIGGER trg_review_requires_delivered_order
BEFORE INSERT ON REVIEW
FOR EACH ROW
BEGIN
    DECLARE v_delivery_status VARCHAR(30);
    SELECT delivery_status INTO v_delivery_status
    FROM DELIVERED
    WHERE delivery_id = NEW.delivery_id;

    IF v_delivery_status IS NULL OR v_delivery_status <> 'DELIVERED' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A review can only be added after delivery is completed.';
    END IF;
END$$
DELIMITER ;

-- Positive trigger test (delivery 801 is already DELIVERED in Phase 1 sample data).
INSERT INTO REVIEW (review_id, order_id, delivery_id, rating, review_text, review_date)
VALUES (990, 501, 801, 5, 'Phase 2 trigger test: delivery completed.', CURRENT_DATE);

SELECT review_id, order_id, delivery_id, rating, review_text
FROM REVIEW WHERE review_id = 990;

-- ============================================================
-- FEATURE 4: TRANSACTIONS
-- Creates one order + two order items + one payment atomically.
-- IDs are distinct from the Phase 1 sample records.
-- ============================================================
START TRANSACTION;

INSERT INTO CUSTOMER_ORDER
    (order_id, customer_id, order_date, order_status, shipping_address, total_amount)
VALUES
    (506, 101, NOW(), 'PROCESSING', 'Bengaluru, Karnataka', 4098.00);

INSERT INTO ORDER_ITEM (order_id, product_id, quantity, unit_price)
VALUES
    (506, 204, 1, 2499.00),
    (506, 206, 1, 1599.00);

INSERT INTO PAYMENT
    (payment_id, order_id, payment_date, amount, payment_method, payment_status, transaction_ref)
VALUES
    (606, 506, NOW(), 4098.00, 'UPI', 'SUCCESS', 'TXN506PHASE2');

SELECT * FROM CUSTOMER_ORDER WHERE order_id = 506;
SELECT * FROM ORDER_ITEM WHERE order_id = 506;
SELECT * FROM PAYMENT WHERE order_id = 506;

COMMIT;

-- Verify that the order-item total agrees with the order total.
SELECT co.order_id, co.order_status, co.total_amount,
       SUM(oi.quantity * oi.unit_price) AS calculated_item_total
FROM CUSTOMER_ORDER co
JOIN ORDER_ITEM oi ON oi.order_id = co.order_id
WHERE co.order_id = 506
GROUP BY co.order_id, co.order_status, co.total_amount;

-- Safe ROLLBACK demonstration: temporary update is undone.
START TRANSACTION;
UPDATE CUSTOMER_ORDER
SET order_status = 'TEMPORARY_TEST_STATUS'
WHERE order_id = 506;
ROLLBACK;

SELECT order_id, order_status
FROM CUSTOMER_ORDER WHERE order_id = 506;

-- ============================================================
-- FINAL VERIFICATION
-- ============================================================
SHOW FULL TABLES WHERE Table_type = 'VIEW';
SHOW TRIGGERS FROM semantic_ecommerce_hub;
SHOW INDEX FROM CUSTOMER_ORDER;
SHOW INDEX FROM PRODUCT;
SHOW INDEX FROM SHIPMENT;
SHOW INDEX FROM INVENTORY;

SELECT 'Phase 2 feature script completed.' AS result;
