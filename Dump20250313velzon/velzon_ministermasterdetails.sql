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
-- Table structure for table `ministermasterdetails`
--

DROP TABLE IF EXISTS `ministermasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ministermasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `LanguageId` bigint DEFAULT NULL,
  `MinisterID` varchar(45) DEFAULT NULL,
  `MinisterName` varchar(45) DEFAULT NULL,
  `MinisterDescription` text,
  `ImageName` longtext,
  `ImagePath` longtext,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeleteDate` datetime(3) DEFAULT NULL,
  `MetaTitle` text,
  `MetaDescription` text,
  `MinisterRank` int DEFAULT NULL,
  `ElectionModeMinister` tinyint(1) DEFAULT '0',
  `ElectionMode` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ministermasterdetails`
--

LOCK TABLES `ministermasterdetails` WRITE;
/*!40000 ALTER TABLE `ministermasterdetails` DISABLE KEYS */;
INSERT INTO `ministermasterdetails` VALUES (1,1,'1','Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-03-04 12:27:40.000',NULL,NULL,NULL,NULL,1,0,NULL),(2,1,'2','Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-03-12 15:21:42.000',NULL,NULL,NULL,NULL,3,0,NULL),(3,1,'3','Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','superadmin','2025-03-12 15:21:42.000',NULL,NULL,NULL,NULL,2,0,NULL),(4,2,'1','bhupendra guj','<p>bhupendra guj</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'admin','2025-02-18 14:29:21.000','admin','2025-02-18 14:40:27.000',NULL,NULL,NULL,NULL,1,0,NULL),(5,2,'2','verma guj','<p>verma guj</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'admin','2025-02-18 14:29:39.000',NULL,NULL,NULL,NULL,NULL,NULL,3,0,NULL),(6,1,'4','Test','<p>test new</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79d89746||2-3f8c1e512400c4574f3bf0038fc4589e||0403202511420546050082815.JPEG',0,0,'kushal','2025-03-04 11:42:03.000','superadmin','2025-03-04 11:43:22.000',NULL,NULL,NULL,NULL,0,0,NULL);
/*!40000 ALTER TABLE `ministermasterdetails` ENABLE KEYS */;
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
