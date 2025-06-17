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
-- Table structure for table `serviceratemasterdetails`
--

DROP TABLE IF EXISTS `serviceratemasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serviceratemasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `LanguageId` bigint DEFAULT NULL,
  `ServiceRateId` varchar(45) DEFAULT NULL,
  `ServiceName` varchar(45) DEFAULT NULL,
  `ShortDescription` text,
  `ServiceDescription` text,
  `ImageName` longtext,
  `ImagePath` longtext,
  `Icon` text,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DeleteDate` datetime(3) DEFAULT NULL,
  `MetaTitle` text,
  `MetaDescription` text,
  `ServiceRank` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceratemasterdetails`
--

LOCK TABLES `serviceratemasterdetails` WRITE;
/*!40000 ALTER TABLE `serviceratemasterdetails` DISABLE KEYS */;
INSERT INTO `serviceratemasterdetails` VALUES (1,1,'1','Reports','Reports desc','<h3 class=\"pbmit-title\">Reports</h3>\r\n',NULL,NULL,'pbmit-colza-icon pbmit-colza-icon-gold-ingots',1,0,'admin','2025-02-18 13:25:34.000','admin','2025-03-12 17:23:50.000',NULL,NULL,NULL,NULL,3),(2,1,'2','Testing Rates','Testing Rates','<h3 class=\"pbmit-title\">Testing Rates</h3>\r\n',NULL,NULL,'pbmit-colza-icon pbmit-colza-icon-miner',0,1,'admin','2025-02-18 13:26:38.000','admin','2025-03-05 12:48:39.000','kushal','2025-03-05 12:51:09.000',NULL,NULL,0),(3,1,'3','Registration','Registration desc','<h3 class=\"pbmit-title\">Registration</h3>\r\n',NULL,NULL,'pbmit-colza-icon pbmit-colza-icon-weight-scale',1,0,'admin','2025-02-18 13:27:15.000','admin','2025-03-12 17:23:34.000',NULL,NULL,NULL,NULL,4),(4,1,'4','Opportunities','Opportunities desc','<div class=\"service-details\">\r\n<h3 class=\"pbmit-title\">Get Started Coal Mining</h3>\r\n\r\n<p class=\"mt-3 pb-3\">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ullamco laboris nisi ut aliquip commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>\r\n\r\n<p>It is a long established fact that a reader will be distracted Lorem ipsum dolor sit consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, nisi ut aliquip ex ea commodo consequat.</p>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<div class=\"list-items-left\">\r\n<h3>Exploration &amp; Mining</h3>\r\n\r\n<p>Lorem ipsum dolor amet, consectetur adipiscing elit, sed tempor incididunt.</p>\r\n\r\n<ul class=\"list-items my-1\">\r\n	<li class=\"list-item\"><span class=\"list-icon\"><i aria-hidden=\"true\" class=\"far fa-check-square\"></i> </span> <span class=\"list-text\"> Best mining machines the coal mining</span></li>\r\n	<li class=\"list-item\"><span class=\"list-icon\"><i aria-hidden=\"true\" class=\"far fa-check-square\"></i> </span> <span class=\"list-text\"> Nulla aliquet sapien nec enim porttitor </span></li>\r\n	<li class=\"list-item\"><span class=\"list-icon\"><i aria-hidden=\"true\" class=\"far fa-check-square\"></i> </span> <span class=\"list-text\"> We have great skilled working engineers </span></li>\r\n	<li class=\"list-item\"><span class=\"list-icon\"><i aria-hidden=\"true\" class=\"far fa-check-square\"></i> </span> <span class=\"list-text\"> Hardworking staff and engineer&#39;s </span></li>\r\n</ul>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-6\">\r\n<div class=\"list-items-img\">&nbsp;</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"fund-adviser\">\r\n<h4 class=\"pbmit-title\">Frequently Asked Questions</h4>\r\n\r\n<p class=\"mb-5\">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.</p>\r\n</div>\r\n',NULL,NULL,'pbmit-colza-icon pbmit-colza-icon-factory',1,0,'admin','2025-02-18 13:28:09.000','admin','2025-03-12 17:23:50.000',NULL,NULL,NULL,NULL,1),(5,1,'5','vvsdfv','vfsd','vsd',NULL,NULL,'vsdvc',0,1,'admin','2025-02-18 13:28:31.000','kushal','2025-03-05 12:50:45.000','kushal','2025-03-05 16:37:46.000',NULL,NULL,5),(6,1,'6','gdfg','bg','bgdf',NULL,NULL,'bd',0,1,'admin','2025-02-18 13:29:47.000',NULL,NULL,'admin','2025-02-18 13:30:21.000',NULL,NULL,5),(7,2,'1','reports guj','reports guj','<p>reports guj</p>\r\n',NULL,NULL,'pbmit-colza-icon pbmit-colza-icon-gold-ingots',1,0,'admin','2025-02-18 13:31:18.000',NULL,NULL,NULL,NULL,NULL,NULL,3),(8,2,'2','testing rate guj','testing rate guj','<p>testing rate guj</p>\r\n',NULL,NULL,'pbmit-colza-icon pbmit-colza-icon-miner',0,1,'admin','2025-02-18 13:31:47.000',NULL,NULL,'kushal','2025-03-05 12:51:09.000',NULL,NULL,0),(9,1,'7','Testing Rates','Gujarat','<p>Test</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79e16460||2-39f600db2e7902bd9f4448f1701e999b||0503202512504160917759716.png','pbmit-colza-icon pbmit-colza-icon-miner',1,0,'kushal','2025-03-05 12:50:38.000','admin','2025-03-13 11:29:25.000',NULL,NULL,NULL,NULL,6),(10,1,'8','GMRDS','website','<p>The GMRDS is formed in the year 2002 to support the mineral industries and to provide the technical support for mineral administration under control of Commissionrate of Geology &amp; Mining/Industry and Mines. There are many aspects of mineral development attended, including mining companies, governments, aid agencies, non-governmental organizations (NGOs), academics and consultants. Mining is an ancient human activity developed through essential societal demand. As society and technology have developed, they have inevitably become ever-more materials hungry. This demand will remain for the foreseeable future. Many areas of the Developed World have depleted high-grade mineral deposits, and remaining resources are subject to strong environmental constraints.</p>\r\n',NULL,'CouchDB##3d19a1cc9f4d2c58b3e04afb79f8dd21||2-f205c76b2e0bff786c5204e6201ed49f||0603202512363580366773069.png',NULL,0,1,'kushal','2025-03-05 16:35:26.000','kushal','2025-03-12 17:20:22.000','kushal','2025-03-12 17:23:40.000',NULL,NULL,2);
/*!40000 ALTER TABLE `serviceratemasterdetails` ENABLE KEYS */;
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
