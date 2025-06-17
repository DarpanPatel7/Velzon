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
-- Table structure for table `gallerymaster`
--

DROP TABLE IF EXISTS `gallerymaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallerymaster` (
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallerymaster`
--

LOCK TABLES `gallerymaster` WRITE;
/*!40000 ALTER TABLE `gallerymaster` DISABLE KEYS */;
INSERT INTO `gallerymaster` VALUES (1,1,0,'superadmin','2025-02-12 12:49:30.000','superadmin','2025-05-01 14:59:46.000',NULL,NULL),(2,0,1,'superadmin','2025-02-12 13:01:23.000','admin','2025-02-13 17:53:50.000','kushal','2025-03-04 17:52:30.000'),(3,1,0,'admin','2025-02-13 17:52:44.000','superadmin','2025-04-25 17:41:05.000',NULL,NULL),(4,0,1,'kushal','2025-03-04 17:48:21.000','kushal','2025-03-12 15:03:00.000','kushal','2025-03-12 15:03:30.000'),(5,1,0,'kushal','2025-03-12 15:29:00.000',NULL,NULL,NULL,NULL),(6,0,1,'kushal','2025-03-12 16:58:45.000',NULL,NULL,'superadmin','2025-04-28 12:42:11.000'),(7,0,1,'superadmin','2025-04-25 17:10:30.000',NULL,NULL,'superadmin','2025-04-28 12:42:09.000'),(8,0,1,'superadmin','2025-04-25 17:13:28.000',NULL,NULL,'superadmin','2025-04-28 12:42:07.000'),(9,0,1,'superadmin','2025-04-25 17:16:02.000','superadmin','2025-04-28 11:34:24.000','superadmin','2025-04-28 12:42:04.000'),(10,0,1,'superadmin','2025-04-25 17:16:32.000','superadmin','2025-04-28 11:33:26.000','superadmin','2025-04-28 12:42:02.000'),(11,0,1,'superadmin','2025-04-25 17:17:12.000','superadmin','2025-04-28 11:32:40.000','superadmin','2025-04-28 12:42:00.000'),(12,0,1,'superadmin','2025-04-25 17:19:03.000','superadmin','2025-04-28 11:32:33.000','superadmin','2025-04-28 12:41:58.000'),(13,0,1,'superadmin','2025-04-25 17:20:37.000',NULL,NULL,'superadmin','2025-04-28 11:24:52.000'),(14,0,1,'superadmin','2025-04-25 17:21:41.000',NULL,NULL,'superadmin','2025-04-28 11:24:50.000'),(15,0,1,'superadmin','2025-04-28 11:24:38.000',NULL,NULL,'superadmin','2025-04-28 11:24:48.000'),(16,0,1,'superadmin','2025-04-28 11:34:36.000','superadmin','2025-04-28 11:34:55.000','superadmin','2025-04-28 12:41:52.000'),(17,0,1,'superadmin','2025-04-28 11:42:38.000','superadmin','2025-04-28 11:43:21.000','superadmin','2025-04-28 12:41:50.000'),(18,0,1,'superadmin','2025-04-28 11:43:43.000','superadmin','2025-04-28 11:43:58.000','superadmin','2025-04-28 12:41:48.000'),(19,0,1,'superadmin','2025-04-28 12:04:47.000',NULL,NULL,'superadmin','2025-04-28 12:41:46.000'),(20,0,1,'superadmin','2025-04-28 12:21:45.000',NULL,NULL,'superadmin','2025-04-28 12:41:44.000'),(21,0,1,'superadmin','2025-04-28 12:33:07.000',NULL,NULL,'superadmin','2025-04-28 12:41:42.000'),(22,0,1,'superadmin','2025-04-28 12:41:36.000',NULL,NULL,'superadmin','2025-04-28 12:41:40.000'),(23,1,0,'superadmin','2025-04-28 12:47:12.000','superadmin','2025-04-28 12:49:48.000',NULL,NULL),(24,0,0,'superadmin','2025-04-28 12:48:01.000',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `gallerymaster` ENABLE KEYS */;
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
