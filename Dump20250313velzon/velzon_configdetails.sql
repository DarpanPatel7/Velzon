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
-- Table structure for table `configdetails`
--

DROP TABLE IF EXISTS `configdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configdetails` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ParameterName` text,
  `ParameterValue` text,
  `Description` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configdetails`
--

LOCK TABLES `configdetails` WRITE;
/*!40000 ALTER TABLE `configdetails` DISABLE KEYS */;
INSERT INTO `configdetails` VALUES (1,'SMTPServer','smtp.gujarat.gov.in',''),(2,'SMTPPassword','',''),(3,'SMTPFromEmail','noreply-gil@gujarat.gov.in',''),(4,'SMTPAccount','',''),(5,'SMTPPort','25',''),(6,'SMTPIsSecure','0',''),(7,'TestSMTPServer','smtp.gujarat.gov.in',''),(8,'TestSMTPPassword','Pass@12345',''),(9,'TestSMTPFromEmail','noreply-gil@gujarat.gov.in',''),(10,'TestSMTPAccount','noreply-gil@gujarat.gov.in',''),(11,'TestSMTPPort',NULL,''),(12,'TestSMTPIsSecure','0',''),(13,'SMTPIsTest','0',''),(14,'CouchDBURL','http://10.10.2.150:5984',NULL),(15,'CouchDBDbName','velzon',NULL),(16,'CouchDBUser','admin:admin123',NULL),(17,'AllowCouchDBStore','1',NULL),(18,'ISAdmin','1003',NULL),(19,'AnswerKeyResentationURL','/ViewFile?fileName=bFaFq1ghqeTmUWTsK7A5C9ARaKAQkWfJMGwQMSnGPrlfvO59TowDQ6F✿AUChoccCjxOltmYY5gZg1NUzMlL5wy✿Fla3rvBpv1UFazkEFeT4o0kVpxropJeCjQP3bwHnB0CQqFOqPhOVVYDdsoIVFKw♬♬',NULL),(20,'Email','exegil-sw-38@gujarat.gov.in',NULL),(90,'UpcommingEventPerPage','10','This parameter determines the number of upcoming events displayed per page in the event listing.'),(91,'PastEventPerPage','10','This parameter specifies the number of past events shown per page in the event listing.'),(92,'SuperAdminRoleId','6','This parameter holds the role ID associated with the Super Admin. It is used to identify and manage the permissions and functionalities available to the Super Admin role.'),(93,'IntervalWrongAttemptInMinutes','20','This parameter defines the interval, in minutes, for automatically unlocking an account that has been locked due to too many wrong login attempts. It helps to determine how long the account remains locked before the user can try logging in again. This setting is used as a security measure to prevent brute force attacks while allowing the account to unlock after the specified time.'),(94,'WrongLoginAttemtLimit','3','This parameter defines the maximum number of wrong login attempts allowed before additional security actions, such as account lockout or CAPTCHA enforcement, are triggered.');
/*!40000 ALTER TABLE `configdetails` ENABLE KEYS */;
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
