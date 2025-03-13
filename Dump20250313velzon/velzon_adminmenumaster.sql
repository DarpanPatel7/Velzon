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
-- Table structure for table `adminmenumaster`
--

DROP TABLE IF EXISTS `adminmenumaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminmenumaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `MenuId` int DEFAULT NULL,
  `Name` text,
  `MenuType` int DEFAULT NULL,
  `ParentId` int DEFAULT NULL,
  `MenuRank` int DEFAULT NULL,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreateBy` text,
  `CreateDate` datetime DEFAULT NULL,
  `UpdateBy` text,
  `UpdateDate` datetime DEFAULT NULL,
  `DeleteBy` text,
  `DeleteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminmenumaster`
--

LOCK TABLES `adminmenumaster` WRITE;
/*!40000 ALTER TABLE `adminmenumaster` DISABLE KEYS */;
INSERT INTO `adminmenumaster` VALUES (1,3,'Admin Master',0,0,1,1,0,'test','2022-04-11 15:08:28',NULL,'2024-09-13 17:26:48',NULL,NULL),(2,1,'Role Master',1,1,6,1,0,NULL,NULL,NULL,'2022-04-28 16:37:49',NULL,NULL),(3,2,'Menu Rights',1,1,4,1,0,NULL,NULL,NULL,'2022-04-26 16:33:29',NULL,NULL),(4,4,'Resouce Master',1,1,5,1,0,NULL,NULL,NULL,'2022-04-28 16:37:49',NULL,NULL),(5,5,'Admin Menu',1,1,3,1,0,NULL,NULL,'admin','2022-05-27 16:58:20',NULL,NULL),(6,6,'User Master',1,1,2,1,0,'admin','2022-04-26 17:49:34',NULL,'2022-05-27 16:55:07',NULL,NULL),(8,8,'CMS Master',0,0,8,1,0,'admin','2022-04-30 15:34:21',NULL,'2024-09-13 17:26:48',NULL,NULL),(9,9,'CMS Menu Resource',1,8,9,1,0,'admin','2022-04-30 15:35:53',NULL,'2023-03-23 11:12:28',NULL,NULL),(11,11,'CMS Template Master',1,8,10,1,0,'admin','2022-05-05 11:21:40','admin','2024-09-04 17:17:39',NULL,NULL),(17,16,'Minister Master',1,8,16,1,0,'admin','2022-07-01 11:58:59',NULL,NULL,NULL,NULL),(19,18,'Banner Master',1,8,18,1,0,'admin','2022-07-05 15:16:18','admin','2022-07-05 15:18:03',NULL,NULL),(20,19,'Popup Master',1,75,19,1,0,'admin','2022-07-08 16:44:32','admin','2024-10-23 10:57:25',NULL,NULL),(21,20,'News Master',1,75,20,1,0,'admin','2022-07-19 11:22:06','admin','2024-10-23 10:58:10',NULL,NULL),(25,24,'Upload Document',1,8,24,1,0,'admin','2022-08-23 16:13:35','admin','2022-08-23 16:32:55',NULL,NULL),(27,26,'Gallery Master',1,75,26,1,0,'admin','2022-09-16 12:45:20','admin','2024-10-05 12:42:45',NULL,NULL),(28,27,'CMS View',0,0,46,1,0,'admin','2022-10-12 14:48:27',NULL,'2025-02-11 11:09:35',NULL,NULL),(29,28,'Feedback',1,28,28,1,0,'admin','2022-10-12 14:49:26',NULL,'2024-08-01 14:58:23',NULL,NULL),(32,31,'Video Master',1,75,31,1,0,'admin','2022-12-23 15:49:19','admin','2024-10-05 12:42:54',NULL,NULL),(43,43,'Schemes',1,8,42,1,1,'admin','2023-05-17 16:39:05','admin1','2023-10-21 15:16:13',NULL,NULL),(44,44,'Sql Execute',1,28,55,1,0,'admin','2023-05-18 12:28:56',NULL,'2024-08-01 14:58:23',NULL,NULL),(45,45,'Tender Master',1,8,44,1,1,'admin','2023-06-30 16:56:10',NULL,NULL,NULL,NULL),(48,49,'Design',0,0,70,1,0,'admin','2023-09-16 12:14:39',NULL,'2025-02-11 11:09:26',NULL,NULL),(49,48,'Css Master',1,48,47,1,0,'admin','2023-09-16 12:15:45',NULL,NULL,NULL,NULL),(55,55,'Ecitizen Master',1,8,51,1,0,'admin','2024-04-26 13:24:48',NULL,'2024-08-03 15:52:40',NULL,NULL),(60,60,'Js Master',1,48,56,1,0,'admin','2024-08-01 16:41:54','admin','2024-08-01 16:42:12',NULL,NULL),(61,61,'CouchDB Settings',1,1,57,1,0,'admin','2024-08-01 16:43:51',NULL,NULL,NULL,NULL),(62,62,'Statistic Master',1,8,45,1,0,'admin','2024-08-03 15:52:16',NULL,'2024-08-03 15:52:40',NULL,NULL),(63,63,'Branch Master',1,8,59,1,0,'admin','2024-08-05 18:16:10',NULL,NULL,NULL,NULL),(71,72,'Utility Master',1,1,66,1,0,'admin','2024-09-05 11:51:31',NULL,NULL,NULL,NULL),(75,76,'Media Gallery',0,0,27,1,0,'admin','2024-10-05 12:41:53',NULL,'2025-02-11 11:09:35',NULL,NULL),(80,80,'Project Master',1,8,71,1,0,'admin','2025-02-11 12:38:23',NULL,NULL,NULL,NULL),(81,81,'GOI Logo Master',1,8,72,1,0,'admin','2025-02-11 16:05:19',NULL,NULL,NULL,NULL),(82,82,'Service Rate Master',1,8,73,1,0,'admin','2025-02-15 11:27:37',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `adminmenumaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-13 17:45:18
