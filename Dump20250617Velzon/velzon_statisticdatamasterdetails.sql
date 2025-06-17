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
-- Table structure for table `statisticdatamasterdetails`
--

DROP TABLE IF EXISTS `statisticdatamasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statisticdatamasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `StatisticDataId` bigint DEFAULT NULL,
  `LanguageId` tinyint DEFAULT NULL,
  `StatisticTypeId` text,
  `Title` longtext,
  `Count` varchar(100) DEFAULT NULL,
  `URL` longtext,
  `ImageName` text,
  `ImagePath` text,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statisticdatamasterdetails`
--

LOCK TABLES `statisticdatamasterdetails` WRITE;
/*!40000 ALTER TABLE `statisticdatamasterdetails` DISABLE KEYS */;
INSERT INTO `statisticdatamasterdetails` VALUES (1,1,1,'1','dfgdfg','dfgdfg',NULL,NULL,NULL,0,1,'superadmin','2025-04-15 12:23:32.000','superadmin','2025-04-17 16:28:42.000','superadmin','2025-04-17 16:28:44.000'),(2,2,1,'3','sdfsdf',NULL,'https://www.google.com/','1002202501272024896462948.png','CouchDB##845322e34701d98c9569dbb32c96eb30||2-2fefee235282454c30071182648ba849||1504202512242179576131534.png',0,1,'superadmin','2025-04-15 12:24:22.000',NULL,NULL,'superadmin','2025-04-17 16:28:50.000'),(3,3,1,'1','fgh','fgh',NULL,NULL,NULL,1,0,'superadmin','2025-04-17 16:27:08.000','superadmin','2025-04-17 16:28:34.000',NULL,NULL),(4,4,1,'2','fgh',NULL,NULL,'1704202501282408023960491.jpg','CouchDB##845322e34701d98c9569dbb32ce3be73||2-175ad7ad41c4cd62d542691b10ccdd47||1704202504272054816755732.jpg',1,0,'superadmin','2025-04-17 16:27:20.000','superadmin','2025-04-17 17:01:04.000',NULL,NULL),(5,5,1,'3','fgh',NULL,'https://www.google.com/','1704202501282408023960491.jpg','CouchDB##845322e34701d98c9569dbb32ce3c70b||2-f65e485ea706106d8d6ea3408f74ae90||1704202504275105770914233.jpg',0,0,'superadmin','2025-04-17 16:27:51.000','superadmin','2025-04-24 16:00:08.000',NULL,NULL);
/*!40000 ALTER TABLE `statisticdatamasterdetails` ENABLE KEYS */;
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
