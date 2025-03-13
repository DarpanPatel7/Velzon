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
-- Table structure for table `menuresourcemaster`
--

DROP TABLE IF EXISTS `menuresourcemaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuresourcemaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `MenuName` text,
  `MenuURL` text,
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `CreateBy` text,
  `CreateDate` datetime DEFAULT NULL,
  `UpdateBy` text,
  `UpdateDate` datetime DEFAULT NULL,
  `DeleteBy` text,
  `DeleteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuresourcemaster`
--

LOCK TABLES `menuresourcemaster` WRITE;
/*!40000 ALTER TABLE `menuresourcemaster` DISABLE KEYS */;
INSERT INTO `menuresourcemaster` VALUES (1,'Role Master','/Admin/RoleMaster',1,0,'test','2022-04-11 15:21:34','test test','2022-04-11 15:21:58',NULL,NULL),(2,'Menu Rights','/Admin/MenuRights',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Admin Master','#',1,0,NULL,NULL,'admin','2022-04-25 17:22:30',NULL,NULL),(4,'Resouce Master','/Admin/MenuResource',1,0,NULL,NULL,'admin','2024-09-04 17:13:37',NULL,NULL),(5,'Admin Menu Master','/Admin/AdminMenu',1,0,'admin','2022-04-25 17:23:02','admin','2022-04-25 17:23:09',NULL,NULL),(6,'User Master','/Admin/UserMaster',1,0,'admin','2022-04-26 12:58:40','admin','2022-04-26 17:46:42',NULL,NULL),(8,'CMS Master','#',1,0,'admin','2022-04-30 15:27:21',NULL,NULL,NULL,NULL),(9,'CMS Menu Resource','/Admin/CMSMenuResource',1,0,'admin','2022-04-30 15:27:37',NULL,NULL,NULL,NULL),(10,'CMS Menu Master','/Admin/CMSMenu',1,0,'admin','2022-05-02 14:57:20',NULL,NULL,NULL,NULL),(11,'CMS Template Master','/Admin/CMSTemplate',1,0,'admin','2022-05-05 11:21:01','admin','2024-09-04 17:16:00',NULL,NULL),(12,'CouchDB Doc Master','/Admin/CouchDB/Index',0,0,'admin','2022-05-05 13:09:57','admin','2022-12-20 11:17:47',NULL,NULL),(16,'Minister Master','/Admin/MinisterMaster',1,0,'admin','2022-07-01 11:58:09','admin','2023-02-17 16:21:07',NULL,NULL),(18,'Banner Master','/Admin/BannerMaster',1,0,'admin','2022-07-05 15:17:51',NULL,NULL,NULL,NULL),(19,'Popup Master','/Admin/PopupMaster',1,0,'admin','2022-07-08 16:46:10','admin','2023-04-13 16:08:14',NULL,NULL),(20,'News Master','/Admin/NewsMaster',1,0,'admin','2022-07-19 11:21:12','admin1','2023-10-21 15:06:32',NULL,NULL),(21,'GOI Logo upload','/Admin/GoiLogoMaster',1,0,'admin','2022-07-20 17:13:29','admin','2023-04-13 12:28:28',NULL,NULL),(24,'Upload Document','/Admin/DocumentMaster',1,0,'admin','2022-08-23 16:02:11','admin','2022-08-23 16:32:36',NULL,NULL),(26,'Gallery Master','/Admin/GalleryMaster',1,0,'admin','2022-09-16 12:44:54',NULL,NULL,NULL,NULL),(27,'CMS View','#',1,0,'admin','2022-10-12 14:46:57',NULL,NULL,NULL,NULL),(28,'Feedback','/Admin/Feedback',1,0,'admin','2022-10-12 14:48:58','admin','2022-10-12 15:00:04',NULL,NULL),(31,'Video Master','/Admin/VideoMaster',1,0,'admin','2022-12-23 15:48:29',NULL,NULL,NULL,NULL),(43,'Blog Master','/Admin/BlogMaster',0,1,'admin','2023-05-17 16:36:51',NULL,NULL,NULL,NULL),(44,'Sql Execute','/Admin/SqlExecute',1,0,'admin','2023-05-18 12:28:27',NULL,NULL,NULL,NULL),(45,'Tender Master','TenderMaster',0,1,'admin','2023-06-30 16:55:30',NULL,NULL,NULL,NULL),(48,'Css Master','/Admin/CssMaster',1,0,'admin','2023-09-16 12:11:56',NULL,NULL,NULL,NULL),(49,'Design','#',1,0,'admin','2023-09-16 12:14:20',NULL,NULL,NULL,NULL),(51,'Language Master','/Admin/LanguageMaster',0,0,'admin','2023-10-19 17:08:07','admin','2024-07-02 15:10:28',NULL,NULL),(55,'Ecitizen Master','/Admin/EcitizenMaster',1,0,'admin','2024-04-26 13:24:01',NULL,NULL,NULL,NULL),(60,'Js Master','/Admin/JsMaster',1,0,'admin','2024-08-01 16:41:28',NULL,NULL,NULL,NULL),(61,'CouchDB Settings','/Admin/ChangeCouchDB',1,0,'admin','2024-08-01 16:43:27',NULL,NULL,NULL,NULL),(62,'Statistic Master','/Admin/StatisticMaster',1,0,'admin','2024-08-03 15:51:47',NULL,NULL,NULL,NULL),(63,'Branch Master','/Admin/BranchMaster',1,0,'admin','2024-08-05 18:15:53',NULL,NULL,NULL,NULL),(72,'Utility Master','/Admin/UtilityMaster',1,0,'admin','2024-09-05 11:50:45',NULL,NULL,NULL,NULL),(76,'Media Gallery','#',1,0,'admin','2024-10-05 12:41:34',NULL,NULL,NULL,NULL),(80,'Project master','/Admin/ProjectMaster',1,0,'admin','2025-02-11 12:37:56',NULL,NULL,NULL,NULL),(81,'GOI logo Master','/Admin/GoiLogoMaster',1,0,'admin','2025-02-11 16:04:36',NULL,NULL,NULL,NULL),(82,'Service Rate Master','/Admin/ServiceRateMaster',1,0,'admin','2025-02-15 11:26:45',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `menuresourcemaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-13 17:45:17
