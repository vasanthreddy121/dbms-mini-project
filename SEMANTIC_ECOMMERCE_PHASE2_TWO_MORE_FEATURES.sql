-- PHASE 2: SIX ADVANCED DATABASE FEATURES (MySQL 8.x)
-- IMPORTANT: Since the original four-feature script may already have been run,
-- execute ONLY the sections marked FEATURE 5 and FEATURE 6 below to add the
-- two new features. Do not rerun the first four sections: they may duplicate
-- indexes, trigger, review_id 990, and order_id 506.
USE semantic_ecommerce_hub;

-- ============================================================
-- FEATURE 5: STORED PROCEDURE
-- Returns an order's customer, products, quantities, and line totals.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_get_order_summary;
DELIMITER $$
CREATE PROCEDURE sp_get_order_summary(IN p_order_id INT)
BEGIN
    SELECT co.order_id, c.customer_id, c.name AS customer_name,
           co.order_date, co.order_status, co.total_amount,
           oi.product_id, p.product_name, oi.quantity, oi.unit_price,
           (oi.quantity * oi.unit_price) AS line_total
    FROM CUSTOMER_ORDER co
    JOIN CUSTOMER c ON c.customer_id = co.customer_id
    JOIN ORDER_ITEM oi ON oi.order_id = co.order_id
    JOIN PRODUCT p ON p.product_id = oi.product_id
    WHERE co.order_id = p_order_id
    ORDER BY p.product_name;
END$$
DELIMITER ;

-- Demonstrate the stored procedure:
CALL sp_get_order_summary(501);

-- ============================================================
-- FEATURE 6: FULL-TEXT SEARCH
-- Adds a FULLTEXT index over existing PRODUCT text attributes.
-- This adds no table or column.
-- Run the ALTER TABLE only once.
-- ============================================================
ALTER TABLE PRODUCT
    ADD FULLTEXT INDEX ft_product_text (product_name, description, category, brand);

-- Search for products relevant to a natural-language keyword query:
SELECT product_id, product_name, description, category, brand,
       MATCH(product_name, description, category, brand)
       AGAINST ('laptop student' IN NATURAL LANGUAGE MODE) AS relevance_score
FROM PRODUCT
WHERE MATCH(product_name, description, category, brand)
      AGAINST ('laptop student' IN NATURAL LANGUAGE MODE)
ORDER BY relevance_score DESC;

-- Another full-text search example:
SELECT product_id, product_name, category, brand
FROM PRODUCT
WHERE MATCH(product_name, description, category, brand)
      AGAINST ('wireless accessories' IN NATURAL LANGUAGE MODE);

-- ============================================================
-- VERIFY THE TWO NEW FEATURES
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'semantic_ecommerce_hub';
SHOW INDEX FROM PRODUCT;
SELECT 'Stored procedure and full-text search added.' AS result;
