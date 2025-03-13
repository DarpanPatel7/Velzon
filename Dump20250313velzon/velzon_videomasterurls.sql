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
-- Table structure for table `videomasterurls`
--

DROP TABLE IF EXISTS `videomasterurls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videomasterurls` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `VideoMasterId` bigint DEFAULT NULL,
  `VideoName` text,
  `ThumbImage` text,
  `VideoUrl` text,
  `uploadedname` text,
  `uploadedurl` text,
  `islinkvideo` tinyint DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videomasterurls`
--

LOCK TABLES `videomasterurls` WRITE;
/*!40000 ALTER TABLE `videomasterurls` DISABLE KEYS */;
INSERT INTO `videomasterurls` VALUES (14,1,'video one','https://img.youtube.com/vi/IL0KfvfSvsg/maxresdefault.jpg','https://www.youtube.com/watch?v=IL0KfvfSvsg',NULL,NULL,1),(21,4,'GMRDS Video','https://www.youtube.com/watch?v=ZSqSb7WyklA','https://www.youtube.com/watch?v=ZSqSb7WyklA',NULL,NULL,1),(22,2,'video two','https://img.youtube.com/vi/emd_z_CnnHA/maxresdefault.jpg','https://www.youtube.com/watch?v=emd_z_CnnHA',NULL,NULL,1),(23,2,'al two video two','https://img.youtube.com/vi/F1bJYHl5iJw/maxresdefault.jpg','https://youtube.com/watch?v=F1bJYHl5iJw',NULL,NULL,1),(24,3,'video three','CouchDB##3d19a1cc9f4d2c58b3e04afb79c8eea6||2-3dc8e6c6b9d62167e2225c1e1115a4f3||2702202512161287046189163.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79c8e526||2-c5a5ae0830c502dbcccfd4637f40b5cf||2702202512150866201521498.mp4',NULL,NULL,0);
/*!40000 ALTER TABLE `videomasterurls` ENABLE KEYS */;
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
