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
-- Table structure for table `goilogomaster`
--

DROP TABLE IF EXISTS `goilogomaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goilogomaster` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `LanguageId` tinyint DEFAULT NULL,
  `LogoName` longtext,
  `ImageName` text,
  `ImagePath` text,
  `URL` longtext,
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
-- Dumping data for table `goilogomaster`
--

LOCK TABLES `goilogomaster` WRITE;
/*!40000 ALTER TABLE `goilogomaster` DISABLE KEYS */;
INSERT INTO `goilogomaster` VALUES (1,1,'test',NULL,'CouchDB##7d792380f3517fdb41b58d6986ee0cbf||2-37f260a9b4ce93bad2dfee33755a43ec||2108202410593760621403603.png','test',0,1,'admin','2024-08-21 10:59:34.000','admin','2025-02-21 16:23:25.000','admin','2025-02-21 16:23:47.000'),(2,1,'mines',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79879468||2-5263e4f2101124734921b61540103227||1102202504114766646216020.jpg','https://mines.gov.in/webportal/home',0,1,'admin','2025-02-11 16:11:46.000','kushal','2025-03-05 12:40:28.000','kushal','2025-03-05 12:47:42.000'),(3,1,'bureau of mines','2a.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79879492||2-8dd29071a8476e5f025f88f1b50beb0d||1102202504142533224107043.jpg','https://www.india.gov.in/website-indian-bureau-mines?page=1',1,0,'admin','2025-02-11 16:14:26.000',NULL,NULL,NULL,NULL),(4,1,'ind and mines department',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79879c26||2-3d7c3c88b33cc66d1c8d0c7b6ded315f||1102202504152136260143347.jpg','https://imd.gujarat.gov.in/',0,0,'admin','2025-02-11 16:15:40.000','kushal','2025-03-05 12:40:15.000',NULL,NULL),(5,1,'geological survey of india','4a.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb7987a5b8||2-3fccebbc5ee95a782f5a5b87b710fa05||1102202504162624349266004.jpg','https://www.gsi.gov.in/webcenter/portal/OCBIS',1,0,'admin','2025-02-11 16:16:23.000',NULL,NULL,NULL,NULL),(6,1,'geology and mines','5a.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79886b81||2-3681fcd8b69ec89745d8d154ff9a775f||1102202505280594613393026.jpg','https://cgm.gujarat.gov.in/',1,0,'admin','2025-02-11 16:17:24.000','admin','2025-02-11 17:28:07.000',NULL,NULL),(7,1,'GIL',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79e163d8||2-f0a816e72ecc56115033c41fa1de652a||0503202512450267010945522.png','https://gil.gujarat.gov.in/',0,0,'kushal','2025-03-05 12:44:59.000','superadmin','2025-05-08 16:51:18.000',NULL,NULL),(8,1,'sdfsdfkkk','educationboarsguj.png','CouchDB##5de25344289097f5561e1849c2e23c3e||2-205e739cdcd4fc9d0b0f82c03ca08280||0805202504471993872102710.png','sdfkkk',0,1,'superadmin','2025-05-08 13:36:07.000','superadmin','2025-05-08 16:47:20.000','superadmin','2025-05-08 16:47:59.000');
/*!40000 ALTER TABLE `goilogomaster` ENABLE KEYS */;
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
