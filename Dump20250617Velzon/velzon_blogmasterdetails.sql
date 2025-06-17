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
-- Table structure for table `blogmasterdetails`
--

DROP TABLE IF EXISTS `blogmasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogmasterdetails` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `BlogMasterId` bigint DEFAULT NULL,
  `LanguageId` bigint DEFAULT NULL,
  `BlogName` varchar(300) DEFAULT NULL,
  `Description` longtext,
  `BlogBy` varchar(45) DEFAULT NULL,
  `BlogDate` datetime DEFAULT NULL,
  `FileUpload` longtext,
  `FilePath` text,
  `IsActive` tinyint DEFAULT NULL,
  `Location` varchar(50) DEFAULT NULL,
  `IsDelete` tinyint DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedBy` varchar(100) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `DeleteBy` varchar(100) DEFAULT NULL,
  `DeletedDate` datetime DEFAULT NULL,
  `MetaTitle` text,
  `MetaDescription` text,
  `TypeId` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogmasterdetails`
--

LOCK TABLES `blogmasterdetails` WRITE;
/*!40000 ALTER TABLE `blogmasterdetails` DISABLE KEYS */;
INSERT INTO `blogmasterdetails` VALUES (1,1,1,'blog','<p>blog</p>\r\n',NULL,'2024-09-10 00:00:00',NULL,NULL,0,'blog',1,'admin','2024-09-05 11:39:21',NULL,NULL,'manthan','2024-09-13 16:01:39','blog','blog',1),(2,1,2,'blog guj','<p>blog guj1</p>\r\n',NULL,'2024-09-11 00:00:00',NULL,NULL,0,'blog guj',1,'admin','2024-09-05 11:39:48','admin','2024-09-05 11:40:23','manthan','2024-09-13 16:01:39','blog guj1','blog guj',1),(3,2,1,'scheme','<p>scheme</p>\r\n',NULL,'2024-09-04 00:00:00',NULL,NULL,0,'scheme',1,'admin','2024-09-05 11:41:11',NULL,NULL,'manthan','2024-09-13 16:14:02','scheme','scheme',2),(4,2,2,'scheme guj','<p>scheme guj</p>\r\n',NULL,'2024-09-04 00:00:00',NULL,NULL,0,'scheme guj',1,'admin','2024-09-05 11:41:33','admin','2024-09-05 13:50:26','manthan','2024-09-13 16:14:02','scheme guj','scheme guj',2),(5,3,1,'press release','<p>press release</p>\r\n',NULL,'2024-09-05 00:00:00',NULL,NULL,0,'press release',1,'admin','2024-09-05 11:42:44',NULL,NULL,'manthan','2024-09-13 15:12:21','press release','press release',3),(6,3,2,'press release guj','<p>press release guj</p>\r\n',NULL,'2024-09-11 00:00:00',NULL,NULL,0,'press release guj',1,'admin','2024-09-05 11:43:05',NULL,NULL,'manthan','2024-09-13 15:12:21','press release guj','press release guj',3),(7,4,1,'test','<p>test</p>\r\n',NULL,'2024-08-27 00:00:00',NULL,NULL,0,'test',1,'admin','2024-09-05 11:50:33','jagtap','2024-09-06 17:00:20','manthan','2024-09-13 16:01:42',NULL,NULL,1),(8,5,1,'testing','<p>test</p>\r\n',NULL,'2024-07-30 00:00:00',NULL,NULL,0,'test',1,'admin','2024-09-05 11:50:52','jagtap','2024-09-06 17:01:41','manthan','2024-09-13 16:14:06',NULL,NULL,2),(9,4,2,'test','<p>test</p>\r\n',NULL,'2024-07-30 00:00:00',NULL,NULL,0,'test',1,'admin','2024-09-05 11:52:59','admin','2024-09-05 14:43:42','manthan','2024-09-13 16:01:42',NULL,NULL,3),(10,6,1,'tttttttt','<p>test</p>\r\n',NULL,'2024-07-02 00:00:00',NULL,NULL,0,'test',1,'admin','2024-09-05 11:55:17','jagtap','2024-09-06 17:01:32','manthan','2024-09-11 16:24:06',NULL,NULL,2),(11,7,1,'Blog test','<p>Test</p>\r\n',NULL,'2024-09-18 00:00:00',NULL,NULL,0,'Giftcity',1,'admin','2024-09-05 12:49:40',NULL,NULL,'manthan','2024-09-13 16:01:45',NULL,NULL,1),(12,7,2,'Blog Gujarati','<p>Test</p>\r\n',NULL,'2024-09-19 00:00:00',NULL,NULL,0,'Giftcity',1,'admin','2024-09-05 12:50:41',NULL,NULL,'manthan','2024-09-13 16:01:45',NULL,NULL,1),(13,8,1,'Press Release New','<p>Press Release New</p>\r\n',NULL,'2024-09-05 00:00:00',NULL,NULL,0,'Ahmedabad',1,'admin','2024-09-05 12:54:59',NULL,NULL,'manthan','2024-09-13 15:12:29',NULL,NULL,3),(14,8,2,'Press Release New','<p>Press Release New</p>\r\n',NULL,'2024-09-06 00:00:00',NULL,NULL,0,'Krishnanagar',1,'admin','2024-09-05 12:55:32',NULL,NULL,'manthan','2024-09-13 15:12:29',NULL,NULL,3),(15,9,1,'scheme 1','<p>scheme 1</p>\r\n',NULL,'2024-09-11 00:00:00',NULL,NULL,0,'scheme 1',1,'admin','2024-09-05 14:30:15','admin','2024-09-05 14:35:04','manthan','2024-09-13 16:14:09','scheme 1','scheme 1',2),(16,9,2,'scheme1 guj','<p>scheme1 guj</p>\r\n',NULL,'2024-09-11 00:00:00',NULL,NULL,0,'scheme1 guj',1,'admin','2024-09-05 14:30:50',NULL,NULL,'manthan','2024-09-13 16:14:09','scheme1 guj','scheme1 guj',2),(17,10,1,'s1','<p>s1</p>\r\n',NULL,'2024-09-11 00:00:00',NULL,NULL,0,'s1',1,'admin','2024-09-05 14:40:05','admin','2024-09-05 14:40:57','admin','2024-09-05 14:42:13','s1','s1`',1),(18,10,2,'s1 guj','<p>s1 guj</p>\r\n',NULL,'2024-09-11 00:00:00',NULL,NULL,0,'s1 guj',1,'admin','2024-09-05 14:40:34','admin','2024-09-05 14:41:33','admin','2024-09-05 14:42:13','s1 guj','s1 guj',1),(19,11,1,'testtesttesttest','<p>test</p>\r\n',NULL,'2024-08-27 00:00:00',NULL,NULL,0,'test',1,'jagtap','2024-09-06 16:37:09','jagtap','2024-09-06 16:37:41','jagtap','2024-09-06 16:37:44',NULL,NULL,1),(20,12,1,'test','<p>test</p>\r\n',NULL,'2024-09-03 00:00:00',NULL,NULL,0,'test',1,'admin','2024-09-10 11:38:31','admin','2024-09-10 11:38:45','admin','2024-09-10 11:38:49',NULL,NULL,1),(21,13,1,'scheme 2','<p>scheme 2</p>\r\n',NULL,'2024-09-17 00:00:00',NULL,NULL,0,NULL,1,'admin','2024-09-11 13:52:22',NULL,NULL,'manthan','2024-09-13 16:14:19','scheme 2','scheme 2',2),(22,14,1,'Divya Bhaskar','<p>test</p>\r\n',NULL,'2024-08-31 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:01:52',NULL,NULL,NULL,NULL,NULL,NULL,3),(23,15,1,'ETV Bharat','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:05:16',NULL,NULL,NULL,NULL,NULL,NULL,3),(24,16,1,'Kamalam Gujarat','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:06:06',NULL,NULL,NULL,NULL,NULL,NULL,3),(25,17,1,'Times Of India','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:06:50',NULL,NULL,NULL,NULL,NULL,NULL,3),(26,18,1,'Navgujarat Samay','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:07:50',NULL,NULL,NULL,NULL,NULL,NULL,3),(27,19,1,'Divya Bhaskar','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:08:53',NULL,NULL,NULL,NULL,NULL,NULL,3),(28,20,1,'Gandhi Nagar Today','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Gandhinagar',0,'manthan','2024-09-13 15:09:44',NULL,NULL,NULL,NULL,NULL,NULL,3),(29,21,1,'Gujarat Mitra','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:10:33',NULL,NULL,NULL,NULL,NULL,NULL,3),(30,22,1,'Gujarat Guardian','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:11:11',NULL,NULL,NULL,NULL,NULL,NULL,3),(31,23,1,'Jai Hind','<p>test</p>\r\n',NULL,'2024-08-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 15:11:45',NULL,NULL,NULL,NULL,NULL,NULL,3),(32,24,1,'Coming soon','<p>test</p>\r\n',NULL,'2024-09-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 16:01:30',NULL,NULL,NULL,NULL,NULL,NULL,1),(33,25,1,'Coming soon','<p>Coming soon</p>\r\n',NULL,'2024-09-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 16:02:13',NULL,NULL,NULL,NULL,NULL,NULL,1),(34,26,1,'Coming soon','<p>Coming soon</p>\r\n',NULL,'2024-09-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 16:02:33',NULL,NULL,NULL,NULL,NULL,NULL,1),(35,27,1,'Ministry Of Food Processing Industries','<p>Ministry Of Food Processing Industries</p>\r\n',NULL,'2024-09-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 16:09:58','manthan','2024-09-13 16:11:05',NULL,NULL,NULL,NULL,2),(36,28,1,'Mission For Integrated Development of Horticulture','<p>Mission For Integrated Development of Horticulture</p>\r\n',NULL,'2024-09-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 16:12:11',NULL,NULL,NULL,NULL,NULL,NULL,2),(37,29,1,'Agriculture Infrastructure Fund','<p>Agriculture Infrastructure Fund</p>\r\n',NULL,'2024-09-01 00:00:00',NULL,NULL,1,'Ahmedabad',0,'manthan','2024-09-13 16:13:07','admin','2024-10-30 12:10:49',NULL,NULL,NULL,NULL,2),(38,30,1,'Test Scheme','<p>test</p>\r\n',NULL,'2024-10-17 00:00:00',NULL,NULL,0,NULL,0,'kushal','2024-10-21 12:28:14','admin','2024-11-28 12:00:58',NULL,NULL,NULL,NULL,2),(39,31,1,'Test Blog','<p>New Blog 2024</p>\r\n',NULL,'2024-10-20 00:00:00',NULL,NULL,0,NULL,0,'kushal','2024-10-21 12:43:33','kushal','2024-10-21 12:47:28',NULL,NULL,NULL,NULL,1),(40,32,1,'Press Release New','<p>New Updates</p>\r\n',NULL,'2024-10-22 00:00:00',NULL,NULL,0,NULL,0,'kushal','2024-10-21 13:27:48','kushal','2024-10-21 13:29:07',NULL,NULL,NULL,NULL,3),(41,29,2,'Scheme Gujarati','<p>test</p>\r\n',NULL,'2024-09-12 00:00:00',NULL,NULL,1,NULL,0,'kushal','2024-10-22 12:14:07',NULL,NULL,NULL,NULL,NULL,NULL,2),(42,33,1,'panorama','<p>panorama</p>\r\n',NULL,'2024-12-26 00:00:00',NULL,NULL,1,'panorama',0,'admin','2024-12-04 15:05:02','admin','2024-12-11 16:24:56',NULL,NULL,'panorama','panorama',4),(43,34,1,'testing','<p>test</p>\r\n',NULL,'2024-12-18 00:00:00',NULL,NULL,1,'test',0,'admin','2024-12-05 13:11:53','admin','2024-12-31 15:00:04',NULL,NULL,'test','test',4),(44,35,1,'test','<p>test</p>\r\n',NULL,'2024-12-01 00:00:00',NULL,NULL,0,NULL,1,'manthan','2024-12-19 16:55:44','manthan','2024-12-19 17:15:53','manthan','2024-12-19 17:41:06',NULL,NULL,4),(45,35,2,'ttt','<p>ttt</p>\r\n',NULL,'2024-12-01 00:00:00',NULL,NULL,0,NULL,1,'manthan','2024-12-19 17:40:23',NULL,NULL,'manthan','2024-12-19 17:41:06',NULL,NULL,4),(46,36,1,'New Panorama','<p>New Panorama</p>\r\n',NULL,'2024-12-19 00:00:00',NULL,NULL,0,NULL,0,'manthan','2024-12-31 15:00:20','manthan','2024-12-31 15:07:22',NULL,NULL,NULL,NULL,4),(47,37,1,'vihal','<p>vkjhijdes</p>\r\n',NULL,'2025-01-06 00:00:00',NULL,NULL,1,NULL,0,'admin','2025-01-01 15:40:11','admin','2025-01-01 15:40:44',NULL,NULL,NULL,NULL,4);
/*!40000 ALTER TABLE `blogmasterdetails` ENABLE KEYS */;
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
