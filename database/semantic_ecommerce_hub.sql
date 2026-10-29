-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: semantic_ecommerce_hub
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `semantic_ecommerce_hub`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `semantic_ecommerce_hub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `semantic_ecommerce_hub`;

--
-- Table structure for table `BROWSES`
--

DROP TABLE IF EXISTS `BROWSES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BROWSES` (
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`customer_id`,`product_id`),
  KEY `fk_browses_product` (`product_id`),
  CONSTRAINT `fk_browses_customer` FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMER` (`customer_id`),
  CONSTRAINT `fk_browses_product` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BROWSES`
--

LOCK TABLES `BROWSES` WRITE;
/*!40000 ALTER TABLE `BROWSES` DISABLE KEYS */;
INSERT INTO `BROWSES` VALUES (101,201),(102,201),(105,201),(101,202),(104,202),(101,203),(103,203),(103,204),(102,205),(105,205),(104,206),(105,206);
/*!40000 ALTER TABLE `BROWSES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CART`
--

DROP TABLE IF EXISTS `CART`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CART` (
  `cart_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `status` varchar(30) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_customer` (`customer_id`),
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMER` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CART`
--

LOCK TABLES `CART` WRITE;
/*!40000 ALTER TABLE `CART` DISABLE KEYS */;
INSERT INTO `CART` VALUES (401,101,'ACTIVE','2026-09-10 18:00:00'),(402,102,'CHECKED_OUT','2026-09-11 12:30:00'),(403,103,'ACTIVE','2026-09-12 09:15:00'),(404,104,'ABANDONED','2026-09-13 20:10:00'),(405,105,'CHECKED_OUT','2026-09-14 15:25:00');
/*!40000 ALTER TABLE `CART` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER`
--

DROP TABLE IF EXISTS `CUSTOMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER` (
  `customer_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER`
--

LOCK TABLES `CUSTOMER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER` DISABLE KEYS */;
INSERT INTO `CUSTOMER` VALUES (101,'Rahul Sharma','rahul.sharma@example.com','9876501001','Bengaluru, Karnataka','2026-09-01 09:30:00'),(102,'Ananya Rao','ananya.rao@example.com','9876501002','Mysuru, Karnataka','2026-09-02 10:15:00'),(103,'Vikram Kumar','vikram.kumar@example.com','9876501003','Chennai, Tamil Nadu','2026-09-03 11:00:00'),(104,'Sneha Patil','sneha.patil@example.com','9876501004','Pune, Maharashtra','2026-09-04 14:20:00'),(105,'Arjun Mehta','arjun.mehta@example.com','9876501005','Hyderabad, Telangana','2026-09-05 16:45:00');
/*!40000 ALTER TABLE `CUSTOMER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_ORDER`
--

DROP TABLE IF EXISTS `CUSTOMER_ORDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_ORDER` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `order_status` varchar(30) NOT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `idx_customer_order_date` (`customer_id`,`order_date`),
  KEY `idx_customer_order_status` (`order_status`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMER` (`customer_id`),
  CONSTRAINT `chk_order_total` CHECK ((`total_amount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_ORDER`
--

LOCK TABLES `CUSTOMER_ORDER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_ORDER` DISABLE KEYS */;
INSERT INTO `CUSTOMER_ORDER` VALUES (501,101,'2026-09-18 10:30:00','DELIVERED','Bengaluru, Karnataka',63998.00),(502,102,'2026-09-19 13:15:00','DELIVERED','Mysuru, Karnataka',24999.00),(503,103,'2026-09-20 16:40:00','SHIPPED','Chennai, Tamil Nadu',10498.00),(504,104,'2026-09-21 11:20:00','PROCESSING','Pune, Maharashtra',4999.00),(505,105,'2026-09-22 17:05:00','DELIVERED','Hyderabad, Telangana',26598.00),(506,101,'2026-10-25 08:16:43','PROCESSING','Bengaluru, Karnataka',4098.00);
/*!40000 ALTER TABLE `CUSTOMER_ORDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DELIVERED`
--

DROP TABLE IF EXISTS `DELIVERED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DELIVERED` (
  `delivery_id` int NOT NULL,
  `shipment_id` int NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `delivery_status` varchar(30) NOT NULL,
  `delivered_to` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`delivery_id`),
  UNIQUE KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `fk_delivered_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `SHIPMENT` (`shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DELIVERED`
--

LOCK TABLES `DELIVERED` WRITE;
/*!40000 ALTER TABLE `DELIVERED` DISABLE KEYS */;
INSERT INTO `DELIVERED` VALUES (801,701,'2026-09-21','DELIVERED','Rahul Sharma'),(802,702,'2026-09-22','DELIVERED','Ananya Rao'),(803,705,'2026-09-25','DELIVERED','Arjun Mehta');
/*!40000 ALTER TABLE `DELIVERED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVENTORY`
--

DROP TABLE IF EXISTS `INVENTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVENTORY` (
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_on_hand` int NOT NULL,
  `reorder_level` int NOT NULL,
  `last_restocked` date DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`,`product_id`),
  KEY `fk_inventory_product` (`product_id`),
  KEY `idx_inventory_quantity` (`quantity_on_hand`),
  CONSTRAINT `fk_inventory_product` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`),
  CONSTRAINT `fk_inventory_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `WAREHOUSE` (`warehouse_id`),
  CONSTRAINT `chk_inventory_quantity` CHECK ((`quantity_on_hand` >= 0)),
  CONSTRAINT `chk_inventory_reorder` CHECK ((`reorder_level` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVENTORY`
--

LOCK TABLES `INVENTORY` WRITE;
/*!40000 ALTER TABLE `INVENTORY` DISABLE KEYS */;
INSERT INTO `INVENTORY` VALUES (301,201,45,10,'2026-09-15'),(301,202,120,25,'2026-09-16'),(301,203,65,15,'2026-09-14'),(301,204,90,20,'2026-09-17'),(302,201,30,10,'2026-09-13'),(302,205,55,12,'2026-09-15'),(302,206,150,30,'2026-09-16'),(303,203,40,10,'2026-09-12'),(303,204,70,15,'2026-09-14'),(303,205,35,10,'2026-09-15');
/*!40000 ALTER TABLE `INVENTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_ITEM`
--

DROP TABLE IF EXISTS `ORDER_ITEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_ITEM` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_item_product` (`product_id`),
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `CUSTOMER_ORDER` (`order_id`),
  CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`),
  CONSTRAINT `chk_order_item_price` CHECK ((`unit_price` >= 0)),
  CONSTRAINT `chk_order_item_quantity` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_ITEM`
--

LOCK TABLES `ORDER_ITEM` WRITE;
/*!40000 ALTER TABLE `ORDER_ITEM` DISABLE KEYS */;
INSERT INTO `ORDER_ITEM` VALUES (501,201,1,58999.00),(501,202,1,4999.00),(502,205,1,24999.00),(503,203,1,7999.00),(503,204,1,2499.00),(504,202,1,4999.00),(505,205,1,24999.00),(505,206,1,1599.00),(506,204,1,2499.00),(506,206,1,1599.00);
/*!40000 ALTER TABLE `ORDER_ITEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PAYMENT`
--

DROP TABLE IF EXISTS `PAYMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PAYMENT` (
  `payment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `payment_date` datetime NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(40) NOT NULL,
  `payment_status` varchar(30) NOT NULL,
  `transaction_ref` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `idx_payment_order` (`order_id`),
  CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `CUSTOMER_ORDER` (`order_id`),
  CONSTRAINT `chk_payment_amount` CHECK ((`amount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PAYMENT`
--

LOCK TABLES `PAYMENT` WRITE;
/*!40000 ALTER TABLE `PAYMENT` DISABLE KEYS */;
INSERT INTO `PAYMENT` VALUES (601,501,'2026-09-18 10:35:00',63998.00,'UPI','SUCCESS','TXN501UPI'),(602,502,'2026-09-19 13:20:00',24999.00,'CARD','SUCCESS','TXN502CARD'),(603,503,'2026-09-20 16:45:00',10498.00,'UPI','SUCCESS','TXN503UPI'),(604,504,'2026-09-21 11:25:00',4999.00,'CARD','SUCCESS','TXN504CARD'),(605,505,'2026-09-22 17:10:00',26598.00,'NET_BANKING','SUCCESS','TXN505NB'),(606,506,'2026-10-25 08:16:43',4098.00,'UPI','SUCCESS','TXN506PHASE2');
/*!40000 ALTER TABLE `PAYMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT`
--

DROP TABLE IF EXISTS `PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT` (
  `product_id` int NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `idx_product_category_name` (`category`,`product_name`),
  FULLTEXT KEY `ft_product_text` (`product_name`,`description`,`category`,`brand`),
  CONSTRAINT `chk_product_price` CHECK ((`price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT`
--

LOCK TABLES `PRODUCT` WRITE;
/*!40000 ALTER TABLE `PRODUCT` DISABLE KEYS */;
INSERT INTO `PRODUCT` VALUES (201,'Lenovo IdeaPad Laptop','15.6-inch laptop for students and professionals','Laptop','Lenovo',58999.00),(202,'Wireless Mechanical Keyboard','Compact mechanical keyboard with wireless connectivity','Accessories','KeyPro',4999.00),(203,'Noise Cancelling Headphones','Over-ear headphones with active noise cancellation','Audio','SoundMax',7999.00),(204,'USB-C Hub','Multi-port USB-C hub with HDMI and USB ports','Accessories','TechLink',2499.00),(205,'Smartphone','5G smartphone with 128 GB storage','Mobile','NovaTech',24999.00),(206,'Wireless Mouse','Ergonomic wireless mouse','Accessories','LogiTech',1599.00);
/*!40000 ALTER TABLE `PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REVIEW`
--

DROP TABLE IF EXISTS `REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REVIEW` (
  `review_id` int NOT NULL,
  `order_id` int NOT NULL,
  `delivery_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_text` varchar(500) DEFAULT NULL,
  `review_date` date NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_review_order` (`order_id`),
  KEY `fk_review_delivery` (`delivery_id`),
  CONSTRAINT `fk_review_delivery` FOREIGN KEY (`delivery_id`) REFERENCES `DELIVERED` (`delivery_id`),
  CONSTRAINT `fk_review_order` FOREIGN KEY (`order_id`) REFERENCES `CUSTOMER_ORDER` (`order_id`),
  CONSTRAINT `chk_review_rating` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REVIEW`
--

LOCK TABLES `REVIEW` WRITE;
/*!40000 ALTER TABLE `REVIEW` DISABLE KEYS */;
INSERT INTO `REVIEW` VALUES (901,501,801,5,'Excellent laptop and fast delivery.','2026-09-22'),(902,502,802,4,'Good smartphone and smooth delivery.','2026-09-23'),(903,505,803,5,'Great product quality and packaging.','2026-09-26'),(990,501,801,5,'Phase 2 trigger test: delivery completed.','2026-10-25');
/*!40000 ALTER TABLE `REVIEW` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_review_requires_delivered_order` BEFORE INSERT ON `REVIEW` FOR EACH ROW BEGIN
    DECLARE v_delivery_status VARCHAR(30);
    SELECT delivery_status INTO v_delivery_status
    FROM DELIVERED
    WHERE delivery_id = NEW.delivery_id;

    IF v_delivery_status IS NULL OR v_delivery_status <> 'DELIVERED' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A review can only be added after delivery is completed.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SHIPMENT`
--

DROP TABLE IF EXISTS `SHIPMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPMENT` (
  `shipment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `shipment_date` date DEFAULT NULL,
  `carrier` varchar(100) DEFAULT NULL,
  `tracking_no` varchar(100) DEFAULT NULL,
  `shipment_status` varchar(30) NOT NULL,
  PRIMARY KEY (`shipment_id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `idx_shipment_tracking` (`tracking_no`),
  CONSTRAINT `fk_shipment_order` FOREIGN KEY (`order_id`) REFERENCES `CUSTOMER_ORDER` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPMENT`
--

LOCK TABLES `SHIPMENT` WRITE;
/*!40000 ALTER TABLE `SHIPMENT` DISABLE KEYS */;
INSERT INTO `SHIPMENT` VALUES (701,501,'2026-09-19','BlueDart','BD501001','DELIVERED'),(702,502,'2026-09-20','Delhivery','DL502002','DELIVERED'),(703,503,'2026-09-21','DTDC','DT503003','IN_TRANSIT'),(704,504,'2026-09-22','BlueDart','BD504004','PROCESSING'),(705,505,'2026-09-23','Delhivery','DL505005','DELIVERED');
/*!40000 ALTER TABLE `SHIPMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WAREHOUSE`
--

DROP TABLE IF EXISTS `WAREHOUSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WAREHOUSE` (
  `warehouse_id` int NOT NULL,
  `warehouse_name` varchar(100) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`),
  CONSTRAINT `chk_warehouse_capacity` CHECK ((`capacity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WAREHOUSE`
--

LOCK TABLES `WAREHOUSE` WRITE;
/*!40000 ALTER TABLE `WAREHOUSE` DISABLE KEYS */;
INSERT INTO `WAREHOUSE` VALUES (301,'Bengaluru Central Warehouse','Bengaluru, Karnataka',10000),(302,'Chennai Distribution Hub','Chennai, Tamil Nadu',8000),(303,'Hyderabad Fulfillment Center','Hyderabad, Telangana',7500);
/*!40000 ALTER TABLE `WAREHOUSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_inventory_reorder_alert`
--

DROP TABLE IF EXISTS `vw_inventory_reorder_alert`;
/*!50001 DROP VIEW IF EXISTS `vw_inventory_reorder_alert`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inventory_reorder_alert` AS SELECT 
 1 AS `warehouse_id`,
 1 AS `warehouse_name`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `quantity_on_hand`,
 1 AS `reorder_level`,
 1 AS `last_restocked`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_order_fulfillment_summary`
--

DROP TABLE IF EXISTS `vw_order_fulfillment_summary`;
/*!50001 DROP VIEW IF EXISTS `vw_order_fulfillment_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_order_fulfillment_summary` AS SELECT 
 1 AS `order_id`,
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `order_date`,
 1 AS `order_status`,
 1 AS `total_amount`,
 1 AS `shipment_id`,
 1 AS `carrier`,
 1 AS `tracking_no`,
 1 AS `shipment_status`,
 1 AS `delivery_id`,
 1 AS `delivery_date`,
 1 AS `delivery_status`,
 1 AS `delivered_to`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'semantic_ecommerce_hub'
--

--
-- Dumping routines for database 'semantic_ecommerce_hub'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_order_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_order_summary`(IN p_order_id INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `semantic_ecommerce_hub`
--

USE `semantic_ecommerce_hub`;

--
-- Final view structure for view `vw_inventory_reorder_alert`
--

/*!50001 DROP VIEW IF EXISTS `vw_inventory_reorder_alert`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inventory_reorder_alert` AS select `w`.`warehouse_id` AS `warehouse_id`,`w`.`warehouse_name` AS `warehouse_name`,`p`.`product_id` AS `product_id`,`p`.`product_name` AS `product_name`,`i`.`quantity_on_hand` AS `quantity_on_hand`,`i`.`reorder_level` AS `reorder_level`,`i`.`last_restocked` AS `last_restocked` from ((`INVENTORY` `i` join `WAREHOUSE` `w` on((`w`.`warehouse_id` = `i`.`warehouse_id`))) join `PRODUCT` `p` on((`p`.`product_id` = `i`.`product_id`))) where (`i`.`quantity_on_hand` <= `i`.`reorder_level`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_order_fulfillment_summary`
--

/*!50001 DROP VIEW IF EXISTS `vw_order_fulfillment_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_order_fulfillment_summary` AS select `co`.`order_id` AS `order_id`,`c`.`customer_id` AS `customer_id`,`c`.`name` AS `customer_name`,`co`.`order_date` AS `order_date`,`co`.`order_status` AS `order_status`,`co`.`total_amount` AS `total_amount`,`s`.`shipment_id` AS `shipment_id`,`s`.`carrier` AS `carrier`,`s`.`tracking_no` AS `tracking_no`,`s`.`shipment_status` AS `shipment_status`,`d`.`delivery_id` AS `delivery_id`,`d`.`delivery_date` AS `delivery_date`,`d`.`delivery_status` AS `delivery_status`,`d`.`delivered_to` AS `delivered_to` from (((`CUSTOMER_ORDER` `co` join `CUSTOMER` `c` on((`c`.`customer_id` = `co`.`customer_id`))) left join `SHIPMENT` `s` on((`s`.`order_id` = `co`.`order_id`))) left join `DELIVERED` `d` on((`d`.`shipment_id` = `s`.`shipment_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-29  8:33:39
