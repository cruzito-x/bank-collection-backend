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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
INSERT INTO `audit` VALUES (1,1,'Create Transaction','2025-01-17 12:00:00','Transaction TX001 created'),(2,2,'Update Balance','2025-01-17 13:00:00','Balance updated for Customer C001'),(3,1,'Inicio de Sesión','2025-01-18 03:04:01','Inicio de Sesión Correcto'),(4,1,'Añadir Colector','2025-01-18 03:24:55','Adición de Nuevo Colector'),(5,1,'Añadir Colector','2025-01-18 03:25:36','Adición de Nuevo Colector'),(6,1,'Añadir Colector','2025-01-18 03:29:37','Adición de Nuevo Colector'),(7,1,'Añadir Colector','2025-01-18 03:30:55','Adición de Nuevo Colector'),(8,1,'Añadir Colector','2025-01-18 03:32:41','Adición de Nuevo Colector'),(9,1,'Añadir Colector','2025-01-18 03:32:54','Adición de Nuevo Colector'),(10,1,'Añadir Colector','2025-01-18 03:33:16','Adición de Nuevo Colector'),(11,1,'Añadir Colector','2025-01-18 03:41:09','Adición de Nuevo Colector'),(12,1,'Inicio de Sesión','2025-01-18 11:16:39','Inicio de Sesión Correcto'),(13,1,'Inicio de Sesión','2025-01-18 11:18:17','Inicio de Sesión Correcto'),(14,2,'Inicio de Sesión','2025-01-18 12:04:25','Inicio de Sesión Correcto'),(15,1,'Inicio de Sesión','2025-01-18 12:05:08','Inicio de Sesión Correcto'),(16,1,'Inicio de Sesión','2025-01-20 11:46:43','Inicio de Sesión Correcto'),(17,1,'Inicio de Sesión','2025-01-20 21:55:41','Inicio de Sesión Correcto'),(18,1,'Inicio de Sesión','2025-01-21 11:41:51','Inicio de Sesión Correcto'),(19,1,'Añadir Colector','2025-01-21 11:48:06','Adición de Nuevo Colector'),(20,1,'Inicio de Sesión','2025-01-22 09:22:49','Inicio de Sesión Correcto'),(21,1,'Inicio de Sesión','2025-01-22 12:55:05','Inicio de Sesión Correcto'),(22,1,'Inicio de Sesión','2025-01-22 12:57:16','Inicio de Sesión Correcto'),(23,1,'Inicio de Sesión','2025-01-22 19:02:04','Inicio de Sesión Correcto'),(24,1,'Inicio de Sesión','2025-01-22 21:50:16','Inicio de Sesión Correcto'),(25,1,'Inicio de Sesión','2025-01-23 11:06:18','Inicio de Sesión Correcto'),(26,1,'Inicio de Sesión','2025-01-24 09:09:34','Inicio de Sesión Correcto'),(27,1,'Inicio de Sesión','2025-01-26 09:21:14','Inicio de Sesión Correcto'),(28,1,'Inicio de Sesión','2025-01-27 10:02:02','Inicio de Sesión Correcto');
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
INSERT INTO `collectors` VALUES (1,'COL001','TIGO','Empresa de Telecomunicaciones'),(2,'COL002','CLARO','Empresa de Telecomunicaciones'),(3,'4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce','CAESS','Empresa de Electricidad'),(4,'4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a','ANDA','Empresa de Alcantarillados y Acueductos'),(5,'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d','JAPI','Empresa de Internet'),(6,'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683','Universidad Tecnológica de El Salvador','Mensualidades UTEC'),(7,'7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451','Universidad Nacional de El Salvador','Mensualidades UES'),(8,'2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3','Universidad Dr. Andrés Bello','Mensualidades UNAB'),(9,'19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7','Universidad Pedagógica','Mensualidades UPED'),(10,'4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5','Movistar','Empresa de Telecomunicaciones'),(11,'4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8','Del Sur','Empresa de Servicios Eléctricos');
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
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'1','David Cruz','00000001-1','dcruzer92@gmail.com','0000 1234 5678 9000',1000.50,NULL),(2,'2','Ana Gomez','00000002-2','ana.gomez@example.com','0000 1234 5678 9001',1500.75,NULL),(3,'3','Carlos Ruiz','00000003-3','carlos.ruiz@example.com','0000 1234 5678 9002',2000.00,NULL),(4,'4','Helena Martínez','00000004-4','helena.martinez@example.com','0000 1234 5678 9003',2500.25,NULL),(5,'5','Jose Fernandez','00000005-5','jose.fernandez@example.com','0000 1234 5678 9004',3000.50,NULL),(6,'6','Laura Sanchez','00000006-6','laura.sanchez@example.com','0000 1234 5678 9005',3500.75,NULL),(7,'7','Miguel Ramirez','00000007-7','miguel.ramirez@example.com','0000 1234 5678 9006',4000.00,NULL),(8,'8','Luis Mendez','00000008-8','luis.mendez@example.com','0000 1234 5678 9007',4500.25,NULL),(9,'9','Carmen Morales','00000009-9','carmen.morales@example.com','0000 1234 5678 9008',5000.50,NULL),(10,'10','Rosa López','00000010-0','rosa.lopez@example.com','0000 1234 5678 9009',5500.75,NULL),(11,'11','Ricardo Torres','00000011-1','ricardo.torres@example.com','0000 1234 5678 9010',6000.00,NULL),(12,'12','Patricia Diaz','00000012-2','patricia.diaz@example.com','0000 1234 5678 9011',6500.25,NULL),(13,'13','Alejandro Castillo','00000013-3','alejandro.castillo@example.com','0000 1234 5678 9012',7000.50,NULL),(14,'14','Gabriela Herrera','00000014-4','gabriela.herrera@example.com','0000 1234 5678 9013',7500.75,NULL),(15,'15','Andres Morales','00000015-5','andres.morales@example.com','0000 1234 5678 9014',8000.00,NULL),(16,'16','Juliana Paredes','00000016-6','juliana.paredes@example.com','0000 1234 5678 9015',8500.25,NULL),(17,'17','Oscar Vega','00000017-7','oscar.vega@example.com','0000 1234 5678 9016',9000.50,NULL),(18,'18','Gloria Jimenez','00000018-8','gloria.jimenez@example.com','0000 1234 5678 9017',9500.75,NULL),(19,'19','Enrique Navarro','00000019-9','enrique.navarro@example.com','0000 1234 5678 9018',10000.00,NULL),(20,'20','Marta Ortega','00000020-0','marta.ortega@example.com','0000 1234 5678 9019',10500.25,NULL),(21,'21','Pablo Castillo','00000021-1','pablo.castillo@example.com','0000 1234 5678 9020',11000.50,NULL),(22,'22','Sofia Medina','00000022-2','sofia.medina@example.com','0000 1234 5678 9021',11500.75,NULL),(23,'23','Juan Perez','00000023-3','juan.perez@example.com','0000 1234 5678 9022',12000.00,NULL),(24,'24','Isabel Rios','00000024-4','isabel.rios@example.com','0000 1234 5678 9023',12500.25,NULL),(25,'25','Fernando Nunez','00000025-5','fernando.nunez@example.com','0000 1234 5678 9024',13000.50,NULL),(26,'26','Marina Silva','00000026-6','marina.silva@example.com','0000 1234 5678 9025',13500.75,NULL),(27,'27','Victor Delgado','00000027-7','victor.delgado@example.com','0000 1234 5678 9026',14000.00,NULL),(28,'28','Monica Leon','00000028-8','monica.leon@example.com','0000 1234 5678 9027',14500.25,NULL),(29,'29','Francisco Rivera','00000029-9','francisco.rivera@example.com','0000 1234 5678 9028',15000.50,NULL),(30,'30','Adriana Suarez','000000030-0','adriana.suarez@example.com','0000 1234 5678 9029',15500.75,'2025-01-27 11:49:44');
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
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_collectors`
--

LOCK TABLES `payments_collectors` WRITE;
/*!40000 ALTER TABLE `payments_collectors` DISABLE KEYS */;
INSERT INTO `payments_collectors` VALUES (1,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',2,1,'1',15.00,'2025-01-17 20:31:55'),(2,'d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',2,2,'2',34.00,'2025-01-17 21:53:39'),(3,'4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',2,10,'10',35.00,'2025-01-18 03:42:42'),(4,'4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',1,10,'10',45.00,'2025-01-18 03:43:02'),(5,'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d',3,4,'4',15.00,'2025-01-18 12:09:40'),(6,'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683',4,4,'4',34.00,'2025-01-18 12:09:57'),(7,'7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451',21,3,'3',27.00,'2025-01-18 12:10:21'),(8,'2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3',1,4,'4',13.00,'2025-01-18 18:30:57'),(9,'19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7',1,10,'10',35.00,'2025-01-18 18:39:25'),(10,'4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5',1,4,'4',15.00,'2025-01-18 21:23:41'),(11,'4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8',1,4,'4',25.00,'2025-01-18 22:08:33'),(12,'6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918',1,2,'2',35.00,'2025-01-20 11:49:28'),(13,'3fdba35f04dc8c462986c992bcf875546257113072a909c162f7e470e581e278',1,3,'3',24.00,'2025-01-20 11:51:56'),(14,'8527a891e224136950ff32ca212b45bc93f69fbb801c3b1ebedac52775f99e61',1,4,'4',12.00,'2025-01-20 12:20:49'),(15,'e629fa6598d732768f7c726b4b621285f9c3b85303900aa912017db7617d8bdb',1,1,'1',25.00,'2025-01-20 12:22:16'),(16,'b17ef6d19c7a5b1ee83b907c595526dcb1eb06db8227d650d5dda0a9f4ce8cd9',1,1,'1',50.00,'2025-01-20 21:56:33'),(17,'4523540f1504cd17100c4835e85b7eefd49911580f8efff0599a8f283be6b9e3',1,4,'4',35.00,'2025-01-20 21:57:12'),(18,'4ec9599fc203d176a301536c2e091a19bc852759b255bd6818810a42c5fed14a',1,3,'3',31.00,'2025-01-20 21:58:22'),(19,'9400f1b21cb527d7fa3d3eabba93557a18ebe7a2ca4e471cfe5e4c5b4ca7f767',1,4,'4',5.00,'2025-01-21 11:42:06'),(20,'f5ca38f748a1d6eaf726b8a42fb575c3c71f1864a8143301782de13da2d9202b',3,3,'3',5.00,'2025-01-21 11:46:20'),(21,'6f4b6612125fb3a0daecd2799dfd6c9c299424fd920f9b308110a2c1fbd8f443',13,11,'11',5.00,'2025-01-21 11:48:22'),(22,'785f3ec7eb32f30b90cd0fcf3657d388b5ff4297f2f9716ff66e9b69c05ddd09',1,4,'4',7.00,'2025-01-21 12:08:25'),(23,'535fa30d7e25dd8a49f1536779734ec8286108d115da5045d77f3b4185d8f790',15,1,'1',5.00,'2025-01-21 12:56:18'),(24,'c2356069e9d1e79ca924378153cfbbfb4d4416b1f99d41a2940bfdb66c5319db',6,5,'5',20.00,'2025-01-21 12:57:05'),(25,'b7a56873cd771f2c446d369b649430b65a756ba278ff97ec81bb6f55b2e73569',4,11,'11',45.00,'2025-01-21 13:12:00'),(26,'5f9c4ab08cac7457e9111a30e4664920607ea2c115a1433d7be98e97e64244ca',15,10,'10',20.00,'2025-01-21 13:58:19'),(27,'670671cd97404156226e507973f2ab8330d3022ca96e0c93bdbdb320c41adcaf',14,11,'11',45.00,'2025-01-21 13:58:59'),(28,'59e19706d51d39f66711c2653cd7eb1291c94d9b55eb14bda74ce4dc636d015a',4,4,'4',21.00,'2025-01-21 14:01:09'),(29,'35135aaa6cc23891b40cb3f378c53a17a1127210ce60e125ccf03efcfdaec458',1,6,'6',6.00,'2025-01-21 16:06:07'),(30,'624b60c58c9d8bfb6ff1886c2fd605d2adeb6ea4da576068201b6c6958ce93f4',1,6,'6',6.00,'2025-01-21 16:06:54'),(31,'eb1e33e8a81b697b75855af6bfcdbcbf7cbbde9f94962ceaec1ed8af21f5a50f',1,6,'6',6.00,'2025-01-21 16:40:57'),(32,'e29c9c180c6279b0b02abd6a1801c7c04082cf486ec027aa13515e4f3884bb6b',1,6,'6',6.00,'2025-01-21 16:42:25'),(33,'c6f3ac57944a531490cd39902d0f777715fd005efac9a30622d5f5205e7f6894',1,6,'6',6.00,'2025-01-21 16:43:00'),(34,'86e50149658661312a9e0b35558d84f6c6d3da797f552a9657fe0558ca40cdef',25,6,'6',65.00,'2025-01-21 16:45:57'),(35,'9f14025af0065b30e47e23ebb3b491d39ae8ed17d33739e5ff3827ffb3634953',26,6,'6',65.00,'2025-01-21 16:46:33'),(36,'76a50887d8f1c2e9301755428990ad81479ee21c25b43215cf524541e0503269',30,3,'3',200.00,'2025-01-21 16:50:56'),(37,'7a61b53701befdae0eeeffaecc73f14e20b537bb0f8b91ad7c2936dc63562b25',13,2,'2',50.00,'2025-01-22 12:20:56'),(38,'aea92132c4cbeb263e6ac2bf6c183b5d81737f179f21efdc5863739672f0f470',13,2,'2',50.00,'2025-01-22 12:20:56'),(39,'0b918943df0962bc7a1824c0555a389347b4febdc7cf9d1254406d80ce44e3f9',17,9,'9',45.00,'2025-01-22 12:22:03'),(40,'d59eced1ded07f84c145592f65bdf854358e009c5cd705f5215bf18697fed103',17,9,'9',45.00,'2025-01-22 12:22:03'),(41,'3d914f9348c9cc0ff8a79716700b9fcd4d2f3e711608004eb8f138bcba7f14d9',27,10,'10',45.00,'2025-01-22 12:29:29'),(42,'73475cb40a568e8da8a045ced110137e159f890ac4da883b6b17dc651b3a8049',27,10,'10',45.00,'2025-01-22 12:29:29'),(43,'44cb730c420480a0477b505ae68af508fb90f96cf0ec54c6ad16949dd427f13a',11,8,'8',60.00,'2025-01-22 12:38:43'),(44,'71ee45a3c0db9a9865f7313dd3372cf60dca6479d46261f3542eb9346e4a04d6',11,8,'8',60.00,'2025-01-22 12:38:43'),(45,'811786ad1ae74adfdd20dd0372abaaebc6246e343aebd01da0bfc4c02bf0106c',6,2,'2',35.00,'2025-01-22 12:58:17'),(46,'25fc0e7096fc653718202dc30b0c580b8ab87eac11a700cba03a7c021bc35b0c',6,2,'2',35.00,'2025-01-22 12:58:17'),(47,'31489056e0916d59fe3add79e63f095af3ffb81604691f21cad442a85c7be617',18,5,'5',34.00,'2025-01-22 13:02:00'),(48,'98010bd9270f9b100b6214a21754fd33bdc8d41b2bc9f9dd16ff54d3c34ffd71',18,3,'3',33.00,'2025-01-22 13:03:00'),(49,'0e17daca5f3e175f448bacace3bc0da47d0655a74c8dd0dc497a3afbdad95f1f',8,10,'10',22.00,'2025-01-22 13:03:43'),(50,'1a6562590ef19d1045d06c4055742d38288e9e6dcd71ccde5cee80f1d5a774eb',2,2,'2',22.00,'2025-01-22 13:05:06'),(51,'031b4af5197ec30a926f48cf40e11a7dbc470048a21e4003b7a3c07c5dab1baa',30,1,'1',15.00,'2025-01-22 13:05:32'),(52,'41cfc0d1f2d127b04555b7246d84019b4d27710a3f3aff6e7764375b1e06e05d',19,3,'3',23.00,'2025-01-22 13:09:33'),(53,'2858dcd1057d3eae7f7d5f782167e24b61153c01551450a628cee722509f6529',15,3,'3',22.00,'2025-01-22 13:20:47'),(54,'2fca346db656187102ce806ac732e06a62df0dbb2829e511a770556d398e1a6e',2,3,'3',16.00,'2025-01-22 13:21:16'),(55,'02d20bbd7e394ad5999a4cebabac9619732c343a4cac99470c03e23ba2bdc2bc',13,2,'2',44.00,'2025-01-22 14:47:37'),(56,'7688b6ef52555962d008fff894223582c484517cea7da49ee67800adc7fc8866',13,3,'3',33.00,'2025-01-22 16:13:04'),(57,'c837649cce43f2729138e72cc315207057ac82599a59be72765a477f22d14a54',24,11,'11',23.00,'2025-01-22 16:13:28'),(58,'6208ef0f7750c111548cf90b6ea1d0d0a66f6bff40dbef07cb45ec436263c7d6',13,5,'5',12.00,'2025-01-22 16:17:46'),(59,'3e1e967e9b793e908f8eae83c74dba9bcccce6a5535b4b462bd9994537bfe15c',13,7,'7',20.00,'2025-01-22 16:21:17'),(60,'39fa9ec190eee7b6f4dff1100d6343e10918d044c75eac8f9e9a2596173f80c9',5,3,'3',12.00,'2025-01-22 16:22:52'),(61,'d029fa3a95e174a19934857f535eb9427d967218a36ea014b70ad704bc6c8d1c',17,6,'6',65.00,'2025-01-22 16:23:25'),(62,'81b8a03f97e8787c53fe1a86bda042b6f0de9b0ec9c09357e107c99ba4d6948a',2,4,'4',10.00,'2025-01-22 16:29:47'),(63,'da4ea2a5506f2693eae190d9360a1f31793c98a1adade51d93533a6f520ace1c',30,4,'4',12.00,'2025-01-22 16:33:14'),(64,'a68b412c4282555f15546cf6e1fc42893b7e07f271557ceb021821098dd66c1b',23,4,'4',12.00,'2025-01-22 16:35:30'),(65,'108c995b953c8a35561103e2014cf828eb654a99e310f87fab94c2f4b7d2a04f',2,9,'9',60.00,'2025-01-22 16:58:09'),(66,'3ada92f28b4ceda38562ebf047c6ff05400d4c572352a1142eedfef67d21e662',16,2,'2',12.00,'2025-01-22 16:58:48'),(67,'49d180ecf56132819571bf39d9b7b342522a2ac6d23c1418d3338251bfe469c8',6,2,'2',25.00,'2025-01-22 17:00:45'),(68,'a21855da08cb102d1d217c53dc5824a3a795c1c1a44e971bf01ab9da3a2acbbf',1,3,'3',12.00,'2025-01-22 17:08:06'),(69,'c75cb66ae28d8ebc6eded002c28a8ba0d06d3a78c6b5cbf9b2ade051f0775ac4',18,2,'2',12.00,'2025-01-22 17:15:28'),(70,'c75cb66ae28d8ebc6eded002c28a8ba0d06d3a78c6b5cbf9b2ade051f0775ac4',18,2,'2',12.00,'2025-01-22 17:15:29'),(71,'7f2253d7e228b22a08bda1f09c516f6fead81df6536eb02fa991a34bb38d9be8',19,9,'9',60.00,'2025-01-22 17:17:02'),(72,'8722616204217eddb39e7df969e0698aed8e599ba62ed2de1ce49b03ade0fede',19,9,'9',60.00,'2025-01-22 17:17:02'),(73,'96061e92f58e4bdcdee73df36183fe3ac64747c81c26f6c83aada8d2aabb1864',26,2,'2',12.00,'2025-01-22 17:36:58'),(74,'96061e92f58e4bdcdee73df36183fe3ac64747c81c26f6c83aada8d2aabb1864',26,2,'2',12.00,'2025-01-22 17:36:58'),(75,'f369cb89fc627e668987007d121ed1eacdc01db9e28f8bb26f358b7d8c4f08ac',14,4,'4',12.00,'2025-01-22 17:37:36'),(76,'f369cb89fc627e668987007d121ed1eacdc01db9e28f8bb26f358b7d8c4f08ac',14,4,'4',12.00,'2025-01-22 17:37:36'),(77,'a88a7902cb4ef697ba0b6759c50e8c10297ff58f942243de19b984841bfe1f73',16,11,'11',14.00,'2025-01-22 17:42:52'),(78,'a88a7902cb4ef697ba0b6759c50e8c10297ff58f942243de19b984841bfe1f73',16,11,'11',14.00,'2025-01-22 17:42:52'),(79,'98a3ab7c340e8a033e7b37b6ef9428751581760af67bbab2b9e05d4964a8874a',2,8,'8',23.00,'2025-01-22 17:43:22'),(80,'48449a14a4ff7d79bb7a1b6f3d488eba397c36ef25634c111b49baf362511afc',2,8,'8',23.00,'2025-01-22 17:43:22'),(81,'5316ca1c5ddca8e6ceccfce58f3b8540e540ee22f6180fb89492904051b3d531',15,2,'2',15.00,'2025-01-22 17:43:53'),(82,'5316ca1c5ddca8e6ceccfce58f3b8540e540ee22f6180fb89492904051b3d531',15,2,'2',15.00,'2025-01-22 17:43:53'),(83,'bbb965ab0c80d6538cf2184babad2a564a010376712012bd07b0af92dcd3097d',13,2,'2',24.00,'2025-01-22 17:45:24'),(84,'44c8031cb036a7350d8b9b8603af662a4b9cdbd2f96e8d5de5af435c9c35da69',13,2,'2',24.00,'2025-01-22 17:45:24'),(85,'b4944c6ff08dc6f43da2e9c824669b7d927dd1fa976fadc7b456881f51bf5ccc',26,11,'11',11.00,'2025-01-22 17:47:19'),(86,'434c9b5ae514646bbd91b50032ca579efec8f22bf0b4aac12e65997c418e0dd6',23,5,'5',12.00,'2025-01-22 17:47:39'),(87,'bdd2d3af3a5a1213497d4f1f7bfcda898274fe9cb5401bbc0190885664708fc2',13,3,'3',12.00,'2025-01-22 17:50:45'),(88,'8b940be7fb78aaa6b6567dd7a3987996947460df1c668e698eb92ca77e425349',2,5,'5',22.00,'2025-01-22 17:51:16'),(89,'cd70bea023f752a0564abb6ed08d42c1440f2e33e29914e55e0be1595e24f45a',13,2,'2',12.00,'2025-01-22 18:02:50'),(90,'69f59c273b6e669ac32a6dd5e1b2cb63333d8b004f9696447aee2d422ce63763',5,11,'11',22.00,'2025-01-22 18:03:31'),(91,'1da51b8d8ff98f6a48f80ae79fe3ca6c26e1abb7b7d125259255d6d2b875ea08',5,10,'10',20.00,'2025-01-22 18:05:43'),(92,'8241649609f88ccd2a0a5b233a07a538ec313ff6adf695aa44a969dbca39f67d',6,7,'7',25.00,'2025-01-22 18:12:47'),(93,'6e4001871c0cf27c7634ef1dc478408f642410fd3a444e2a88e301f5c4a35a4d',26,8,'8',60.00,'2025-01-22 18:23:59'),(94,'e3d6c4d4599e00882384ca981ee287ed961fa5f3828e2adb5e9ea890ab0d0525',30,9,'9',62.00,'2025-01-22 18:26:22'),(95,'ad48ff99415b2f007dc35b7eb553fd1eb35ebfa2f2f308acd9488eeb86f71fa8',28,1,'1',22.00,'2025-01-22 18:32:11'),(96,'7b1a278f5abe8e9da907fc9c29dfd432d60dc76e17b0fabab659d2a508bc65c4',30,3,'3',23.00,'2025-01-22 18:56:24'),(97,'d6d824abba4afde81129c71dea75b8100e96338da5f416d2f69088f1960cb091',30,3,'3',23.00,'2025-01-22 18:56:26'),(98,'29db0c6782dbd5000559ef4d9e953e300e2b479eed26d887ef3f92b921c06a67',30,3,'3',23.00,'2025-01-22 18:56:31'),(99,'8c1f1046219ddd216a023f792356ddf127fce372a72ec9b4cdac989ee5b0b455',13,3,'3',21.00,'2025-01-22 18:59:15'),(100,'ad57366865126e55649ecb23ae1d48887544976efea46a48eb5d85a6eeb4d306',13,3,'3',21.00,'2025-01-22 18:59:20'),(101,'16dc368a89b428b2485484313ba67a3912ca03f2b2b42429174a4f8b3dc84e44',13,3,'3',21.00,'2025-01-22 19:03:05'),(102,'37834f2f25762f23e1f74a531cbe445db73d6765ebe60878a7dfbecd7d4af6e1',4,2,'2',25.00,'2025-01-22 19:04:52'),(103,'454f63ac30c8322997ef025edff6abd23e0dbe7b8a3d5126a894e4a168c1b59b',29,4,'4',12.00,'2025-01-22 19:05:26'),(104,'5ef6fdf32513aa7cd11f72beccf132b9224d33f271471fff402742887a171edf',7,1,'1',27.99,'2025-01-22 19:05:45'),(105,'1253e9373e781b7500266caa55150e08e210bc8cd8cc70d89985e3600155e860',24,8,'8',60.00,'2025-01-22 19:06:01'),(106,'482d9673cfee5de391f97fde4d1c84f9f8d6f2cf0784fcffb958b4032de7236c',24,8,'8',60.00,'2025-01-22 19:06:04'),(107,'3346f2bbf6c34bd2dbe28bd1bb657d0e9c37392a1d5ec9929e6a5df4763ddc2d',24,8,'8',60.00,'2025-01-22 19:06:09'),(108,'9537f32ec7599e1ae953af6c9f929fe747ff9dadf79a9beff1f304c550173011',24,1,'1',22.50,'2025-01-22 19:06:28'),(109,'0fd42b3f73c448b34940b339f87d07adf116b05c0227aad72e8f0ee90533e699',2,3,'3',12.00,'2025-01-22 22:02:31'),(110,'9bdb2af6799204a299c603994b8e400e4b1fd625efdb74066cc869fee42c9df3',9,1,'1',24.00,'2025-01-22 22:04:27'),(111,'f6e0a1e2ac41945a9aa7ff8a8aaa0cebc12a3bcc981a929ad5cf810a090e11ae',23,10,'10',34.00,'2025-01-22 22:05:02'),(112,'b1556dea32e9d0cdbfed038fd7787275775ea40939c146a64e205bcb349ad02f',14,3,'3',12.00,'2025-01-22 22:18:02'),(113,'b1556dea32e9d0cdbfed038fd7787275775ea40939c146a64e205bcb349ad02f',14,3,'3',12.00,'2025-01-22 22:18:02'),(114,'9f1f9dce319c4700ef28ec8c53bd3cc8e6abe64c68385479ab89215806a5bdd6',8,8,'8',60.00,'2025-01-22 22:33:43'),(115,'9f1f9dce319c4700ef28ec8c53bd3cc8e6abe64c68385479ab89215806a5bdd6',8,8,'8',60.00,'2025-01-22 22:33:43'),(116,'e5b861a6d8a966dfca7e7341cd3eb6be9901688d547a72ebed0b1f5e14f3d08d',16,4,'4',12.00,'2025-01-22 22:46:06'),(117,'e5b861a6d8a966dfca7e7341cd3eb6be9901688d547a72ebed0b1f5e14f3d08d',16,4,'4',12.00,'2025-01-22 22:46:06'),(118,'85daaf6f7055cd5736287faed9603d712920092c4f8fd0097ec3b650bf27530e',4,4,'4',11.00,'2025-01-23 12:03:41'),(119,'85daaf6f7055cd5736287faed9603d712920092c4f8fd0097ec3b650bf27530e',4,4,'4',11.00,'2025-01-23 12:03:41'),(120,'2abaca4911e68fa9bfbf3482ee797fd5b9045b841fdff7253557c5fe15de6477',5,3,'3',12.00,'2025-01-23 12:11:09'),(121,'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904',13,3,'3',12.00,'2025-01-23 12:22:46'),(122,'1be00341082e25c4e251ca6713e767f7131a2823b0052caf9c9b006ec512f6cb',2,2,'2',32.00,'2025-01-23 13:00:07'),(123,'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',29,11,'11',16.00,'2025-01-23 13:00:39'),(124,'6affdae3b3c1aa6aa7689e9b6a7b3225a636aa1ac0025f490cca1285ceaf1487',13,3,'3',12.00,'2025-01-23 13:02:41'),(125,'0f8ef3377b30fc47f96b48247f463a726a802f62f3faa03d56403751d2f66c67',2,4,'4',12.00,'2025-01-23 13:37:20'),(126,'65a699905c02619370bcf9207f5a477c3d67130ca71ec6f750e07fe8d510b084',2,2,'2',21.99,'2025-01-23 14:27:29'),(127,'922c7954216ccfe7a61def609305ce1dc7c67e225f873f256d30d7a8ee4f404c',5,10,'10',25.00,'2025-01-23 14:28:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'S001',1,'Internet Residencial','Servicio de Intenet Residencial',0.00),(2,'S002',2,'Telefonía Fija','Servicio de Telefonía Fija',0.00),(3,'S003',3,'Luz','Servicio de Luz Eléctrica',0.00),(4,'S004',4,'Agua','Servicio de Agua Potable',0.00),(5,'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d',5,'Internet Residencial','Servicio de Internet Residencial',0.00),(6,'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683',6,'Mensualidades UTEC','Mensualidades de alumnado de Universidad Tecnológica de El Salvador',65.00),(7,'7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451',7,'Mensualidades UES','Mensualidades de alumnado de Universidad Nacional de El Salvador',20.00),(8,'2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3',8,'Mensualidades UNAB','Mensualidades de alumnado de Universidad Dr. Andrés Bello',60.00),(9,'19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7',9,'Mensualidades UPED','Mensualidades de alumnado de Universidad Pedagógica',60.00),(10,'4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5',10,'Internet Residencial','Servicio de Internet Residencial',0.00),(11,'4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8',11,'Luz','Servicio de Luz Eléctrica',0.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (1,'1','Deposito'),(2,'2','Retiro'),(3,'3','Transferencia'),(4,'4','Pago a Colector');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'TX001',1,2,3,500.00,'2025-01-20 10:00:00','1'),(2,'TX002',2,2,1,200.00,'2025-01-21 11:00:00','1'),(3,'TX003',1,5,3,15.00,'2025-01-27 11:00:00','1');
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

-- Dump completed on 2025-01-27 22:57:17
