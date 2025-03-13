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
-- Table structure for table `newsmasterdetails`
--

DROP TABLE IF EXISTS `newsmasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsmasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `LanguageId` bigint DEFAULT NULL,
  `NewsId` bigint DEFAULT NULL,
  `NewsTypeId` text,
  `NewsTitle` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `ShortDescription` text,
  `NewsDesc` longtext,
  `NewsBy` longtext,
  `ArchiveDate` datetime(3) DEFAULT NULL,
  `PublicDate` datetime(3) DEFAULT NULL,
  `ImageName` longtext,
  `ImagePath` text,
  `Location` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `IsLink` tinyint DEFAULT NULL,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  `MetaTitle` text,
  `MetaDescription` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsmasterdetails`
--

LOCK TABLES `newsmasterdetails` WRITE;
/*!40000 ALTER TABLE `newsmasterdetails` DISABLE KEYS */;
INSERT INTO `newsmasterdetails` VALUES (1,1,1,'1','ann 1',NULL,'<p>ann 1 desc</p>\n',NULL,'2025-03-20 00:00:00.000','2025-03-12 00:00:00.000','BookRecievableReport20241204145710814.pdf','CouchDB##da15478d6e8497b82f10618eee32c4fb||2-3ffb5152c3f2ac5fd89d25075c8380eb||1203202504563307921340017.pdf',NULL,0,1,0,'admin','2025-03-12 15:22:05.000','kushal','2025-03-12 16:56:29.000',NULL,NULL,'ann 1','ann 1'),(2,1,2,'2','news 1',NULL,'<p><a href=\"https://www.google.com\">news 1</a></p>\n',NULL,'2025-03-20 00:00:00.000','2025-03-12 00:00:00.000','','',NULL,1,1,0,'admin','2025-03-12 15:26:23.000','admin','2025-03-12 15:32:55.000',NULL,NULL,'news 1','news 1'),(3,1,3,'2','news 2',NULL,'<p><a href=\"https://www.google.com\">news 2</a></p>\n',NULL,'2025-03-27 00:00:00.000','2025-03-12 00:00:00.000','','',NULL,1,1,0,'admin','2025-03-12 15:44:13.000','admin','2025-03-12 16:41:20.000',NULL,NULL,'news 2','news 2'),(4,1,4,'1','qa',NULL,'<p>qa</p>\n',NULL,'2025-03-21 00:00:00.000','2025-03-20 00:00:00.000','pbsc.pdf','CouchDB##da15478d6e8497b82f10618eee32af3c||2-6f37fc92231cd8e353d799689006a20e||1203202504540404693586150.pdf',NULL,0,1,0,'kushal','2025-03-12 16:24:42.000','kushal','2025-03-12 16:54:00.000',NULL,NULL,NULL,NULL),(5,1,5,'1','xs',NULL,'<p>cxasx</p>\n',NULL,NULL,'2025-03-19 00:00:00.000','','',NULL,1,0,1,'admin','2025-03-12 16:35:06.000','admin','2025-03-12 16:35:58.000','admin','2025-03-12 16:37:10.000',NULL,NULL),(6,1,6,'1','news',NULL,'<p>News Descriptions</p>\n',NULL,NULL,'2025-03-06 00:00:00.000','','',NULL,1,1,0,'kushal','2025-03-12 16:42:19.000','kushal','2025-03-13 12:36:15.000',NULL,NULL,NULL,NULL),(7,1,7,'2','wd',NULL,'<p>WSD</p>\n',NULL,NULL,'2025-03-18 00:00:00.000','','',NULL,1,1,0,'kushal','2025-03-12 16:43:08.000','kushal','2025-03-12 16:43:17.000',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `newsmasterdetails` ENABLE KEYS */;
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
