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
-- Table structure for table `usersmaster`
--

DROP TABLE IF EXISTS `usersmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` int DEFAULT NULL,
  `FirstName` text,
  `LastName` text,
  `Email` text,
  `Username` text,
  `PhoneNo` text,
  `LastLoginDate` datetime DEFAULT NULL,
  `UserPassword` text,
  `IsPasswordReset` tinyint DEFAULT '0',
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreateBy` text,
  `CreateDate` datetime DEFAULT NULL,
  `UpdateBy` text,
  `UpdateDate` datetime DEFAULT NULL,
  `DeleteBy` text,
  `DeleteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usersmaster`
--

LOCK TABLES `usersmaster` WRITE;
/*!40000 ALTER TABLE `usersmaster` DISABLE KEYS */;
INSERT INTO `usersmaster` VALUES (1,1,'admin','admin','admin@gmail.com','admin','9999999999',NULL,'DpjDRf7y908PdNgwER0oWw==',0,1,0,NULL,NULL,'1','2024-10-15 15:24:24',NULL,NULL),(2,3,'Darpan','Patel','exegil-sw-30@gujarat.gov.in','darpan','8160665061',NULL,'2r4PHllh3fey9cXL1SwkzA==',0,1,0,NULL,NULL,'admin','2024-09-10 18:01:55',NULL,NULL),(6,1,'urvish','patel','exegil-sw76@gujarat.gov.in','urvish','9999999990',NULL,'M6iM8PHF2PSZzOAsscUARw==',0,1,0,'admin','2024-09-03 12:34:46','admin','2025-02-11 16:06:18',NULL,NULL),(13,1,'Dipak','Dipak','dipak@gmail.com','dipak','9999999997',NULL,'mMf1fKV82amCBirpREAkhw==',0,1,0,'raju','2024-09-13 13:34:11',NULL,NULL,NULL,NULL),(15,1,'Vipul','Parmar','vipul@test.com','vipul','9955886644',NULL,'UipmsJvf7ZAhIJjHKtKDhw==',0,1,0,'admin','2024-09-13 15:13:01','normaluserv','2024-09-21 13:35:37',NULL,NULL),(17,6,'Super','Admin','superadmin@gil.com','superadmin','9988558866',NULL,'DpjDRf7y908PdNgwER0oWw==',0,1,0,'admin','2024-09-18 13:23:58',NULL,NULL,NULL,NULL),(19,1,'vishal','rana','vishal@gmail.com','vishal','8887778880',NULL,'/LcPAP9sa3H+E1eJbKic6Q==',0,1,0,'admin','2024-11-19 11:52:21',NULL,NULL,NULL,NULL),(22,1,'kushal','kushal','kushal@gmail.com','kushal','9998887770',NULL,'D7uoVlyRq3R+5zSX/2KwZQ==',0,1,0,'admin','2025-03-03 11:21:14',NULL,NULL,NULL,NULL),(23,2,'audit','audit','audit@gmail.com','audit','7778887770',NULL,'KPqM0jYN2wywcM7x7CKD3w==',0,1,0,'admin','2025-03-12 11:00:22',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usersmaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-13 17:45:16
