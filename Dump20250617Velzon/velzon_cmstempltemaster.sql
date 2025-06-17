CREATE DATABASE  IF NOT EXISTS `velzon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `velzon`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: velzon
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `cmstempltemaster`
--

DROP TABLE IF EXISTS `cmstempltemaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmstempltemaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `TemplateType` int DEFAULT NULL,
  `IsDelete` tinyint DEFAULT '0',
  `IsActive` tinyint DEFAULT '1',
  `CreatedBy` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(50) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmstempltemaster`
--

LOCK TABLES `cmstempltemaster` WRITE;
/*!40000 ALTER TABLE `cmstempltemaster` DISABLE KEYS */;
INSERT INTO `cmstempltemaster` VALUES (1,0,0,1,'superadmin','2025-02-10 13:23:14.000','admin','2025-03-04 12:10:27.000',NULL,NULL),(2,0,0,1,'superadmin','2025-02-10 13:24:52.000','admin','2025-03-04 11:44:32.000',NULL,NULL),(3,0,0,1,'superadmin','2025-02-11 13:13:57.000','admin','2025-02-13 10:53:15.000',NULL,NULL),(4,0,0,1,'superadmin','2025-02-11 13:29:54.000','admin','2025-02-21 16:40:55.000',NULL,NULL),(5,0,0,1,'admin','2025-02-12 12:52:19.000',NULL,NULL,NULL,NULL),(6,0,0,1,'superadmin','2025-02-19 12:42:02.000','superadmin','2025-04-09 17:59:49.000',NULL,NULL),(7,0,1,0,'superadmin','2025-04-09 17:47:41.000','superadmin','2025-04-09 17:59:28.000','superadmin','2025-04-09 17:59:44.000'),(8,0,1,0,'superadmin','2025-04-09 17:48:12.000',NULL,NULL,'superadmin','2025-04-09 17:59:41.000'),(9,0,1,0,'superadmin','2025-04-09 17:50:36.000',NULL,NULL,'superadmin','2025-04-09 17:59:39.000'),(10,0,1,0,'superadmin','2025-04-09 17:50:43.000',NULL,NULL,'superadmin','2025-04-09 17:59:37.000'),(11,0,1,0,'superadmin','2025-04-09 18:01:42.000',NULL,NULL,'superadmin','2025-04-09 18:01:49.000'),(12,0,1,0,'superadmin','2025-04-28 13:24:51.000','superadmin','2025-04-28 13:24:59.000','superadmin','2025-04-28 13:25:02.000');
/*!40000 ALTER TABLE `cmstempltemaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:48
