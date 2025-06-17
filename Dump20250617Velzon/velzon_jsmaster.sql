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
-- Table structure for table `jsmaster`
--

DROP TABLE IF EXISTS `jsmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(1000) DEFAULT NULL,
  `Jsfile` text,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsmaster`
--

LOCK TABLES `jsmaster` WRITE;
/*!40000 ALTER TABLE `jsmaster` DISABLE KEYS */;
INSERT INTO `jsmaster` VALUES (1,'test','test',0,1,'superadmin','2025-05-02 16:11:24','superadmin','2025-05-02 16:20:04','superadmin','2025-05-02 16:20:06'),(2,'sdfsdfs','dfsdfsdf',0,1,'superadmin','2025-05-02 16:20:10','superadmin','2025-05-02 16:20:13','superadmin','2025-05-02 16:20:15');
/*!40000 ALTER TABLE `jsmaster` ENABLE KEYS */;
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
