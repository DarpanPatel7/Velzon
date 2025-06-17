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
-- Table structure for table `ministermaster`
--

DROP TABLE IF EXISTS `ministermaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ministermaster` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ministermaster`
--

LOCK TABLES `ministermaster` WRITE;
/*!40000 ALTER TABLE `ministermaster` DISABLE KEYS */;
INSERT INTO `ministermaster` VALUES (1,1,0,'superadmin','2025-02-11 13:16:27.000','kushal','2025-04-11 16:47:30.000',NULL,NULL),(2,1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-04-25 16:34:16.000',NULL,NULL),(3,1,0,'superadmin','2025-02-11 13:17:13.000','superadmin','2025-04-11 16:47:49.000',NULL,NULL),(4,0,1,'kushal','2025-03-04 11:42:03.000','superadmin','2025-04-11 16:47:41.000','superadmin','2025-04-11 16:47:44.000'),(5,0,1,'superadmin','2025-04-11 13:35:00.000','superadmin','2025-04-11 15:08:18.000','superadmin','2025-04-11 15:29:30.000'),(6,0,1,'superadmin','2025-04-11 15:08:52.000','superadmin','2025-04-11 15:18:56.000','superadmin','2025-04-11 15:29:28.000'),(7,0,1,'superadmin','2025-04-11 15:29:38.000','superadmin','2025-04-11 15:39:18.000','superadmin','2025-04-11 16:47:36.000'),(8,0,1,'superadmin','2025-04-25 16:32:01.000','superadmin','2025-04-25 16:34:16.000','superadmin','2025-04-25 16:34:18.000');
/*!40000 ALTER TABLE `ministermaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:52
