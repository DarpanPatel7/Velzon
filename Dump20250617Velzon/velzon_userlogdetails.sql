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
-- Table structure for table `userlogdetails`
--

DROP TABLE IF EXISTS `userlogdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userlogdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `UserId` bigint DEFAULT NULL,
  `LogType` text COMMENT '''login/logout''',
  `EntryDatetime` datetime DEFAULT NULL,
  `IPAddress` text,
  `Details` text,
  `WrongAttempt` tinyint DEFAULT '0',
  `IsLock` tinyint DEFAULT '0',
  `UpdateBy` text,
  `UpdateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlogdetails`
--

LOCK TABLES `userlogdetails` WRITE;
/*!40000 ALTER TABLE `userlogdetails` DISABLE KEYS */;
INSERT INTO `userlogdetails` VALUES (1,2,'login','2025-05-16 12:35:53','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(2,2,'logout','2025-05-16 12:36:02','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(3,2,'login','2025-05-16 12:36:06','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',1,0,NULL,NULL),(4,2,'login','2025-05-16 12:36:10','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',1,0,NULL,NULL),(5,2,'login','2025-05-16 12:36:13','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',1,0,'superadmin','2025-05-16 12:36:28'),(6,2,'logout','2025-05-16 12:36:28','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,'superadmin','2025-05-16 12:36:28'),(7,2,'login','2025-05-16 12:36:38','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(8,2,'logout','2025-05-16 12:36:40','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,'superadmin','2025-05-16 12:37:06'),(9,2,'login','2025-05-16 12:37:11','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(10,2,'logout','2025-05-16 12:37:15','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(11,17,'login','2025-05-16 16:49:52','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(12,17,'login','2025-05-16 17:09:34','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(13,17,'login','2025-05-17 16:16:15','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(14,17,'login','2025-05-17 16:44:02','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(15,17,'login','2025-05-17 16:50:00','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(16,17,'login','2025-05-17 16:51:21','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(17,17,'login','2025-05-19 11:41:59','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(18,17,'login','2025-05-19 12:52:45','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36\n',0,0,NULL,NULL),(19,17,'login','2025-06-17 14:34:18','::1','RemoteUser=;\nRemoteHost=::1;\nuserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36\n',0,0,NULL,NULL);
/*!40000 ALTER TABLE `userlogdetails` ENABLE KEYS */;
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
