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
-- Table structure for table `ministermasterdetailshistory`
--

DROP TABLE IF EXISTS `ministermasterdetailshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ministermasterdetailshistory` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `MinisterDetailId` bigint DEFAULT NULL,
  `LanguageId` int DEFAULT NULL,
  `MinisterID` int DEFAULT NULL,
  `MinisterName` text,
  `MinisterDescription` text,
  `ImageName` longtext,
  `ImagePath` longtext,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(50) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ministermasterdetailshistory`
--

LOCK TABLES `ministermasterdetailshistory` WRITE;
/*!40000 ALTER TABLE `ministermasterdetailshistory` DISABLE KEYS */;
INSERT INTO `ministermasterdetailshistory` VALUES (1,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n','MamtaVermaIAS.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000',NULL,NULL,NULL,NULL),(2,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n','bhupendarpatel.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000',NULL,NULL,NULL,NULL),(3,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n','MamtaVermaIAS.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-02-13 12:15:58.000',NULL,NULL),(4,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n','bhupendarpatel.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-02-13 12:15:58.000',NULL,NULL),(5,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n','bhupendarpatel.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-02-13 12:16:14.000',NULL,NULL),(6,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujara</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','admin','2025-02-13 12:20:37.000',NULL,NULL),(7,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','admin','2025-02-13 12:20:53.000',NULL,NULL),(8,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',0,0,'superadmin','2025-02-11 13:16:27.000','admin','2025-02-13 12:21:00.000',NULL,NULL),(9,4,2,1,'bhupendra guj','<p>bhupendra guj</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',0,0,'admin','2025-02-18 14:29:21.000',NULL,NULL,NULL,NULL),(10,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n','MamtaVermaIAS.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-02-13 12:16:13.000',NULL,NULL),(11,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','admin','2025-02-18 14:40:36.000',NULL,NULL),(12,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','admin','2025-02-13 12:21:16.000',NULL,NULL),(13,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-02-18 14:41:22.000',NULL,NULL),(14,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-02-18 14:41:22.000',NULL,NULL),(15,6,1,4,'Test','<p>test new</p>\r\n','as.JPEG','CouchDB##3d19a1cc9f4d2c58b3e04afb79d89746||2-3f8c1e512400c4574f3bf0038fc4589e||0403202511420546050082815.JPEG',0,0,'kushal','2025-03-04 11:42:03.000',NULL,NULL,NULL,NULL),(16,6,1,4,'Test','<p>test new</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79d89746||2-3f8c1e512400c4574f3bf0038fc4589e||0403202511420546050082815.JPEG',1,0,'kushal','2025-03-04 11:42:03.000','kushal','2025-03-04 11:42:10.000',NULL,NULL),(17,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n','dhavalpatel.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000',NULL,NULL,NULL,NULL),(18,6,1,4,'Test','<p>test new</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79d89746||2-3f8c1e512400c4574f3bf0038fc4589e||0403202511420546050082815.JPEG',1,0,'kushal','2025-03-04 11:42:03.000','kushal','2025-03-04 11:42:13.000',NULL,NULL),(19,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-02-18 17:42:38.000',NULL,NULL),(20,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n','dhavalpatel.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','kushal','2025-03-04 11:42:13.000',NULL,NULL),(21,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','kushal','2025-03-04 11:42:16.000',NULL,NULL),(22,6,1,4,'Test','<p>test new</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79d89746||2-3f8c1e512400c4574f3bf0038fc4589e||0403202511420546050082815.JPEG',1,0,'kushal','2025-03-04 11:42:03.000','kushal','2025-03-04 11:42:16.000',NULL,NULL),(23,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-02-18 17:42:38.000',NULL,NULL),(24,6,1,4,'Test','<p>test new</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79d89746||2-3f8c1e512400c4574f3bf0038fc4589e||0403202511420546050082815.JPEG',0,0,'kushal','2025-03-04 11:42:03.000','kushal','2025-03-04 11:43:17.000',NULL,NULL),(25,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-03-04 11:43:22.000',NULL,NULL),(26,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n','dhavalpatel.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','superadmin','2025-03-04 11:42:22.000',NULL,NULL),(27,1,1,1,'Shri Bhupendrabhai Patel','<p>Hon&#39;ble Chief Minister,<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865b51||2-519554d7d3e8c35b5cb3e742104cd1d2||1102202501162599552373110.png',1,0,'superadmin','2025-02-11 13:16:27.000','superadmin','2025-03-04 11:43:26.000',NULL,NULL),(28,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n','dhavalpatel.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','superadmin','2025-03-04 11:43:26.000',NULL,NULL),(29,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n','dhavalpatel.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','superadmin','2025-03-04 12:27:40.000',NULL,NULL),(30,3,1,3,'Dr.Dhaval Patel, IAS','<p>qa</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','kushal','2025-03-04 12:28:04.000',NULL,NULL),(31,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','kushal','2025-03-04 12:28:38.000',NULL,NULL),(32,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-03-04 11:42:22.000',NULL,NULL),(33,3,1,3,'Dr.Dhaval Patel, IAS','<p>Commissioner Geology &amp; Mining<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ce7||2-64ff0bd4c7b931bd29f9a0bfe8bd5690||1102202501171602150615188.jpg',1,0,'superadmin','2025-02-11 13:17:14.000','superadmin','2025-03-12 10:55:06.000',NULL,NULL),(34,2,1,2,'Smt. Mamta Verma, IAS','<p>Principle Secretary Industries &amp; Mines Department<br />\r\nGovernment of Gujarat</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79865ba2||2-0911d1261ab1e8f258dac09d0ddfc8b2||1102202501164915089327239.jpg',1,0,'superadmin','2025-02-11 13:16:46.000','superadmin','2025-03-12 10:55:06.000',NULL,NULL);
/*!40000 ALTER TABLE `ministermasterdetailshistory` ENABLE KEYS */;
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
