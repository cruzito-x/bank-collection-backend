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
INSERT INTO `accounts` VALUES (1,'1',1,'0000 1234 5678 9000',88100.00,'2025-01-30 00:00:00',NULL),(2,'2',2,'0000 1234 5678 9001',79975.00,'2025-01-30 00:00:00',NULL),(3,'3',3,'0000 1234 5678 9002',90025.00,'2025-01-30 00:00:00',NULL),(4,'4',4,'0000 1234 5678 9003',90025.00,'2025-01-30 00:00:00',NULL),(5,'5',5,'0000 1234 5678 9004',90000.00,'2025-01-30 00:00:00',NULL),(6,'6',6,'0000 1234 5678 9005',90000.00,'2025-01-30 00:00:00',NULL),(7,'7',7,'0000 1234 5678 9006',90000.00,'2025-01-30 00:00:00',NULL),(8,'8',8,'0000 1234 5678 9007',65800.00,'2025-01-30 00:00:00',NULL),(9,'9',9,'0000 1234 5678 9008',79000.00,'2025-01-30 00:00:00',NULL),(10,'10',10,'0000 1234 5678 9009',79000.00,'2025-01-30 00:00:00',NULL),(11,'11',11,'0000 1234 5678 9010',79000.00,'2025-01-30 00:00:00',NULL),(12,'12',12,'0000 1234 5678 9011',90000.00,'2025-01-30 00:00:00',NULL),(13,'13',13,'0000 1234 5678 9012',90000.00,'2025-01-30 00:00:00',NULL),(14,'14',14,'0000 1234 5678 9013',78800.00,'2025-01-30 00:00:00',NULL),(15,'15',15,'0000 1234 5678 9014',90000.00,'2025-01-30 00:00:00',NULL),(16,'16',16,'0000 1234 5678 9015',70000.00,'2025-01-30 00:00:00',NULL),(17,'17',17,'0000 1234 5678 9016',90000.00,'2025-01-30 00:00:00',NULL),(18,'18',18,'0000 1234 5678 9017',80000.00,'2025-01-30 00:00:00',NULL),(19,'19',19,'0000 1234 5678 9018',70000.00,'2025-01-30 00:00:00',NULL),(20,'20',20,'0000 1234 5678 9019',80000.00,'2025-01-30 00:00:00',NULL),(21,'21',21,'0000 1234 5678 9020',80000.00,'2025-01-30 00:00:00',NULL),(22,'22',22,'0000 1234 5678 9021',80000.00,'2025-01-30 00:00:00',NULL),(23,'23',23,'0000 1234 5678 9022',90000.00,'2025-01-30 00:00:00',NULL),(24,'24',24,'0000 1234 5678 9023',80000.00,'2025-01-30 00:00:00',NULL),(25,'25',25,'0000 1234 5678 9024',80000.00,'2025-01-30 00:00:00',NULL),(26,'26',26,'0000 1234 5678 9025',77000.00,'2025-01-30 00:00:00',NULL),(27,'27',27,'0000 1234 5678 9026',79865.00,'2025-01-30 00:00:00',NULL),(28,'28',28,'0000 1234 5678 9027',67000.00,'2025-01-30 00:00:00',NULL),(29,'29',29,'0000 1234 5678 9028',90250.00,'2025-01-30 00:00:00',NULL),(30,'30',30,'0000 1234 5678 9029',90000.00,'2025-01-30 00:00:00',NULL),(31,'31',1,'0000 1234 5678 9030',78215.00,'2025-01-30 00:00:00',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approvals`
--

LOCK TABLES `approvals` WRITE;
/*!40000 ALTER TABLE `approvals` DISABLE KEYS */;
INSERT INTO `approvals` VALUES (1,'APVL000001',3,1,1,'2025-02-01 21:28:35'),(2,'APVL000002',4,1,1,'2025-02-01 21:46:59'),(3,'APVL000003',5,1,1,'2025-02-01 23:27:02'),(4,'APVL000004',6,1,1,'2025-02-01 23:52:00'),(5,'APVL000005',7,1,1,'2025-02-01 23:59:16'),(6,'APVL000006',8,1,1,'2025-02-02 00:27:46'),(7,'APVL000007',11,1,1,'2025-02-02 00:52:38'),(8,'APVL000008',12,1,1,'2025-02-02 13:34:27'),(9,'APVL000009',15,1,1,'2025-02-03 18:28:18'),(10,'APVL000010',16,1,1,'2025-02-03 18:30:27'),(11,'APVL000011',17,1,1,'2025-02-04 20:41:06'),(12,'APVL000012',18,1,1,'2025-02-05 15:15:27'),(13,'APVL000013',19,1,1,'2025-02-05 15:15:28'),(14,'APVL000014',20,1,1,'2025-02-05 15:15:29'),(15,'APVL000015',21,1,1,'2025-02-05 15:15:29'),(16,'APVL000016',22,1,1,'2025-02-05 15:15:30'),(17,'APVL000017',23,1,1,'2025-02-05 15:15:31'),(18,'APVL000018',24,1,1,'2025-02-05 15:15:32'),(19,'APVL000019',25,1,1,'2025-02-05 15:15:33'),(20,'APVL000020',26,1,1,'2025-02-05 17:50:47'),(21,'APVL000021',27,1,1,'2025-02-05 17:50:48'),(22,'APVL000022',28,1,1,'2025-02-05 17:32:31'),(39,'APVL000023',61,1,1,'2025-02-06 16:32:21'),(40,'APVL000040',62,1,1,'2025-02-06 16:33:19');
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
  `details` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
INSERT INTO `audit` VALUES (1,1,'Inicio de Sesión','2025-02-01 11:37:29','Inicio de Sesión Correcto'),(2,1,'Añadir Colector','2025-02-01 11:49:33','Adición de Nuevo Colector'),(3,2,'Transacción Registrada','2025-02-02 00:22:42','Se Creo la Transacción TSC000008 por un Monto de $10000'),(4,2,'Transacción Registrada','2025-02-02 00:31:05','Se Creo la Transacción TSC000010 por un Monto de $150'),(5,2,'Transacción Registrada','2025-02-02 00:52:09','Se Creo la Transacción TSC000011 por un Monto de $10000'),(6,1,'Transacción Aprobada','2025-02-02 00:52:38','Se Aprobó la Transacción TSC000011 por un Monto de $10000.00'),(7,1,'Cliente Actualizado','2025-02-02 01:08:21','Se Actualizaron los Datos del Cliente con Número de Identidad 00000029-9'),(8,1,'Cliente Eliminado','2025-02-02 01:15:15','Se Eliminó al Cliente con Número de Identidad 000000030-0'),(9,1,'Pago a Colector Realizado','2025-02-02 01:31:05','Pago de $25 Realizado a TIGO por Servicio de Intenet Residencial'),(10,1,'Pago a Colector Realizado','2025-02-02 01:31:47','Pago de $25 Realizado a TIGO por Servicio de Intenet Residencial'),(11,1,'Pago a Colector Realizado','2025-02-02 01:34:19','Pago de $20 Realizado a Ancianas en Bikini sin Dentadura por Besuqueadas'),(12,1,'Pago a Colector Realizado','2025-02-02 01:39:42','Pago de $15 Realizado a ANDA por Servicio de Agua Potable'),(13,1,'Pago a Colector Realizado','2025-02-02 01:40:06','Pago de $20 Realizado a UES por Mensualidad UES'),(14,1,'Pago a Colector Realizado','2025-02-02 01:48:33','Pago de $65 Realizado a UTEC por Mensualidad UTEC'),(15,1,'Pago a Colector Realizado','2025-02-02 01:49:04','Pago de $15 Realizado a Del Sur por Servicio de Luz Eléctrica'),(16,1,'Tipo de Transacción Eliminado','2025-02-02 02:02:22','Ejemplo Eliminado'),(17,1,'Nuevo Tipo de Transacción Registrado','2025-02-02 02:02:57','Ejemplo2 Registrado'),(18,1,'Tipo de Transacción Eliminado','2025-02-02 02:03:07','Cola de vaca Eliminado'),(19,1,'Tipo de Transacción Eliminado','2025-02-02 02:03:09','Ejemplo2 Eliminado'),(20,1,'Tipo de Transacción Actualizado','2025-02-02 02:05:39','Se Actualizó el Nombre del Tipo de Transacción con Código 5 Actualizado'),(21,1,'Tipo de Transacción Eliminado','2025-02-02 02:06:25','Se Eliminó el Tipo de Transacción Ejemplo3'),(22,1,'Asignación de Nuevo Rol','2025-02-02 02:10:12','Se Asignó el Rol 2 al Usuario Juan Caballo'),(23,1,'Asignación de Nuevo Rol','2025-02-02 02:12:06','Se Asignó el Rol Cajero al Usuario Juan Caballo'),(24,1,'Usuario Actualizado','2025-02-02 02:14:10','Se Actualizaron los Datos del Usuario Juan Caballo'),(25,1,'Usuario Eliminado','2025-02-02 02:22:51','Se Eliminó el Usuario Juan Caballo'),(26,1,'Colector Registrado','2025-02-02 02:25:46','Se Registró al Colector Ejemplo'),(27,1,'Colector Registrado','2025-02-02 02:31:10','Se Registró al Colector Ejemplo 2'),(28,1,'Servicio Registrado','2025-02-02 02:31:10','Se Registró el Servicio Ejemplo Servicio 2 del Colector Ejemplo 2'),(29,1,'Inicio de Sesión','2025-02-02 02:40:28','Inicio de Sesión Correcto'),(30,1,'Inicio de Sesión','2025-02-02 02:41:39','Inicio de Sesión Correcto'),(31,1,'Inicio de Sesión','2025-02-02 02:43:31','Inicio de Sesión Correcto'),(32,1,'Eliminación de Colector','2025-02-02 03:06:26','Se Eliminó al Colector Ancianas en Bikini sin Dentadura'),(33,1,'Eliminación de Colector','2025-02-02 03:06:47','Se Eliminó al Colector Ancianas en Bikini sin Dentadura'),(34,1,'Eliminación de Colector','2025-02-02 03:12:06','Se Eliminó al Colector Ancianas en Bikini sin Dentadura'),(35,1,'Eliminación de Colector','2025-02-02 03:14:32','Se Eliminó al Colector Ancianas en Bikini sin Dentadura'),(36,1,'Eliminación de Colector','2025-02-02 03:16:01','Se Eliminó al Colector Ejemplo 2'),(37,1,'Inicio de Sesión','2025-02-02 03:36:40','Inicio de Sesión Correcto'),(38,1,'Inicio de Sesión','2025-02-02 03:37:16','Inicio de Sesión Correcto'),(39,2,'Inicio de Sesión','2025-02-02 03:37:43','Inicio de Sesión Correcto'),(40,1,'Inicio de Sesión','2025-02-02 03:37:50','Inicio de Sesión Correcto'),(41,1,'Inicio de Sesión','2025-02-02 03:40:13','Inicio de Sesión Correcto'),(42,2,'Inicio de Sesión','2025-02-02 03:40:55','Inicio de Sesión Correcto'),(43,1,'Inicio de Sesión','2025-02-02 11:14:57','Inicio de Sesión Correcto'),(44,2,'Inicio de Sesión','2025-02-02 13:01:13','Inicio de Sesión Correcto'),(45,2,'Transacción Registrada','2025-02-02 13:01:40','Se Creo la Transacción TSC000012, de $11000'),(46,1,'Transacción Aprobada','2025-02-02 13:34:27','Se Aprobó la Transacción TSC000012 por un Monto de $11000.00'),(47,1,'Colector Modificado','2025-02-02 13:59:06','Se Modificó el Colector TIGO'),(48,1,'Colector Modificado','2025-02-02 13:59:13','Se Modificó el Colector TIGO'),(49,1,'Servicio Registrado','2025-02-02 16:02:14','Se Registró el Servicio Internet Residencial Para el Colector CLARO Desde la Vista Servicios'),(50,1,'Servicio Actualizado','2025-02-02 16:25:12','Se Actualizó el Servicio Internet Residencial de 10MB del Colector CLARO'),(51,1,'Servicio Eliminado','2025-02-02 16:42:18','Se Eliminó el Servicio Ejemplo Servicio 2 del Colector Ejemplo 2'),(52,1,'Servicio Actualizado','2025-02-02 16:45:29','Se Actualizó el Servicio Intenet Residencial de 50MB del Colector JAPI'),(53,1,'Colector Registrado','2025-02-02 17:29:41','Se Registró al Colector Mi Colector'),(54,1,'Servicio Registrado','2025-02-02 17:29:41','Se Registró el Servicio asdas del Colector Mi Colector'),(55,2,'Transacción Registrada','2025-02-02 17:31:38','Se Creo la Transacción TSC000013, de $250.75'),(56,1,'Pago a Colector Realizado','2025-02-02 19:43:21','Pago de $22 Realizado a TIGO por Intenet Residencial de 150MB'),(57,2,'Transacción Registrada','2025-02-02 23:19:46','Se Creo la Transacción TSC000014, de $25'),(58,1,'Inicio de Sesión','2025-02-03 00:05:00','Inicio de Sesión Correcto'),(59,1,'Inicio de Sesión','2025-02-03 10:17:10','Inicio de Sesión Correcto'),(60,2,'Inicio de Sesión','2025-02-03 16:36:09','Inicio de Sesión Correcto'),(61,2,'Transacción Registrada','2025-02-03 16:36:38','Se Creo la Transacción TSC000015, de $10000'),(62,1,'Transacción Aprobada','2025-02-03 18:28:18','Se Aprobó la Transacción TSC000015 por un Monto de $10000.00'),(63,2,'Transacción Registrada','2025-02-03 18:30:20','Se Creo la Transacción TSC000016, de $11000'),(64,1,'Transacción Aprobada','2025-02-03 18:30:27','Se Aprobó la Transacción TSC000016 por un Monto de $11000.00'),(65,1,'Inicio de Sesión','2025-02-03 18:38:53','Inicio de Sesión Correcto'),(66,1,'Pago a Colector Realizado','2025-02-03 18:42:07','Pago de $15 Realizado a Del Sur por Luz Eléctrica'),(67,1,'Colector Registrado','2025-02-03 18:53:47','Se Registró al Colector Mi Colector xd'),(68,1,'Servicio Registrado','2025-02-03 18:53:47','Se Registró el Servicio qqwe del Colector Mi Colector xd'),(69,2,'Inicio de Sesión','2025-02-03 18:54:16','Inicio de Sesión Correcto'),(70,1,'Colector Modificado','2025-02-03 18:55:02','Se Modificó el Colector Mi Colector xd'),(71,1,'Eliminación de Colector','2025-02-03 18:55:06','Se Eliminó Tanto al Colector Mi Colector xd Como a sus Servicios'),(72,1,'Eliminación de Colector','2025-02-03 18:55:09','Se Eliminó Tanto al Colector Mi Colector Como a sus Servicios'),(73,1,'Inicio de Sesión','2025-02-03 20:27:22','Inicio de Sesión Correcto'),(74,2,'Inicio de Sesión','2025-02-03 20:35:50','Inicio de Sesión Correcto'),(75,1,'Inicio de Sesión','2025-02-03 20:36:05','Inicio de Sesión Correcto'),(76,1,'Inicio de Sesión','2025-02-03 20:36:56','Inicio de Sesión Correcto'),(77,1,'Inicio de Sesión','2025-02-03 21:08:24','Inicio de Sesión Correcto'),(78,1,'Inicio de Sesión','2025-02-04 11:08:11','Inicio de Sesión Correcto'),(79,2,'Inicio de Sesión','2025-02-04 18:38:05','Inicio de Sesión Correcto'),(80,2,'Inicio de Sesión','2025-02-04 20:33:48','Inicio de Sesión Correcto'),(81,1,'Inicio de Sesión','2025-02-04 20:33:59','Inicio de Sesión Correcto'),(82,2,'Transacción Registrada','2025-02-04 20:39:58','Se Creo la Transacción TSC000017, de $10000'),(83,1,'Transacción Aprobada','2025-02-04 20:41:06','Se Aprobó la Transacción TSC000017 por un Monto de $10000.00'),(84,2,'Transacción Registrada','2025-02-04 20:41:36','Se Creo la Transacción TSC000018, de $11000'),(85,2,'Transacción Registrada','2025-02-04 20:42:09','Se Creo la Transacción TSC000019, de $12000'),(86,2,'Transacción Registrada','2025-02-04 21:03:27','Se Creo la Transacción TSC000020, de $11000'),(87,2,'Transacción Registrada','2025-02-04 21:04:08','Se Creo la Transacción TSC000021, de $11200'),(88,1,'Inicio de Sesión','2025-02-05 10:51:17','Inicio de Sesión Correcto'),(89,2,'Inicio de Sesión','2025-02-05 10:53:06','Inicio de Sesión Correcto'),(90,1,'Inicio de Sesión','2025-02-05 10:53:23','Inicio de Sesión Correcto'),(91,2,'Transacción Registrada','2025-02-05 10:54:46','Se Creo la Transacción TSC000022, de $11200'),(92,2,'Transacción Registrada','2025-02-05 13:58:24','Se Creo la Transacción TSC000023, de $13000'),(93,2,'Transacción Registrada','2025-02-05 14:59:21','Se Creo la Transacción TSC000024, de $10000'),(94,2,'Transacción Registrada','2025-02-05 15:07:20','Se Creo la Transacción TSC000025, de $10000'),(95,1,'Transacción Aprobada','2025-02-05 15:15:27','Se Aprobó la Transacción TSC000018 por un Monto de $11000.00'),(96,1,'Transacción Aprobada','2025-02-05 15:15:28','Se Aprobó la Transacción TSC000019 por un Monto de $12000.00'),(97,1,'Transacción Aprobada','2025-02-05 15:15:29','Se Aprobó la Transacción TSC000020 por un Monto de $11000.00'),(98,1,'Transacción Aprobada','2025-02-05 15:15:29','Se Aprobó la Transacción TSC000021 por un Monto de $11200.00'),(99,1,'Transacción Aprobada','2025-02-05 15:15:30','Se Aprobó la Transacción TSC000022 por un Monto de $11200.00'),(100,1,'Transacción Aprobada','2025-02-05 15:15:31','Se Aprobó la Transacción TSC000023 por un Monto de $13000.00'),(101,1,'Transacción Aprobada','2025-02-05 15:15:32','Se Aprobó la Transacción TSC000024 por un Monto de $10000.00'),(102,1,'Transacción Aprobada','2025-02-05 15:15:33','Se Aprobó la Transacción TSC000025 por un Monto de $10000.00'),(103,2,'Inicio de Sesión','2025-02-05 15:16:06','Inicio de Sesión Correcto'),(104,2,'Transacción Registrada','2025-02-05 15:17:29','Se Creo la Transacción TSC000026, de $10000'),(105,2,'Transacción Registrada','2025-02-05 15:31:42','Se Creo la Transacción TSC000027, de $10000'),(106,2,'Transacción Registrada','2025-02-05 15:33:05','Se Creo la Transacción TSC000028, de $11000'),(107,1,'Transacción Aprobada','2025-02-05 17:50:47','Se Aprobó la Transacción TSC000026 por un Monto de $10000.00'),(108,1,'Transacción Aprobada','2025-02-05 17:50:48','Se Aprobó la Transacción TSC000027 por un Monto de $10000.00'),(109,2,'Inicio de Sesión','2025-02-06 11:15:54','Inicio de Sesión Correcto'),(110,1,'Inicio de Sesión','2025-02-06 12:11:40','Inicio de Sesión Correcto'),(111,2,'Transacción Registrada','2025-02-06 13:24:34','Se Creo la Transacción TSC000029, de $120'),(112,2,'Transacción Registrada','2025-02-06 13:24:50','Se Creo la Transacción TSC000055, de $50'),(113,1,'Inicio de Sesión','2025-02-06 13:38:39','Inicio de Sesión Correcto'),(114,2,'Transacción Registrada','2025-02-06 14:48:00','Se Creo la Transacción TSC000056, de $125'),(115,2,'Transacción Registrada','2025-02-06 14:51:47','Se Creo la Transacción TSC000057, de $15'),(116,2,'Transacción Registrada','2025-02-06 15:30:34','Se Creo la Transacción TSC000058, de $35'),(117,2,'Transacción Registrada','2025-02-06 15:33:41','Se Creo la Transacción TSC000059, de $15'),(118,2,'Transacción Registrada','2025-02-06 15:45:13','Se Creo la Transacción TSC000060, de $10'),(119,2,'Transacción Registrada','2025-02-06 16:19:18','Se Creo la Transacción TSC000061, de $12000'),(120,1,'Transacción Aprobada','2025-02-06 16:32:21','Se Aprobó la Transacción TSC000061 por un Monto de $12000.00'),(121,2,'Transacción Registrada','2025-02-06 16:33:11','Se Creo la Transacción TSC000062, de $13000'),(122,1,'Transacción Aprobada','2025-02-06 16:33:19','Se Aprobó la Transacción TSC000062 por un Monto de $13000.00'),(123,2,'Inicio de Sesión','2025-02-06 17:28:32','Inicio de Sesión Correcto'),(124,2,'Cierre de Sesión','2025-02-06 17:29:27','Cierre de Sesión Correcto'),(125,2,'Inicio de Sesión','2025-02-06 17:29:45','Inicio de Sesión Correcto'),(126,1,'Cierre de Sesión','2025-02-06 17:29:58','Cierre de Sesión Correcto'),(127,1,'Inicio de Sesión','2025-02-06 17:30:04','Inicio de Sesión Correcto');
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
  `collector` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collectors`
--

LOCK TABLES `collectors` WRITE;
/*!40000 ALTER TABLE `collectors` DISABLE KEYS */;
INSERT INTO `collectors` VALUES (1,'CLT000001','TIGO','Empresa de Telecomunicaciones',NULL),(2,'CLT000002','CLARO','Empresa de Telecomunicaciones',NULL),(3,'CLT000003','CAESS','Empresa de Servicios Eléctricos',NULL),(4,'CLT000004','ANDA','Administración Nacional de Acueductos y Alcantarillados',NULL),(5,'CLT000005','JAPI','Empresa de Telecomunicaciones',NULL),(6,'CLT000006','UTEC','Universidad Tecnológica de El Salvador',NULL),(7,'CLT000007','UES','Universidad Nacional de El Salvador',NULL),(8,'CLT000008','UNAB','Universidad Dr. Andrés Bello',NULL),(9,'CLT000009','UPED','Universidad Pedagógica',NULL),(10,'CLT000010','Movistar','Empresa de Telecomunicaciones',NULL),(11,'CLT000011','Del Sur','Empresa de Servicios Eléctricos',NULL),(12,'CLT000012','aes El Salvador','Empresa de Servicios Eléctricos','2025-02-02 03:14:32'),(13,'CLT000013','Ejemplo','Ejemplo de descripción de Colector',NULL),(14,'CLT000014','Ejemplo 2','Ejemplo 2 de descripción de colector','2025-02-02 03:16:01'),(15,'CLT000015','Mi Colector','wsdfwe','2025-02-03 18:55:09'),(16,'CLT000016','Mi Colector xd','adqw2w3w34423','2025-02-03 18:55:06');
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
INSERT INTO `customers` VALUES (1,'1','David Cruz','00000001-1','dcruzer92@gmail.com',NULL),(2,'2','Ana Gomez','00000002-2','ana.gomez@example.com',NULL),(3,'3','Carlos Ruiz','00000003-3','carlos.ruiz@example.com',NULL),(4,'4','Helena Martínez','00000004-4','helena.martinez@example.com',NULL),(5,'5','Jose Fernandez','00000005-5','jose.fernandez@example.com',NULL),(6,'6','Laura Sanchez','00000006-6','laura.sanchez@example.com',NULL),(7,'7','Miguel Ramirez','00000007-7','miguel.ramirez@example.com',NULL),(8,'8','Luis Mendez','00000008-8','luis.mendez@example.com',NULL),(9,'9','Carmen Morales','00000009-9','carmen.morales@example.com',NULL),(10,'10','Rosa López','00000010-0','rosa.lopez@example.com',NULL),(11,'11','Ricardo Torres','00000011-1','ricardo.torres@example.com',NULL),(12,'12','Patricia Diaz','00000012-2','patricia.diaz@example.com',NULL),(13,'13','Alejandro Castillo','00000013-3','alejandro.castillo@example.com',NULL),(14,'14','Gabriela Herrera','00000014-4','gabriela.herrera@example.com',NULL),(15,'15','Andres Morales','00000015-5','andres.morales@example.com',NULL),(16,'16','Juliana Paredes','00000016-6','juliana.paredes@example.com',NULL),(17,'17','Oscar Vega','00000017-7','oscar.vega@example.com',NULL),(18,'18','Gloria Jimenez','00000018-8','gloria.jimenez@example.com',NULL),(19,'19','Enrique Navarro','00000019-9','enrique.navarro@example.com',NULL),(20,'20','Marta Ortega','00000020-0','marta.ortega@example.com',NULL),(21,'21','Pablo Castillo','00000021-1','pablo.castillo@example.com',NULL),(22,'22','Sofia Medina','00000022-2','sofia.medina@example.com',NULL),(23,'23','Juan Perez','00000023-3','juan.perez@example.com',NULL),(24,'24','Isabel Rios','00000024-4','isabel.rios@example.com',NULL),(25,'25','Fernando Nunez','00000025-5','fernando.nunez@example.com',NULL),(26,'26','Marina Silva','00000026-6','marina.silva@example.com',NULL),(27,'27','Victor Delgado','00000027-7','victor.delgado@example.com',NULL),(28,'28','Monica Leon','00000028-8','monica.leon@example.com',NULL),(29,'29','Francisco Rivera','00000029-9','francisco.rivera@example.com',NULL),(30,'30','Adriana Suarez','000000030-0','adriana.suarez@example.com','2025-02-02 01:20:38');
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
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_collectors`
--

LOCK TABLES `payments_collectors` WRITE;
/*!40000 ALTER TABLE `payments_collectors` DISABLE KEYS */;
INSERT INTO `payments_collectors` VALUES (1,'PAY000001',2,1,'1',15.00,1,'2025-01-17 20:31:55'),(2,'PAY000002',2,2,'2',34.00,1,'2025-01-17 21:53:39'),(3,'PAY000003',2,10,'10',35.00,2,'2025-01-18 03:42:42'),(4,'PAY000004',1,10,'10',45.00,2,'2025-01-18 03:43:02'),(5,'PAY000005',3,4,'4',15.00,2,'2025-01-18 12:09:40'),(6,'PAY000006',4,4,'4',34.00,2,'2025-01-18 12:09:57'),(7,'PAY000007',21,3,'3',27.00,2,'2025-01-18 12:10:21'),(8,'PAY000008',1,4,'4',13.00,2,'2025-01-18 18:30:57'),(9,'PAY000009',1,10,'10',35.00,2,'2025-01-18 18:39:25'),(10,'PAY000010',1,4,'4',15.00,2,'2025-01-18 21:23:41'),(11,'PAY000011',1,4,'4',25.00,1,'2025-01-18 22:08:33'),(12,'PAY000012',1,2,'2',35.00,2,'2025-01-20 11:49:28'),(13,'PAY000013',1,3,'3',24.00,1,'2025-01-20 11:51:56'),(14,'PAY000014',1,4,'4',12.00,1,'2025-01-20 12:20:49'),(15,'PAY000015',1,1,'1',25.00,1,'2025-01-20 12:22:16'),(16,'PAY000016',1,1,'1',50.00,1,'2025-01-20 21:56:33'),(17,'PAY000017',1,4,'4',35.00,2,'2025-01-20 21:57:12'),(18,'PAY000018',1,3,'3',31.00,2,'2025-01-20 21:58:22'),(19,'PAY000019',1,4,'4',5.00,2,'2025-01-21 11:42:06'),(20,'PAY000020',3,3,'3',5.00,1,'2025-01-21 11:46:20'),(21,'PAY000021',13,11,'11',5.00,1,'2025-01-21 11:48:22'),(22,'PAY000022',1,4,'4',7.00,2,'2025-01-21 12:08:25'),(23,'PAY000023',15,1,'1',5.00,2,'2025-01-21 12:56:18'),(24,'PAY000024',6,5,'5',20.00,1,'2025-01-21 12:57:05'),(25,'PAY000025',4,11,'11',45.00,2,'2025-01-21 13:12:00'),(26,'PAY000026',15,10,'10',20.00,1,'2025-01-21 13:58:19'),(27,'PAY000027',14,11,'11',45.00,1,'2025-01-21 13:58:59'),(28,'PAY000028',4,4,'4',21.00,1,'2025-01-21 14:01:09'),(29,'PAY000029',1,6,'6',6.00,1,'2025-01-21 16:06:07'),(30,'PAY000030',1,6,'6',6.00,2,'2025-01-21 16:06:54'),(31,'PAY000031',1,6,'6',6.00,2,'2025-01-21 16:40:57'),(32,'PAY000032',1,6,'6',6.00,2,'2025-01-21 16:42:25'),(33,'PAY000033',1,6,'6',6.00,2,'2025-01-21 16:43:00'),(34,'PAY000034',25,6,'6',65.00,2,'2025-01-21 16:45:57'),(35,'PAY000035',26,6,'6',65.00,2,'2025-01-21 16:46:33'),(36,'PAY000036',30,3,'3',200.00,1,'2025-01-21 16:50:56'),(37,'PAY000037',13,2,'2',50.00,1,'2025-01-22 12:20:56'),(38,'PAY000038',13,2,'2',50.00,1,'2025-01-22 12:20:56'),(39,'PAY000039',17,9,'9',45.00,1,'2025-01-22 12:22:03'),(40,'PAY000040',17,9,'9',45.00,1,'2025-01-22 12:22:03'),(41,'PAY000041',27,10,'10',45.00,1,'2025-01-22 12:29:29'),(42,'PAY000042',27,10,'10',45.00,2,'2025-01-22 12:29:29'),(43,'PAY000043',11,8,'8',60.00,2,'2025-01-22 12:38:43'),(44,'PAY000044',11,8,'8',60.00,1,'2025-01-22 12:38:43'),(45,'PAY000045',6,2,'2',35.00,2,'2025-01-22 12:58:17'),(46,'PAY000046',6,2,'2',35.00,1,'2025-01-22 12:58:17'),(47,'PAY000047',18,5,'5',34.00,1,'2025-01-22 13:02:00'),(48,'PAY000048',18,3,'3',33.00,1,'2025-01-22 13:03:00'),(49,'PAY000049',8,10,'10',22.00,2,'2025-01-22 13:03:43'),(50,'PAY000050',2,2,'2',22.00,2,'2025-01-22 13:05:06'),(51,'PAY000051',30,1,'1',15.00,1,'2025-01-22 13:05:32'),(52,'PAY000052',19,3,'3',23.00,2,'2025-01-22 13:09:33'),(53,'PAY000053',15,3,'3',22.00,1,'2025-01-22 13:20:47'),(54,'PAY000054',2,3,'3',16.00,2,'2025-01-22 13:21:16'),(55,'PAY000055',13,2,'2',44.00,1,'2025-01-22 14:47:37'),(56,'PAY000056',13,3,'3',33.00,2,'2025-01-22 16:13:04'),(57,'PAY000057',24,11,'11',23.00,2,'2025-01-22 16:13:28'),(58,'PAY000058',13,5,'5',12.00,2,'2025-01-22 16:17:46'),(59,'PAY000059',13,7,'7',20.00,1,'2025-01-22 16:21:17'),(60,'PAY000060',5,3,'3',12.00,1,'2025-01-22 16:22:52'),(61,'PAY000061',17,6,'6',65.00,1,'2025-01-22 16:23:25'),(62,'PAY000062',2,4,'4',10.00,1,'2025-01-22 16:29:47'),(63,'PAY000063',30,4,'4',12.00,1,'2025-01-22 16:33:14'),(64,'PAY000064',23,4,'4',12.00,1,'2025-01-22 16:35:30'),(65,'PAY000065',2,9,'9',60.00,1,'2025-01-22 16:58:09'),(66,'PAY000066',16,2,'2',12.00,1,'2025-01-22 16:58:48'),(67,'PAY000067',6,2,'2',25.00,2,'2025-01-22 17:00:45'),(68,'PAY000068',1,3,'3',12.00,2,'2025-01-22 17:08:06'),(69,'PAY000069',18,2,'2',12.00,2,'2025-01-22 17:15:28'),(70,'PAY000070',18,2,'2',12.00,2,'2025-01-22 17:15:29'),(71,'PAY000071',19,9,'9',60.00,2,'2025-01-22 17:17:02'),(72,'PAY000072',19,9,'9',60.00,2,'2025-01-22 17:17:02'),(73,'PAY000073',26,2,'2',12.00,2,'2025-01-22 17:36:58'),(74,'PAY000074',26,2,'2',12.00,2,'2025-01-22 17:36:58'),(75,'PAY000075',14,4,'4',12.00,2,'2025-01-22 17:37:36'),(76,'PAY000076',14,4,'4',12.00,2,'2025-01-22 17:37:36'),(77,'PAY000077',16,11,'11',14.00,2,'2025-01-22 17:42:52'),(78,'PAY000078',16,11,'11',14.00,2,'2025-01-22 17:42:52'),(79,'PAY000079',2,8,'8',23.00,2,'2025-01-22 17:43:22'),(80,'PAY000080',2,8,'8',23.00,2,'2025-01-22 17:43:22'),(81,'PAY000081',15,2,'2',15.00,2,'2025-01-22 17:43:53'),(82,'PAY000082',15,2,'2',15.00,2,'2025-01-22 17:43:53'),(83,'PAY000083',13,2,'2',24.00,2,'2025-01-22 17:45:24'),(84,'PAY000084',13,2,'2',24.00,2,'2025-01-22 17:45:24'),(85,'PAY000085',26,11,'11',11.00,2,'2025-01-22 17:47:19'),(86,'PAY000086',23,5,'5',12.00,2,'2025-01-22 17:47:39'),(87,'PAY000087',13,3,'3',12.00,2,'2025-01-22 17:50:45'),(88,'PAY000088',2,5,'5',22.00,2,'2025-01-22 17:51:16'),(89,'PAY000089',13,2,'2',12.00,2,'2025-01-22 18:02:50'),(90,'PAY000090',5,11,'11',22.00,2,'2025-01-22 18:03:31'),(91,'PAY000091',5,10,'10',20.00,2,'2025-01-22 18:05:43'),(92,'PAY000092',6,7,'7',25.00,2,'2025-01-22 18:12:47'),(93,'PAY000093',26,8,'8',60.00,2,'2025-01-22 18:23:59'),(94,'PAY000094',30,9,'9',62.00,2,'2025-01-22 18:26:22'),(95,'PAY000095',28,1,'1',22.00,2,'2025-01-22 18:32:11'),(96,'PAY000096',30,3,'3',23.00,2,'2025-01-22 18:56:24'),(97,'PAY000097',30,3,'3',23.00,2,'2025-01-22 18:56:26'),(98,'PAY000098',30,3,'3',23.00,2,'2025-01-22 18:56:31'),(99,'PAY000099',13,3,'3',21.00,2,'2025-01-22 18:59:15'),(100,'PAY000100',13,3,'3',21.00,2,'2025-01-22 18:59:20'),(101,'PAY000101',13,3,'3',21.00,2,'2025-01-22 19:03:05'),(102,'PAY000102',4,2,'2',25.00,2,'2025-01-22 19:04:52'),(103,'PAY000103',29,4,'4',12.00,2,'2025-01-22 19:05:26'),(104,'PAY000104',7,1,'1',27.99,1,'2025-01-22 19:05:45'),(105,'PAY000105',24,8,'8',60.00,1,'2025-01-22 19:06:01'),(106,'PAY000106',24,8,'8',60.00,1,'2025-01-22 19:06:04'),(107,'PAY000107',24,8,'8',60.00,1,'2025-01-22 19:06:09'),(108,'PAY000108',24,1,'1',22.50,1,'2025-01-22 19:06:28'),(109,'PAY000109',2,3,'3',12.00,1,'2025-01-22 22:02:31'),(110,'PAY000110',9,1,'1',24.00,1,'2025-01-22 22:04:27'),(111,'PAY000111',23,10,'10',34.00,1,'2025-01-22 22:05:02'),(112,'PAY000112',14,3,'3',12.00,1,'2025-01-22 22:18:02'),(113,'PAY000113',14,3,'3',12.00,2,'2025-01-22 22:18:02'),(114,'PAY000114',8,8,'8',60.00,2,'2025-01-22 22:33:43'),(115,'PAY000115',8,8,'8',60.00,1,'2025-01-22 22:33:43'),(116,'PAY000116',16,4,'4',12.00,1,'2025-01-22 22:46:06'),(117,'PAY000117',16,4,'4',12.00,1,'2025-01-22 22:46:06'),(118,'PAY000118',4,4,'4',11.00,1,'2025-01-23 12:03:41'),(119,'PAY000119',4,4,'4',11.00,1,'2025-01-23 12:03:41'),(120,'PAY000120',5,3,'3',12.00,1,'2025-01-23 12:11:09'),(121,'PAY000121',13,3,'3',12.00,1,'2025-01-23 12:22:46'),(122,'PAY000122',2,2,'2',32.00,1,'2025-01-23 13:00:07'),(123,'PAY000123',29,11,'11',16.00,1,'2025-01-23 13:00:39'),(124,'PAY000124',13,3,'3',12.00,1,'2025-01-23 13:02:41'),(125,'PAY000125',2,4,'4',12.00,1,'2025-01-23 13:37:20'),(126,'PAY000126',2,2,'2',21.99,1,'2025-01-23 14:27:29'),(127,'PAY000127',5,10,'10',25.00,1,'2025-01-23 14:28:19'),(128,'PAY000128',1,1,'1',28.00,1,'2025-01-30 23:52:50'),(129,'PAY000129',1,2,'2',15.00,1,'2025-01-31 00:01:32'),(130,'PAY000130',1,3,'3',12.00,1,'2025-01-31 00:04:06'),(131,'PAY000131',1,1,'1',28.00,1,'2025-01-31 00:10:02'),(132,'PAY000132',1,6,'6',65.00,1,'2025-01-31 00:10:51'),(133,'PAY000133',1,7,'7',20.00,1,'2025-01-31 00:11:51'),(134,'PAY000134',1,3,'3',12.00,1,'2025-01-31 00:13:48'),(135,'PAY000135',2,1,'1',25.00,2,'2025-01-31 00:22:26'),(136,'PAY000136',18,11,'11',13.00,1,'2025-01-31 00:26:35'),(137,'PAY000137',9,2,'2',22.00,2,'2025-01-31 00:34:14'),(138,'PAY000138',3,11,'11',14.00,2,'2025-01-31 00:45:06'),(139,'PAY000139',19,2,'2',23.00,1,'2025-01-31 00:47:38'),(140,'PAY000140',29,2,'2',34.00,2,'2025-01-31 00:50:19'),(141,'PAY000141',5,1,'1',22.00,1,'2025-01-31 00:59:01'),(142,'PAY000142',9,11,'11',15.00,1,'2025-01-31 01:01:15'),(143,'PAY000143',8,3,'3',14.00,1,'2025-01-31 01:05:16'),(144,'PAY000144',26,1,'1',45.00,2,'2025-01-31 01:13:27'),(145,'PAY000145',9,5,'5',23.00,2,'2025-01-31 01:23:49'),(146,'PAY000146',5,11,'11',23.00,2,'2025-01-31 01:26:25'),(147,'PAY000147',6,1,'1',25.00,2,'2025-01-31 01:27:48'),(148,'PAY000148',15,11,'11',14.50,2,'2025-01-31 11:13:20'),(149,'PAY000149',19,8,'8',60.00,2,'2025-01-31 11:24:07'),(150,'PAY000150',18,1,'12',26.00,1,'2025-02-01 00:05:51'),(151,'PAY000151',3,1,'1',25.00,1,'2025-02-02 01:26:59'),(152,'PAY000152',22,1,'1',25.00,1,'2025-02-02 01:28:16'),(153,'PAY000153',22,1,'1',25.00,1,'2025-02-02 01:31:04'),(154,'PAY000154',22,1,'1',25.00,1,'2025-02-02 01:31:47'),(155,'PAY000155',26,12,'13',20.00,1,'2025-02-02 01:34:17'),(156,'PAY000156',5,4,'4',15.00,1,'2025-02-02 01:39:41'),(157,'PAY000157',10,7,'7',20.00,1,'2025-02-02 01:40:05'),(158,'PAY000158',12,6,'6',65.00,1,'2025-02-02 01:48:32'),(159,'PAY000159',17,11,'11',15.00,1,'2025-02-02 01:49:04'),(160,'PAY000160',28,1,'16',42.00,1,'2025-02-02 19:36:26'),(161,'PAY000161',20,1,'12',22.00,1,'2025-02-02 19:43:20'),(162,'PAY000162',7,11,'11',15.00,1,'2025-02-03 18:42:07');
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
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collector_id` (`collector_id`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`collector_id`) REFERENCES `collectors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'SRV000001',1,'Intenet Residencial de 150MB','Servicio de Intenet Residencial de 150MB',0.00,NULL),(2,'SRV000002',2,'Telefonía Fija','Servicio de Telefonía Fija',0.00,NULL),(3,'SRV000003',3,'Luz Eléctrica','Servicio de Luz Eléctrica',0.00,NULL),(4,'SRV000004',4,'Agua Potable','Servicio de Agua Potable',0.00,NULL),(5,'SRV000005',5,'Intenet Residencial de 50MB','Servicio de Internet Residencial',33.45,NULL),(6,'SRV000006',6,'Mensualidad UTEC','Mensualidades de alumnado de Universidad Tecnológica de El Salvador',65.00,NULL),(7,'SRV000007',7,'Mensualidad UES','Mensualidades de alumnado de Universidad Nacional de El Salvador',20.00,NULL),(8,'SRV000008',8,'Mensualidad UNAB','Mensualidades de alumnado de Universidad Dr. Andrés Bello',60.00,NULL),(9,'SRV000009',9,'Mensualidad UPED','Mensualidades de alumnado de Universidad Pedagógica',60.00,NULL),(10,'SRV000010',10,'Intenet Residencial de 100MB','Servicio de Internet Residencial',0.00,NULL),(11,'SRV000011',11,'Luz Eléctrica','Servicio de Luz Eléctrica',0.00,NULL),(12,'SRV000012',1,'Televisión por Cable','Servicio de Televisión por Cable',0.00,NULL),(13,'SRV000013',12,'Luz Eléctrica','Servicio de Luz Eléctrica',0.00,'2025-02-02 03:14:32'),(14,'SRV000014',13,'Ejemplo Servicio','Ejemplo de descripción de Servicio',0.00,NULL),(15,'SRV000015',14,'Ejemplo Servicio 2','Ejemplo 2 de descripción de servicio',0.00,'2025-02-02 16:42:18'),(16,'SRV000016',1,'Internet Residencial de 200MB','Servicio de Intenet Residencial de 200MB',0.00,NULL),(17,'SRV000017',2,'Internet Residencial de 10MB','Servicio de Internet Residencial de 10MB',24.99,NULL),(18,'SRV000018',15,'asdas','asdrqw',24.45,'2025-02-03 18:55:09'),(19,'SRV000019',16,'qqwe','qwe12',123.00,'2025-02-03 18:55:06');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (1,'1','Deposito',NULL),(2,'2','Retiro',NULL),(3,'3','Transferencia',NULL),(4,'4','Cola de vaca','2025-02-02 02:03:07'),(5,'5','Ejemplo3','2025-02-02 02:06:25'),(6,'6','Ejemplo2','2025-02-02 02:03:09');
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'TSC000001',1,'0000 1234 5678 9000',1,NULL,1,100000.00,NULL,2,'2025-02-01 20:27:06','1','1'),(2,'TSC000002',2,'0000 1234 5678 9001',4,'0000 1234 5678 9003',3,25.00,NULL,2,'2025-02-01 20:30:00','1','1'),(3,'TSC000003',19,'0000 1234 5678 9018',19,NULL,2,10000.00,NULL,2,'2025-02-01 20:31:33','1','1'),(4,'TSC000004',18,'0000 1234 5678 9017',18,NULL,2,10000.00,NULL,2,'2025-02-01 21:35:28','1','1'),(5,'TSC000005',11,'0000 1234 5678 9010',11,NULL,2,10000.00,NULL,2,'2025-02-01 23:26:42','1','1'),(6,'TSC000006',20,'0000 1234 5678 9019',20,NULL,2,10000.00,NULL,2,'2025-02-01 23:51:10','1','1'),(7,'TSC000007',24,'0000 1234 5678 9023',24,NULL,2,10000.00,NULL,2,'2025-02-01 23:59:07','1','1'),(8,'TSC000008',21,'0000 1234 5678 9020',21,NULL,2,10000.00,NULL,2,'2025-02-02 00:22:42','1','1'),(9,'TSC000009',29,'0000 1234 5678 9028',29,NULL,1,250.00,NULL,2,'2025-02-02 00:28:27','1','1'),(10,'TSC000010',27,'0000 1234 5678 9026',1,'0000 1234 5678 9030',3,150.00,'Gracias',2,'2025-02-02 00:31:05','1','1'),(11,'TSC000011',16,'0000 1234 5678 9015',16,NULL,2,10000.00,NULL,2,'2025-02-02 00:52:09','1','1'),(12,'TSC000012',28,'0000 1234 5678 9027',28,NULL,2,11000.00,NULL,2,'2025-02-02 13:01:40','1','1'),(13,'TSC000013',2,'0000 1234 5678 9001',17,'0000 1234 5678 9016',3,250.75,'Chi... Chiflatumauser :D',2,'2025-02-02 17:31:38','1','1'),(14,'TSC000014',3,'0000 1234 5678 9002',3,NULL,1,25.00,NULL,2,'2025-02-02 23:19:46','1','1'),(15,'TSC000015',2,'0000 1234 5678 9001',2,NULL,2,10000.00,NULL,2,'2025-02-03 16:36:38','1','1'),(16,'TSC000016',9,'0000 1234 5678 9008',9,NULL,2,11000.00,NULL,2,'2025-02-03 18:30:20','1','1'),(17,'TSC000017',25,'0000 1234 5678 9024',25,NULL,2,10000.00,NULL,2,'2025-02-04 20:39:58','1','1'),(18,'TSC000018',11,'0000 1234 5678 9010',11,NULL,2,11000.00,NULL,2,'2025-02-04 20:41:36','1','1'),(19,'TSC000019',28,'0000 1234 5678 9027',28,NULL,2,12000.00,NULL,2,'2025-02-04 20:42:09','1','1'),(20,'TSC000020',10,'0000 1234 5678 9009',10,NULL,2,11000.00,NULL,2,'2025-02-04 21:03:27','1','1'),(21,'TSC000021',14,'0000 1234 5678 9013',14,NULL,2,11200.00,NULL,2,'2025-02-04 21:04:08','1','1'),(22,'TSC000022',8,'0000 1234 5678 9007',8,NULL,2,11200.00,NULL,2,'2025-02-05 10:54:46','1','1'),(23,'TSC000023',26,'0000 1234 5678 9025',26,NULL,2,13000.00,NULL,2,'2025-02-05 13:58:24','1','1'),(24,'TSC000024',22,'0000 1234 5678 9021',22,NULL,2,10000.00,NULL,2,'2025-02-05 14:59:21','1','1'),(25,'TSC000025',27,'0000 1234 5678 9026',27,NULL,2,10000.00,NULL,2,'2025-02-05 15:07:20','1','1'),(26,'TSC000026',19,'0000 1234 5678 9018',19,NULL,2,10000.00,NULL,2,'2025-02-05 15:17:29','1','1'),(27,'TSC000027',16,'0000 1234 5678 9015',16,NULL,2,10000.00,NULL,2,'2025-02-05 15:31:42','1','1'),(28,'TSC000028',11,'0000 1234 5678 9010',11,NULL,2,11000.00,NULL,2,'2025-02-05 15:33:05','1','1'),(54,'TSC000029',2,'0000 1234 5678 9001',2,NULL,2,120.00,NULL,2,'2025-02-06 13:24:34','1','1'),(55,'TSC000055',1,'0000 1234 5678 9030',1,NULL,1,50.00,NULL,2,'2025-02-06 13:24:50','1','1'),(56,'TSC000056',1,'0000 1234 5678 9000',1,NULL,1,125.00,NULL,2,'2025-02-06 14:48:00','1','1'),(57,'TSC000057',1,'0000 1234 5678 9000',27,'0000 1234 5678 9026',3,15.00,NULL,2,'2025-02-06 14:51:47','1','1'),(58,'TSC000058',1,'0000 1234 5678 9000',1,NULL,1,35.00,NULL,2,'2025-02-06 15:30:34','1','1'),(59,'TSC000059',1,'0000 1234 5678 9000',1,'0000 1234 5678 9030',3,15.00,NULL,2,'2025-02-06 15:33:41','1','1'),(60,'TSC000060',2,'0000 1234 5678 9001',2,NULL,1,10.00,NULL,2,'2025-02-06 15:45:13','1','1'),(61,'TSC000061',1,'0000 1234 5678 9000',1,NULL,2,12000.00,NULL,2,'2025-02-06 16:19:18','1','1'),(62,'TSC000062',8,'0000 1234 5678 9007',8,NULL,2,13000.00,NULL,2,'2025-02-06 16:33:11','1','1');
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
  `pin` varchar(255) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
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
INSERT INTO `users` VALUES (1,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','David Cruz','791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c','dcruzer92@gmail.com',1,'791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c',NULL),(2,'d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35','Juan Caballo','791600add16b8f1b60280a9db9560d93a2a966b0d960a2f72eb03f04ac9b5f9c','juan.caballo@example.com',2,NULL,NULL);
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

-- Dump completed on 2025-02-06 18:40:23
