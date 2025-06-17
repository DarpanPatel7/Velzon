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
-- Table structure for table `videomasterurls`
--

DROP TABLE IF EXISTS `videomasterurls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videomasterurls` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `VideoMasterId` bigint DEFAULT NULL,
  `VideoName` text,
  `ThumbImage` text,
  `VideoUrl` text,
  `uploadedname` text,
  `uploadedurl` text,
  `islinkvideo` tinyint DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videomasterurls`
--

LOCK TABLES `videomasterurls` WRITE;
/*!40000 ALTER TABLE `videomasterurls` DISABLE KEYS */;
INSERT INTO `videomasterurls` VALUES (14,1,'video one','https://img.youtube.com/vi/IL0KfvfSvsg/maxresdefault.jpg','https://www.youtube.com/watch?v=IL0KfvfSvsg',NULL,NULL,1),(22,2,'video two','https://img.youtube.com/vi/emd_z_CnnHA/maxresdefault.jpg','https://www.youtube.com/watch?v=emd_z_CnnHA',NULL,NULL,1),(23,2,'al two video two','https://img.youtube.com/vi/F1bJYHl5iJw/maxresdefault.jpg','https://youtube.com/watch?v=F1bJYHl5iJw',NULL,NULL,1),(24,3,'video three','CouchDB##3d19a1cc9f4d2c58b3e04afb79c8eea6||2-3dc8e6c6b9d62167e2225c1e1115a4f3||2702202512161287046189163.jpg','CouchDB##3d19a1cc9f4d2c58b3e04afb79c8e526||2-c5a5ae0830c502dbcccfd4637f40b5cf||2702202512150866201521498.mp4',NULL,NULL,0),(25,5,'sdfsdfsdf','CouchDB##5de25344289097f5561e1849c2345492||2-8f51ca7b10650903a8af79852b6e88db||0105202502355935434739589.jpg','CouchDB##5de25344289097f5561e1849c2345448||2-2f37a387d0aab8bd03e213838110f080||0105202502355872431066173.mp4',NULL,NULL,0),(45,6,'tryrytry','CouchDB##5de25344289097f5561e1849c234dc16||2-d5107ba06b4b91daa6d0cc3245d0f887||0105202502405754361639963.jpg','CouchDB##5de25344289097f5561e1849c234d4ba||2-3fcf2a979e15fe8d650c5697405efb6e||0105202502405650144790443.mp4',NULL,NULL,0),(46,6,'yyyyy','https://img.youtube.com/vi/V5aDnIfBCKA/maxresdefault.jpg','https://www.youtube.com/watch?v=V5aDnIfBCKA',NULL,NULL,1),(47,7,'sdfssdf','CouchDB##5de25344289097f5561e1849c2363446||2-c4c38093f65928573336260dde918753||0105202503000397712938011.jpg','CouchDB##5de25344289097f5561e1849c2363300||2-be39299dc2d3640aba7d4edc3f79161d||0105202503000310978867520.mp4',NULL,NULL,0),(57,8,'sdfsdf','CouchDB##5de25344289097f5561e1849c23675b2||2-b06b699e3e3d0c54966383a517e8cf30||0105202503121002235662174.jpg','CouchDB##5de25344289097f5561e1849c2366dde||2-0ea771338a98c2bdd12be3f68ebc5c69||0105202503120920010664163.mp4',NULL,NULL,0),(58,8,'sfsdfsdf','https://img.youtube.com/vi/V5aDnIfBCKA/maxresdefault.jpg','https://www.youtube.com/watch?v=V5aDnIfBCKA',NULL,NULL,1),(59,4,'GMRDS Video','https://www.youtube.com/watch?v=ZSqSb7WyklA','https://www.youtube.com/watch?v=ZSqSb7WyklA',NULL,NULL,1);
/*!40000 ALTER TABLE `videomasterurls` ENABLE KEYS */;
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
