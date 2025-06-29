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
-- Table structure for table `blogmasterimages`
--

DROP TABLE IF EXISTS `blogmasterimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogmasterimages` (
  `recid` int NOT NULL AUTO_INCREMENT,
  `BlogMasterId` int DEFAULT NULL,
  `ImageName` longtext,
  `ImagePath` longtext,
  `LanguageId` longtext,
  PRIMARY KEY (`recid`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogmasterimages`
--

LOCK TABLES `blogmasterimages` WRITE;
/*!40000 ALTER TABLE `blogmasterimages` DISABLE KEYS */;
INSERT INTO `blogmasterimages` VALUES (3,1,'hero small.jpg','CouchDB##8aa78fedc80598705024b3f1e019b2e4||2-53dbc7f1bdcb5fa860c207641791a2d1||0509202411371967466312929.jpg',NULL),(8,3,'slider 01.jpg','CouchDB##8aa78fedc80598705024b3f1e019c6cc||2-f6c276098c421b5ef8ddd6e2cdb9556f||0509202411424680108183466.jpg',NULL),(21,7,'33.png','CouchDB##8aa78fedc80598705024b3f1e01ac360||2-9104761da51e7c86b601321a73caff39||0509202403194007177216777.png',NULL),(23,8,'ViewFile.jpg','CouchDB##8aa78fedc80598705024b3f1e01acbbf||2-dbad6c352b69c910e21902b6e3c82007||0509202403242225722984324.jpg',NULL),(24,2,'slider 03.jpg','CouchDB##8aa78fedc80598705024b3f1e019bef8||2-26b84cd1b1a9a8fa45157e6457c7eb21||0509202411410249562616255.jpg',NULL),(28,9,'slider 01.jpg','CouchDB##8aa78fedc80598705024b3f1e01b3af5||2-d5c51ef79b02ca0fd70db2ea1750353b||0509202402301367409950054.jpg',NULL),(32,10,'hero small.jpg','CouchDB##8aa78fedc80598705024b3f1e01b47f0||2-4bebfd75f0d45b6c35547f5d48b8782f||0509202402400163104883780.jpg',NULL),(35,11,'Banana.png','CouchDB##8aa78fedc80598705024b3f1e01db86d||2-d8c2bf76e66a8e5eb5e4798d94a63d34||0609202404370542086909034.png',NULL),(38,4,'blog2.png','CouchDB##8aa78fedc80598705024b3f1e019d21f||2-488463782e37c03e517dd3895dbae6aa||0509202411503357449236358.png',NULL),(39,6,'blog.png','CouchDB##8aa78fedc80598705024b3f1e019e75a||2-74c24d66b4b7c53241bdb44fdbfb9c4f||0509202411551711370013937.png',NULL),(40,5,'date 1.png','CouchDB##8aa78fedc80598705024b3f1e019d960||2-2f01fbe1865b49d05513b8ada896e313||0509202411505462015222565.png',NULL),(42,12,'advocate.png','CouchDB##8aa78fedc80598705024b3f1e0260c2a||2-b9f1295851afc1ea384854e14605648f||1009202411383227441105475.png',NULL),(43,13,'g14.jpg','CouchDB##8aa78fedc80598705024b3f1e02e42e8||2-204c0b4684774a882f896aa774ebdeda||1109202401522311866075920.jpg',NULL),(44,14,'divya.png','CouchDB##8aa78fedc80598705024b3f1e038c83d||2-3c18f93688460720eb233a56a2836bd3||1309202403015457822212908.png',NULL),(45,15,'etv.png','CouchDB##8aa78fedc80598705024b3f1e038ef14||2-22cd76a487cef760a6270f36e04ba4a2||1309202403051851630685637.png',NULL),(46,16,'kamalam.png','CouchDB##8aa78fedc80598705024b3f1e039a754||2-f14f112fb95050b03e968dad914a9e4d||1309202403060885113074259.png',NULL),(47,17,'times.png','CouchDB##8aa78fedc80598705024b3f1e03a60b9||2-54c1ae138c3559118d1ee3bb9432a1c5||1309202403065138356314014.png',NULL),(48,18,'navgujarat.png','CouchDB##8aa78fedc80598705024b3f1e03a7a24||2-ac65e45d917893f39967e4cbdec8a0da||1309202403075278073505117.png',NULL),(49,19,'divya1.png','CouchDB##8aa78fedc80598705024b3f1e03ab0d1||2-91811343899517268d885ed28dc6165e||1309202403084802010699972.png',NULL),(50,20,'gandhi.png','CouchDB##8aa78fedc80598705024b3f1e03b6115||2-34a20d0cdc60aca8a6f68c5b639e5620||1309202403094789213205996.png',NULL),(51,21,'gujarat.png','CouchDB##8aa78fedc80598705024b3f1e03b991b||2-d68760cfbdd5e4d223bd8da9e9831b4a||1309202403102782907207816.png',NULL),(52,22,'gujarat1.png','CouchDB##8aa78fedc80598705024b3f1e03bd4c2||2-58361d10b5bbeef3815b13da32676fe3||1309202403111416568429870.png',NULL),(53,23,'jai.png','CouchDB##8aa78fedc80598705024b3f1e03be966||2-b4afe922c1828f7b6899541ca237f9fa||1309202403114858569568738.png',NULL),(54,24,'soon.png','CouchDB##8aa78fedc80598705024b3f1e0469620||2-210d204d51e4d1bcfac63d2f18da7063||1309202404013256303467195.png',NULL),(55,25,'soon.png','CouchDB##8aa78fedc80598705024b3f1e046ca2a||2-19164132b67530ac917e6acb0624a899||1309202404021131027715598.png',NULL),(56,26,'soon.png','CouchDB##8aa78fedc80598705024b3f1e046e4d7||2-4e19e84650ccc76d7210e69775df8792||1309202404023564752110665.png',NULL),(58,27,'scheme1.jpg','CouchDB##8aa78fedc80598705024b3f1e0483c6d||2-ad799feeac6ce68625f7b1b34edbc32a||1309202404094946538997598.jpg',NULL),(59,28,'scheme2.jpg','CouchDB##8aa78fedc80598705024b3f1e04858c7||2-830f0fda6b5df3f15c41174039dbf041||1309202404121471770483746.jpg',NULL),(66,31,'tur.png','CouchDB##7ce65395c5645b23577736dc0c53bf7c||2-115bf6c9c9ad3901dcb07ccc51fd4bff||2110202412432093854161338.png',NULL),(68,32,'gram.png','CouchDB##7ce65395c5645b23577736dc0c5472a9||2-dab7877cc032ab75b9d6108dabd6f285||2110202401270437085473055.png',NULL),(70,29,'scheme3.jpg','CouchDB##8aa78fedc80598705024b3f1e048e3bd||2-c65c95715aa055077e345787ff35eb82||1309202404131151978921336.jpg',NULL),(72,30,'maize.png','CouchDB##7ce65395c5645b23577736dc0c53b7e2||2-043a60b7d6915c636d04b744ffce05a1||2110202412275161855010249.png',NULL),(100,33,'paranoma2.jpg','CouchDB##a02141439edf967b6ad8b996b26655da||2-26078c0eaf759cfcca4c77a30b486c17||0412202403050172336367497.jpg',NULL),(101,33,'paranoma3.jpg','CouchDB##a02141439edf967b6ad8b996b2665e8e||2-71ae55f3cda8fb979302153cb20a4ca7||0412202403050192064672531.jpg',NULL),(102,33,'paranoma4.jpg','CouchDB##a02141439edf967b6ad8b996b2666958||2-2d4b170eeecbce4ae6dd1cf11942d23b||0412202403050209371450481.jpg',NULL),(103,33,'pan.jpg','CouchDB##a02141439edf967b6ad8b996b269d8e5||2-d88b41723ffb49afecc586e6970efb86||0612202411585689241612861.jpg',NULL),(104,33,'PANO20210805174033.jpg','CouchDB##a02141439edf967b6ad8b996b279e64a||2-6ef5f4e58e166d172a43b47fb1d5a8d9||1112202404245429153122138.jpg',NULL),(110,35,'scroll.png','CouchDB##c1175c034fae114ba83a2c1de9182f9f||2-f7597bd5995192a9f9aa8fa394849723||1912202405155186539217616.png',NULL),(111,35,'sector.png','CouchDB##c1175c034fae114ba83a2c1de91839fc||2-aeae7448e44a2682ee03ef13f7902395||1912202405155203688155239.png',NULL),(112,34,'2.jpg','CouchDB##a02141439edf967b6ad8b996b268a247||2-73f39a0660d3fad6fae1b8a1c9e19aaa||0512202402315874376373246.jpg',NULL),(113,34,'5.jpg','CouchDB##a02141439edf967b6ad8b996b268a99f||2-5818de8b89d597a7ee4064ab7fbcf52b||0512202402320021150842870.jpg',NULL),(114,34,'4.jpg','CouchDB##a02141439edf967b6ad8b996b268b898||2-7867005d77550d5507109daa892dea72||0512202402320068186568756.jpg',NULL),(115,34,'1.jpg','CouchDB##a02141439edf967b6ad8b996b268c389||2-cf4a59d430162d77ab6949f3a11dceb7||0512202402320119971132741.jpg',NULL),(116,34,'3.jpg','CouchDB##a02141439edf967b6ad8b996b268c997||2-ab85328bd73b09085c096d71b996badf||0512202402320168549468667.jpg',NULL),(129,36,'logo.png','CouchDB##f46acb1290c839aeb20c3bd8b837e479||2-4db581f00f2b3636b93a6b446b614ae7||3112202403013511271651765.png',NULL),(130,36,'chilly.png','CouchDB##f46acb1290c839aeb20c3bd8b837f078||2-f4236ca157ba3f88edbb75d334039cff||3112202403042889693277263.png',NULL),(131,36,'fennel.png','CouchDB##f46acb1290c839aeb20c3bd8b837fb85||2-b29ee598aafb1cbd340f0507412349e5||3112202403042917793141531.png',NULL),(132,36,'cummins.png','CouchDB##f46acb1290c839aeb20c3bd8b8380303||2-a53fe208f2ab32f154494393e99a7402||3112202403042941940882279.png',NULL),(137,37,'paranoma.jpg','CouchDB##f46acb1290c839aeb20c3bd8b83fcd5b||2-fc645e8b6dc1033ad54b5c0cd7fc4260||0101202503394348683176675.jpg',NULL),(138,37,'paranoma2.jpg','CouchDB##f46acb1290c839aeb20c3bd8b83fd284||2-f6fa90a97221af1e111f47dc801a2632||0101202503395894052432024.jpg',NULL),(139,37,'paranoma3.jpg','CouchDB##f46acb1290c839aeb20c3bd8b83fe034||2-fc4c2f5e31e3151f009849a15bc4e2a2||0101202503395916079911891.jpg',NULL),(140,37,'paranoma4.jpg','CouchDB##f46acb1290c839aeb20c3bd8b83feca6||2-825d8d3eb734980037ef38088768a9b8||0101202503395925952970462.jpg',NULL);
/*!40000 ALTER TABLE `blogmasterimages` ENABLE KEYS */;
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
