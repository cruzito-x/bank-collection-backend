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
-- Table structure for table `approvals`
--

DROP TABLE IF EXISTS `approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `approvals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `approval_id` varchar(255) NOT NULL,
  `transaction_id` int NOT NULL,
  `authorizer_id` int NOT NULL,
  `date_hour` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `authorizer_id` (`authorizer_id`),
  CONSTRAINT `approvals_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `approvals_ibfk_2` FOREIGN KEY (`authorizer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approvals`
--

LOCK TABLES `approvals` WRITE;
/*!40000 ALTER TABLE `approvals` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
INSERT INTO `audit` VALUES (1,1,'Create Transaction','2025-01-17 12:00:00','Transaction TX001 created'),(2,2,'Update Balance','2025-01-17 13:00:00','Balance updated for Customer C001'),(3,1,'Inicio de Sesión','2025-01-18 03:04:01','Inicio de Sesión Correcto'),(4,1,'Añadir Colector','2025-01-18 03:24:55','Adición de Nuevo Colector'),(5,1,'Añadir Colector','2025-01-18 03:25:36','Adición de Nuevo Colector'),(6,1,'Añadir Colector','2025-01-18 03:29:37','Adición de Nuevo Colector'),(7,1,'Añadir Colector','2025-01-18 03:30:55','Adición de Nuevo Colector'),(8,1,'Añadir Colector','2025-01-18 03:32:41','Adición de Nuevo Colector'),(9,1,'Añadir Colector','2025-01-18 03:32:54','Adición de Nuevo Colector'),(10,1,'Añadir Colector','2025-01-18 03:33:16','Adición de Nuevo Colector'),(11,1,'Añadir Colector','2025-01-18 03:41:09','Adición de Nuevo Colector');
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
INSERT INTO `bills` VALUES (1,'BILL001',1,150.00,1),(2,'BILL002',2,100.00,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collectors`
--

