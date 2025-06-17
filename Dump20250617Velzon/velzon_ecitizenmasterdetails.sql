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
-- Table structure for table `ecitizenmasterdetails`
--

DROP TABLE IF EXISTS `ecitizenmasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecitizenmasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `LanguageId` bigint DEFAULT NULL,
  `EcitizenId` bigint DEFAULT NULL,
  `EcitizenTypeId` text,
  `BranchId` bigint DEFAULT NULL,
  `Date` datetime(3) DEFAULT NULL,
  `Number` longtext,
  `Subject` longtext,
  `ImageName` longtext,
  `ImagePath` text,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecitizenmasterdetails`
--

LOCK TABLES `ecitizenmasterdetails` WRITE;
/*!40000 ALTER TABLE `ecitizenmasterdetails` DISABLE KEYS */;
INSERT INTO `ecitizenmasterdetails` VALUES (1,1,1,'1',2,'2025-03-11 00:00:00.000','1','<p>GR 1</p>\r\n','gujarat profile.pdf','CouchDB##da15478d6e8497b82f10618eee309da3||2-10ce432b053bda79936da31bdacea162||1203202512510672144096674.pdf',1,0,'admin','2025-03-12 12:51:09.000','kushal','2025-03-12 13:23:14.000',NULL,NULL),(2,1,2,'4',NULL,'2025-03-12 00:00:00.000','25','<p>test11</p>\r\n',NULL,NULL,1,0,'kushal','2025-03-12 13:10:57.000','kushal','2025-03-12 13:14:45.000',NULL,NULL),(3,1,3,'8',NULL,'2025-03-27 00:00:00.000','A','<p>qqqq</p>\r\n',NULL,NULL,1,0,'kushal','2025-03-12 13:16:42.000',NULL,NULL,NULL,NULL),(4,1,4,'1',NULL,'2025-03-11 00:00:00.000','a','<p>111</p>\r\n','pbsc.pdf','CouchDB##da15478d6e8497b82f10618eee30bb89||2-a677a202047810ac1ae5c150657bf5ea||1203202501224229571645800.pdf',1,0,'kushal','2025-03-12 13:22:39.000','kushal','2025-03-12 14:31:57.000',NULL,NULL),(5,1,5,'5',2,'2025-03-13 00:00:00.000','aaaaa','<p>New one</p>\r\n','pbsc.pdf','CouchDB##da15478d6e8497b82f10618eee30e4e4||2-102d8e44e38535427f7ce13d558885e3||1203202502315157208823200.pdf',1,0,'kushal','2025-03-12 14:31:48.000',NULL,NULL,NULL,NULL),(6,1,6,'1',NULL,'2025-03-12 00:00:00.000','1','<p>new</p>\r\n','pbsc.pdf','CouchDB##da15478d6e8497b82f10618eee30eed9||2-c21b8be5107596614e3a74fa7ca66c6a||1203202502425048757186423.pdf',1,0,'kushal','2025-03-12 14:42:47.000',NULL,NULL,NULL,NULL),(7,1,7,'5',NULL,'2025-03-12 00:00:00.000','120325','<p>test</p>\r\n','0512202401155088200219514.pdf','CouchDB##da15478d6e8497b82f10618eee30f4b8||2-6f28f1f9363e1ac0a2693729890a9d45||1203202502433826151772750.pdf',0,0,'kushal','2025-03-12 14:43:35.000','kushal','2025-03-12 14:44:23.000',NULL,NULL),(8,1,8,'4',2,'2025-03-12 00:00:00.000','2025','<p>Subject</p>\r\n','pbsc.pdf','CouchDB##da15478d6e8497b82f10618eee3330c1||2-507c29a5b7430c82839d1347ec335454||1203202505401411713445780.pdf',1,0,'kushal','2025-03-12 17:40:10.000','superadmin','2025-04-24 15:59:37.000',NULL,NULL),(9,1,9,'4',NULL,'2025-03-12 00:00:00.000','25','<p>No Documents</p>\r\n',NULL,NULL,1,0,'kushal','2025-03-12 17:41:38.000','superadmin','2025-04-24 16:00:20.000',NULL,NULL),(10,1,10,'5',NULL,'2025-03-15 00:00:00.000','2526','<p>Test</p>\r\n','pbsc.pdf','CouchDB##da15478d6e8497b82f10618eee3426d8||2-b839145e92327afcef702137c846ae48||1303202512235871359277051.pdf',0,1,'kushal','2025-03-13 12:23:54.000','superadmin','2025-04-23 12:11:00.000','superadmin','2025-04-23 12:11:10.000'),(11,1,11,'1',NULL,'2025-04-24 00:00:00.000','sdfsdf','<p>sdfsdf</p>\r\n','BAVLA.pdf','CouchDB##9980984db1c332e65f57290bcc3a00d1||2-540523f162ec6490d1e4cf2ccaf04b40||2304202501050217634354005.pdf',0,1,'superadmin','2025-04-23 13:05:02.000','superadmin','2025-04-23 13:05:09.000','superadmin','2025-04-23 13:05:25.000');
/*!40000 ALTER TABLE `ecitizenmasterdetails` ENABLE KEYS */;
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
