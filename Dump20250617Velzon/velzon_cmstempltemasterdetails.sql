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
-- Table structure for table `cmstempltemasterdetails`
--

DROP TABLE IF EXISTS `cmstempltemasterdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmstempltemasterdetails` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `LanguageId` int DEFAULT NULL,
  `TemplateId` int DEFAULT NULL,
  `TemplateName` text,
  `Content` text,
  `IsDelete` tinyint DEFAULT '0',
  `IsActive` tinyint DEFAULT '1',
  `CreatedBy` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime(3) DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL,
  `UpdatedDate` datetime(3) DEFAULT NULL,
  `DeletedBy` varchar(50) DEFAULT NULL,
  `DeletedDate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmstempltemasterdetails`
--

LOCK TABLES `cmstempltemasterdetails` WRITE;
/*!40000 ALTER TABLE `cmstempltemasterdetails` DISABLE KEYS */;
INSERT INTO `cmstempltemasterdetails` VALUES (1,1,1,'HeaderDesign','<ul class=\"pbmit-top-links\">\r\n	<li>\r\n	<ul class=\"pbmit-social-links\">\r\n		<li class=\"pbmit-social-li pbmit-social-facebook \"><a href=\"/index\" target=\"_blank\" title=\"Home\"><span><i class=\"fa fa-home\"></i></span> </a></li>\r\n		<li class=\"pbmit-social-li pbmit-social-twitter \"><a href=\"/FeedBack\" target=\"_blank\" title=\"Feedback\"><span><i class=\"fa fa-envelope\"></i></span> </a></li>\r\n		<li class=\"pbmit-social-li pbmit-social-instagram \"><a href=\"/Home/ContactUs\" target=\"_blank\" title=\"Contact us\"><span><i class=\"fa fa-phone\"></i></span> </a></li>\r\n		<li class=\"pbmit-social-li pbmit-social-youtube \"><a href=\"/Sitemap\" target=\"_blank\" title=\"Sitemap\"><span><i class=\"fa fa-sitemap\"></i></span> </a></li>\r\n	</ul>\r\n	</li>\r\n</ul>\r\n',0,1,'superadmin','2025-02-10 13:23:14.000','admin','2025-03-04 12:10:27.000',NULL,NULL),(2,1,2,'MainLogo','<div class=\"container\">\r\n<div class=\"d-flex align-items-center justify-content-between\">\r\n<div class=\"site-branding\"><a href=\"/index\"><img alt=\"#\" class=\"logo-img\" src=\"/ViewFile?fileName=PD03hA99Q✤UVlg3Pl9enHRcbTa7aqO52fdGviSZ030w✤zrR5OPeqg✿EVtiSERoxr3TzG9OveP9FQ0d8Q9gaJ5G1ogKZDIP✤mxjAkCcqhsuHqx82cQ58T5bGtnaAuSZObeNqJmRQwOck7heQdjYTyfA♬♬\" /> </a>\r\n<div class=\"logotitle\">\r\n<h5>Gujarat Mineral Research &amp; Development Soceity</h5>\r\n\r\n<p>Industries &amp; Mines Department<br />\r\nCommisioner of Geology &amp; Mining, Gandhinagar<br />\r\nGovt.of Gujarat</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pbmit-header-info d-flex align-items-center\"><a class=\"pbmit-btn pbmit-btn-outline loginbtn\" href=\"#\"><span>Login</span> </a></div>\r\n</div>\r\n</div>\r\n',0,1,'superadmin','2025-02-10 13:24:52.000','admin','2025-03-04 11:44:32.000',NULL,NULL),(3,1,3,'WelcomeNote','<div class=\"pbmit-heading-subheading text-right\">\r\n<h4 class=\"pbmit-subtitle\">About Us</h4>\r\n\r\n<h2 class=\"pbmit-title\">Welcome to GMRDS</h2>\r\n</div>\r\n\r\n<p>The GMRDS is formed in the year 2002 to support the mineral industries and to provide the technical support for mineral administration under control of Commissionrate of Geology &amp; Mining/Industry and Mines. There are many aspects of mineral development attended, including mining companies, governments, aid agencies, non-governmental organizations (NGOs), academics and consultants. Mining is an ancient human activity developed through essential societal demand. As society and technology have developed, they have inevitably become ever-more materials hungry. This demand will remain for the foreseeable future. Many areas of the Developed World have depleted high-grade mineral deposits, and remaining resources are subject to strong environmental constraints.</p>\r\n\r\n<p><a class=\"pbmit-btn\" href=\"#\"><span>Read More</span> </a></p>\r\n',0,1,'superadmin','2025-02-11 13:13:57.000','admin','2025-02-13 10:53:15.000',NULL,NULL),(4,1,4,'FooterDesign','<div class=\"col-lg-4\">\r\n<div class=\"pbmit-first-widget pbmit-widget\">\r\n<div class=\"footer-logo\">\r\n<h5>GUJARAT MINERAL RESEARCH &amp; DEVELOPMENT SOCIETY</h5>\r\n</div>\r\n\r\n<p class=\"text\">We are the leaders in the building industries and factories. We&rsquo;re world wide. We never give up on the challenges.</p>\r\n\r\n<div class=\"pbmit-free-call-box\"><i class=\"pbmit-base-icon-phone-call\"></i>\r\n\r\n<div class=\"pbmit-call-text\">Talk To Our Support\r\n<h3>079-23271010</h3>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-lg-2\">\r\n<div class=\"pbmit-two-widget pbmit-widget\">\r\n<h2 class=\"widget-title\">Important Links</h2>\r\n\r\n<div class=\"menu-services-menu-container\">\r\n<ul class=\"menu\" id=\"menu-services-menu_1\">\r\n	<li class=\"menu-item\" id=\"menu-item-11\"><a href=\"/Home/TermsandConditions\">Terms &amp; Conditions</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-22\"><a href=\"/Home/PrivacyPolicy\">Privacy Policy</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-33\"><a href=\"/Home/CopyrightPolicy\">Copyright Policy</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-44\"><a href=\"/Home/HyperlinkPolicy\">Hyperlinking Policy</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-55\"><a href=\"/Home/Disclaimer\">Disclaimer</a></li>\r\n</ul>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-lg-2\">\r\n<div class=\"pbmit-two-widget pbmit-widget\">\r\n<h2 class=\"widget-title\">Quick Links</h2>\r\n\r\n<div class=\"menu-services-menu-container\">\r\n<ul class=\"menu\" id=\"menu-services-menu_1\">\r\n	<li class=\"menu-item\" id=\"menu-item-11\"><a href=\"/ProjectList\">Project</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-22\"><a href=\"#\">Registration</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-33\"><a href=\"/News\">News</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-44\"><a href=\"/FeedBack\">Feedback</a></li>\r\n	<li class=\"menu-item\" id=\"menu-item-55\"><a href=\"#\">Testing Rates</a></li>\r\n</ul>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-lg-4\">\r\n<div class=\"pbmit-three-widget pbmit-widget\">\r\n<h2 class=\"widget-title\">Address</h2>\r\n\r\n<div class=\"f-item address\">\r\n<ul>\r\n	<li><i class=\"fas fa-map\"></i>\r\n\r\n	<p><span>Petrography &amp; Mineral Chemistry Laboratory Nr. P.D.P.U, near Solar Park Puri Foundation, Raysan, Gandhinagar </span></p>\r\n	</li>\r\n	<li><i class=\"fas fa-envelope\"></i>\r\n	<p><span>exemple[at]gujarat[dot]gov[dot]in</span></p>\r\n	</li>\r\n	<li><i class=\"fas fa-mobile-alt\"></i>\r\n	<p><span>079-23271010</span></p>\r\n	</li>\r\n</ul>\r\n</div>\r\n</div>\r\n</div>\r\n',0,1,'superadmin','2025-02-11 13:29:54.000','admin','2025-02-21 16:40:55.000',NULL,NULL),(5,1,5,'ServiceRate','<article class=\"pbmit-miconheading-style-11 col-lg-3 col-md-6 pbmit-mihbox-hover-active\">\r\n				<div class=\"pbmit-ihbox pbmit-ihbox-style-1\">\r\n					<div class=\"pbmit-ihbox-box\">\r\n						<div class=\"pbmit-ihbox-icon\">\r\n							<div class=\"pbmit-ihbox-icon-wrapper\">\r\n								<i class=\"pbmit-colza-icon pbmit-colza-icon-miner\"></i>\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-contents\">\r\n							<h2 class=\"pbmit-element-title\">Testing Rates</h2>\r\n							<div class=\"pbmit-heading-desc\">\r\n								There are many variations of passa ges of Lorem.\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-btn\">\r\n							<a href=\"#\"><span>Read More</span></a>\r\n						</div>\r\n					</div>\r\n				</div>\r\n</article>\r\n<article class=\"pbmit-miconheading-style-11 col-lg-3 col-md-6\">\r\n				<div class=\"pbmit-ihbox pbmit-ihbox-style-1\">\r\n					<div class=\"pbmit-ihbox-box\">\r\n						<div class=\"pbmit-ihbox-icon\">\r\n							<div class=\"pbmit-ihbox-icon-wrapper\">\r\n								<i class=\"pbmit-colza-icon pbmit-colza-icon-weight-scale\"></i>\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-contents\">\r\n							<h2 class=\"pbmit-element-title\">Registration</h2>\r\n							<div class=\"pbmit-heading-desc\">\r\n								There are many variations of passa ges of Lorem.\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-btn\">\r\n							<a href=\"#\"><span>Read More</span></a>\r\n						</div>\r\n					</div>\r\n				</div>\r\n</article>\r\n<article class=\"pbmit-miconheading-style-11 col-lg-3 col-md-6\">\r\n				<div class=\"pbmit-ihbox pbmit-ihbox-style-1\">\r\n					<div class=\"pbmit-ihbox-box\">\r\n						<div class=\"pbmit-ihbox-icon\">\r\n							<div class=\"pbmit-ihbox-icon-wrapper\">\r\n								<i class=\"pbmit-colza-icon pbmit-colza-icon-gold-ingots\"></i>\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-contents\">\r\n							<h2 class=\"pbmit-element-title\">Reports</h2>\r\n							<div class=\"pbmit-heading-desc\">\r\n								There are many variations of passa ges of Lorem.\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-btn\">\r\n							<a href=\"#\"><span>Read More</span></a>\r\n						</div>\r\n					</div>\r\n				</div>\r\n</article>\r\n<article class=\"pbmit-miconheading-style-11 col-lg-3 col-md-6\">\r\n				<div class=\"pbmit-ihbox pbmit-ihbox-style-1\">\r\n					<div class=\"pbmit-ihbox-box\">\r\n						<div class=\"pbmit-ihbox-icon\">\r\n							<div class=\"pbmit-ihbox-icon-wrapper\">\r\n								<i class=\"pbmit-colza-icon pbmit-colza-icon-factory\"></i>\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-contents\">\r\n							<h2 class=\"pbmit-element-title\">Opportunities</h2>\r\n							<div class=\"pbmit-heading-desc\">\r\n								There are many variations of passa ges of Lorem.\r\n							</div>\r\n						</div>\r\n						<div class=\"pbmit-ihbox-btn\">\r\n							<a href=\"#\"><span>Read More</span></a>\r\n						</div>\r\n					</div>\r\n				</div>\r\n</article>',0,1,'admin','2025-02-12 12:52:19.000',NULL,NULL,NULL,NULL),(6,1,6,'HiddenTemplate','<p>test</p>\r\n',0,1,'superadmin','2025-02-19 12:42:02.000','superadmin','2025-04-09 17:59:49.000',NULL,NULL),(7,1,7,'sdfsdfllll','<p>fghfghfghllll eng</p>\r\n',1,0,'superadmin','2025-04-09 17:47:41.000','superadmin','2025-04-09 17:59:28.000','superadmin','2025-04-09 17:59:44.000'),(8,1,8,'sdfsd','<p>fsdf</p>\r\n',1,0,'superadmin','2025-04-09 17:48:12.000',NULL,NULL,'superadmin','2025-04-09 17:59:41.000'),(9,1,9,'dfgdfgfdg',NULL,1,0,'superadmin','2025-04-09 17:50:36.000',NULL,NULL,'superadmin','2025-04-09 17:59:39.000'),(10,1,10,'sdfsdf','<p>sdfsdfsdfsdfsdf</p>\r\n',1,0,'superadmin','2025-04-09 17:50:43.000',NULL,NULL,'superadmin','2025-04-09 17:59:37.000'),(11,2,7,'sdfsdfllll','<p>fghfghfghllll guj 1</p>\r\n',1,0,'superadmin','2025-04-09 17:56:15.000','superadmin','2025-04-09 17:59:28.000','superadmin','2025-04-09 17:59:44.000'),(12,1,11,'fghfghfg',NULL,1,0,'superadmin','2025-04-09 18:01:42.000',NULL,NULL,'superadmin','2025-04-09 18:01:49.000'),(13,1,12,'sdfsdf','<p>sdfsdf</p>\r\n',1,0,'superadmin','2025-04-28 13:24:51.000','superadmin','2025-04-28 13:24:59.000','superadmin','2025-04-28 13:25:02.000');
/*!40000 ALTER TABLE `cmstempltemasterdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:49
