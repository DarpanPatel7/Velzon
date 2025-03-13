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
-- Table structure for table `gallerymasterdetails`
--

DROP TABLE IF EXISTS `gallerymasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallerymasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `GallerymasterId` bigint DEFAULT NULL,
  `LanguageId` bigint DEFAULT NULL,
  `PlaceName` text,
  `ThumbImageName` text,
  `ThumbImagePath` text,
  `IsVideo` tinyint DEFAULT NULL,
  `AlbumRank` int DEFAULT NULL,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreateBy` text,
  `CreateDate` datetime DEFAULT NULL,
  `UpdateBy` text,
  `UpdateDate` datetime DEFAULT NULL,
  `DeleteBy` text,
  `DeleteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallerymasterdetails`
--

LOCK TABLES `gallerymasterdetails` WRITE;
/*!40000 ALTER TABLE `gallerymasterdetails` DISABLE KEYS */;
INSERT INTO `gallerymasterdetails` VALUES (1,1,1,'Album 1',NULL,NULL,0,0,1,0,'superadmin','2025-02-12 12:49:30','admin','2025-02-13 17:53:08',NULL,NULL),(2,2,1,'Album 2',NULL,NULL,0,1,0,1,'superadmin','2025-02-12 13:01:23','admin','2025-02-13 17:53:50','kushal','2025-03-04 17:52:30'),(3,3,1,'Album 3',NULL,NULL,0,2,1,0,'admin','2025-02-13 17:52:44','admin','2025-03-04 17:51:57',NULL,NULL),(4,4,1,'Album new',NULL,NULL,0,3,0,1,'kushal','2025-03-04 17:48:21','kushal','2025-03-12 15:03:00','kushal','2025-03-12 15:03:30'),(5,5,1,'New Album',NULL,NULL,0,3,1,0,'kushal','2025-03-12 15:29:00',NULL,NULL,NULL,NULL),(6,6,1,'qaaa',NULL,NULL,0,4,0,0,'kushal','2025-03-12 16:58:45',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `gallerymasterdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-13 17:45:19
