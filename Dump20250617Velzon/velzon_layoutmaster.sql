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
-- Table structure for table `layoutmaster`
--

DROP TABLE IF EXISTS `layoutmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `layoutmaster` (
  `LayoutId` int NOT NULL AUTO_INCREMENT,
  `LayoutName` varchar(100) NOT NULL,
  `PageTitle` varchar(200) DEFAULT NULL,
  `MetaHtml` text,
  `HeaderHtml` text,
  `FooterHtml` text,
  `MainContentHtml` text,
  `Styles` text,
  `Scripts` text,
  `IsActive` tinyint(1) DEFAULT '1',
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LayoutId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutmaster`
--

LOCK TABLES `layoutmaster` WRITE;
/*!40000 ALTER TABLE `layoutmaster` DISABLE KEYS */;
INSERT INTO `layoutmaster` VALUES (2,'DefaultAdmin','Admin Dashboard','<meta name=\"description\" content=\"Admin Panel Layout\">','<header class=\"admin-header\">\n        <div class=\"container\">\n            <div class=\"d-flex justify-content-between align-items-center\">\n                <h1 class=\"text-white\">Admin Dashboard</h1>\n                <nav>\n                    <ul class=\"d-flex\">\n                        <li><a href=\"/admin/dashboard\" class=\"text-white\">Dashboard</a></li>\n                        <li><a href=\"/admin/settings\" class=\"text-white\">Settings</a></li>\n                        <li><a href=\"/admin/logout\" class=\"text-white\">Logout</a></li>\n                    </ul>\n                </nav>\n            </div>\n        </div>\n    </header>','<footer class=\"admin-footer\">\n        <div class=\"container\">\n            <p class=\"text-center text-white\">&copy; 2025 Admin Panel. All rights reserved.</p>\n        </div>\n    </footer>',NULL,'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css, /css/admin-custom.css','https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js, /js/admin-scripts.js',1,'2025-05-14 12:38:23','2025-05-14 17:28:23');
/*!40000 ALTER TABLE `layoutmaster` ENABLE KEYS */;
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
