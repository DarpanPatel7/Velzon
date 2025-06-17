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
-- Table structure for table `frontusermaster`
--

DROP TABLE IF EXISTS `frontusermaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontusermaster` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `FirstName` text,
  `MiddleName` text,
  `LastName` text,
  `Email` text,
  `PhoneNo` text,
  `Address` text,
  `UserPassword` text,
  `IsPasswordReset` tinyint DEFAULT '0',
  `IsActive` tinyint DEFAULT '1',
  `IsDelete` tinyint DEFAULT '0',
  `IsChangeProfile` tinyint DEFAULT '0',
  `CreateBy` text,
  `CreateDate` datetime DEFAULT NULL,
  `UpdateBy` text,
  `UpdateDate` datetime DEFAULT NULL,
  `DeleteBy` text,
  `DeleteDate` datetime DEFAULT NULL,
  `ApplicantPhoto` text,
  `InvestorType` text,
  `AgroFoodPreferences` text,
  `KeyInterest` text,
  `AverageInvestment` text,
  `InvestmentHorizon` text,
  `SpecificInformation` text,
  `IsExistingInvestment` text,
  `AdditionalInformation` text,
  `Designation` text,
  `Company` text,
  `PinCode` text,
  `Website` text,
  `State` text,
  `City` text,
  `SessionVersion` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontusermaster`
--

LOCK TABLES `frontusermaster` WRITE;
/*!40000 ALTER TABLE `frontusermaster` DISABLE KEYS */;
INSERT INTO `frontusermaster` VALUES (1,'urvish',NULL,'patel','exegil-sw76@gujarat.gov.in','7778889990','test address','M6iM8PHF2PSZzOAsscUARw==',0,1,0,1,NULL,'2024-10-21 12:59:54',NULL,'2025-01-18 15:31:49',NULL,NULL,'CouchDB##a02141439edf967b6ad8b996b25b8bc5||2-c181b6c1bb87ccbac6165216fd8ac893||3011202401085667371090460.jpg',NULL,'Grain & Pulses Processing',NULL,NULL,'Short term (1-3 Years)','Advice on Necessary Requirements/Formalities',NULL,NULL,'developer','IT','384002',NULL,'Gujarat','Amreli','b68b0e4d-8fe5-41b6-90c0-39e22e6634e4'),(2,'Vipul','U','Parmar','exegil-sw26@gujarat.gov.in','8887778880',NULL,'B4mnwmlE7JttI+DE+tRCVA==',0,1,0,1,NULL,'2024-10-21 13:02:23',NULL,'2024-12-03 16:39:11',NULL,NULL,'CouchDB##a02141439edf967b6ad8b996b263f287||2-4ef255ae61bbfee7da638baa5638a1a2||0312202404391431180543530.jpg','Institutional Investor',NULL,'Processing units,Cold storage facilities',NULL,'Short term (1-3 Years)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gujarat','Amreli','bbaf2caf-f6f4-4447-9154-7f56ac5954f4'),(15,'Vishal','Jagdishbhai','Rana','vishalr@gujarat.gov.in','9998310082','Ahmedabad','OR2QrzezCzeTo3Zz/kwgBA==',0,1,0,1,NULL,'2024-11-19 17:54:48',NULL,'2025-01-01 15:22:04',NULL,NULL,'CouchDB##f46acb1290c839aeb20c3bd8b83f9e2e||2-eb15db567c2a07e32c517b86aa4f7a20||0101202503220768930604652.jpg','Individual Investor','Grain & Pulses Processing,Fat & Oilseed Processing,Spices Processing','Infrastructure development,Organic Farming','Less than 1 Crore','Short term (1-3 Years)','Advice on Necessary Requirements/Formalities','0','Hi Please let me know about anything happening on iNDEXT-A','Project Manager','GIL','380015',NULL,'Gujarat','Ahmedabad','eb7e07ff-bf6d-4162-a68d-20957e5dbc1f'),(19,'Kushal','H','Shah','exegil-sw74@gujarat.gov.in','9725598474','test data ','Y5yyaOcg8e3NKSIphyVsxA==',0,1,0,1,NULL,'2024-11-20 12:51:39','Kushal','2024-11-20 14:57:13',NULL,NULL,'CouchDB##a02141439edf967b6ad8b996b2306581||2-e6e4acf89045add46b78b1e97c7cda88||2011202401045157512944762.png','Individual Investor','Grain & Pulses Processing','Processing units','50-2500 Crores','Long term (5+ Years)','Advice on Necessary Requirements/Formalities,Suggestion of Possible Locations','1','test data',NULL,'IT','382345','qa','Gujarat','Ahmedabad ','99cca532-d498-4864-bb59-34756fb56acf'),(21,'Jaimin','N','Patel','exegil-sw32@gujarat.gov.in','9898989898','OK Done','dpFQHK4HNvwnpW2uePPnXA==',0,1,0,1,NULL,'2024-11-20 15:18:28',NULL,'2024-11-20 15:25:31',NULL,NULL,NULL,'Institutional Investor',NULL,'Processing units,Cold storage facilities','25-50 Crores','Medium term (3-5 Years)','Advice on Necessary Requirements/Formalities,Details of Policy/Incentives','0',NULL,'QA','DEV IT','382345','https://staging-gil1.gujarat.gov.in','Gujarat','Ahmedabad ',NULL),(23,'Kushal','H','Shah','kushalshah1838@gmail.com','9725598162','Giftcity Gandhinagar','EVkok6NYku3ADzSPsiyQuQ==',0,1,0,1,NULL,'2024-11-21 13:04:05',NULL,'2024-11-21 15:50:24',NULL,NULL,'CouchDB##a02141439edf967b6ad8b996b2353b45||2-8350e01243515d5e98af6326c0d558ef||2111202403471867458103213.png','Venture Capitalist','Fruits & Vegetables Processing,Dairy & Milk Products','Cold storage facilities,Value-added products','1-5 Crores','Medium term (3-5 Years)','Suggestion of Possible Locations,Details of Policy/Incentives','0','Additional','IT',NULL,'382255','DO','Gujarat','Gandhinagar ','99e6de1f-6441-48a1-adf3-35f1b8b2e345'),(24,'Kushal','test','Shah','Kushal.Shah@devitpl.com','9725598155',NULL,'Ej8yOJm/gFcrnoa/nQpmPw==',0,1,0,1,NULL,'2024-11-21 16:15:15','Kushal','2024-11-21 16:40:08',NULL,NULL,'CouchDB##a02141439edf967b6ad8b996b236040e||2-bdc0caab209529011b5e40aededd84fb||2111202404385446913599182.png','Institutional Investor','Spices Processing,Fruits & Vegetables Processing','Infrastructure development','1-5 Crores','Medium term (3-5 Years)','Suggestion of Possible Locations,Details of Policy/Incentives','0','XSSDDX','Designation',NULL,'121212',NULL,'Jammu & Kashmir','Srinagar ','990385e1-7ed3-42f4-8f9d-ece9c2f7b9c9'),(26,'Kushal','H','Shah','exegil-sw40@gujarat.gov.in','9725598162',NULL,'EVkok6NYku3ADzSPsiyQuQ==',0,1,0,1,NULL,'2024-11-25 11:27:33','Kushal','2024-11-26 11:32:28',NULL,NULL,NULL,'Individual Investor','Spices Processing,Fruits & Vegetables Processing,Dairy & Milk Products','Infrastructure development,Processing units,Cold storage facilities','50-2500 Crores','Long term (5+ Years)','Advice on Necessary Requirements/Formalities,Details of Policy/Incentives','1',NULL,'QA','IT','382345','www.google.com','Gujarat','Ahmedabad ','62395045-7f17-4287-a1c5-c85eb0799ed7'),(28,'Mahal','Singh','GIL','kushal.shah@devitpl.com','8866114741',NULL,'U2zjwF8FIFkxAdu9aaE3iA==',0,1,0,1,NULL,'2024-11-25 15:28:01',NULL,'2024-11-25 15:34:56',NULL,NULL,NULL,'Institutional Investor',NULL,'Infrastructure development,Processing units,Cold storage facilities,Value-added products,1111111111111111',NULL,NULL,'Advice on Necessary Requirements/Formalities,Suggestion of Possible Locations,Details of Policy/Incentives,Suggestion on Potential Projects','0',NULL,'Mahal ','Mahal','382256','Mahal.com','Gujarat','Gandhinagar',NULL),(29,'test','test','test','manthanjagtap2211@gmail.com','3434343434',NULL,'49rjKDxvKWaWQlEPNFKQcg==',0,1,0,0,NULL,'2024-11-25 15:48:45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gujarat','Gandhinagar',NULL),(30,'Kushal','H','Shah','Kushal.shah@devitpl.com','8866112244',NULL,'HniEqXJank5ysjbR14feRA==',0,1,0,1,NULL,'2024-11-27 15:01:02',NULL,'2024-11-27 15:25:57',NULL,NULL,NULL,'Venture Capitalist','Grain & Pulses Processing,Fat & Oilseed Processing,Spices Processing,Fruits & Vegetables Processing,Dairy & Milk Products,Fish, Meat & Poultry','Infrastructure development,Processing units,Cold storage facilities,Value-added products','5-10 Crores','Medium term (3-5 Years)','Advice on Necessary Requirements/Formalities,Suggestion of Possible Locations,Details of Policy/Incentives,Suggestion on Potential Projects','1','test',NULL,NULL,'382345','it','Gujarat','Ahmedabad ','3f638de6-2879-421d-bdb0-bfd92016b752'),(31,'sanket','K','Mishra','sanketmishra123@gmail.com','7014475854','AHEMDABAD','D7uoVlyRq3R+5zSX/2KwZQ==',0,1,0,1,NULL,'2025-01-01 16:25:26',NULL,'2025-01-01 16:37:34',NULL,NULL,NULL,'Individual Investor','Grain & Pulses Processing','Infrastructure development,Processing units','1-5 Crores',NULL,'Advice on Necessary Requirements/Formalities','1','i AM BUSSINESSMAN','pm','EY','380015',NULL,'Gujarat','Ahmedabad',NULL),(32,'manthan',NULL,'jagtap','exegil-sw78@gujarat.gov.in','8734916683','address','49rjKDxvKWaWQlEPNFKQcg==',0,1,0,1,NULL,'2025-01-03 11:00:43',NULL,'2025-01-03 11:04:20',NULL,NULL,NULL,'Individual Investor','Grain & Pulses Processing,Fat & Oilseed Processing,Spices Processing,Fruits & Vegetables Processing,Dairy & Milk Products,Fish, Meat & Poultry','Infrastructure development','Less than 1 Crore','Short term (1-3 Years)','Advice on Necessary Requirements/Formalities,Suggestion of Possible Locations,Details of Policy/Incentives,Suggestion on Potential Projects','1','test','designation','company','123456','test.com','Gujarat','Ahmedabad',NULL);
/*!40000 ALTER TABLE `frontusermaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:48
