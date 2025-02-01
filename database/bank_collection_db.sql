-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: bank_collection_db
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `owner_id` int NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'1',1,'0000 1234 5678 9000',755045.50,'2025-01-30 00:00:00',NULL),(2,'2',2,'0000 1234 5678 9001',-7529.25,'2025-01-30 00:00:00',NULL),(3,'3',3,'0000 1234 5678 9002',2000.00,'2025-01-30 00:00:00',NULL),(4,'4',4,'0000 1234 5678 9003',2500.25,'2025-01-30 00:00:00',NULL),(5,'5',5,'0000 1234 5678 9004',3000.50,'2025-01-30 00:00:00',NULL),(6,'6',6,'0000 1234 5678 9005',3500.75,'2025-01-30 00:00:00',NULL),(7,'7',7,'0000 1234 5678 9006',4000.00,'2025-01-30 00:00:00',NULL),(8,'8',8,'0000 1234 5678 9007',4500.00,'2025-01-30 00:00:00',NULL),(9,'9',9,'0000 1234 5678 9008',5000.00,'2025-01-30 00:00:00',NULL),(10,'10',10,'0000 1234 5678 9009',5500.00,'2025-01-30 00:00:00',NULL),(11,'11',11,'0000 1234 5678 9010',6000.00,'2025-01-30 00:00:00',NULL),(12,'12',12,'0000 1234 5678 9011',6500.00,'2025-01-30 00:00:00',NULL),(13,'13',13,'0000 1234 5678 9012',7000.00,'2025-01-30 00:00:00',NULL),(14,'14',14,'0000 1234 5678 9013',7500.00,'2025-01-30 00:00:00',NULL),(15,'15',15,'0000 1234 5678 9014',8000.00,'2025-01-30 00:00:00',NULL),(16,'16',16,'0000 1234 5678 9015',8500.00,'2025-01-30 00:00:00',NULL),(17,'17',17,'0000 1234 5678 9016',9000.00,'2025-01-30 00:00:00',NULL),(18,'18',18,'0000 1234 5678 9017',10000.00,'2025-01-30 00:00:00',NULL),(19,'19',19,'0000 1234 5678 9018',10500.00,'2025-01-30 00:00:00',NULL),(20,'20',20,'0000 1234 5678 9019',11000.00,'2025-01-30 00:00:00',NULL),(21,'21',21,'0000 1234 5678 9020',11500.00,'2025-01-30 00:00:00',NULL),(22,'22',22,'0000 1234 5678 9021',12500.00,'2025-01-30 00:00:00',NULL),(23,'23',23,'0000 1234 5678 9022',13000.00,'2025-01-30 00:00:00',NULL),(24,'24',24,'0000 1234 5678 9023',13500.00,'2025-01-30 00:00:00',NULL),(25,'25',25,'0000 1234 5678 9024',14000.00,'2025-01-30 00:00:00',NULL),(26,'26',26,'0000 1234 5678 9025',14500.00,'2025-01-30 00:00:00',NULL),(27,'27',27,'0000 1234 5678 9026',15000.00,'2025-01-30 00:00:00',NULL),(28,'28',28,'0000 1234 5678 9027',15500.00,'2025-01-30 00:00:00',NULL),(29,'29',29,'0000 1234 5678 9028',16000.00,'2025-01-30 00:00:00',NULL),(30,'30',30,'0000 1234 5678 9029',16500.00,'2025-01-30 00:00:00',NULL),(31,'31',1,'0000 1234 5678 9030',27120.50,'2025-01-30 00:00:00',NULL);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approvals`
--

DROP TABLE IF EXISTS `approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `approvals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `approval_id` varchar(255) NOT NULL,
  `transaction_id` int NOT NULL,
  `is_approved` int DEFAULT NULL,
  `authorizer_id` int DEFAULT NULL,
  `date_hour` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `approvals_ibfk_2` (`authorizer_id`),
  CONSTRAINT `approvals_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `approvals_ibfk_2` FOREIGN KEY (`authorizer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approvals`
--

LOCK TABLES `approvals` WRITE;
/*!40000 ALTER TABLE `approvals` DISABLE KEYS */;
INSERT INTO `approvals` VALUES (1,'APPVL000001',50,0,1,'2025-01-29 19:52:03'),(2,'APPVL000002',51,0,1,'2025-01-29 19:55:30'),(3,'APPVL000003',52,0,1,'2025-01-29 19:56:20'),(4,'APPVL000004',53,1,1,'2025-01-29 20:22:14'),(5,'APPVL000005',54,1,1,'2025-01-29 20:23:20'),(6,'APPVL000006',55,0,1,'2025-01-29 20:24:44'),(7,'APPVL000007',56,1,1,'2025-01-29 21:40:01'),(8,'APPVL000008',57,1,1,'2025-01-29 21:59:20'),(9,'APPVL000009',58,1,1,'2025-01-29 22:03:06'),(10,'APPVL000010',59,1,1,'2025-01-29 22:06:35'),(13,'APPVL000011',61,1,1,'2025-01-30 09:33:21'),(14,'APPVL000012',62,1,1,'2025-01-30 09:37:45'),(18,'APPVL000013',68,0,1,'2025-01-30 10:30:00'),(19,'APPVL000014',69,1,1,'2025-01-30 10:36:01'),(20,'APPVL000015',70,1,1,'2025-01-30 10:37:18'),(21,'APPVL000016',72,1,1,'2025-01-30 10:49:38'),(22,'APPVL000017',73,1,1,'2025-01-30 10:51:24'),(23,'APPVL000018',74,1,1,'2025-01-30 11:01:58'),(24,'APPVL000019',75,1,1,'2025-01-30 11:08:55'),(25,'APPVL000020',76,1,1,'2025-01-30 11:09:31'),(26,'APPVL000021',77,1,1,'2025-01-30 11:10:33'),(27,'APPVL000022',78,1,1,'2025-01-30 11:11:17'),(28,'APPVL000023',79,1,1,'2025-01-30 11:13:36'),(29,'APPVL000024',80,1,1,'2025-01-30 11:50:07');
/*!40000 ALTER TABLE `approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `action` varchar(255) NOT NULL,
  `date_hour` datetime NOT NULL,
  `detail` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
INSERT INTO `audit` VALUES (1,1,'Create Transaction','2025-01-17 12:00:00','Transaction TX001 created'),(2,2,'Update Balance','2025-01-17 13:00:00','Balance updated for Customer C001'),(3,1,'Inicio de Sesión','2025-01-18 03:04:01','Inicio de Sesión Correcto'),(4,1,'Añadir Colector','2025-01-18 03:24:55','Adición de Nuevo Colector'),(5,1,'Añadir Colector','2025-01-18 03:25:36','Adición de Nuevo Colector'),(6,1,'Añadir Colector','2025-01-18 03:29:37','Adición de Nuevo Colector'),(7,1,'Añadir Colector','2025-01-18 03:30:55','Adición de Nuevo Colector'),(8,1,'Añadir Colector','2025-01-18 03:32:41','Adición de Nuevo Colector'),(9,1,'Añadir Colector','2025-01-18 03:32:54','Adición de Nuevo Colector'),(10,1,'Añadir Colector','2025-01-18 03:33:16','Adición de Nuevo Colector'),(11,1,'Añadir Colector','2025-01-18 03:41:09','Adición de Nuevo Colector'),(12,1,'Inicio de Sesión','2025-01-18 11:16:39','Inicio de Sesión Correcto'),(13,1,'Inicio de Sesión','2025-01-18 11:18:17','Inicio de Sesión Correcto'),(14,2,'Inicio de Sesión','2025-01-18 12:04:25','Inicio de Sesión Correcto'),(15,1,'Inicio de Sesión','2025-01-18 12:05:08','Inicio de Sesión Correcto'),(16,1,'Inicio de Sesión','2025-01-20 11:46:43','Inicio de Sesión Correcto'),(17,1,'Inicio de Sesión','2025-01-20 21:55:41','Inicio de Sesión Correcto'),(18,1,'Inicio de Sesión','2025-01-21 11:41:51','Inicio de Sesión Correcto'),(19,1,'Añadir Colector','2025-01-21 11:48:06','Adición de Nuevo Colector'),(20,1,'Inicio de Sesión','2025-01-22 09:22:49','Inicio de Sesión Correcto'),(21,1,'Inicio de Sesión','2025-01-22 12:55:05','Inicio de Sesión Correcto'),(22,1,'Inicio de Sesión','2025-01-22 12:57:16','Inicio de Sesión Correcto'),(23,1,'Inicio de Sesión','2025-01-22 19:02:04','Inicio de Sesión Correcto'),(24,1,'Inicio de Sesión','2025-01-22 21:50:16','Inicio de Sesión Correcto'),(25,1,'Inicio de Sesión','2025-01-23 11:06:18','Inicio de Sesión Correcto'),(26,1,'Inicio de Sesión','2025-01-24 09:09:34','Inicio de Sesión Correcto'),(27,1,'Inicio de Sesión','2025-01-26 09:21:14','Inicio de Sesión Correcto'),(28,1,'Inicio de Sesión','2025-01-27 10:02:02','Inicio de Sesión Correcto'),(29,1,'Inicio de Sesión','2025-01-28 10:00:17','Inicio de Sesión Correcto'),(30,1,'Inicio de Sesión','2025-01-29 09:26:46','Inicio de Sesión Correcto'),(31,1,'Inicio de Sesión','2025-01-29 18:10:54','Inicio de Sesión Correcto'),(32,1,'Inicio de Sesión','2025-01-30 09:05:47','Inicio de Sesión Correcto'),(33,2,'Inicio de Sesión','2025-01-30 09:53:48','Inicio de Sesión Correcto'),(34,1,'Inicio de Sesión','2025-01-30 09:54:16','Inicio de Sesión Correcto'),(35,2,'Inicio de Sesión','2025-01-31 10:22:05','Inicio de Sesión Correcto'),(36,1,'Inicio de Sesión','2025-01-31 10:22:36','Inicio de Sesión Correcto'),(37,2,'Inicio de Sesión','2025-01-31 14:13:53','Inicio de Sesión Correcto'),(38,1,'Inicio de Sesión','2025-01-31 14:14:03','Inicio de Sesión Correcto');
/*!40000 ALTER TABLE `audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_details`
--

DROP TABLE IF EXISTS `bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `bill_details_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`),
  CONSTRAINT `bill_details_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_details`
--

LOCK TABLES `bill_details` WRITE;
/*!40000 ALTER TABLE `bill_details` DISABLE KEYS */;
INSERT INTO `bill_details` VALUES (1,1,1,1,75.00),(2,2,2,2,30.00);
/*!40000 ALTER TABLE `bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` varchar(255) NOT NULL,
  `transaction_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `mail_sent` tinyint(1) NOT NULL,
  `receiver_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,'BILL001',1,150.00,1,NULL),(2,'BILL002',2,100.00,0,NULL);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collectors`
--

DROP TABLE IF EXISTS `collectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collectors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collector_id` varchar(255) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collectors`
--

LOCK TABLES `collectors` WRITE;
/*!40000 ALTER TABLE `collectors` DISABLE KEYS */;
INSERT INTO `collectors` VALUES (1,'COL00001','TIGO','Empresa de Telecomunicaciones'),(2,'COL00002','CLARO','Empresa de Telecomunicaciones'),(3,'COL00003','CAESS','Empresa de Servicios Eléctricos'),(4,'COL00004','ANDA','Administración Nacional de Acueductos y Alcantarillados'),(5,'COL00005','JAPI','Empresa de Telecomunicaciones'),(6,'COL00006','UTEC','Universidad Tecnológica de El Salvador'),(7,'COL00007','UES','Universidad Nacional de El Salvador'),(8,'COL00008','UNAB','Universidad Dr. Andrés Bello'),(9,'COL00009','UPED','Universidad Pedagógica'),(10,'COL00010','Movistar','Empresa de Telecomunicaciones'),(11,'COL00011','Del Sur','Empresa de Servicios Eléctricos');
/*!40000 ALTER TABLE `collectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `identity_doc` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'1','David Cruz','00000001-1','dcruzer92@gmail.com',NULL),(2,'2','Ana Gomez','00000002-2','ana.gomez@example.com',NULL),(3,'3','Carlos Ruiz','00000003-3','carlos.ruiz@example.com',NULL),(4,'4','Helena Martínez','00000004-4','helena.martinez@example.com',NULL),(5,'5','Jose Fernandez','00000005-5','jose.fernandez@example.com',NULL),(6,'6','Laura Sanchez','00000006-6','laura.sanchez@example.com',NULL),(7,'7','Miguel Ramirez','00000007-7','miguel.ramirez@example.com',NULL),(8,'8','Luis Mendez','00000008-8','luis.mendez@example.com',NULL),(9,'9','Carmen Morales','00000009-9','carmen.morales@example.com',NULL),(10,'10','Rosa López','00000010-0','rosa.lopez@example.com',NULL),(11,'11','Ricardo Torres','00000011-1','ricardo.torres@example.com',NULL),(12,'12','Patricia Diaz','00000012-2','patricia.diaz@example.com',NULL),(13,'13','Alejandro Castillo','00000013-3','alejandro.castillo@example.com',NULL),(14,'14','Gabriela Herrera','00000014-4','gabriela.herrera@example.com',NULL),(15,'15','Andres Morales','00000015-5','andres.morales@example.com',NULL),(16,'16','Juliana Paredes','00000016-6','juliana.paredes@example.com',NULL),(17,'17','Oscar Vega','00000017-7','oscar.vega@example.com',NULL),(18,'18','Gloria Jimenez','00000018-8','gloria.jimenez@example.com',NULL),(19,'19','Enrique Navarro','00000019-9','enrique.navarro@example.com',NULL),(20,'20','Marta Ortega','00000020-0','marta.ortega@example.com',NULL),(21,'21','Pablo Castillo','00000021-1','pablo.castillo@example.com',NULL),(22,'22','Sofia Medina','00000022-2','sofia.medina@example.com',NULL),(23,'23','Juan Perez','00000023-3','juan.perez@example.com',NULL),(24,'24','Isabel Rios','00000024-4','isabel.rios@example.com',NULL),(25,'25','Fernando Nunez','00000025-5','fernando.nunez@example.com',NULL),(26,'26','Marina Silva','00000026-6','marina.silva@example.com',NULL),(27,'27','Victor Delgado','00000027-7','victor.delgado@example.com',NULL),(28,'28','Monica Leon','00000028-8','monica.leon@example.com',NULL),(29,'29','Francisco Rivera','00000029-9','francisco.rivera@example.com',NULL),(30,'30','Adriana Suarez','000000030-0','adriana.suarez@example.com','2025-01-27 11:49:44');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `denominations`
--

DROP TABLE IF EXISTS `denominations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denominations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` varchar(255) NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denominations`
--

LOCK TABLES `denominations` WRITE;
/*!40000 ALTER TABLE `denominations` DISABLE KEYS */;
INSERT INTO `denominations` VALUES (1,'D001',100.00,'Bill'),(2,'D002',50.00,'Bill'),(3,'D003',10.00,'Coin');
/*!40000 ALTER TABLE `denominations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments_collectors`
--

DROP TABLE IF EXISTS `payments_collectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments_collectors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(255) NOT NULL,
  `customer_id` int NOT NULL,
  `collector_id` int NOT NULL,
  `service_id` varchar(45) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `registered_by` int DEFAULT NULL,
  `date_hour` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `collector_id` (`collector_id`),
  KEY `service_id` (`service_id`),
  KEY `payments_collectors_ibfk_3_idx` (`registered_by`),
  CONSTRAINT `payments_collectors_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `payments_collectors_ibfk_2` FOREIGN KEY (`collector_id`) REFERENCES `collectors` (`id`),
  CONSTRAINT `payments_collectors_ibfk_3` FOREIGN KEY (`registered_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_collectors`
--

LOCK TABLES `payments_collectors` WRITE;
/*!40000 ALTER TABLE `payments_collectors` DISABLE KEYS */;
INSERT INTO `payments_collectors` VALUES (1,'PAY00001',2,1,'1',15.00,1,'2025-01-17 20:31:55'),(2,'PAY00002',2,2,'2',34.00,1,'2025-01-17 21:53:39'),(3,'PAY00003',2,10,'10',35.00,2,'2025-01-18 03:42:42'),(4,'PAY00004',1,10,'10',45.00,2,'2025-01-18 03:43:02'),(5,'PAY00005',3,4,'4',15.00,2,'2025-01-18 12:09:40'),(6,'PAY00006',4,4,'4',34.00,2,'2025-01-18 12:09:57'),(7,'PAY00007',21,3,'3',27.00,2,'2025-01-18 12:10:21'),(8,'PAY00008',1,4,'4',13.00,2,'2025-01-18 18:30:57'),(9,'PAY00009',1,10,'10',35.00,2,'2025-01-18 18:39:25'),(10,'PAY00010',1,4,'4',15.00,2,'2025-01-18 21:23:41'),(11,'PAY00011',1,4,'4',25.00,1,'2025-01-18 22:08:33'),(12,'PAY00012',1,2,'2',35.00,2,'2025-01-20 11:49:28'),(13,'PAY00013',1,3,'3',24.00,1,'2025-01-20 11:51:56'),(14,'PAY00014',1,4,'4',12.00,1,'2025-01-20 12:20:49'),(15,'PAY00015',1,1,'1',25.00,1,'2025-01-20 12:22:16'),(16,'PAY00016',1,1,'1',50.00,1,'2025-01-20 21:56:33'),(17,'PAY00017',1,4,'4',35.00,2,'2025-01-20 21:57:12'),(18,'PAY00018',1,3,'3',31.00,2,'2025-01-20 21:58:22'),(19,'PAY00019',1,4,'4',5.00,2,'2025-01-21 11:42:06'),(20,'PAY00020',3,3,'3',5.00,1,'2025-01-21 11:46:20'),(21,'PAY00021',13,11,'11',5.00,1,'2025-01-21 11:48:22'),(22,'PAY00022',1,4,'4',7.00,2,'2025-01-21 12:08:25'),(23,'PAY00023',15,1,'1',5.00,2,'2025-01-21 12:56:18'),(24,'PAY00024',6,5,'5',20.00,1,'2025-01-21 12:57:05'),(25,'PAY00025',4,11,'11',45.00,2,'2025-01-21 13:12:00'),(26,'PAY00026',15,10,'10',20.00,1,'2025-01-21 13:58:19'),(27,'PAY00027',14,11,'11',45.00,1,'2025-01-21 13:58:59'),(28,'PAY00028',4,4,'4',21.00,1,'2025-01-21 14:01:09'),(29,'PAY00029',1,6,'6',6.00,1,'2025-01-21 16:06:07'),(30,'PAY00030',1,6,'6',6.00,2,'2025-01-21 16:06:54'),(31,'PAY00031',1,6,'6',6.00,2,'2025-01-21 16:40:57'),(32,'PAY00032',1,6,'6',6.00,2,'2025-01-21 16:42:25'),(33,'PAY00033',1,6,'6',6.00,2,'2025-01-21 16:43:00'),(34,'PAY00034',25,6,'6',65.00,2,'2025-01-21 16:45:57'),(35,'PAY00035',26,6,'6',65.00,2,'2025-01-21 16:46:33'),(36,'PAY00036',30,3,'3',200.00,1,'2025-01-21 16:50:56'),(37,'PAY00037',13,2,'2',50.00,1,'2025-01-22 12:20:56'),(38,'PAY00038',13,2,'2',50.00,1,'2025-01-22 12:20:56'),(39,'PAY00039',17,9,'9',45.00,1,'2025-01-22 12:22:03'),(40,'PAY00040',17,9,'9',45.00,1,'2025-01-22 12:22:03'),(41,'PAY00041',27,10,'10',45.00,1,'2025-01-22 12:29:29'),(42,'PAY00042',27,10,'10',45.00,2,'2025-01-22 12:29:29'),(43,'PAY00043',11,8,'8',60.00,2,'2025-01-22 12:38:43'),(44,'PAY00044',11,8,'8',60.00,1,'2025-01-22 12:38:43'),(45,'PAY00045',6,2,'2',35.00,2,'2025-01-22 12:58:17'),(46,'PAY00046',6,2,'2',35.00,1,'2025-01-22 12:58:17'),(47,'PAY00047',18,5,'5',34.00,1,'2025-01-22 13:02:00'),(48,'PAY00048',18,3,'3',33.00,1,'2025-01-22 13:03:00'),(49,'PAY00049',8,10,'10',22.00,2,'2025-01-22 13:03:43'),(50,'PAY00050',2,2,'2',22.00,2,'2025-01-22 13:05:06'),(51,'PAY00051',30,1,'1',15.00,1,'2025-01-22 13:05:32'),(52,'PAY00052',19,3,'3',23.00,2,'2025-01-22 13:09:33'),(53,'PAY00053',15,3,'3',22.00,1,'2025-01-22 13:20:47'),(54,'PAY00054',2,3,'3',16.00,2,'2025-01-22 13:21:16'),(55,'PAY00055',13,2,'2',44.00,1,'2025-01-22 14:47:37'),(56,'PAY00056',13,3,'3',33.00,2,'2025-01-22 16:13:04'),(57,'PAY00057',24,11,'11',23.00,2,'2025-01-22 16:13:28'),(58,'PAY00058',13,5,'5',12.00,2,'2025-01-22 16:17:46'),(59,'PAY00059',13,7,'7',20.00,1,'2025-01-22 16:21:17'),(60,'PAY00060',5,3,'3',12.00,1,'2025-01-22 16:22:52'),(61,'PAY00061',17,6,'6',65.00,1,'2025-01-22 16:23:25'),(62,'PAY00062',2,4,'4',10.00,1,'2025-01-22 16:29:47'),(63,'PAY00063',30,4,'4',12.00,1,'2025-01-22 16:33:14'),(64,'PAY00064',23,4,'4',12.00,1,'2025-01-22 16:35:30'),(65,'PAY00065',2,9,'9',60.00,1,'2025-01-22 16:58:09'),(66,'PAY00066',16,2,'2',12.00,1,'2025-01-22 16:58:48'),(67,'PAY00067',6,2,'2',25.00,2,'2025-01-22 17:00:45'),(68,'PAY00068',1,3,'3',12.00,2,'2025-01-22 17:08:06'),(69,'PAY00069',18,2,'2',12.00,2,'2025-01-22 17:15:28'),(70,'PAY00070',18,2,'2',12.00,2,'2025-01-22 17:15:29'),(71,'PAY00071',19,9,'9',60.00,2,'2025-01-22 17:17:02'),(72,'PAY00072',19,9,'9',60.00,2,'2025-01-22 17:17:02'),(73,'PAY00073',26,2,'2',12.00,2,'2025-01-22 17:36:58'),(74,'PAY00074',26,2,'2',12.00,2,'2025-01-22 17:36:58'),(75,'PAY00075',14,4,'4',12.00,2,'2025-01-22 17:37:36'),(76,'PAY00076',14,4,'4',12.00,2,'2025-01-22 17:37:36'),(77,'PAY00077',16,11,'11',14.00,2,'2025-01-22 17:42:52'),(78,'PAY00078',16,11,'11',14.00,2,'2025-01-22 17:42:52'),(79,'PAY00079',2,8,'8',23.00,2,'2025-01-22 17:43:22'),(80,'PAY00080',2,8,'8',23.00,2,'2025-01-22 17:43:22'),(81,'PAY00081',15,2,'2',15.00,2,'2025-01-22 17:43:53'),(82,'PAY00082',15,2,'2',15.00,2,'2025-01-22 17:43:53'),(83,'PAY00083',13,2,'2',24.00,2,'2025-01-22 17:45:24'),(84,'PAY00084',13,2,'2',24.00,2,'2025-01-22 17:45:24'),(85,'PAY00085',26,11,'11',11.00,2,'2025-01-22 17:47:19'),(86,'PAY00086',23,5,'5',12.00,2,'2025-01-22 17:47:39'),(87,'PAY00087',13,3,'3',12.00,2,'2025-01-22 17:50:45'),(88,'PAY00088',2,5,'5',22.00,2,'2025-01-22 17:51:16'),(89,'PAY00089',13,2,'2',12.00,2,'2025-01-22 18:02:50'),(90,'PAY00090',5,11,'11',22.00,2,'2025-01-22 18:03:31'),(91,'PAY00091',5,10,'10',20.00,2,'2025-01-22 18:05:43'),(92,'PAY00092',6,7,'7',25.00,2,'2025-01-22 18:12:47'),(93,'PAY00093',26,8,'8',60.00,2,'2025-01-22 18:23:59'),(94,'PAY00094',30,9,'9',62.00,2,'2025-01-22 18:26:22'),(95,'PAY00095',28,1,'1',22.00,2,'2025-01-22 18:32:11'),(96,'PAY00096',30,3,'3',23.00,2,'2025-01-22 18:56:24'),(97,'PAY00097',30,3,'3',23.00,2,'2025-01-22 18:56:26'),(98,'PAY00098',30,3,'3',23.00,2,'2025-01-22 18:56:31'),(99,'PAY00099',13,3,'3',21.00,2,'2025-01-22 18:59:15'),(100,'PAY00100',13,3,'3',21.00,2,'2025-01-22 18:59:20'),(101,'PAY00101',13,3,'3',21.00,2,'2025-01-22 19:03:05'),(102,'PAY00102',4,2,'2',25.00,2,'2025-01-22 19:04:52'),(103,'PAY00103',29,4,'4',12.00,2,'2025-01-22 19:05:26'),(104,'PAY00104',7,1,'1',27.99,1,'2025-01-22 19:05:45'),(105,'PAY00105',24,8,'8',60.00,1,'2025-01-22 19:06:01'),(106,'PAY00106',24,8,'8',60.00,1,'2025-01-22 19:06:04'),(107,'PAY00107',24,8,'8',60.00,1,'2025-01-22 19:06:09'),(108,'PAY00108',24,1,'1',22.50,1,'2025-01-22 19:06:28'),(109,'PAY00109',2,3,'3',12.00,1,'2025-01-22 22:02:31'),(110,'PAY00110',9,1,'1',24.00,1,'2025-01-22 22:04:27'),(111,'PAY00111',23,10,'10',34.00,1,'2025-01-22 22:05:02'),(112,'PAY00112',14,3,'3',12.00,1,'2025-01-22 22:18:02'),(113,'PAY00113',14,3,'3',12.00,2,'2025-01-22 22:18:02'),(114,'PAY00114',8,8,'8',60.00,2,'2025-01-22 22:33:43'),(115,'PAY00115',8,8,'8',60.00,1,'2025-01-22 22:33:43'),(116,'PAY00116',16,4,'4',12.00,1,'2025-01-22 22:46:06'),(117,'PAY00117',16,4,'4',12.00,1,'2025-01-22 22:46:06'),(118,'PAY00118',4,4,'4',11.00,1,'2025-01-23 12:03:41'),(119,'PAY00119',4,4,'4',11.00,1,'2025-01-23 12:03:41'),(120,'PAY00120',5,3,'3',12.00,1,'2025-01-23 12:11:09'),(121,'PAY00121',13,3,'3',12.00,1,'2025-01-23 12:22:46'),(122,'PAY00122',2,2,'2',32.00,1,'2025-01-23 13:00:07'),(123,'PAY00123',29,11,'11',16.00,1,'2025-01-23 13:00:39'),(124,'PAY00124',13,3,'3',12.00,1,'2025-01-23 13:02:41'),(125,'PAY00125',2,4,'4',12.00,1,'2025-01-23 13:37:20'),(126,'PAY00126',2,2,'2',21.99,1,'2025-01-23 14:27:29'),(127,'PAY00127',5,10,'10',25.00,1,'2025-01-23 14:28:19'),(128,'PAY00128',1,1,'1',28.00,1,'2025-01-30 23:52:50'),(129,'PAY00129',1,2,'2',15.00,1,'2025-01-31 00:01:32'),(130,'PAY00130',1,3,'3',12.00,1,'2025-01-31 00:04:06'),(131,'PAY00131',1,1,'1',28.00,1,'2025-01-31 00:10:02'),(132,'PAY00132',1,6,'6',65.00,1,'2025-01-31 00:10:51'),(133,'PAY00133',1,7,'7',20.00,1,'2025-01-31 00:11:51'),(134,'PAY00134',1,3,'3',12.00,1,'2025-01-31 00:13:48'),(135,'PAY00135',2,1,'1',25.00,2,'2025-01-31 00:22:26'),(136,'PAY00136',18,11,'11',13.00,1,'2025-01-31 00:26:35'),(137,'PAY00137',9,2,'2',22.00,2,'2025-01-31 00:34:14'),(138,'PAY00138',3,11,'11',14.00,2,'2025-01-31 00:45:06'),(139,'PAY00139',19,2,'2',23.00,1,'2025-01-31 00:47:38'),(140,'PAY00140',29,2,'2',34.00,2,'2025-01-31 00:50:19'),(141,'PAY00141',5,1,'1',22.00,1,'2025-01-31 00:59:01'),(142,'PAY00142',9,11,'11',15.00,1,'2025-01-31 01:01:15'),(143,'PAY00143',8,3,'3',14.00,1,'2025-01-31 01:05:16'),(144,'PAY00144',26,1,'1',45.00,2,'2025-01-31 01:13:27'),(145,'PAY00145',9,5,'5',23.00,2,'2025-01-31 01:23:49'),(146,'PAY00146',5,11,'11',23.00,2,'2025-01-31 01:26:25'),(147,'PAY00147',6,1,'1',25.00,2,'2025-01-31 01:27:48'),(148,'PAY00148',15,11,'11',14.50,2,'2025-01-31 11:13:20'),(149,'PAY00149',19,8,'8',60.00,2,'2025-01-31 11:24:07'),(150,'PAY00150',18,1,'12',26.00,1,'2025-02-01 00:05:51');
/*!40000 ALTER TABLE `payments_collectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,1,'Supervisor'),(2,2,'Cajero');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` varchar(255) NOT NULL,
  `collector_id` int NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collector_id` (`collector_id`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`collector_id`) REFERENCES `collectors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'S001',1,'Servicio de Intenet Residencial','Servicio de Intenet Residencial',0.00),(2,'S002',2,'Servicio de Telefonía Fija','Servicio de Telefonía Fija',0.00),(3,'S003',3,'Servicio de Luz Eléctrica','Servicio de Luz Eléctrica',0.00),(4,'S004',4,'Servicio de Agua Potable','Servicio de Agua Potable',0.00),(5,'S005',5,'Servicio de Intenet Residencial','Servicio de Internet Residencial',0.00),(6,'S006',6,'Mensualidad UTEC','Mensualidades de alumnado de Universidad Tecnológica de El Salvador',65.00),(7,'S007',7,'Mensualidad UES','Mensualidades de alumnado de Universidad Nacional de El Salvador',20.00),(8,'S008',8,'Mensualidad UNAB','Mensualidades de alumnado de Universidad Dr. Andrés Bello',60.00),(9,'S009',9,'Mensualidad UPED','Mensualidades de alumnado de Universidad Pedagógica',60.00),(10,'S0010',10,'Servicio de Intenet Residencial','Servicio de Internet Residencial',0.00),(11,'S0011',11,'Servicio de Luz Eléctrica','Servicio de Luz Eléctrica',0.00),(12,'S0012',1,'Servicio de Televisión por Cable','Servicio de Televisión por Cable',0.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_types`
--

DROP TABLE IF EXISTS `transaction_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_type_id` varchar(255) NOT NULL,
  `transaction_type` varchar(25) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (1,'1','Deposito',NULL),(2,'2','Retiro',NULL),(3,'3','Transferencia',NULL),(4,'4','Cola de vaca','2025-01-31 22:50:19');
/*!40000 ALTER TABLE `transaction_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(255) NOT NULL,
  `customer_id` int NOT NULL,
  `sender_account` varchar(100) DEFAULT NULL,
  `receiver_id` int NOT NULL,
  `receiver_account` varchar(100) DEFAULT NULL,
  `transaction_type_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `concept` varchar(100) DEFAULT NULL,
  `status` int NOT NULL,
  `date_hour` datetime NOT NULL,
  `realized_by` varchar(100) DEFAULT NULL,
  `authorized_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `transaction_type_id` (`transaction_type_id`),
  KEY `transactions_ibfk_3` (`receiver_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`transaction_type_id`) REFERENCES `transaction_types` (`id`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`receiver_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'TX000001',1,NULL,2,NULL,3,40.00,'',1,'2024-01-02 08:00:00','1','1'),(2,'TX000002',2,NULL,2,NULL,2,20.00,'',2,'2024-01-03 10:00:00','2','1'),(3,'TX000003',1,NULL,1,NULL,1,15.00,'Deposito1',2,'2024-01-04 11:00:00','1','1'),(4,'TX000004',3,NULL,17,NULL,1,20.00,'Deposito2',3,'2024-01-06 10:00:00','2','1'),(5,'TX000005',5,NULL,22,NULL,1,25.00,'Deposito3',1,'2024-01-08 10:00:00','1','1'),(6,'TX000006',10,NULL,15,NULL,2,50.00,'Retiro2',1,'2024-01-10 09:30:00','1','1'),(7,'TX000007',25,NULL,12,NULL,1,30.00,'Deposito4',1,'2024-02-14 14:15:00','1','1'),(8,'TX000008',8,NULL,27,NULL,1,45.00,'Deposito5',2,'2024-03-20 16:45:00','1','1'),(9,'TX000009',16,NULL,9,NULL,2,20.00,'Retiro3',1,'2024-04-08 11:00:00','2','1'),(10,'TX000010',5,NULL,3,NULL,3,35.00,'Pago2',3,'2024-05-12 13:20:00','1','1'),(11,'TX000011',14,NULL,19,NULL,1,25.00,'Deposito6',1,'2024-06-30 10:45:00','1','1'),(12,'TX000012',22,NULL,6,NULL,1,40.00,'Deposito7',1,'2024-07-15 15:30:00','1','1'),(13,'TX000013',13,NULL,20,NULL,1,55.00,'Deposito8',1,'2024-08-19 12:00:00','1','1'),(14,'TX000014',2,NULL,28,NULL,3,60.00,'Pago3',3,'2024-09-03 17:00:00','1','1'),(15,'TX000015',9,NULL,11,NULL,2,75.00,'Retiro4',1,'2024-10-21 09:15:00','2','1'),(16,'TX000016',6,NULL,18,NULL,1,80.00,'Deposito9',1,'2024-11-12 10:30:00','1','1'),(17,'TX000017',21,NULL,30,NULL,1,25.00,'Deposito10',1,'2024-12-07 08:45:00','1','1'),(18,'TX000018',30,NULL,16,NULL,1,20.00,'Deposito11',3,'2024-12-25 14:00:00','1','1'),(19,'TX000019',12,NULL,7,NULL,1,35.00,'Deposito12',2,'2025-01-02 13:45:00','1','1'),(20,'TX000020',4,NULL,24,NULL,2,45.00,'Retiro5',2,'2025-01-05 09:00:00','1','1'),(21,'TX000021',17,NULL,29,NULL,3,60.00,'Pago4',3,'2025-01-09 11:30:00','2','1'),(22,'TX000022',3,NULL,8,NULL,1,75.00,'Deposito13',2,'2025-01-13 16:15:00','1','1'),(23,'TX000023',7,NULL,25,NULL,2,30.00,'Retiro6',1,'2025-01-17 10:50:00','1','1'),(24,'TX000024',11,NULL,13,NULL,1,50.00,'Deposito14',1,'2025-01-20 14:40:00','2','1'),(25,'TX000025',20,NULL,23,NULL,1,65.00,'Deposito15',3,'2025-01-23 12:00:00','1','1'),(26,'TX000026',15,NULL,5,NULL,1,20.00,'Deposito16',3,'2025-01-24 15:10:00','2','1'),(27,'TX000027',29,NULL,4,NULL,1,40.00,'Deposito17',2,'2025-01-25 09:30:00','1','1'),(28,'TX000028',18,NULL,21,NULL,1,55.00,'Deposito18',2,'2025-01-26 10:00:00','2','1'),(29,'TX000029',27,NULL,14,NULL,1,70.00,'Deposito19',1,'2025-01-27 13:45:00','2','1'),(30,'TX000030',24,NULL,10,NULL,1,25.00,'Deposito20',1,'2025-01-29 11:15:00','2','1'),(31,'TX000031',13,NULL,13,NULL,1,10.00,'Simon :u',2,'2025-01-29 16:43:30','2','1'),(32,'TX000032',13,NULL,13,NULL,1,10.00,'Sisas xdd',2,'2025-01-29 17:02:16','1','1'),(33,'TX000033',13,NULL,13,NULL,2,10.00,'JAJAJA no',2,'2025-01-29 17:02:53','1','1'),(34,'TX000034',13,NULL,13,NULL,2,20.00,'YA WEY',2,'2025-01-29 17:05:19','1','1'),(35,'TX000035',2,NULL,1,NULL,3,15.00,'asasasa',2,'2025-01-29 17:16:07','2','1'),(36,'TX000036',1,NULL,1,NULL,1,15.00,'sdxafasddas',2,'2025-01-29 17:28:08','1','1'),(37,'TX000037',1,NULL,1,NULL,2,15.00,'asdqwq',2,'2025-01-29 17:28:55','2','1'),(38,'TX000038',15,NULL,2,NULL,3,200.00,'qsdqada',2,'2025-01-29 17:33:05','1','1'),(39,'TX000039',2,NULL,2,NULL,2,200.00,'wasxdgg',2,'2025-01-29 17:33:44','2','1'),(40,'TX000040',1,NULL,1,NULL,2,10000.00,'XDDDD',2,'2025-01-29 17:34:49','1','1'),(41,'TX000041',2,NULL,1,NULL,3,10000.00,'asdasdqwqw1221',2,'2025-01-29 17:41:51','2','1'),(42,'TX000042',1,NULL,1,NULL,2,10000.00,'jkdskajekwqa12',1,'2025-01-29 17:47:30','2','1'),(43,'TX000043',1,NULL,1,NULL,2,10000.00,'s23e2323',1,'2025-01-29 17:48:58','1','1'),(44,'TX000044',1,NULL,1,NULL,2,10000.00,'sdqweq12123',1,'2025-01-29 17:51:17','2','1'),(45,'TX000045',1,NULL,1,NULL,2,10000.00,'jei230',1,'2025-01-29 17:51:51','2','1'),(46,'TX000046',1,NULL,1,NULL,2,10000.00,'sadq12',1,'2025-01-29 17:53:49','1','1'),(47,'TX000047',1,NULL,1,NULL,2,10000.00,'jsako2',1,'2025-01-29 17:55:28','2','1'),(48,'TX000048',1,NULL,1,NULL,2,10000.00,'dqw122356',1,'2025-01-29 17:56:51','1','1'),(49,'TX000049',1,NULL,1,NULL,2,10000.00,'SDFKMWEK23',1,'2025-01-29 17:58:23','1','1'),(50,'TX000050',1,NULL,1,NULL,2,10000.00,'sdjksjdk2345',1,'2025-01-29 19:52:03','2','1'),(51,'TX000051',1,NULL,1,NULL,2,10000.00,'jasdskwj023',2,'2025-01-29 19:55:30','1','1'),(52,'TX000052',1,NULL,1,NULL,2,10000.00,'j23u01',1,'2025-01-29 19:56:20','1','1'),(53,'TX000053',1,NULL,1,NULL,2,10000.00,'jasdj203',2,'2025-01-29 20:22:14','2','1'),(54,'TX000054',1,NULL,1,NULL,2,10000.00,'ei231',2,'2025-01-29 20:23:20','2','1'),(55,'TX000055',1,NULL,1,NULL,2,10000.00,'j2031',3,'2025-01-29 20:24:44','2','1'),(56,'TX000056',1,NULL,1,NULL,2,10000.00,'je012u3',2,'2025-01-29 20:39:01','2','1'),(57,'TX000057',1,NULL,1,NULL,2,10000.00,'kw02u3',1,'2025-01-29 21:49:25','2','1'),(58,'TX000058',1,NULL,1,NULL,2,15000.00,'JD1203U',2,'2025-01-29 22:02:59','2','1'),(59,'TX000059',1,NULL,1,NULL,2,12500.00,'DJ1JI3',2,'2025-01-29 22:04:20','1','1'),(60,'TX000060',29,'0000 1234 5678 9028',2,'0000 1234 5678 9001',3,1000.00,'Te lo debo we',2,'2025-01-30 09:12:01','1','1'),(61,'TX000061',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,16000.00,'',2,'2025-01-30 09:29:59','1','1'),(62,'TX000062',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,16500.00,'',2,'2025-01-30 09:37:13','1','1'),(63,'TX000063',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',1,5.00,'asasaq',2,'2025-01-30 09:46:08','1','1'),(64,'TX000064',1,'0000 1234 5678 9000',2,'0000 1234 5678 9001',3,5.00,'asfadfqwe',2,'2025-01-30 09:46:57','1','1'),(65,'TX000065',15,'0000 1234 5678 9014',15,'0000 1234 5678 9014',1,12.00,'sddq12',2,'2025-01-30 09:49:30','1','1'),(66,'TX000066',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,10000.00,'',3,'2025-01-30 10:21:38','1','1'),(67,'TX000067',1,'0000 1234 5678 9000',2,'0000 1234 5678 9001',3,150.00,'w4r2342',2,'2025-01-30 10:26:34','1','1'),(68,'TX000068',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12000.00,'',2,'2025-01-30 10:29:06','1','1'),(69,'TX000069',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,10000.00,'',1,'2025-01-30 10:35:13','1','1'),(70,'TX000070',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12500.00,'',1,'2025-01-30 10:36:55','1','1'),(71,'TX000071',2,'0000 1234 5678 9001',2,'0000 1234 5678 9001',2,200.00,'',2,'2025-01-30 10:38:09','1','1'),(72,'TX000072',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12700.00,'',2,'2025-01-30 10:38:36','1','1'),(73,'TX000073',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12000.00,'',2,'2025-01-30 10:51:09','1','1'),(74,'TX000074',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,13560.00,'',2,'2025-01-30 11:01:42','1','1'),(75,'TX000075',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,20120.00,'',2,'2025-01-30 11:05:10','1','1'),(76,'TX000076',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12345.00,'',2,'2025-01-30 11:09:26','1','1'),(77,'TX000077',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,15000.00,'',2,'2025-01-30 11:10:14','1','1'),(78,'TX000078',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12345.00,'',2,'2025-01-30 11:11:11','1','1'),(79,'TX000079',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12345.00,'',2,'2025-01-30 11:13:26','1','1'),(80,'TX000080',1,'0000 1234 5678 9000',1,'0000 1234 5678 9000',2,12340.00,'',2,'2025-01-30 11:50:02','2','1'),(83,'TX000081',1,'0000 1234 5678 9000',1,'0000 1234 5678 9030',3,120.00,NULL,2,'2025-01-30 18:25:56','2','1');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','David Cruz','791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c','dcruzer92@gmail.com',1),(2,'d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35','Juan Caballo','791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c','juan.caballo@example.com',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-01  1:21:15
