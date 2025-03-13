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
) ENGINE=InnoDB AUTO_INCREMENT=2454 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menurightsmaster`
--

LOCK TABLES `menurightsmaster` WRITE;
/*!40000 ALTER TABLE `menurightsmaster` DISABLE KEYS */;
INSERT INTO `menurightsmaster` VALUES (1519,3,1,1,1,1,1,'admin'),(1520,3,6,1,1,1,1,'admin'),(1521,3,5,1,1,1,1,'admin'),(1522,3,3,1,1,1,1,'admin'),(1523,3,4,1,1,1,1,'admin'),(1524,3,2,1,1,1,1,'admin'),(1525,3,61,1,1,1,1,'admin'),(1526,3,8,1,1,1,1,'admin'),(1527,3,9,1,1,1,1,'admin'),(1528,3,17,0,0,0,1,'admin'),(2190,6,1,1,1,1,1,'superadmin'),(2191,6,6,1,1,1,1,'superadmin'),(2192,6,5,1,1,1,1,'superadmin'),(2193,6,3,1,1,1,1,'superadmin'),(2194,6,4,1,1,1,1,'superadmin'),(2195,6,2,1,1,1,1,'superadmin'),(2196,6,61,1,1,1,1,'superadmin'),(2197,6,71,1,1,1,1,'superadmin'),(2198,6,8,1,1,1,1,'superadmin'),(2199,6,9,1,1,1,1,'superadmin'),(2200,6,11,1,1,1,1,'superadmin'),(2201,6,17,1,1,1,1,'superadmin'),(2202,6,19,1,1,1,1,'superadmin'),(2203,6,25,1,1,1,1,'superadmin'),(2204,6,62,1,1,1,1,'superadmin'),(2205,6,55,1,1,1,1,'superadmin'),(2206,6,53,1,1,1,1,'superadmin'),(2207,6,54,1,1,1,1,'superadmin'),(2208,6,63,1,1,1,1,'superadmin'),(2209,6,78,1,1,1,1,'superadmin'),(2210,6,28,1,1,1,1,'superadmin'),(2211,6,29,1,1,1,1,'superadmin'),(2212,6,44,1,1,1,1,'superadmin'),(2213,6,48,1,1,1,1,'superadmin'),(2214,6,49,1,1,1,1,'superadmin'),(2215,6,60,1,1,1,1,'superadmin'),(2216,6,74,1,1,1,1,'superadmin'),(2217,6,64,1,1,1,1,'superadmin'),(2218,6,65,1,1,1,1,'superadmin'),(2219,6,66,1,1,1,1,'superadmin'),(2220,6,67,1,1,1,1,'superadmin'),(2221,6,68,1,1,1,1,'superadmin'),(2222,6,69,1,1,1,1,'superadmin'),(2223,6,75,1,1,1,1,'superadmin'),(2224,6,20,1,1,1,1,'superadmin'),(2225,6,21,1,1,1,1,'superadmin'),(2226,6,27,1,1,1,1,'superadmin'),(2227,6,32,1,1,1,1,'superadmin'),(2228,6,76,1,1,1,1,'superadmin'),(2229,6,46,1,1,1,1,'superadmin'),(2230,6,72,1,1,1,1,'superadmin'),(2231,6,73,1,1,1,1,'superadmin'),(2232,6,77,1,1,1,1,'superadmin'),(2312,7,76,1,1,1,1,'admin'),(2313,7,46,1,1,1,1,'admin'),(2314,7,72,1,1,1,1,'admin'),(2315,7,73,1,1,1,1,'admin'),(2316,7,77,1,1,1,1,'admin'),(2396,1,1,1,1,1,1,'admin'),(2397,1,6,1,1,1,1,'admin'),(2398,1,5,1,1,1,1,'admin'),(2399,1,3,1,1,1,1,'admin'),(2400,1,4,1,1,1,1,'admin'),(2401,1,2,1,1,1,1,'admin'),(2402,1,8,1,1,1,1,'admin'),(2403,1,9,1,1,1,1,'admin'),(2404,1,11,1,1,1,1,'admin'),(2405,1,17,1,1,1,1,'admin'),(2406,1,19,1,1,1,1,'admin'),(2407,1,25,1,1,1,1,'admin'),(2408,1,55,1,1,1,1,'admin'),(2409,1,63,1,1,1,1,'admin'),(2410,1,80,1,1,1,1,'admin'),(2411,1,81,1,1,1,1,'admin'),(2412,1,82,1,1,1,1,'admin'),(2413,1,75,1,1,1,1,'admin'),(2414,1,20,1,1,1,1,'admin'),(2415,1,21,1,1,1,1,'admin'),(2416,1,27,1,1,1,1,'admin'),(2417,1,32,1,1,1,1,'admin'),(2418,1,28,1,1,1,1,'admin'),(2419,1,29,1,1,1,1,'admin'),(2420,1,48,1,1,1,1,'admin'),(2421,1,49,1,1,1,1,'admin'),(2422,1,60,1,1,1,1,'admin'),(2438,2,8,1,1,1,1,'admin'),(2439,2,9,1,1,1,1,'admin'),(2440,2,11,1,1,1,1,'admin'),(2441,2,17,1,1,1,1,'admin'),(2442,2,19,1,1,1,1,'admin'),(2443,2,25,1,1,1,1,'admin'),(2444,2,55,1,1,1,1,'admin'),(2445,2,63,1,1,1,1,'admin'),(2446,2,80,1,1,1,1,'admin'),(2447,2,81,1,1,1,1,'admin'),(2448,2,82,1,1,1,1,'admin'),(2449,2,75,1,1,1,1,'admin'),(2450,2,20,1,1,1,1,'admin'),(2451,2,21,1,1,1,1,'admin'),(2452,2,27,1,1,1,1,'admin'),(2453,2,32,1,1,1,1,'admin');
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

-- Dump completed on 2025-03-13 17:45:19
