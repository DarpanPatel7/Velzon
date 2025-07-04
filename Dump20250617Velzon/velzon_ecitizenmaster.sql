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
-- Table structure for table `ecitizenmaster`
--

DROP TABLE IF EXISTS `ecitizenmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecitizenmaster` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `IsNewIcon` tinyint DEFAULT NULL,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreateBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreateDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecitizenmaster`
--

LOCK TABLES `ecitizenmaster` WRITE;
/*!40000 ALTER TABLE `ecitizenmaster` DISABLE KEYS */;
INSERT INTO `ecitizenmaster` VALUES (1,NULL,1,0,'admin','2025-03-12 12:51:08.000','kushal','2025-03-12 13:23:14.000',NULL,NULL),(2,NULL,1,0,'kushal','2025-03-12 13:10:57.000','kushal','2025-03-12 13:14:45.000',NULL,NULL),(3,NULL,1,0,'kushal','2025-03-12 13:16:42.000',NULL,NULL,NULL,NULL),(4,NULL,1,0,'kushal','2025-03-12 13:22:39.000','kushal','2025-03-12 14:31:57.000',NULL,NULL),(5,NULL,1,0,'kushal','2025-03-12 14:31:48.000',NULL,NULL,NULL,NULL),(6,NULL,1,0,'kushal','2025-03-12 14:42:47.000',NULL,NULL,NULL,NULL),(7,NULL,0,0,'kushal','2025-03-12 14:43:35.000','kushal','2025-03-12 14:44:23.000',NULL,NULL),(8,NULL,1,0,'kushal','2025-03-12 17:40:10.000','superadmin','2025-04-24 15:59:37.000',NULL,NULL),(9,NULL,1,0,'kushal','2025-03-12 17:41:38.000','superadmin','2025-04-24 16:00:20.000',NULL,NULL),(10,NULL,0,1,'kushal','2025-03-13 12:23:54.000','superadmin','2025-04-23 12:11:00.000','superadmin','2025-04-23 12:11:10.000'),(11,NULL,0,1,'superadmin','2025-04-23 13:05:02.000','superadmin','2025-04-23 13:05:09.000','superadmin','2025-04-23 13:05:25.000');
/*!40000 ALTER TABLE `ecitizenmaster` ENABLE KEYS */;
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
