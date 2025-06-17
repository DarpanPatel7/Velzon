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
-- Table structure for table `menurightsmaster`
--

DROP TABLE IF EXISTS `menurightsmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menurightsmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` int DEFAULT NULL,
  `MenuId` int DEFAULT NULL,
  `Insert` tinyint DEFAULT '0',
  `Update` tinyint DEFAULT '0',
  `Delete` tinyint DEFAULT '0',
  `View` tinyint DEFAULT '0',
  `LastUpdateBy` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2698 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menurightsmaster`
--

LOCK TABLES `menurightsmaster` WRITE;
/*!40000 ALTER TABLE `menurightsmaster` DISABLE KEYS */;
INSERT INTO `menurightsmaster` VALUES (1519,3,1,1,1,1,1,'admin'),(1520,3,6,1,1,1,1,'admin'),(1521,3,5,1,1,1,1,'admin'),(1522,3,3,1,1,1,1,'admin'),(1523,3,4,1,1,1,1,'admin'),(1524,3,2,1,1,1,1,'admin'),(1525,3,61,1,1,1,1,'admin'),(1526,3,8,1,1,1,1,'admin'),(1527,3,9,1,1,1,1,'admin'),(1528,3,17,0,0,0,1,'admin'),(2312,7,76,1,1,1,1,'admin'),(2313,7,46,1,1,1,1,'admin'),(2314,7,72,1,1,1,1,'admin'),(2315,7,73,1,1,1,1,'admin'),(2316,7,77,1,1,1,1,'admin'),(2438,2,8,1,1,1,1,'admin'),(2439,2,9,1,1,1,1,'admin'),(2440,2,11,1,1,1,1,'admin'),(2441,2,17,1,1,1,1,'admin'),(2442,2,19,1,1,1,1,'admin'),(2443,2,25,1,1,1,1,'admin'),(2444,2,55,1,1,1,1,'admin'),(2445,2,63,1,1,1,1,'admin'),(2446,2,80,1,1,1,1,'admin'),(2447,2,81,1,1,1,1,'admin'),(2448,2,82,1,1,1,1,'admin'),(2449,2,75,1,1,1,1,'admin'),(2450,2,20,1,1,1,1,'admin'),(2451,2,21,1,1,1,1,'admin'),(2452,2,27,1,1,1,1,'admin'),(2453,2,32,1,1,1,1,'admin'),(2454,1,1,1,1,1,1,'superadmin'),(2455,1,6,1,1,1,1,'superadmin'),(2456,1,5,1,1,1,1,'superadmin'),(2457,1,3,1,1,1,1,'superadmin'),(2458,1,4,1,1,1,1,'superadmin'),(2459,1,2,1,1,1,1,'superadmin'),(2666,6,1,1,1,1,1,'superadmin'),(2667,6,6,1,1,1,1,'superadmin'),(2668,6,5,1,1,1,1,'superadmin'),(2669,6,3,1,1,1,1,'superadmin'),(2670,6,4,1,1,1,1,'superadmin'),(2671,6,2,1,1,1,1,'superadmin'),(2672,6,61,1,1,1,1,'superadmin'),(2673,6,89,1,1,1,1,'superadmin'),(2674,6,71,1,1,1,1,'superadmin'),(2675,6,91,1,1,1,1,'superadmin'),(2676,6,8,1,1,1,1,'superadmin'),(2677,6,9,1,1,1,1,'superadmin'),(2678,6,11,1,1,1,1,'superadmin'),(2679,6,17,1,1,1,1,'superadmin'),(2680,6,19,1,1,1,1,'superadmin'),(2681,6,25,1,1,1,1,'superadmin'),(2682,6,62,1,1,1,1,'superadmin'),(2683,6,81,1,1,1,1,'superadmin'),(2684,6,80,1,1,1,1,'superadmin'),(2685,6,55,1,1,1,1,'superadmin'),(2686,6,63,1,1,1,1,'superadmin'),(2687,6,75,1,1,1,1,'superadmin'),(2688,6,20,1,1,1,1,'superadmin'),(2689,6,21,1,1,1,1,'superadmin'),(2690,6,27,1,1,1,1,'superadmin'),(2691,6,32,1,1,1,1,'superadmin'),(2692,6,90,1,1,1,1,'superadmin'),(2693,6,28,1,1,1,1,'superadmin'),(2694,6,29,1,1,1,1,'superadmin'),(2695,6,44,1,1,1,1,'superadmin'),(2696,6,48,1,1,1,1,'superadmin'),(2697,6,49,1,1,1,1,'superadmin');
/*!40000 ALTER TABLE `menurightsmaster` ENABLE KEYS */;
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
