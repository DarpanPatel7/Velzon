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
-- Table structure for table `projectmasterdetails`
--

DROP TABLE IF EXISTS `projectmasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectmasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `ProjectMasterId` bigint DEFAULT NULL,
  `LanguageId` bigint DEFAULT NULL,
  `ProjectName` varchar(400) DEFAULT NULL,
  `Description` longtext,
  `ProjectBy` varchar(100) DEFAULT NULL,
  `ProjectDate` datetime DEFAULT NULL,
  `FileUpload` longtext,
  `FilePath` text,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `MetaTitle` text,
  `MetaDescription` text,
  `TypeId` int DEFAULT NULL,
  `ProjectRank` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectmasterdetails`
--

LOCK TABLES `projectmasterdetails` WRITE;
/*!40000 ALTER TABLE `projectmasterdetails` DISABLE KEYS */;
INSERT INTO `projectmasterdetails` VALUES (1,1,1,'project 1','project 1 this is testing long description','admin','2025-02-11 00:00:00','project one.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb798667a3||2-d175b6011ea24809ee992fca5c649bf0||1102202501193641703323378.jpg',1,0,'admin','2025-02-11 13:19:39','kushal','2025-03-07 15:47:26',NULL,NULL,'ahm','project 1','project 1',NULL,NULL),(2,2,1,'project 2','project 2 desc','admin','2025-02-12 00:00:00','project two.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79867295||2-2099a924379f5a51ef6a18ca6c64e98c||1102202501200596684385703.jpg',1,0,'admin','2025-02-11 13:20:04','admin','2025-02-28 15:42:40',NULL,NULL,'delhi','project 2','project 2',NULL,NULL),(3,3,1,'project 3','project 3 desc','admin','2025-02-13 00:00:00','project three.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79867e33||2-40f8384364b3a95401df03272a1edde8||1102202501203670471018354.jpg',1,0,'admin','2025-02-11 13:20:34','kushal','2025-03-07 17:45:50',NULL,NULL,'mehsana','project 3','project 3',NULL,NULL),(4,1,2,'project 1','project 1 this is testing long description','admin','2025-02-11 00:00:00','project one.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb798667a3||2-d175b6011ea24809ee992fca5c649bf0||1102202501193641703323378.jpg',1,0,'admin','2025-02-11 15:42:38','kushal','2025-03-07 15:47:26',NULL,NULL,'ahm','project 1','project 1',NULL,NULL),(5,2,2,'project 2','project 2 desc','admin','2025-02-12 00:00:00','project two.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79867295||2-2099a924379f5a51ef6a18ca6c64e98c||1102202501200596684385703.jpg',1,0,'admin','2025-02-11 15:43:42','admin','2025-02-28 15:42:40',NULL,NULL,'delhi','project 2','project 2',NULL,NULL),(6,3,2,'project 3','project 3 desc','admin','2025-02-13 00:00:00','project three.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79867e33||2-40f8384364b3a95401df03272a1edde8||1102202501203670471018354.jpg',1,0,'admin','2025-02-11 15:44:13','kushal','2025-03-07 17:45:50',NULL,NULL,'mehsana','project 3','project 3',NULL,NULL),(7,4,1,'test 1222','wasx','kushal','2025-03-12 00:00:00','as.JPEG','CouchDB##3d19a1cc9f4d2c58b3e04afb79dfb2f1||2-49b627f02145c55a275606182950d4b3||0503202511170248525222035.JPEG',0,1,'kushal','2025-03-05 11:16:59','kushal','2025-03-05 11:19:36','admin','2025-03-05 12:34:48',NULL,NULL,NULL,NULL,NULL),(8,5,1,'Project Name test','test','kushal','2025-03-10 00:00:00','ss.png','CouchDB##da15478d6e8497b82f10618eee1e5adc||2-b444db79087d990ae2965bb8c73ba3a0||0703202512351349220080640.png',0,1,'kushal','2025-03-07 12:35:08','kushal','2025-03-07 12:36:05','kushal','2025-03-07 17:45:33',NULL,NULL,NULL,NULL,NULL),(9,6,1,'Project','test project page','kushal','2025-02-12 00:00:00','ss.png','CouchDB##da15478d6e8497b82f10618eee3052d3||2-050a68e5d0d55cbbb64d26a9687ebe82||1203202512044963950878993.png',0,1,'kushal','2025-03-07 15:45:51','kushal','2025-03-12 12:05:20','kushal','2025-03-12 12:06:28',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `projectmasterdetails` ENABLE KEYS */;
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