LOCK TABLES `collectors` WRITE;
/*!40000 ALTER TABLE `collectors` DISABLE KEYS */;
INSERT INTO `collectors` VALUES (1,'COL001','TIGO','Empresa de Telecomunicaciones'),(2,'COL002','Claro','Empresa de Telecomunicaciones'),(3,'4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce','CAESS','Empresa de Electricidad'),(4,'4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a','ANDA','Empresa de Alcantarillados y Acueductos'),(5,'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d','JAPI','Empresa de Internet'),(6,'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683','JASKAJK','AJSKAJSK'),(7,'7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451','asdas','asdas'),(8,'2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3','asdas','qwqw'),(9,'19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7','asdas','asdas'),(10,'4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5','Movistar','Empresa de Telecomunicaciones');
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
  `account_number` varchar(19) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'C001','David Cruz','00000001-1','david.cruz@example.com','0000 1234 5678 9000',1000.50),(2,'C002','Ana Gomez','00000002-2','ana.gomez@example.com','0000 1234 5678 9001',1500.75),(3,'3','Carlos Ruiz','00000003-3','carlos.ruiz@example.com','0000 1234 5678 9002',2000.00),(4,'4','Elena Martinez','00000004-4','elena.martinez@example.com','0000 1234 5678 9003',2500.25),(5,'5','Jose Fernandez','00000005-5','jose.fernandez@example.com','0000 1234 5678 9004',3000.50),(6,'6','Laura Sanchez','00000006-6','laura.sanchez@example.com','0000 1234 5678 9005',3500.75),(7,'7','Miguel Ramirez','00000007-7','miguel.ramirez@example.com','0000 1234 5678 9006',4000.00),(8,'8','Luis Mendez','00000008-8','luis.mendez@example.com','0000 1234 5678 9007',4500.25),(9,'9','Carmen Morales','00000009-9','carmen.morales@example.com','0000 1234 5678 9008',5000.50),(10,'10','Rosa Lopez','00000010-0','rosa.lopez@example.com','0000 1234 5678 9009',5500.75),(11,'11','Ricardo Torres','00000011-1','ricardo.torres@example.com','0000 1234 5678 9010',6000.00),(12,'12','Patricia Diaz','00000012-2','patricia.diaz@example.com','0000 1234 5678 9011',6500.25),(13,'13','Alejandro Castillo','00000013-3','alejandro.castillo@example.com','0000 1234 5678 9012',7000.50),(14,'14','Gabriela Herrera','00000014-4','gabriela.herrera@example.com','0000 1234 5678 9013',7500.75),(15,'15','Andres Morales','00000015-5','andres.morales@example.com','0000 1234 5678 9014',8000.00),(16,'16','Juliana Paredes','00000016-6','juliana.paredes@example.com','0000 1234 5678 9015',8500.25),(17,'17','Oscar Vega','00000017-7','oscar.vega@example.com','0000 1234 5678 9016',9000.50),(18,'18','Gloria Jimenez','00000018-8','gloria.jimenez@example.com','0000 1234 5678 9017',9500.75),(19,'19','Enrique Navarro','00000019-9','enrique.navarro@example.com','0000 1234 5678 9018',10000.00),(20,'20','Marta Ortega','00000020-0','marta.ortega@example.com','0000 1234 5678 9019',10500.25),(21,'21','Pablo Castillo','00000021-1','pablo.castillo@example.com','0000 1234 5678 9020',11000.50),(22,'22','Sofia Medina','00000022-2','sofia.medina@example.com','0000 1234 5678 9021',11500.75),(23,'23','Juan Perez','00000023-3','juan.perez@example.com','0000 1234 5678 9022',12000.00),(24,'24','Isabel Rios','00000024-4','isabel.rios@example.com','0000 1234 5678 9023',12500.25),(25,'25','Fernando Nunez','00000025-5','fernando.nunez@example.com','0000 1234 5678 9024',13000.50),(26,'26','Marina Silva','00000026-6','marina.silva@example.com','0000 1234 5678 9025',13500.75),(27,'27','Victor Delgado','00000027-7','victor.delgado@example.com','0000 1234 5678 9026',14000.00),(28,'28','Monica Leon','00000028-8','monica.leon@example.com','0000 1234 5678 9027',14500.25),(29,'29','Francisco Rivera','00000029-9','francisco.rivera@example.com','0000 1234 5678 9028',15000.50),(30,'30','Adriana Suarez','000000030-0','adriana.suarez@example.com','0000 1234 5678 9029',15500.75);
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
  `date_hour` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `collector_id` (`collector_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `payments_collectors_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `payments_collectors_ibfk_2` FOREIGN KEY (`collector_id`) REFERENCES `collectors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_collectors`
--

LOCK TABLES `payments_collectors` WRITE;
/*!40000 ALTER TABLE `payments_collectors` DISABLE KEYS */;
INSERT INTO `payments_collectors` VALUES (1,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',2,1,'1',15.00,'2025-01-17 20:31:55'),(2,'d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',2,2,'2',34.00,'2025-01-17 21:53:39'),(3,'4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',2,10,'10',35.00,'2025-01-18 03:42:42'),(4,'4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',1,10,'10',45.00,'2025-01-18 03:43:02');
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
INSERT INTO `roles` VALUES (1,1,'Admin'),(2,2,'Collector');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'S001',1,'Internet Residencial','Servicio de Intenet Residencial',75.00),(2,'S002',2,'Telefonía Fija','Servicio de Telefonía Fija',30.00),(3,'S003',3,'Luz','Servicio de Luz Eléctrica',0.00),(4,'S004',4,'Agua','Servicio de Agua Potable',0.00),(5,'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d',5,'Internet Residencial','Servicio de Internet Residencial',0.00),(6,'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683',6,'JAKSJAK','AJKSJAK',0.00),(7,'7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451',7,'asdas','asdas',0.00),(8,'2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3',8,'qweqw','qweqw',0.00),(9,'19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7',9,'asdas','asdas',0.00),(10,'4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5',10,'Internet Residencial','Servicio de Internet Residencial',0.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_denominations`
--

DROP TABLE IF EXISTS `transaction_denominations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_denominations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int NOT NULL,
  `denomination_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `transaction_denominations_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `transaction_denominations_ibfk_2` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_denominations`
--

LOCK TABLES `transaction_denominations` WRITE;
/*!40000 ALTER TABLE `transaction_denominations` DISABLE KEYS */;
INSERT INTO `transaction_denominations` VALUES (1,1,1,2),(2,1,2,3);
/*!40000 ALTER TABLE `transaction_denominations` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (1,'T001','Deposito'),(2,'T002','Retiro'),(3,'T003','Transferencia');
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
  `receiver_id` int DEFAULT NULL,
  `transaction_type_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date_hour` datetime NOT NULL,
  `authorized_by` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `transaction_type_id` (`transaction_type_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`transaction_type_id`) REFERENCES `transaction_types` (`id`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`receiver_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'TX001',1,NULL,1,500.00,'2025-01-17 10:00:00','Admin'),(2,'TX002',2,1,3,200.00,'2025-01-17 11:00:00','Admin');
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
INSERT INTO `users` VALUES (1,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','David Cruz','791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c','dcruzer92@gmail.com',1),(2,'d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35','Juan Caballo','791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c','juancaballodeverdadsoyyoirapuescomorelinchoijijijaequisdedede@gmail.com',2);
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

-- Dump completed on 2025-01-18  4:01:15
