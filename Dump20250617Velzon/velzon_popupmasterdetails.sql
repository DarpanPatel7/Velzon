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
-- Table structure for table `popupmasterdetails`
--

DROP TABLE IF EXISTS `popupmasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `popupmasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `LanguageId` bigint DEFAULT NULL,
  `popupID` varchar(45) DEFAULT NULL,
  `popupDescription` text,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeleteDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `popupmasterdetails`
--

LOCK TABLES `popupmasterdetails` WRITE;
/*!40000 ALTER TABLE `popupmasterdetails` DISABLE KEYS */;
INSERT INTO `popupmasterdetails` VALUES (1,1,'1','<p><img src=\"https://gil.gujarat.gov.in/Media/DocumentUpload/12052022_595_315.jpg\" style=\"width: 100%\"></p>\n',0,1,'admin','2024-08-20 17:20:23.000','admin','2024-08-21 10:48:44.000','admin','2024-08-21 10:48:56.000'),(2,1,'2','<p><img src=\"https://gil.gujarat.gov.in/Media/DocumentUpload/12052022_595_315.jpg\" style=\"width: 100%\"></p>\n',0,1,'admin','2024-08-22 10:35:52.000','admin','2024-08-28 12:24:41.000','admin','2024-08-28 12:24:34.000'),(3,1,'3','<p><img src=\"https://gil.gujarat.gov.in/Media/DocumentUpload/12052022_595_315.jpg\"></p>\n',0,1,'admin','2024-08-28 12:25:53.000','admin','2024-08-28 12:26:19.000','admin','2024-08-28 12:26:16.000'),(4,1,'4','<p><img src=\"https://gil.gujarat.gov.in/Media/DocumentUpload/12052022_595_315.jpg\"></p>\n',0,1,'admin','2024-08-28 12:26:41.000',NULL,NULL,'admin','2024-08-28 12:26:59.000'),(5,1,'5','<p><img src=\"https://gil.gujarat.gov.in/Media/DocumentUpload/12052022_595_315.jpg\"></p>\n',0,1,'admin','2024-08-28 12:27:14.000',NULL,NULL,'admin','2024-08-28 12:27:17.000'),(6,1,'6','<p>zxczxcxzc</p>\n',1,1,'admin','2024-08-28 12:27:21.000','admin','2024-10-29 11:22:18.000','admin','2024-10-29 11:22:12.000'),(7,1,'7','<p>TEST</p>\n',0,1,'admin','2024-10-29 11:22:27.000',NULL,NULL,'admin','2024-10-29 12:40:11.000'),(8,1,'8','<p>Test</p>\n',0,1,'superadmin','2025-02-11 16:21:33.000','kushal','2025-03-04 17:31:50.000','superadmin','2025-04-24 16:19:53.000'),(9,1,'9','<p>sdadasd</p>\n',0,1,'superadmin','2025-04-24 16:33:18.000',NULL,NULL,'superadmin','2025-04-24 16:34:20.000'),(10,1,'10','<p>fghfgh</p>\n',0,1,'superadmin','2025-04-24 16:34:25.000','superadmin','2025-04-24 16:36:02.000','superadmin','2025-04-24 16:36:04.000'),(11,1,'11','<p>vfghfgh</p>\n',0,1,'superadmin','2025-04-28 15:33:08.000','superadmin','2025-04-28 15:33:12.000','superadmin','2025-04-28 15:33:14.000');
/*!40000 ALTER TABLE `popupmasterdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:50
