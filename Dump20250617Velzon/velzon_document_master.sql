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
-- Table structure for table `document_master`
--

DROP TABLE IF EXISTS `document_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_master` (
  `Doc_Id` int NOT NULL AUTO_INCREMENT,
  `Doc_Name` longtext,
  `File_Name` longtext,
  `Doc_Path` longtext,
  `LanguageId` tinyint DEFAULT NULL,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Doc_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_master`
--

LOCK TABLES `document_master` WRITE;
/*!40000 ALTER TABLE `document_master` DISABLE KEYS */;
INSERT INTO `document_master` VALUES (1,'logowithouttitlett','schemebgmainedu.jpg','CouchDB##845322e34701d98c9569dbb32c85f7e5||2-9110f6eee77647bf7618e96510c22626||1104202505322130602725076.jpg',1,0,1,'superadmin','2025-02-10 14:30:44.000','superadmin','2025-04-11 17:33:02.000','superadmin','2025-04-11 17:34:37.000'),(2,'Doc ','output.pdf','CouchDB##3d19a1cc9f4d2c58b3e04afb79db7ee9||2-9febe8d2c8b5e8e9c64ba44f03d14dd7||0403202512463062437359672.pdf',1,0,1,'kushal','2025-03-04 12:46:28.000','kushal','2025-03-04 12:47:25.000','kushal','2025-03-04 12:47:42.000'),(3,'dfgdfgdfg','0403202511420546050082815.JPEG','CouchDB##845322e34701d98c9569dbb32c86011b||2-4b93db6bc40c80332770d32b686dffa2||1104202505325909916218949.JPEG',1,0,0,'superadmin','2025-04-11 17:32:59.000','superadmin','2025-04-11 17:40:50.000',NULL,NULL),(4,'hjkuykyukttt','schemebgmainedu.jpg','CouchDB##845322e34701d98c9569dbb32c862494||2-210bc7f9f573f073238238734d4a16b4||1104202505410576515852210.jpg',1,1,0,'superadmin','2025-04-11 17:41:05.000','superadmin','2025-04-17 16:28:27.000',NULL,NULL),(5,'dsfdsftyty','2804202511430446461641860.jpg','CouchDB##5de25344289097f5561e1849c20f893d||2-442de788113377ac1f486a1a13858302||2804202501264888478769575.jpg',1,0,1,'superadmin','2025-04-28 13:26:31.000','superadmin','2025-04-28 13:26:57.000','superadmin','2025-04-28 13:27:05.000');
/*!40000 ALTER TABLE `document_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:49
