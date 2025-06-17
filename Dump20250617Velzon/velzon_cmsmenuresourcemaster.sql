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
-- Table structure for table `cmsmenuresourcemaster`
--

DROP TABLE IF EXISTS `cmsmenuresourcemaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmsmenuresourcemaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `MenuRank` int DEFAULT NULL,
  `MenuURL` longtext,
  `ResourceType` int DEFAULT NULL,
  `TemplateId` text,
  `col_parent_id` int DEFAULT NULL,
  `col_menu_type` varchar(100) DEFAULT NULL,
  `IsActive` tinyint DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(50) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmsmenuresourcemaster`
--

LOCK TABLES `cmsmenuresourcemaster` WRITE;
/*!40000 ALTER TABLE `cmsmenuresourcemaster` DISABLE KEYS */;
INSERT INTO `cmsmenuresourcemaster` VALUES (1,0,'#',0,'0',0,'0',0,1,'superadmin','2025-02-10 13:04:46.000',NULL,NULL,'superadmin','2025-02-10 13:11:24.000'),(2,1,'#',0,NULL,0,'0',1,0,'superadmin','2025-02-10 13:05:07.000','superadmin','2025-04-11 16:57:56.000',NULL,NULL),(3,2,'Introduction',0,'0',2,'1',1,0,'superadmin','2025-02-10 13:05:39.000','superadmin','2025-04-28 13:23:47.000',NULL,NULL),(4,3,'MissionAndVision',0,'0',2,'1',1,0,'superadmin','2025-02-10 13:06:07.000','superadmin','2025-04-28 13:23:47.000',NULL,NULL),(5,4,'#',0,'0',0,'0',1,0,'superadmin','2025-02-10 13:06:28.000','superadmin','2025-04-09 16:33:48.000',NULL,NULL),(6,5,'Parent2Child1',0,'0',5,'1',0,1,'superadmin','2025-02-10 13:10:33.000','superadmin','2025-02-11 16:15:16.000','admin','2025-02-12 15:39:54.000'),(7,6,'Parent2Child2',0,'0',5,'1',0,1,'superadmin','2025-02-10 13:10:58.000','superadmin','2025-02-11 16:15:30.000','admin','2025-02-12 15:40:03.000'),(8,7,'Objectives',0,'0',2,'1',1,0,'admin','2025-02-12 15:30:58.000','superadmin','2025-04-09 16:33:39.000',NULL,NULL),(9,8,'OrganizationalChart',0,'0',2,'1',1,0,'admin','2025-02-12 15:32:05.000','superadmin','2025-04-09 16:33:37.000',NULL,NULL),(10,9,'Activities',0,'0',2,'1',1,0,'admin','2025-02-12 15:32:40.000',NULL,NULL,NULL,NULL),(11,10,'FuturePlan',0,'0',2,'1',1,0,'admin','2025-02-12 15:33:41.000',NULL,NULL,NULL,NULL),(12,11,'Laboratory',0,'0',5,'1',1,0,'admin','2025-02-12 15:37:26.000',NULL,NULL,NULL,NULL),(13,12,'KGCMP',0,'0',5,'1',1,0,'admin','2025-02-12 15:37:55.000',NULL,NULL,NULL,NULL),(14,13,'SystemAudit',0,'0',5,'1',1,0,'admin','2025-02-12 15:38:36.000',NULL,NULL,NULL,NULL),(15,14,'MineralExploration',0,'0',5,'1',1,0,'admin','2025-02-12 15:39:05.000',NULL,NULL,NULL,NULL),(16,15,'GeoParks',0,'0',5,'1',1,0,'admin','2025-02-12 15:39:40.000',NULL,NULL,NULL,NULL),(17,16,'#',0,'0',0,'0',1,0,'admin','2025-02-12 15:41:30.000',NULL,NULL,NULL,NULL),(18,17,'ServiceRateDetails/uRnt6JieFCReZ✤jLks✿cWQ♬♬',0,NULL,2,'1',1,0,'admin','2025-02-12 15:42:02.000','superadmin','2025-04-09 16:08:16.000',NULL,NULL),(19,18,'ServiceRateDetails/xKNwB8H6autaudV8AV83FA♬♬',0,'0',17,'1',1,0,'admin','2025-02-12 15:42:30.000','admin','2025-03-04 12:56:16.000',NULL,NULL),(20,19,'ServiceRateDetails/cqAQSGndT4su5PCjskZ32g♬♬',0,'0',17,'1',1,0,'admin','2025-02-12 15:42:58.000','admin','2025-02-17 16:49:03.000',NULL,NULL),(21,20,'ServiceRateDetails/r4Jlr6OhAHYMeFC63fUVdw♬♬',0,'0',17,'1',1,0,'admin','2025-02-12 15:43:26.000','admin','2025-03-04 12:55:49.000',NULL,NULL),(22,21,'#',0,'0',0,'0',1,0,'admin','2025-02-12 15:44:05.000',NULL,NULL,NULL,NULL),(23,22,'/PhotoGallery',1,'0',22,'1',1,0,'admin','2025-02-12 15:45:11.000','admin','2025-02-13 17:55:14.000',NULL,NULL),(24,23,'/VideoGallery',1,'0',22,'1',1,0,'admin','2025-02-12 15:46:12.000','admin','2025-02-13 17:55:25.000',NULL,NULL),(25,24,'/News',1,'0',22,'1',1,0,'admin','2025-02-12 15:46:53.000','admin','2025-02-12 15:47:49.000',NULL,NULL),(26,25,'Publication',0,'0',22,'1',1,0,'admin','2025-02-12 15:49:05.000',NULL,NULL,NULL,NULL),(27,26,'#',0,'0',0,'0',1,0,'admin','2025-02-12 15:50:37.000',NULL,NULL,NULL,NULL),(28,27,'/RightToInformation',1,'0',27,'1',1,0,'admin','2025-02-12 15:51:20.000','admin','2025-03-05 12:47:57.000',NULL,NULL),(29,28,'/ActAndRule',1,'0',27,'1',1,0,'admin','2025-02-12 15:52:05.000','admin','2025-04-11 16:57:07.000',NULL,NULL),(30,29,'/GovernmentResolution',1,'0',27,'1',1,0,'admin','2025-02-12 15:53:20.000','admin','2025-04-11 16:57:07.000',NULL,NULL),(31,30,'faq',0,'0',27,'1',1,0,'admin','2025-02-12 15:54:17.000',NULL,NULL,NULL,NULL),(32,31,'/Downloads',1,'0',27,'1',1,0,'admin','2025-02-12 15:54:42.000','admin','2025-02-12 15:55:44.000',NULL,NULL),(33,32,'ContactUs',0,'0',0,'0',1,0,'admin','2025-02-12 15:57:03.000','admin','2025-02-14 17:01:08.000',NULL,NULL),(34,33,'TermsandConditions',0,'0',0,'2',1,0,'admin','2025-02-18 12:06:24.000','admin','2025-02-18 12:29:33.000',NULL,NULL),(35,34,'PrivacyPolicy',0,'0',0,'2',1,0,'admin','2025-02-18 12:12:24.000','admin','2025-02-18 12:29:43.000',NULL,NULL),(36,35,'CopyrightPolicy',0,'0',0,'2',1,0,'admin','2025-02-18 12:13:08.000','admin','2025-02-18 12:29:55.000',NULL,NULL),(37,36,'HyperlinkPolicy',0,'0',0,'2',1,0,'admin','2025-02-18 12:13:43.000','admin','2025-02-18 12:30:06.000',NULL,NULL),(38,37,'Disclaimer',0,NULL,0,'2',1,0,'admin','2025-02-18 12:14:11.000','superadmin','2025-04-08 16:54:04.000',NULL,NULL),(39,38,'fsdfsdf',0,NULL,0,'0',1,0,'superadmin','2025-04-05 11:45:35.000',NULL,NULL,NULL,NULL),(40,39,'fsdfsdf',0,NULL,0,'0',0,0,'superadmin','2025-04-05 18:06:51.000',NULL,NULL,NULL,NULL),(41,40,'dfgdfgdf',0,NULL,0,'2',0,1,'superadmin','2025-04-05 18:09:42.000','superadmin','2025-04-08 16:49:33.000','superadmin','2025-04-08 17:04:23.000'),(42,41,'sdfsdf',0,NULL,0,'0',0,1,'superadmin','2025-04-08 16:16:39.000','superadmin','2025-04-08 16:41:55.000','superadmin','2025-04-08 17:04:27.000'),(43,42,'Eligendi repellendus',1,NULL,0,'3',0,1,'superadmin','2025-04-08 16:35:33.000',NULL,NULL,'superadmin','2025-04-08 16:49:17.000'),(44,43,'Qui temporibus fugit',0,NULL,0,'0',0,1,'superadmin','2025-04-08 16:50:01.000','superadmin','2025-04-08 16:50:24.000','superadmin','2025-04-08 17:04:30.000'),(45,44,'Non velit eum excep',1,NULL,0,'0',0,1,'superadmin','2025-04-08 17:58:59.000',NULL,NULL,'superadmin','2025-04-09 16:25:47.000'),(46,45,'Pariatur Vitae alia',0,'0',0,'0',0,1,'superadmin','2025-04-09 11:55:25.000',NULL,NULL,'superadmin','2025-04-09 16:25:45.000'),(47,46,'In praesentium ipsum',1,NULL,0,'2',0,1,'superadmin','2025-04-09 11:58:43.000',NULL,NULL,'superadmin','2025-04-09 16:26:18.000'),(48,47,'Fugiat quae velit e guj',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:03:27.000','superadmin','2025-04-09 16:01:09.000','superadmin','2025-04-09 16:25:42.000'),(49,48,'Sit amet perspicia',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:12:38.000',NULL,NULL,'superadmin','2025-04-09 16:25:50.000'),(50,49,'Voluptas id et error',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:13:41.000',NULL,NULL,'superadmin','2025-04-09 16:25:52.000'),(51,50,'Ut atque voluptate q',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:14:47.000',NULL,NULL,'superadmin','2025-04-09 16:25:55.000'),(52,51,'dfgdf',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:15:31.000',NULL,NULL,'superadmin','2025-04-09 16:25:31.000'),(53,52,'Qui minim assumenda ',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:19:06.000','superadmin','2025-04-09 12:21:10.000','superadmin','2025-04-09 16:25:58.000'),(54,53,'jghjghj',0,NULL,0,'0',0,1,'superadmin','2025-04-09 12:20:20.000',NULL,NULL,'superadmin','2025-04-09 16:25:34.000'),(55,54,'sdfsdf',0,NULL,2,'1',0,1,'superadmin','2025-04-09 12:20:35.000','superadmin','2025-04-09 16:05:06.000','superadmin','2025-04-09 16:25:21.000'),(56,55,'test engg guj',0,NULL,0,'0',0,1,'superadmin','2025-04-09 16:04:16.000','superadmin','2025-04-09 16:24:51.000','superadmin','2025-04-09 16:25:37.000'),(57,56,'Fuga Dicta eos nes',1,NULL,0,'2',0,1,'superadmin','2025-04-09 16:30:52.000','superadmin','2025-04-28 13:23:33.000','superadmin','2025-04-28 13:23:36.000');
/*!40000 ALTER TABLE `cmsmenuresourcemaster` ENABLE KEYS */;
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
