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
-- Table structure for table `bannermasterdetails`
--

DROP TABLE IF EXISTS `bannermasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannermasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `BannerId` bigint DEFAULT NULL,
  `LanguageId` bigint DEFAULT NULL,
  `Title` longtext,
  `Description` longtext,
  `ImageName` longtext,
  `ImagePath` longtext,
  `BannerRank` int DEFAULT NULL,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `DeletedBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime DEFAULT NULL,
  `URL` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bannermasterdetails`
--

LOCK TABLES `bannermasterdetails` WRITE;
/*!40000 ALTER TABLE `bannermasterdetails` DISABLE KEYS */;
INSERT INTO `bannermasterdetails` VALUES (1,1,1,'Banner1','<p>Banner1</p>\n','bannerone.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79844650||2-ff8ef7fd5e5e46e727f9fc0b76bc084b||1002202501270385787744257.png',0,1,0,'superadmin','2025-02-10 13:27:05','superadmin','2025-02-11 17:37:46',NULL,NULL,NULL),(2,2,1,'Banner2','<p>Banner2</p>\n','bannertwo.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79844e4f||2-3c1c821f0cf4f6ffafe2d6533ced9615||1002202501272024896462948.png',1,1,0,'superadmin','2025-02-10 13:27:19','superadmin','2025-03-12 11:01:11',NULL,NULL,NULL),(3,3,1,'Banner3','<p>Banner3</p>\n','bannerthree.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79845c27||2-317841d2d439098f5cad8da1b7502574||1002202501273405349111800.png',2,0,0,'superadmin','2025-02-10 13:27:32','kushal','2025-03-12 11:46:37',NULL,NULL,NULL),(4,4,1,'Banner4','<p>Banner4</p>\n','bannerfour.png','CouchDB##3d19a1cc9f4d2c58b3e04afb798465ab||2-49fc5ce8b8d83725fd03ea7a3ce5ecc4||1002202501283802849751096.png',3,0,0,'superadmin','2025-02-10 13:28:37','kushal','2025-03-12 11:46:27',NULL,NULL,NULL),(5,5,1,'BannerTest','<p>new</p>\n','logo.png','CouchDB##3d19a1cc9f4d2c58b3e04afb79d8e3fc||2-d6b940f3bbf83e0922563103e64fdccc||0403202512054597356385780.png',4,0,1,'kushal','2025-03-04 12:05:43','kushal','2025-03-12 11:07:35','kushal','2025-03-12 11:46:48',NULL);
/*!40000 ALTER TABLE `bannermasterdetails` ENABLE KEYS */;
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
