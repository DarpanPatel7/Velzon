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
-- Table structure for table `videomasterdetails`
--

DROP TABLE IF EXISTS `videomasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videomasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `VideoId` int DEFAULT NULL,
  `LanguageId` tinyint DEFAULT NULL,
  `VideoTitle` longtext,
  `ThumbImage` text,
  `VideoUrl` text,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videomasterdetails`
--

LOCK TABLES `videomasterdetails` WRITE;
/*!40000 ALTER TABLE `videomasterdetails` DISABLE KEYS */;
INSERT INTO `videomasterdetails` VALUES (1,1,1,'album video one',NULL,NULL,1,0,'superadmin','2025-02-12 17:59:08.000','admin','2025-02-13 18:00:23.000',NULL,NULL),(2,1,2,'video one',NULL,NULL,1,0,'superadmin','2025-02-12 17:59:08.000',NULL,NULL,NULL,NULL),(3,2,1,'album video two ',NULL,NULL,0,0,'superadmin','2025-02-12 17:59:34.000','kushal','2025-03-05 12:09:30.000',NULL,NULL),(4,2,2,'video two',NULL,NULL,0,0,'superadmin','2025-02-12 17:59:34.000',NULL,NULL,NULL,NULL),(5,3,1,'album video three',NULL,NULL,0,0,'superadmin','2025-02-12 18:07:21.000','kushal','2025-03-12 17:04:32.000',NULL,NULL),(6,3,2,'album video three',NULL,NULL,0,0,'superadmin','2025-02-12 18:07:21.000',NULL,NULL,NULL,NULL),(7,4,1,'Video',NULL,NULL,1,0,'kushal','2025-03-05 12:09:12.000',NULL,NULL,NULL,NULL),(8,4,2,'Video',NULL,NULL,1,0,'kushal','2025-03-05 12:09:12.000',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `videomasterdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-13 17:45:15
