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
-- Table structure for table `feedbackfromuser`
--

DROP TABLE IF EXISTS `feedbackfromuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbackfromuser` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `FName` longtext,
  `LName` longtext,
  `Email` longtext,
  `MobileNo` varchar(45) DEFAULT NULL,
  `Zip` varchar(45) DEFAULT NULL,
  `Subject` text,
  `FeedbackDetails` longtext,
  `IP` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `Address` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbackfromuser`
--

LOCK TABLES `feedbackfromuser` WRITE;
/*!40000 ALTER TABLE `feedbackfromuser` DISABLE KEYS */;
INSERT INTO `feedbackfromuser` VALUES (2,'test','test','test@gmail.com','8887776660',NULL,'test sub','test comment',NULL,'2025-02-12 17:38:14.000',NULL,NULL,'ahm','test address'),(3,'testing','testing','testing@gmail.com','8887776665',NULL,'testing sub','testing comment',NULL,'2025-02-28 16:38:31.000',NULL,NULL,'testingtown','testing address'),(4,'test','new','111@d.in','9725598222',NULL,'ws','test',NULL,'2025-03-04 11:51:03.000',NULL,NULL,'qa','aaaaaaaaaaaaaaaaaaaaa'),(5,'Giftcity','Towerone','Test@test.com','9854741444',NULL,'test','test',NULL,'2025-03-06 13:25:13.000',NULL,NULL,'test','test'),(6,'Kushal','Shah','test@gmail.com','9725598000',NULL,'test','test',NULL,'2025-03-12 10:51:19.000',NULL,NULL,'AHMEDABAD','gandhinagar'),(7,'GIL','Test','Test@gmail.com','9874455555',NULL,'Test','Under Development',NULL,'2025-03-12 17:57:01.000',NULL,NULL,'Ahmedabad',NULL);
/*!40000 ALTER TABLE `feedbackfromuser` ENABLE KEYS */;
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
