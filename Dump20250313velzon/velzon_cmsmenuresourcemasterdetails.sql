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
-- Table structure for table `cmsmenuresourcemasterdetails`
--

DROP TABLE IF EXISTS `cmsmenuresourcemasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmsmenuresourcemasterdetails` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `CMSMenuResId` int DEFAULT NULL,
  `LanguageId` int DEFAULT NULL,
  `MenuName` longtext,
  `Tooltip` longtext,
  `PageDescription` longtext,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(50) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  `MetaTitle` text,
  `MetaDescription` text,
  `IsRedirect` tinyint DEFAULT NULL,
  `IsFullScreen` tinyint DEFAULT NULL,
  `BannerImagePath` text,
  `IconImagePath` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmsmenuresourcemasterdetails`
--

LOCK TABLES `cmsmenuresourcemasterdetails` WRITE;
/*!40000 ALTER TABLE `cmsmenuresourcemasterdetails` DISABLE KEYS */;
INSERT INTO `cmsmenuresourcemasterdetails` VALUES (1,1,1,'Home','Home',NULL,0,1,'superadmin','2025-02-10 13:04:46.000',NULL,NULL,'superadmin','2025-02-10 13:11:25.000','Home','Home',0,0,'',''),(2,2,1,'About Us','About Us',NULL,1,0,'superadmin','2025-02-10 13:05:07.000','admin','2025-02-12 15:27:49.000',NULL,NULL,'About Us','About Us',0,0,'',''),(3,3,1,'Introduction','Introduction','<p>Introduction</p>\r\n',1,0,'superadmin','2025-02-10 13:05:40.000','admin','2025-02-12 15:28:57.000',NULL,NULL,'Introduction','Introduction',0,0,'',''),(4,4,1,'Mission & Vision','Mission & Vision','<p>Mission &amp; Vision</p>\r\n',1,0,'superadmin','2025-02-10 13:06:07.000','admin','2025-02-12 15:29:48.000',NULL,NULL,'Mission & Vision','Mission & Vision',0,0,'',''),(5,5,1,'Projects','Projects',NULL,1,0,'superadmin','2025-02-10 13:06:29.000','admin','2025-02-12 15:36:43.000',NULL,NULL,'Projects','Projects',0,0,'',''),(6,6,1,'Parent 2 Child 1','Parent 2 Child 1','<p>Parent 2 Child 1</p>\r\n',0,1,'superadmin','2025-02-10 13:10:33.000','superadmin','2025-02-11 16:15:16.000','admin','2025-02-12 15:39:54.000','Parent 2 Child 1','Parent 2 Child 1',0,0,'',''),(7,7,1,'Parent 2 Child 2','Parent 2 Child 2','<p>Parent 2 Child 2</p>\r\n',0,1,'superadmin','2025-02-10 13:10:58.000','superadmin','2025-02-11 16:15:30.000','admin','2025-02-12 15:40:03.000','Parent 2 Child 2','Parent 2 Child 2',0,0,'',''),(8,4,NULL,'Parent 1 Child 2','Parent 1 Child 2','<p>Parent 1 Child 2</p>\r\n',1,0,'superadmin','2025-02-11 16:15:11.000',NULL,NULL,NULL,NULL,'Parent 1 Child 2','Parent 1 Child 2',0,0,'',''),(9,8,1,'Objectives','Objectives','<p>Objectives</p>\r\n',1,0,'admin','2025-02-12 15:30:58.000',NULL,NULL,NULL,NULL,'Objectives','Objectives',0,0,'',''),(10,9,1,'Organizational Chart','Organizational Chart','<p>Organizational Chart</p>\r\n',1,0,'admin','2025-02-12 15:32:05.000',NULL,NULL,NULL,NULL,'Organizational Chart','Organizational Chart',0,0,'',''),(11,10,1,'Activities','Activities','<p>Activities</p>\r\n',1,0,'admin','2025-02-12 15:32:40.000',NULL,NULL,NULL,NULL,'Activities','Activities',0,0,'',''),(12,11,1,'Future Plan','Future Plan','<p>Future Plan</p>\r\n',1,0,'admin','2025-02-12 15:33:41.000',NULL,NULL,NULL,NULL,'Future Plan','Future Plan',0,0,'',''),(13,12,1,'Laboratory','Laboratory','<p>Laboratory</p>\r\n',1,0,'admin','2025-02-12 15:37:26.000',NULL,NULL,NULL,NULL,'Laboratory','Laboratory',0,0,'',''),(14,13,1,'KGCMP','KGCMP','<p>KGCMP</p>\r\n',1,0,'admin','2025-02-12 15:37:55.000',NULL,NULL,NULL,NULL,'KGCMP','KGCMP',0,0,'',''),(15,14,1,'System Audit','System Audit','<p>System Audit</p>\r\n',1,0,'admin','2025-02-12 15:38:36.000',NULL,NULL,NULL,NULL,'System Audit','System Audit',0,0,'',''),(16,15,1,'Mineral Exploration','Mineral Exploration','<p>Mineral Exploration</p>\r\n',1,0,'admin','2025-02-12 15:39:05.000',NULL,NULL,NULL,NULL,'Mineral Exploration','Mineral Exploration',0,0,'',''),(17,16,1,'Geo Parks','Geo Parks','<p>Geo Parks</p>\r\n',1,0,'admin','2025-02-12 15:39:40.000',NULL,NULL,NULL,NULL,'Geo Parks','Geo Parks',0,0,'',''),(18,17,1,'At your service','At your service',NULL,1,0,'admin','2025-02-12 15:41:31.000',NULL,NULL,NULL,NULL,'At your service','At your service',0,0,'',''),(19,18,1,'Testing Rates','Testing Rates','<p>Testing Rates</p>\r\n',1,0,'admin','2025-02-12 15:42:02.000','admin','2025-03-05 15:17:21.000',NULL,NULL,'Testing Rates','Testing Rates',0,0,'',''),(20,19,1,'Registration','Registration','<p>Registration</p>\r\n',1,0,'admin','2025-02-12 15:42:30.000','admin','2025-03-04 12:56:16.000',NULL,NULL,'Registration','Registration',0,0,'',''),(21,20,1,'Reports','Reports','<p>Reports</p>\r\n',1,0,'admin','2025-02-12 15:42:58.000','admin','2025-02-17 16:49:03.000',NULL,NULL,'Reports','Reports',0,0,'',''),(22,21,1,'Opportunities','Opportunities','<p>Opportunities</p>\r\n',1,0,'admin','2025-02-12 15:43:26.000','admin','2025-03-04 12:55:49.000',NULL,NULL,'Opportunities','Opportunities',0,0,'',''),(23,22,1,'Media Corner','Media Corner',NULL,1,0,'admin','2025-02-12 15:44:05.000',NULL,NULL,NULL,NULL,'Media Corner','Media Corner',0,0,'',''),(24,23,1,'Photo Gallery','Photo Gallery',NULL,1,0,'admin','2025-02-12 15:45:11.000','admin','2025-02-13 17:55:15.000',NULL,NULL,'Photo Gallery','Photo Gallery',0,0,'',''),(25,24,1,'Video Gallery','Video Gallery',NULL,1,0,'admin','2025-02-12 15:46:12.000','admin','2025-02-13 17:55:25.000',NULL,NULL,'Video Gallery','Video Gallery',0,0,'',''),(26,25,1,'News & Events','News & Events',NULL,1,0,'admin','2025-02-12 15:46:53.000','admin','2025-02-12 15:47:49.000',NULL,NULL,'News & Events','News & Events',0,0,'',''),(27,26,1,'Publication','Publication','<p>Publication</p>\r\n',1,0,'admin','2025-02-12 15:49:05.000',NULL,NULL,NULL,NULL,'Publication','Publication',0,0,'',''),(28,27,1,'E-Citizen','E-Citizen',NULL,1,0,'admin','2025-02-12 15:50:37.000',NULL,NULL,NULL,NULL,'E-Citizen','E-Citizen',0,0,'',''),(29,28,1,'Right to Information','Right to Information',NULL,1,0,'admin','2025-02-12 15:51:20.000','admin','2025-03-05 12:47:57.000',NULL,NULL,'Right to Information','Right to Information',0,0,'',''),(30,29,1,'Acts & Rules','Acts & Rules',NULL,1,0,'admin','2025-02-12 15:52:05.000','admin','2025-02-13 13:18:18.000',NULL,NULL,'Acts & Rules','Acts & Rules',0,0,'',''),(31,30,1,'Government Resolution','Government Resolution',NULL,1,0,'admin','2025-02-12 15:53:20.000',NULL,NULL,NULL,NULL,'Government Resolution','Government Resolution',0,0,'',''),(32,31,1,'FAQs','FAQs','<p>FAQs</p>\r\n',1,0,'admin','2025-02-12 15:54:17.000',NULL,NULL,NULL,NULL,'FAQs','FAQs',0,0,'',''),(33,32,1,'Downloads','Downloads',NULL,1,0,'admin','2025-02-12 15:54:42.000','admin','2025-02-12 15:55:44.000',NULL,NULL,'Downloads','Downloads',0,0,'',''),(34,33,1,'Contact Us','Contact Us','<p>Contact Us</p>\r\n',1,0,'admin','2025-02-12 15:57:03.000','admin','2025-02-14 17:01:08.000',NULL,NULL,'Contact Us','Contact Us',0,1,'',''),(35,34,1,'Terms and Conditions','Terms and Conditions','<p>Terms and Conditions</p>\r\n',1,0,'admin','2025-02-18 12:06:24.000','admin','2025-02-18 12:29:33.000',NULL,NULL,'Terms and Conditions','Terms and Conditions',0,1,'',''),(36,35,1,'Privacy Policy','Privacy Policy','<p>Privacy Policy</p>\r\n',1,0,'admin','2025-02-18 12:12:24.000','admin','2025-02-18 12:29:43.000',NULL,NULL,'Privacy Policy','Privacy Policy',0,1,'',''),(37,36,1,'Copyright Policy','Copyright Policy','<p>Copyright Policy</p>\r\n',1,0,'admin','2025-02-18 12:13:08.000','admin','2025-02-18 12:29:55.000',NULL,NULL,'Copyright Policy','Copyright Policy',0,1,'',''),(38,37,1,'Hyperlink Policy','Hyperlink Policy','<p>Hyperlink Policy</p>\r\n',1,0,'admin','2025-02-18 12:13:43.000','admin','2025-02-18 12:30:06.000',NULL,NULL,'Hyperlink Policy','Hyperlink Policy',0,1,'',''),(39,38,1,'Disclaimer','Disclaimer','<p>Disclaimer</p>\r\n',1,0,'admin','2025-02-18 12:14:11.000','admin','2025-02-18 12:30:16.000',NULL,NULL,'Disclaimer','Disclaimer',0,1,'','');
/*!40000 ALTER TABLE `cmsmenuresourcemasterdetails` ENABLE KEYS */;
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
