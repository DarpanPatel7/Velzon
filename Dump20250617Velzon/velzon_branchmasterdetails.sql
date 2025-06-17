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
-- Table structure for table `branchmasterdetails`
--

DROP TABLE IF EXISTS `branchmasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branchmasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `BranchId` bigint DEFAULT NULL,
  `LanguageId` bigint DEFAULT NULL,
  `BranchName` longtext,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchmasterdetails`
--

LOCK TABLES `branchmasterdetails` WRITE;
/*!40000 ALTER TABLE `branchmasterdetails` DISABLE KEYS */;
INSERT INTO `branchmasterdetails` VALUES (1,1,1,'d',1,0,NULL,'2025-02-07 17:19:15',NULL,'2025-02-13 15:17:49',NULL,NULL),(2,2,1,'A',1,0,NULL,'2025-02-13 13:11:05',NULL,NULL,NULL,NULL),(3,3,1,'c',1,0,NULL,'2025-03-12 17:26:37','superadmin','2025-04-24 16:04:40',NULL,NULL),(4,4,1,'sdfsdf',0,1,NULL,'2025-04-24 15:52:03',NULL,'2025-04-24 16:03:50','superadmin','2025-04-24 16:04:36'),(5,5,1,'sdfsdf',0,1,NULL,'2025-04-24 15:52:09','superadmin','2025-04-24 16:03:44','superadmin','2025-04-24 16:04:34'),(6,5,2,'sdfsdf12',0,1,NULL,'2025-04-24 15:57:12','superadmin','2025-04-24 16:03:44','superadmin','2025-04-24 16:04:34'),(7,6,1,'sdfsdfsdfhhhhh',0,1,NULL,'2025-04-25 15:33:36','superadmin','2025-04-25 15:43:04','superadmin','2025-04-25 15:43:08'),(8,7,1,'fghfghkkkkiiii',0,1,NULL,'2025-04-25 15:43:12',NULL,'2025-04-25 16:29:14','superadmin','2025-04-25 16:29:18'),(9,8,1,'dfdfg',0,0,NULL,'2025-04-25 16:29:21','superadmin','2025-04-25 16:31:29',NULL,NULL),(10,9,1,'dfsgdfg45g5g',0,1,NULL,'2025-04-25 16:31:33',NULL,'2025-04-25 16:31:40','superadmin','2025-04-25 16:31:42'),(11,10,1,'fghfghfghjkljklkjl',0,1,NULL,'2025-04-25 16:55:33',NULL,'2025-04-25 16:55:40','superadmin','2025-04-25 16:55:42'),(12,1,2,'d guj',1,0,NULL,'2025-05-08 17:40:08',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `branchmasterdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:51
