-- MySQL dump 10.13  Distrib 5.7.37, for Linux (x86_64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	5.7.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Basket`
--

DROP TABLE IF EXISTS `Basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(256) DEFAULT NULL,
  `cdate` datetime NOT NULL,
  `num` int(11) NOT NULL,
  `data` mediumblob,
  `userId` int(11) NOT NULL,
  `multiDistribId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Basket_ref` (`ref`),
  KEY `Basket_user` (`userId`),
  KEY `Basket_multiDistrib` (`multiDistribId`),
  CONSTRAINT `Basket_multiDistrib` FOREIGN KEY (`multiDistribId`) REFERENCES `MultiDistrib` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Basket_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Basket`
--

LOCK TABLES `Basket` WRITE;
/*!40000 ALTER TABLE `Basket` DISABLE KEYS */;
INSERT INTO `Basket` VALUES (1,NULL,'2022-04-13 11:49:52',1,NULL,2,161);
/*!40000 ALTER TABLE `Basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BufferedMail`
--

DROP TABLE IF EXISTS `BufferedMail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BufferedMail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `htmlBody` mediumtext,
  `textBody` mediumtext,
  `headers` mediumblob NOT NULL,
  `sender` mediumblob NOT NULL,
  `recipients` mediumblob NOT NULL,
  `mailerType` varchar(32) NOT NULL,
  `tries` int(11) NOT NULL,
  `cdate` datetime NOT NULL,
  `sdate` datetime DEFAULT NULL,
  `rawStatus` mediumtext,
  `status` mediumblob,
  `data` mediumblob,
  `remoteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `BufferedMail_remoteId_sdate_cdate` (`remoteId`,`sdate`,`cdate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BufferedMail`
--

LOCK TABLES `BufferedMail` WRITE;
/*!40000 ALTER TABLE `BufferedMail` DISABLE KEYS */;
/*!40000 ALTER TABLE `BufferedMail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cache`
--

DROP TABLE IF EXISTS `Cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cache` (
  `name` varchar(128) NOT NULL,
  `value` mediumtext NOT NULL,
  `expire` datetime NOT NULL,
  `cdate` datetime DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cache`
--

LOCK TABLES `Cache` WRITE;
/*!40000 ALTER TABLE `Cache` DISABLE KEYS */;
INSERT INTO `Cache` VALUES ('productsExcerpt161','aoy4:namey10:Lait%20cruy3:ridi408y5:imagey41:%2Fimg%2Ftaxo%2Fgrey%2Ffruits-legumes.pnggoR0y39:Courlis%20doux%20-%20Tomme%20de%20vacheR2i373R3R4goR0y42:Fromage%20blanc%20%C3%A0%20la%20cr%C3%A8meR2i324R3R4goR0y5:SkyyrR2i131R3R4goR0y41:Fromage%20de%20ch%C3%A8vre%20-%20demi-secR2i60R3R4goR0y7:EpinardR2i16R3R4gh','2022-04-14 19:55:47','2022-04-14 07:55:47'),('productsExcerpt162','aoy4:namey39:Courlis%20doux%20-%20Tomme%20de%20vachey3:ridi499y5:imagey41:%2Fimg%2Ftaxo%2Fgrey%2Ffruits-legumes.pnggoR0y7:EpinardR2i455R3R4goR0y41:Fromage%20de%20ch%C3%A8vre%20-%20demi-secR2i360R3R4goR0y42:Fromage%20blanc%20%C3%A0%20la%20cr%C3%A8meR2i315R3R4goR0y5:SkyyrR2i27R3R4goR0y10:Lait%20cruR2i10R3R4gh','2022-04-22 05:46:39','2022-04-21 17:46:39'),('productsExcerpt163','aoy4:namey41:Fromage%20de%20ch%C3%A8vre%20-%20demi-secy3:ridi443y5:imagey41:%2Fimg%2Ftaxo%2Fgrey%2Ffruits-legumes.pnggoR0y39:Courlis%20doux%20-%20Tomme%20de%20vacheR2i382R3R4goR0y7:EpinardR2i325R3R4goR0y10:Lait%20cruR2i304R3R4goR0y42:Fromage%20blanc%20%C3%A0%20la%20cr%C3%A8meR2i277R3R4goR0y5:SkyyrR2i144R3R4gh','2022-04-22 05:46:39','2022-04-21 17:46:39');
/*!40000 ALTER TABLE `Cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Catalog`
--

DROP TABLE IF EXISTS `Catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Catalog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `description` mediumtext,
  `distributorNum` tinyint(4) NOT NULL,
  `flags` int(11) NOT NULL,
  `percentageValue` double DEFAULT NULL,
  `percentageName` varchar(64) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `vendorId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Catalog_startDate_endDate` (`startDate`,`endDate`),
  KEY `Catalog_contact` (`userId`),
  KEY `Catalog_vendor` (`vendorId`),
  KEY `Catalog_group` (`groupId`),
  CONSTRAINT `Catalog_contact` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Catalog_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Catalog_vendor` FOREIGN KEY (`vendorId`) REFERENCES `Vendor` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Catalog`
--

LOCK TABLES `Catalog` WRITE;
/*!40000 ALTER TABLE `Catalog` DISABLE KEYS */;
INSERT INTO `Catalog` VALUES (4,'Ferme Adiiris','2022-04-13 00:00:00','2023-04-13 23:59:59',NULL,0,3,NULL,NULL,1,1,4,1),(5,'Ferme du Jointout','2022-04-13 00:00:00','2023-04-12 23:59:59',NULL,0,3,NULL,NULL,1,1,5,1);
/*!40000 ALTER TABLE `Catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `categoryGroupId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Category_categoryGroup` (`categoryGroupId`),
  CONSTRAINT `Category_categoryGroup` FOREIGN KEY (`categoryGroupId`) REFERENCES `CategoryGroup` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CategoryGroup`
--

DROP TABLE IF EXISTS `CategoryGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CategoryGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `color` tinyint(4) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `amapId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CategoryGroup_amap` (`amapId`),
  CONSTRAINT `CategoryGroup_amap` FOREIGN KEY (`amapId`) REFERENCES `Group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CategoryGroup`
--

LOCK TABLES `CategoryGroup` WRITE;
/*!40000 ALTER TABLE `CategoryGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `CategoryGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Distribution`
--

DROP TABLE IF EXISTS `Distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Distribution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `orderStartDate` datetime DEFAULT NULL,
  `orderEndDate` datetime DEFAULT NULL,
  `catalogId` int(11) NOT NULL,
  `multiDistribId` int(11) NOT NULL,
  `placeId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Distribution_date_orderStartDate_orderEndDate` (`date`,`orderStartDate`,`orderEndDate`),
  KEY `Distribution_catalog` (`catalogId`),
  KEY `Distribution_multiDistrib` (`multiDistribId`),
  KEY `Distribution_place` (`placeId`),
  CONSTRAINT `Distribution_catalog` FOREIGN KEY (`catalogId`) REFERENCES `Catalog` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Distribution_multiDistrib` FOREIGN KEY (`multiDistribId`) REFERENCES `MultiDistrib` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Distribution_place` FOREIGN KEY (`placeId`) REFERENCES `Place` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Distribution`
--

LOCK TABLES `Distribution` WRITE;
/*!40000 ALTER TABLE `Distribution` DISABLE KEYS */;
INSERT INTO `Distribution` VALUES (19,'2022-04-17 19:00:00','2022-04-17 20:00:00','2022-04-10 08:00:00','2022-04-16 23:55:00',4,161,2),(20,'2022-04-17 19:00:00','2022-04-17 20:00:00','2022-04-10 08:00:00','2022-04-16 23:55:00',5,161,2),(21,'2022-04-22 19:00:00','2022-04-22 20:00:00','2022-04-17 08:00:00','2022-04-20 23:55:00',5,162,2),(22,'2022-04-22 19:00:00','2022-04-22 20:00:00','2022-04-17 08:00:00','2022-04-20 23:55:00',4,162,2),(23,'2022-04-29 19:00:00','2022-04-29 20:00:00','2022-04-24 08:00:00','2022-04-27 23:55:00',5,163,2),(24,'2022-04-29 19:00:00','2022-04-29 20:00:00','2022-04-24 08:00:00','2022-04-27 23:55:00',4,163,2),(25,'2022-05-06 19:00:00','2022-05-06 20:00:00','2022-05-01 08:00:00','2022-05-04 23:55:00',5,164,2),(26,'2022-05-06 19:00:00','2022-05-06 20:00:00','2022-05-01 08:00:00','2022-05-04 23:55:00',4,164,2),(27,'2022-05-13 19:00:00','2022-05-13 20:00:00','2022-05-08 08:00:00','2022-05-11 23:55:00',5,165,2),(28,'2022-05-13 19:00:00','2022-05-13 20:00:00','2022-05-08 08:00:00','2022-05-11 23:55:00',4,165,2);
/*!40000 ALTER TABLE `Distribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DistributionCycle`
--

DROP TABLE IF EXISTS `DistributionCycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DistributionCycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cycleType` tinyint(3) unsigned NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `startHour` datetime NOT NULL,
  `endHour` datetime NOT NULL,
  `daysBeforeOrderStart` tinyint(4) DEFAULT NULL,
  `daysBeforeOrderEnd` tinyint(4) DEFAULT NULL,
  `openingHour` date DEFAULT NULL,
  `closingHour` date DEFAULT NULL,
  `groupId` int(11) NOT NULL,
  `placeId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `DistributionCycle_group` (`groupId`),
  KEY `DistributionCycle_place` (`placeId`),
  CONSTRAINT `DistributionCycle_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `DistributionCycle_place` FOREIGN KEY (`placeId`) REFERENCES `Place` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DistributionCycle`
--

LOCK TABLES `DistributionCycle` WRITE;
/*!40000 ALTER TABLE `DistributionCycle` DISABLE KEYS */;
INSERT INTO `DistributionCycle` VALUES (4,0,'2022-04-15','2022-05-13','2022-04-03 19:00:00','2022-04-03 20:00:00',5,2,'2022-04-03','2022-04-03',1,2);
/*!40000 ALTER TABLE `DistributionCycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EntityFile`
--

DROP TABLE IF EXISTS `EntityFile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EntityFile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityType` varchar(64) NOT NULL,
  `documentType` varchar(64) NOT NULL,
  `data` varchar(128) DEFAULT NULL,
  `entityId` int(11) NOT NULL,
  `fileId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `EntityFile_fileId_entityType_entityId` (`fileId`,`entityType`,`entityId`),
  CONSTRAINT `EntityFile_file` FOREIGN KEY (`fileId`) REFERENCES `File` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EntityFile`
--

LOCK TABLES `EntityFile` WRITE;
/*!40000 ALTER TABLE `EntityFile` DISABLE KEYS */;
/*!40000 ALTER TABLE `EntityFile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Error`
--

DROP TABLE IF EXISTS `Error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `error` mediumtext NOT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `userAgent` varchar(256) DEFAULT NULL,
  `url` tinytext,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Error_date` (`date`),
  KEY `Error_user` (`uid`),
  CONSTRAINT `Error_user` FOREIGN KEY (`uid`) REFERENCES `User` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Error`
--

LOCK TABLES `Error` WRITE;
/*!40000 ALTER TABLE `Error` DISABLE KEYS */;
INSERT INTO `Error` VALUES (1,'2022-04-12 11:46:17','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install/firstInstall',NULL),(2,'2022-04-12 11:46:21','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install/firstInstall',NULL),(3,'2022-04-12 11:46:25','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(4,'2022-04-12 11:46:27','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(5,'2022-04-12 11:47:05','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(6,'2022-04-12 11:47:06','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(7,'2022-04-12 11:47:07','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(8,'2022-04-12 11:47:07','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(9,'2022-04-12 11:47:07','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(10,'2022-04-12 11:48:07','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(11,'2022-04-12 14:54:14','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(12,'2022-04-12 14:54:16','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(13,'2022-04-12 14:55:50','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(14,'2022-04-12 14:55:50','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(15,'2022-04-12 14:55:50','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(16,'2022-04-12 14:55:51','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(17,'2022-04-12 14:55:55','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(18,'2022-04-12 14:55:57','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/form.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/install',NULL),(19,'2022-04-12 14:57:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(20,'2022-04-13 07:56:48','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(21,'2022-04-13 08:00:59','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(22,'2022-04-13 08:04:16','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(23,'2022-04-13 08:04:19','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(24,'2022-04-13 08:04:19','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(25,'2022-04-13 08:04:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(26,'2022-04-13 08:04:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(27,'2022-04-13 08:04:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(28,'2022-04-13 08:04:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(29,'2022-04-13 08:04:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(30,'2022-04-13 08:04:20','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(31,'2022-04-13 08:08:58','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(32,'2022-04-13 08:09:00','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(33,'2022-04-13 08:09:00','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(34,'2022-04-13 08:09:00','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(35,'2022-04-13 08:09:01','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(36,'2022-04-13 08:09:01','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/home.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/home',NULL),(37,'2022-04-13 08:12:06','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(38,'2022-04-13 08:12:09','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(39,'2022-04-13 08:13:25','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(40,'2022-04-13 08:13:27','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(41,'2022-04-13 08:13:27','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(42,'2022-04-13 08:13:27','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(43,'2022-04-13 08:13:28','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(44,'2022-04-13 08:13:28','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(45,'2022-04-13 08:14:11','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(46,'2022-04-13 08:19:33','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(47,'2022-04-13 08:19:35','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(48,'2022-04-13 09:26:39','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(49,'2022-04-13 09:28:27','load.c(181) : Module not found : /var/www/cagette/www/../lang/en/tmp/user__login.mtt.n\n\nCalled from templo/Loader.hx line 132\nCalled from templo/Loader.hx line 135\nCalled from templo/Loader.hx line 70\nCalled from a C function\nCalled from templo/Loader.hx line 54\nCalled from sugoi/BaseApp.hx line 66\nCalled from sugoi/BaseApp.hx line 73\nCalled from sugoi/BaseApp.hx line 128\nCalled from haxe/web/Dispatch.hx line 251\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 133\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 233\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.24.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/user/login',NULL),(50,'2022-04-13 11:11:49','Invalid call\n\nCalled from contractadmin/defineVendor.mtt line 17\nCalled from templo/Loader.hx line 195\nCalled from contractadmin/defineVendor.mtt line 15\nCalled from templo/Loader.hx line 209\nCalled from templo/Loader.hx line 77\nCalled from templo/Loader.hx line 80\nCalled from sugoi/BaseApp.hx line 116\nCalled from sugoi/BaseApp.hx line 286\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.23.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/contract/defineVendor/',1),(51,'2022-04-13 11:15:18','DEInvalidValue\n\nCalled from haxe/web/Dispatch.hx line 208\nCalled from haxe/web/Dispatch.hx line 237\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 238\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 250\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.23.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/distribution/deleteMd/9',1),(52,'2022-04-13 11:49:46','DEInvalidValue\n\nCalled from haxe/web/Dispatch.hx line 199\nCalled from haxe/web/Dispatch.hx line 213\nCalled from haxe/web/Dispatch.hx line 240\nCalled from haxe/web/Dispatch.hx line 242\nCalled from haxe/web/Dispatch.hx line 127\nCalled from controller/Main.hx line 280\nCalled from a C function\nCalled from haxe/web/Dispatch.hx line 132\nCalled from haxe/web/Dispatch.hx line 131\nCalled from sugoi/BaseApp.hx line 243\nCalled from sugoi/BaseApp.hx line 250\nCalled from a C function\nCalled from App.hx line 59\nCalled from sugoi/BaseApp.hx line 403\nCalled from sys/db/Transaction.hx line 32\n','172.23.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36','/contractAdmin/ordersByDate/2022-04-15/null',1);
/*!40000 ALTER TABLE `Error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `cdate` datetime NOT NULL,
  `data` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `File_cdate` (`cdate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Graph`
--

DROP TABLE IF EXISTS `Graph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Graph` (
  `key` varchar(128) NOT NULL,
  `date` date NOT NULL,
  `value` double NOT NULL,
  PRIMARY KEY (`key`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Graph`
--

LOCK TABLES `Graph` WRITE;
/*!40000 ALTER TABLE `Graph` DISABLE KEYS */;
/*!40000 ALTER TABLE `Graph` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group`
--

DROP TABLE IF EXISTS `Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `txtIntro` mediumtext,
  `txtHome` mediumtext,
  `txtDistrib` mediumtext,
  `extUrl` varchar(64) DEFAULT NULL,
  `membershipRenewalDate` date DEFAULT NULL,
  `membershipFee` tinyint(4) DEFAULT NULL,
  `vatRates` mediumblob NOT NULL,
  `flags` int(11) NOT NULL,
  `betaFlags` int(11) NOT NULL,
  `hasMembership` tinyint(1) NOT NULL,
  `groupType` tinyint(3) unsigned DEFAULT NULL,
  `cdate` datetime NOT NULL,
  `regOption` tinyint(3) unsigned NOT NULL,
  `currency` varchar(12) NOT NULL,
  `currencyCode` varchar(3) NOT NULL,
  `allowedPaymentsType` mediumblob,
  `checkOrder` varchar(64) DEFAULT NULL,
  `IBAN` varchar(40) DEFAULT NULL,
  `allowMoneyPotWithNegativeBalance` tinyint(1) DEFAULT NULL,
  `volunteersMailDaysBeforeDutyPeriod` tinyint(4) NOT NULL,
  `volunteersMailContent` mediumtext NOT NULL,
  `vacantVolunteerRolesMailDaysBeforeDutyPeriod` tinyint(4) NOT NULL,
  `daysBeforeDutyPeriodsOpen` int(11) NOT NULL,
  `alertMailContent` mediumtext NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `imageId` int(11) DEFAULT NULL,
  `placeId` int(11) DEFAULT NULL,
  `legalReprId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Group_contact` (`userId`),
  KEY `Group_image` (`imageId`),
  KEY `Group_mainPlace` (`placeId`),
  KEY `Group_legalRepresentative` (`legalReprId`),
  CONSTRAINT `Group_contact` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Group_image` FOREIGN KEY (`imageId`) REFERENCES `File` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Group_legalRepresentative` FOREIGN KEY (`legalReprId`) REFERENCES `User` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Group_mainPlace` FOREIGN KEY (`placeId`) REFERENCES `Place` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group`
--

LOCK TABLES `Group` WRITE;
/*!40000 ALTER TABLE `Group` DISABLE KEYS */;
INSERT INTO `Group` VALUES (1,'Alterconso du Val de Brenne',NULL,'Welcome in the group of Alterconso du Val de Brenne!\n You can look at the delivery planning or make a new order.',NULL,NULL,NULL,NULL,_binary 'by5:20%25i20y8:5%2C5%25d5.5h',18,1,1,NULL,'2022-04-13 09:30:56',2,'â‚¬','EUR',NULL,'',NULL,NULL,4,'<b>Rappel : Vous Ãªtes inscrit(e) Ã  la permanence du [DATE_DISTRIBUTION],</b><br/>\n		Lieu de distribution : [LIEU_DISTRIBUTION]<br/>\n		<br/>\n		Voici la liste des bÃ©nÃ©voles inscrits :<br/>\n		[LISTE_BENEVOLES]<br/>',7,60,'Nous avons besoin de <b>bÃ©nÃ©voles pour la permanence du [DATE_DISTRIBUTION]</b><br/>\n		Lieu de distribution : [LIEU_DISTRIBUTION]<br/>\n		Les roles suivants sont Ã  pourvoir :<br/>\n		[ROLES_MANQUANTS]<br/>\n		Cliquez sur \"calendrier des permanences\" pour vous inscrire !',1,NULL,2,NULL);
/*!40000 ALTER TABLE `Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Membership`
--

DROP TABLE IF EXISTS `Membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Membership` (
  `amount` double NOT NULL,
  `year` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `distributionId` int(11) DEFAULT NULL,
  `operationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`,`groupId`,`year`),
  KEY `Membership_group` (`groupId`),
  KEY `Membership_distribution` (`distributionId`),
  KEY `Membership_operation` (`operationId`),
  CONSTRAINT `Membership_distribution` FOREIGN KEY (`distributionId`) REFERENCES `MultiDistrib` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Membership_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Membership_operation` FOREIGN KEY (`operationId`) REFERENCES `Operation` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Membership_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Membership`
--

LOCK TABLES `Membership` WRITE;
/*!40000 ALTER TABLE `Membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `Membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message`
--

DROP TABLE IF EXISTS `Message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipientListId` varchar(12) DEFAULT NULL,
  `recipients` mediumblob,
  `title` varchar(128) NOT NULL,
  `body` mediumtext NOT NULL,
  `date` datetime NOT NULL,
  `amapId` int(11) DEFAULT NULL,
  `senderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Message_amap` (`amapId`),
  KEY `Message_sender` (`senderId`),
  CONSTRAINT `Message_amap` FOREIGN KEY (`amapId`) REFERENCES `Group` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Message_sender` FOREIGN KEY (`senderId`) REFERENCES `User` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message`
--

LOCK TABLES `Message` WRITE;
/*!40000 ALTER TABLE `Message` DISABLE KEYS */;
INSERT INTO `Message` VALUES (1,'1',_binary 'ay26:oceanep.lilas%40riseup.nety28:guillaume.penaud%40gmail.comy19:admin%40cagette.neth','Test','<style>\ntable.table{\n    border-collapse: collapse;\n}\n\ntable.table td{\n	border: 1px solid #ddd;\n	padding: 6px;\n}    \n</style>\n\n	\n<div>\n	\n\n\n<p>test</p>\n\n\n\n\n</div>\n\n<hr/>\n\n<div style=\"color:#666;font-size:12px;\">\n\n	<!-- btn -->\n	\n	<div style=\"width:50%;max-width:300px;margin: 12px auto;padding: 8px;text-decoration: none;background: #070;border-radius: 3px;text-align: center;\">\n		<a href=\"http://localhost/group/1\" style=\"color: white;font-weight: bold;text-decoration: none;font-size:1.2em;\">\n			&rarr; Alterconso du Val de Brenne\n		</a>\n	</div>\n	\n\n	Cet email a Ã©tÃ© envoyÃ© depuis <a href=\"http://localhost\">Cagette.net</a>.\n\n	\n		<br/>\n		Vous recevez ce message car vous faites partie de <b>Alterconso du Val de Brenne</b>\n		 ( Tout le monde ) \n		<br/>\n		\n	\n\n	\n\n	\n\n</div>','2022-04-13 11:46:09',1,1);
/*!40000 ALTER TABLE `Message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MultiDistrib`
--

DROP TABLE IF EXISTS `MultiDistrib`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MultiDistrib` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distribStartDate` datetime NOT NULL,
  `distribEndDate` datetime NOT NULL,
  `orderStartDate` datetime DEFAULT NULL,
  `orderEndDate` datetime DEFAULT NULL,
  `slotsMode` mediumblob,
  `slots` mediumblob,
  `inNeedUserIds` mediumblob,
  `voluntaryUsers` mediumblob,
  `counterBeforeDistrib` double NOT NULL,
  `volunteerRolesIds` mediumtext,
  `validated` tinyint(1) DEFAULT NULL,
  `groupId` int(11) NOT NULL,
  `placeId` int(11) NOT NULL,
  `distributionCycleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `MultiDistrib_distribStartDate` (`distribStartDate`),
  KEY `MultiDistrib_group` (`groupId`),
  KEY `MultiDistrib_place` (`placeId`),
  KEY `MultiDistrib_distributionCycle` (`distributionCycleId`),
  CONSTRAINT `MultiDistrib_distributionCycle` FOREIGN KEY (`distributionCycleId`) REFERENCES `DistributionCycle` (`id`) ON DELETE SET NULL,
  CONSTRAINT `MultiDistrib_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `MultiDistrib_place` FOREIGN KEY (`placeId`) REFERENCES `Place` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MultiDistrib`
--

LOCK TABLES `MultiDistrib` WRITE;
/*!40000 ALTER TABLE `MultiDistrib` DISABLE KEYS */;
INSERT INTO `MultiDistrib` VALUES (161,'2022-04-17 19:00:00','2022-04-17 20:00:00','2022-04-10 08:00:00','2022-04-16 23:55:00',NULL,_binary 'n',NULL,NULL,0,'2',0,1,2,4),(162,'2022-04-22 19:00:00','2022-04-22 20:00:00','2022-04-17 08:00:00','2022-04-20 23:55:00',NULL,NULL,NULL,NULL,0,'2',0,1,2,4),(163,'2022-04-29 19:00:00','2022-04-29 20:00:00','2022-04-24 08:00:00','2022-04-27 23:55:00',NULL,NULL,NULL,NULL,0,'2',0,1,2,4),(164,'2022-05-06 19:00:00','2022-05-06 20:00:00','2022-05-01 08:00:00','2022-05-04 23:55:00',NULL,NULL,NULL,NULL,0,'2',0,1,2,4),(165,'2022-05-13 19:00:00','2022-05-13 20:00:00','2022-05-08 08:00:00','2022-05-11 23:55:00',NULL,NULL,NULL,NULL,0,'2',0,1,2,4);
/*!40000 ALTER TABLE `MultiDistrib` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Operation`
--

DROP TABLE IF EXISTS `Operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `amount` double NOT NULL,
  `date` datetime NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `data` mediumblob NOT NULL,
  `pending` tinyint(1) NOT NULL,
  `relationId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Operation_relation` (`relationId`),
  KEY `Operation_user` (`userId`),
  KEY `Operation_group` (`groupId`),
  CONSTRAINT `Operation_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Operation_relation` FOREIGN KEY (`relationId`) REFERENCES `Operation` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Operation_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Operation`
--

LOCK TABLES `Operation` WRITE;
/*!40000 ALTER TABLE `Operation` DISABLE KEYS */;
INSERT INTO `Operation` VALUES (1,'Commande du Vendredi 15 Avril 2022',0,'2022-04-13 11:49:52',0,_binary 'oy8:basketIdi1g',1,NULL,2,1);
/*!40000 ALTER TABLE `Operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permalink`
--

DROP TABLE IF EXISTS `Permalink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Permalink` (
  `link` varchar(128) NOT NULL,
  `entityType` varchar(64) NOT NULL,
  `entityId` int(11) NOT NULL,
  PRIMARY KEY (`link`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permalink`
--

LOCK TABLES `Permalink` WRITE;
/*!40000 ALTER TABLE `Permalink` DISABLE KEYS */;
/*!40000 ALTER TABLE `Permalink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Place`
--

DROP TABLE IF EXISTS `Place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(64) DEFAULT NULL,
  `zipCode` varchar(32) NOT NULL,
  `city` varchar(64) NOT NULL,
  `country` varchar(64) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Place_lat_lng` (`lat`,`lng`),
  KEY `Place_group` (`groupId`),
  CONSTRAINT `Place_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Place`
--

LOCK TABLES `Place` WRITE;
/*!40000 ALTER TABLE `Place` DISABLE KEYS */;
INSERT INTO `Place` VALUES (2,'Ecolieu Le Portail','7 Rue du Portail',NULL,'71270','Torpes','FR',NULL,NULL,1);
/*!40000 ALTER TABLE `Place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `ref` varchar(32) DEFAULT NULL,
  `price` double NOT NULL,
  `vat` double NOT NULL,
  `desc` mediumtext,
  `stock` double DEFAULT NULL,
  `unitType` tinyint(3) unsigned DEFAULT NULL,
  `qt` double DEFAULT NULL,
  `organic` tinyint(1) NOT NULL,
  `variablePrice` tinyint(1) NOT NULL,
  `multiWeight` tinyint(1) NOT NULL,
  `wholesale` tinyint(1) NOT NULL,
  `retail` tinyint(1) NOT NULL,
  `bulk` tinyint(1) NOT NULL,
  `hasFloatQt` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `catalogId` int(11) NOT NULL,
  `imageId` int(11) DEFAULT NULL,
  `txpProductId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Product_catalog` (`catalogId`),
  KEY `Product_image` (`imageId`),
  KEY `Product_txpProduct` (`txpProductId`),
  CONSTRAINT `Product_catalog` FOREIGN KEY (`catalogId`) REFERENCES `Catalog` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Product_image` FOREIGN KEY (`imageId`) REFERENCES `File` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Product_txpProduct` FOREIGN KEY (`txpProductId`) REFERENCES `TxpProduct` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (3,'Epinard','000-001',2.8,5.5,'Une botte d\'Ã©pinard.',100,2,500,1,0,0,0,0,0,0,1,5,NULL,NULL),(4,'Fromage de chÃ¨vre - demi-sec','000-002',3.2,5.5,NULL,20,0,1,1,0,0,0,0,0,0,1,5,NULL,NULL),(5,'Courlis doux - Tomme de vache','000-003',10,5.5,NULL,20,2,600,1,0,0,0,0,0,0,1,5,NULL,NULL),(6,'Fromage blanc Ã  la crÃ¨me','000-004',3.4,5.5,NULL,10,2,500,0,0,0,0,0,0,0,1,4,NULL,NULL),(7,'Skyyr','000-01',2.4,5.5,NULL,10,2,500,0,0,0,0,0,0,0,1,4,NULL,NULL),(8,'Lait cru','000-002',1.6,5.5,NULL,10,3,1,0,0,0,0,0,0,0,1,4,NULL,NULL);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductCategory`
--

DROP TABLE IF EXISTS `ProductCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductCategory` (
  `productId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  PRIMARY KEY (`productId`,`categoryId`),
  KEY `ProductCategory_category` (`categoryId`),
  CONSTRAINT `ProductCategory_category` FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ProductCategory_product` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCategory`
--

LOCK TABLES `ProductCategory` WRITE;
/*!40000 ALTER TABLE `ProductCategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProductCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Session`
--

DROP TABLE IF EXISTS `Session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Session` (
  `sid` varchar(32) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `messages` mediumblob NOT NULL,
  `lastTime` datetime NOT NULL,
  `createTime` datetime NOT NULL,
  `sdata` mediumblob NOT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  KEY `Session_lastTime` (`lastTime`),
  KEY `Session_user` (`uid`),
  CONSTRAINT `Session_user` FOREIGN KEY (`uid`) REFERENCES `User` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Session`
--

LOCK TABLES `Session` WRITE;
/*!40000 ALTER TABLE `Session` DISABLE KEYS */;
INSERT INTO `Session` VALUES ('cfSD3TfwvquV1YIcPJbfVNFETvJymMn7','127.0.0.1','fr',_binary 'ah','2022-04-21 17:48:01','2022-04-21 17:48:01',_binary 'o\0\0\0\0z',NULL),('F8CI6aJoLcIRqMlMo4ksqFYdxdIUXbba','172.23.0.1','fr',_binary 'ah','2022-04-13 12:02:27','2022-04-13 11:44:35',_binary 'o�)�\�i\0\0\0Ȭ�i\0\0\0\0�� 5N��>=N\0\0\0\0z',1),('ftbsSBpAqujRDfw4ABxbk0wBbVJCDRhF','172.22.0.1','fr',_binary 'ah','2022-04-14 08:13:55','2022-04-14 07:55:36',_binary 'o�)�\�i\0\0\0Ȭ�i\0\0\0\0�� 5N��>=N\0\0\0\0z',2),('IDMhMYDDMJWqSbmqfDY3vX76CMk0q9mv','172.24.0.1','fr',_binary 'ah','2022-04-13 09:38:53','2022-04-13 09:35:31',_binary 'o�)�\�i\0\0\0Ȭ�i\0\0\0\0�� 5N��>=N\0\0\0\0z',1),('jXfNiDtSeUQhUKIY1ocRoiFMxJeLma3h','127.0.0.1','fr',_binary 'ah','2022-04-21 17:46:01','2022-04-21 17:46:01',_binary 'o\0\0\0\0z',NULL),('kQeIjjAQMWj6OMvhrDpjRE5mbnAAeIjj','127.0.0.1','fr',_binary 'ah','2022-04-21 17:49:01','2022-04-21 17:49:01',_binary 'o\0\0\0\0z',NULL),('kXRt2Y5pqxL6ovs9pyvcj1eKw6mesYPf','127.0.0.1','fr',_binary 'ah','2022-04-21 17:47:01','2022-04-21 17:47:01',_binary 'o\0\0\0\0z',NULL),('OEjo2J4noCp6xQSIwK4YCnS2TX1N2JWj','172.24.0.1','en',_binary 'ah','2022-04-12 14:57:20','2022-04-12 14:54:14',_binary 'o\0\0\0\0z',NULL),('VJURhyVayiHFhZWsB5PQt02kjJVtbmEa','172.22.0.1','fr',_binary 'ah','2022-04-21 17:48:52','2022-04-21 17:46:02',_binary 'o�)�\�i\0\0\0Ȭ�i\0\0\0\0�� 5N��>=N\0\0\0\0z',1);
/*!40000 ALTER TABLE `Session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subscription`
--

DROP TABLE IF EXISTS `Subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `isValidated` tinyint(1) NOT NULL,
  `isPaid` tinyint(1) NOT NULL,
  `userId` int(11) NOT NULL,
  `catalogId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Subscription_user` (`userId`),
  KEY `Subscription_catalog` (`catalogId`),
  CONSTRAINT `Subscription_catalog` FOREIGN KEY (`catalogId`) REFERENCES `Catalog` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Subscription_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subscription`
--

LOCK TABLES `Subscription` WRITE;
/*!40000 ALTER TABLE `Subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `Subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TmpBasket`
--

DROP TABLE IF EXISTS `TmpBasket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TmpBasket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(256) DEFAULT NULL,
  `cdate` datetime NOT NULL,
  `data` mediumblob NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `multiDistribId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `TmpBasket_ref` (`ref`),
  KEY `TmpBasket_user` (`userId`),
  KEY `TmpBasket_multiDistrib` (`multiDistribId`),
  CONSTRAINT `TmpBasket_multiDistrib` FOREIGN KEY (`multiDistribId`) REFERENCES `MultiDistrib` (`id`) ON DELETE CASCADE,
  CONSTRAINT `TmpBasket_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TmpBasket`
--

LOCK TABLES `TmpBasket` WRITE;
/*!40000 ALTER TABLE `TmpBasket` DISABLE KEYS */;
/*!40000 ALTER TABLE `TmpBasket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TxpCategory`
--

DROP TABLE IF EXISTS `TxpCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TxpCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(64) DEFAULT NULL,
  `displayOrder` tinyint(4) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TxpCategory`
--

LOCK TABLES `TxpCategory` WRITE;
/*!40000 ALTER TABLE `TxpCategory` DISABLE KEYS */;
INSERT INTO `TxpCategory` VALUES (1,NULL,0,'Produits de la mer'),(2,NULL,0,'Livraison Ã  domicile'),(3,NULL,0,'BeautÃ© & soins'),(4,NULL,0,'Traiteur'),(5,NULL,0,'Maison & Jardin'),(6,NULL,0,'Fruits & LÃ©gumes'),(7,NULL,0,'Boulangerie & PÃ¢tisserie'),(8,NULL,0,'CrÃ¨merie'),(9,NULL,0,'Boissons'),(10,NULL,0,'Viandes'),(11,NULL,0,'Animaux'),(12,NULL,0,'Artisanat & Loisirs'),(13,NULL,0,'Paniers et Coffrets'),(14,NULL,0,'Ã‰picerie');
/*!40000 ALTER TABLE `TxpCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TxpProduct`
--

DROP TABLE IF EXISTS `TxpProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TxpProduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `subCategoryId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `TxpProduct_category` (`categoryId`),
  KEY `TxpProduct_subCategory` (`subCategoryId`),
  CONSTRAINT `TxpProduct_category` FOREIGN KEY (`categoryId`) REFERENCES `TxpCategory` (`id`) ON DELETE CASCADE,
  CONSTRAINT `TxpProduct_subCategory` FOREIGN KEY (`subCategoryId`) REFERENCES `TxpSubCategory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=659 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TxpProduct`
--

LOCK TABLES `TxpProduct` WRITE;
/*!40000 ALTER TABLE `TxpProduct` DISABLE KEYS */;
INSERT INTO `TxpProduct` VALUES (1,'Carrelet',1,1),(2,'Livraison Ã  domicile',2,2),(3,'Savon liquide',3,3),(4,'Tofu',4,4),(5,'Lait d\'Ã¢nesse (cosmÃ©tique)',3,5),(6,'Huile de soin',3,5),(7,'MacÃ©ration solaire (non alimentaire)',3,5),(8,'Soin des cheveux',3,5),(9,'Soin du corps',3,5),(10,'DÃ©maquillant',3,5),(11,'Linge de Maison',5,6),(12,'Semences',5,7),(13,'Basilic',6,8),(14,'GÃ¢teau',7,9),(15,'PÃ¢tes',7,9),(16,'Beurre',8,10),(17,'BiÃ¨re',9,11),(18,'Calvados',9,11),(19,'Bouleau',6,8),(20,'AubÃ©pine',6,8),(21,'Bulot',1,12),(22,'Brioche',7,13),(23,'Bison',10,14),(24,'Poissons et crustacÃ©s',1,15),(25,'Seitan',4,4),(26,'Caviar',1,1),(27,'Panier de poissons',1,1),(28,'Germoir',5,7),(29,'Escargots',10,16),(30,'Eglefin',1,1),(31,'FÃ©ra (corÃ©gone)',1,1),(32,'Limande',1,1),(33,'Graines pour oiseaux',11,17),(34,'Vaisselle en bois',12,18),(35,'Lotte',1,1),(36,'Maquereau',1,1),(37,'Digestif ou liqueur',9,11),(38,'Morue',1,1),(39,'Hydromel',9,11),(40,'PÃ©tillant de raisin',9,11),(41,'Colin',1,1),(42,'Rouget',1,1),(43,'Sar',1,1),(44,'Galet',1,1),(45,'Hareng',1,1),(46,'Lieu Noir',1,1),(47,'PoirÃ©',9,11),(48,'Loup',1,1),(49,'Pommeau',9,11),(50,'Champagne rosÃ©',9,11),(51,'BiÃ¨re brune',9,11),(52,'BiÃ¨re blonde',9,11),(53,'Pain d\'Ã©pices',7,9),(54,'Glace',8,19),(55,'Ustensile de cuisine',5,6),(56,'ApÃ©ritif',9,11),(57,'BiÃ¨re ambrÃ©e',9,11),(58,'PÃ¢tisserie au chocolat',7,9),(59,'Condiments',13,20),(60,'Panier de condiments',13,20),(61,'Panier de produits du terroir',13,20),(62,'Plant',5,7),(63,'Bouquet ou composition florale',5,7),(64,'Palmier',7,9),(65,'CD',12,21),(66,'Plat cuisinÃ©',4,4),(67,'Livres',12,21),(68,'Meubles et dÃ©coration',12,18),(69,'Cours de jardinage',12,22),(70,'Cours de cuisine',12,22),(71,'Boissons sans alcool',9,23),(72,'Cognac',9,11),(73,'Bar',1,1),(74,'Cabillaud',1,1),(75,'Daurade',1,1),(76,'Lamproie',1,1),(77,'Merlan',1,1),(78,'Cheval',10,14),(79,'Chevreau',10,14),(80,'Information',12,24),(81,'Jouet en bois',12,25),(82,'Muge',1,1),(83,'Fromage',8,26),(84,'Pageot',1,1),(85,'BiÃ¨re triple',9,11),(86,'Champagne',9,11),(87,'Telline',1,12),(88,'Cidre',9,11),(89,'CrÃ¨me de cassis',9,11),(90,'Mouton',10,14),(91,'Jouet en tissu',12,25),(92,'Tee-shirt',12,27),(93,'Tissu et textile',12,18),(94,'VÃªtement pour enfant',12,27),(95,'Visite Ã  la ferme',12,22),(96,'Vannerie',12,18),(97,'Tartelette aux fruits',7,9),(98,'Tarte sucrÃ©e',7,9),(99,'HuÃ®tre',1,12),(100,'Eau de vie',9,11),(101,'Jus de fruit Ã  consommation immÃ©diate  TVA 10%',9,28),(102,'Essaim',11,17),(103,'Faisselle',8,29),(104,'Fromage blanc',8,29),(105,'Lait fermentÃ©',8,29),(106,'Dessert glacÃ©',8,19),(107,'Fruits au sirop',6,30),(108,'Biscuit de Savoie',7,9),(109,'Financier',7,9),(110,'Brownie',7,9),(111,'CannelÃ©',7,9),(112,'Compote',7,9),(113,'Dessert vÃ©gÃ©tal',7,9),(114,'Galette de blÃ© noir',7,31),(115,'Gaufre',7,9),(116,'Macarons',7,9),(117,'Muffin',7,9),(118,'Pain lin pavot',7,32),(119,'Pain multigraines',7,32),(120,'Pain nature',7,32),(121,'Pain sÃ©same',7,32),(122,'MarbrÃ©',7,9),(123,'Pain au noix',7,32),(124,'Pain aux graines de courge',7,32),(125,'Pain aux raisins',7,32),(126,'Quatre-quarts',7,9),(127,'Pain complet',7,32),(128,'Pain de campagne',7,32),(129,'Pain demi-complet',7,32),(130,'MarbrÃ©',1,1),(131,'Oursin',1,12),(132,'Soin du visage',3,5),(133,'Palourde',1,12),(134,'Lapin',10,14),(135,'BrÃ¨des',6,33),(136,'Yaourt',8,29),(137,'Miel',14,34),(138,'Confiture',14,34),(139,'Dessert',4,4),(140,'GelÃ©e',14,34),(141,'GelÃ©e royale',14,34),(142,'Madeleine',7,9),(143,'Riz',14,35),(144,'PÃ¢tÃ© en croute',4,4),(145,'Germe de blÃ©',14,35),(146,'Boulghour',14,35),(147,'CrÃªpe',7,31),(148,'Tous pains',7,32),(149,'Viennoiserie',7,13),(150,'Tiramisu',7,9),(151,'Argile',3,5),(152,'Baume',3,5),(153,'Baume de beautÃ© prÃ©cieux visage',3,5),(154,'Sels de bain',3,5),(155,'PÃ¢tÃ©',10,36),(156,'PÃ¢tÃ© de canard',10,36),(157,'Panier de fruits et lÃ©gumes',6,37),(158,'Panier de lÃ©gumes',6,37),(159,'Soupe dÃ©shydratÃ©e',6,30),(160,'Miel de Montagne',14,34),(161,'Aigre-doux',14,38),(162,'Graines Ã  germer',14,35),(163,'Graines germÃ©es',14,35),(164,'Graines moulues',14,35),(165,'Glace individuelle Ã  l\'unitÃ© < 200ml',8,19),(166,'Goyave',6,39),(167,'Perche',1,1),(168,'Epeautre',14,35),(169,'NÃ¨fle du Japon',6,39),(170,'Poulpe',1,12),(171,'Noisette',6,40),(172,'Piment',14,38),(173,'Poivre',14,38),(174,'Chips',14,41),(175,'Miel de chataÃ®gnier',14,34),(176,'Produits vÃ©tÃ©rinaires',11,17),(177,'Bigarade',6,39),(178,'Brugnon',6,39),(179,'Kiwi',6,39),(180,'Kumquat',6,39),(181,'Citrons',6,39),(182,'Citron vert',6,39),(183,'Sapote',6,39),(184,'Oeufs de poisson',1,1),(185,'Miel de ForÃªt',14,34),(186,'Guarana',14,42),(187,'Miel de Tilleul',14,34),(188,'Infusion',14,43),(189,'Assortiment de viandes',10,14),(190,'Rillette',10,36),(191,'Rillettes',10,36),(192,'Rillettes de saumon',1,44),(193,'Rillettes de truite',1,44),(194,'Rillettes de canard',10,36),(195,'Rillettes et PÃ¢tÃ©s',10,45),(196,'Terrine',10,36),(197,'Sapotille',6,39),(198,'Cerise de Cayenne',6,39),(199,'Poire',6,39),(200,'Cachiman',6,39),(201,'Physalis',6,39),(202,'Pomme liane',6,39),(203,'Pruneau',6,40),(204,'Pomme',6,39),(205,'Ananas',6,39),(206,'Pamplemousse',6,39),(207,'Tomate arbuste (Tamarillo)',6,39),(208,'Noix de coco',6,39),(209,'Pomme de lait',6,39),(210,'Raisins',6,40),(211,'Ramboutan',6,39),(212,'Prune',6,39),(213,'Mombin',6,39),(214,'Myrobolan',6,39),(215,'Raisin',6,39),(216,'MÃ»re',6,39),(217,'Cassis',6,39),(218,'Corossol',6,39),(219,'ClÃ©mentines',6,39),(220,'Tamarin',6,39),(221,'Prune de CythÃ¨re',6,39),(222,'Mangoustan',6,39),(223,'Coquilles Saint-Jacques',1,12),(224,'Crabe',1,12),(225,'Produits Ã  tartiner',14,41),(226,'Farine',14,35),(227,'Flocons d\'avoine',14,35),(228,'Crevettes',1,12),(229,'Fleur de sel',14,38),(230,'Ã‰crevisse',1,12),(231,'Homard',1,12),(232,'Anguille',1,46),(233,'Mangue',6,39),(234,'Attier',6,39),(235,'Coing',6,39),(236,'Combava',6,39),(237,'Feijoa',6,39),(238,'AcÃ©rola',6,39),(239,'Bonite',1,1),(240,'Amandes',6,40),(241,'Pomme de lait',6,39),(242,'Papier toilette',5,6),(243,'Nettoyant sols et surfaces',5,6),(244,'Brochet',1,1),(245,'Carpe',1,1),(246,'Longani',6,39),(247,'Groseille',6,39),(248,'Moule',1,12),(249,'Murex (coquillage)',1,12),(250,'Kaki',6,39),(251,'Arbousier',6,39),(252,'Mandarine',6,39),(253,'Compote',6,39),(254,'Couches',3,3),(255,'Coupe menstruelle',3,3),(256,'Lingettes',3,3),(257,'Cerise',6,39),(258,'ChÃ©rimole',6,39),(259,'Gommage',3,5),(260,'Sapin de NoÃ«l',5,7),(261,'Lotion',3,5),(262,'Figue',6,39),(263,'Fraise',6,39),(264,'Ketchup',14,47),(265,'Miel de sapin',14,34),(266,'Rochers Ã  la noix de coco',7,9),(267,'SablÃ©',7,9),(268,'Framboise',6,39),(269,'Abricot',6,39),(270,'Myrtilles',6,39),(271,'Miel fleur de printemps',14,34),(272,'Banane',6,39),(273,'Figue',6,40),(274,'Kiwano',6,39),(275,'Litchi',6,39),(276,'Nectarine',6,39),(277,'Rhubarbe',6,39),(278,'Nashis',6,39),(279,'Origan',6,8),(280,'Miel fleur d\'Ã©tÃ©',14,34),(281,'Truite',1,1),(282,'Turbot',1,1),(283,'Ardoise',12,18),(284,'Bougie',12,18),(285,'Aliment pour Chats',11,17),(286,'Aliment pour Chiens',11,17),(287,'Cassoulet',4,4),(288,'Cire d\'abeille',12,18),(289,'Graines pour volaille',11,17),(290,'LitiÃ¨re et foin',11,17),(291,'Goyavier',6,39),(292,'Cacao (fÃ¨ves)',14,48),(293,'CÃ©ramique',12,18),(294,'Grenadelle',6,39),(295,'Grenadille',6,39),(296,'Icaque',6,39),(297,'Tourte',4,4),(298,'Bougie naturelle',12,18),(299,'Jacque',6,39),(300,'Pitaya',6,39),(301,'Conte',12,21),(302,'Carambole',6,39),(303,'Engrais',5,7),(304,'NÃ¨fle',6,39),(305,'Autres fruits sÃ©chÃ©s',6,40),(306,'Tamarin des Indes',6,39),(307,'Abricot sÃ©chÃ©',6,40),(308,'Truffe',6,33),(309,'Bois et dÃ©rivÃ©s de bois',5,6),(310,'Seiche',1,12),(311,'ActivitÃ© pÃ©dagogique et culturelle',12,22),(312,'Artisanat et culture',12,49),(313,'Saumon',1,1),(314,'Saumon de fontaine',1,1),(315,'Saurel',1,1),(316,'Seiche',1,1),(317,'Atelier',12,22),(318,'Atelier de fabrication',12,22),(319,'Serviette hygiÃ©nique',3,3),(320,'Aide Ã  la pÃ¢tisserie',4,4),(321,'Kit tarte',4,4),(322,'Autres',12,27),(323,'Pizza',4,4),(324,'Saumon fumÃ©',1,46),(325,'Terreau',5,7),(326,'Tarte salÃ©e',4,4),(327,'Soin du linge',5,6),(328,'Truite fumÃ©e',1,46),(329,'PÃ¢te Ã  tartiner',14,34),(330,'PurÃ©e de fruit ou compote',14,34),(331,'Sole',1,1),(332,'Sorbet',8,19),(333,'Thon',1,1),(334,'Panier composÃ© avec contenant',13,20),(335,'Oeufs',8,50),(336,'Lombricomposteur',5,7),(337,'Pied de sapin',5,7),(338,'BruyÃ¨re',6,8),(339,'Camomille matricaire',6,8),(340,'Camomille romaine',6,8),(341,'Aloe vera',6,8),(342,'Barquette au marrons',7,9),(343,'AngÃ©lique',6,8),(344,'Plat cuisinÃ© Ã  consommer sur place',4,4),(345,'Confits',14,34),(346,'Sel au cÃ©leri',14,38),(347,'Huile aromatisÃ©e',14,51),(348,'Huile de chanvre',14,51),(349,'Huile de pÃ©pins de raisins',14,51),(350,'Panier de fruits',6,37),(351,'Chou palmiste',6,33),(352,'Coriandre',6,8),(353,'Huile de cameline',14,51),(354,'CÃ©leri rave',6,33),(355,'Lentilles',6,52),(356,'Oignon',6,33),(357,'Panais',6,33),(358,'Patate douce',6,33),(359,'Piment vÃ©gÃ©tarien',6,33),(360,'Poireau',6,33),(361,'Cresson',6,33),(362,'Salsifis',6,33),(363,'CÃ©bette',6,33),(364,'Sauge',6,8),(365,'MadÃ¨re',6,33),(366,'Manioc',6,33),(367,'PÃ¢tisson',6,33),(368,'Persil tubÃ©reux',6,33),(369,'Potiron',6,33),(370,'Romarin',6,8),(371,'Myrtillier',6,8),(372,'Ortie',6,8),(373,'Cive',6,33),(374,'Eau florale (non alimentaire)',3,5),(375,'Fleur alimentaire',6,8),(376,'Petit-beurre',7,9),(377,'Huile d\'olive',14,51),(378,'CrÃ¨me de cuisine vÃ©gÃ©tale (Ã  l\'avoine)',14,38),(379,'Paprika',14,38),(380,'Moutarde',14,38),(381,'Huile de tournesol olÃ©ique',14,51),(382,'Savon',3,3),(383,'Jus de Fraise',9,28),(384,'Jus de Poire',9,28),(385,'Jus de Pomme',9,28),(386,'Jus de Tomate',9,28),(387,'Jus d\'Orange',9,28),(388,'Vinaigrette',14,51),(389,'Distillat (aromatique)',14,38),(390,'Mayonnaise',14,47),(391,'CÃ¢pres',14,38),(392,'Pesto',14,47),(393,'Pickles',14,38),(394,'Jus de Kiwi',9,28),(395,'Boisson vÃ©gÃ©tale',9,53),(396,'Cola',9,53),(397,'Jus d\'Abricot',9,28),(398,'Haricot',6,52),(399,'Lait',8,54),(400,'Lait d\'Ã¢nesse (alimentaire)',8,54),(401,'Bouquet des champs',5,7),(402,'Lait de jument',8,54),(403,'Autres huiles',14,51),(404,'Huile de noix',14,51),(405,'Parfum d\'intÃ©rieur',5,6),(406,'Vaisselle',5,6),(407,'Vanille',14,38),(408,'Jus de Fruits rouges',9,28),(409,'Jus de Griotte',9,28),(410,'Jus de Raisin',9,28),(411,'Limonade',9,53),(412,'Nectar',9,28),(413,'PÃ©tillant de pomme',9,53),(414,'Pollen',14,42),(415,'Huile d\'argan',14,51),(416,'Huile de colza',14,51),(417,'Huile de lin',14,51),(418,'Huile de noisettes',14,51),(419,'Sardine',1,1),(420,'Sirop',9,55),(421,'Cookie',7,9),(422,'Huile d\'arachide',14,51),(423,'Curcuma',14,38),(424,'Haricot beurre',6,33),(425,'CrÃ¨me fraÃ®che',8,10),(426,'SpÃ©cialitÃ©s fromagÃ¨res',8,26),(427,'Biscuit rose',7,9),(428,'Soupe',6,30),(429,'Soupe de lÃ©gumes',6,30),(430,'Soupe de tomates',6,30),(431,'Conserves de lÃ©gumes',6,30),(432,'Biscuits',7,9),(433,'Soupe (rascasse, vive, etc)',1,44),(434,'Cake',7,9),(435,'Ratatouille',6,30),(436,'Salade',6,33),(437,'Avocat',6,33),(438,'Sauternes',9,11),(439,'Vin mousseux ou CrÃ©mant',9,11),(440,'Meringue',7,9),(441,'Palet breton',7,9),(442,'Pain tournesol',7,32),(443,'Pain Ã  l\'engrain',7,32),(444,'Pain Ã  l\'Ã©peautre',7,32),(445,'Vin Blanc',9,11),(446,'Vin RosÃ©',9,11),(447,'Vin Rouge',9,11),(448,'Sauge',6,8),(449,'Huile essentielle',6,8),(450,'Sucre',14,38),(451,'ThÃ©',14,43),(452,'Tisane',14,43),(453,'Chutney',14,38),(454,'MÃ©lange d\'Ã©pices',14,38),(455,'Quinoa',14,35),(456,'Lin',14,35),(457,'Graines Ã  croquer',14,35),(458,'Graines Ã  cuire',14,35),(459,'Gingembre',14,38),(460,'Huile de ricin',14,51),(461,'Huile de soja',14,51),(462,'Huile de tournesol',14,51),(463,'Huile d\'olive',14,51),(464,'Aloe vera',14,42),(465,'Vinaigre',14,38),(466,'Vinaigre alcoolisÃ©',14,38),(467,'Vinaigre balsamique',14,38),(468,'Coulis de fruit',14,38),(469,'Coulis de fruits rouges',14,38),(470,'Coulis de tomates',14,47),(471,'Lait de coco',14,38),(472,'MacÃ©ration solaire (alimentaire)',14,51),(473,'Chips de lÃ©gume',14,41),(474,'Muesli',14,35),(475,'PÃ¢tes',14,35),(476,'Laurier',6,8),(477,'Algues',14,42),(478,'Baies roses',14,38),(479,'CafÃ©',14,43),(480,'Miel d\'acacia',14,34),(481,'Miel de Lavande',14,34),(482,'Pigeon',10,56),(483,'Autruche',10,56),(484,'Boeuf',10,57),(485,'Caille',10,56),(486,'Confit',10,58),(487,'Confit de canard',10,58),(488,'Confit d\'oie',10,58),(489,'Canard',10,56),(490,'Coquelet',10,56),(491,'Faisan',10,56),(492,'GÃ©line',10,56),(493,'Chapon',10,56),(494,'Foie gras',10,58),(495,'Oie',10,56),(496,'Foie gras entier',10,58),(497,'Perdrix',10,56),(498,'Pintade',10,56),(499,'Dinde',10,56),(500,'Agneau',10,59),(501,'Magret',10,58),(502,'Poitrine fumÃ©e',10,60),(503,'Cerfs & Biches',10,56),(504,'Porc',10,61),(505,'Poularde',10,56),(506,'Poule',10,56),(507,'Poulet',10,56),(508,'Mousse de foie gras',10,58),(509,'PÃ¢tÃ©',10,58),(510,'Andouille',10,60),(511,'Boudin',10,60),(512,'Coppa',10,60),(513,'Jambon',10,60),(514,'Jambon cru',10,60),(515,'Jambonneau',10,60),(516,'Pancetta',10,60),(517,'Rosette',10,60),(518,'Saucisse',10,60),(519,'Saucisson',10,60),(520,'Veau',10,62),(521,'Confit d\'oignons',10,58),(522,'abats',10,14),(523,'Confit d\'Ã©chalote',14,38),(524,'Spiruline',14,42),(525,'Tapenade',14,38),(526,'Propolis',14,42),(527,'Poudre de noisettes',14,38),(528,'Poudre de noix',14,38),(529,'Biscuit apÃ©ritif',14,41),(530,'Rouille',14,47),(531,'Sauce d\'accompagnement',14,47),(532,'Sauce pour salade',14,47),(533,'Safran',14,38),(534,'Sauce tomate',14,47),(535,'Aromates',14,38),(536,'Semoule de blÃ©',14,35),(537,'Sel',14,38),(538,'chocolat blanc',14,48),(539,'Rutabaga',6,33),(540,'Christophine (Chouchou, Chayotte)',6,33),(541,'Thym',6,8),(542,'FrÃªne',6,8),(543,'Eglantier',6,8),(544,'Souci',6,8),(545,'Hysope',6,8),(546,'Ail des ours',6,8),(547,'AspÃ©rule Odorante',6,8),(548,'MaÃ¯s',6,33),(549,'Menthe',6,8),(550,'Haricot vert',6,33),(551,'Olive',6,33),(552,'Radis',6,33),(553,'Persil',6,8),(554,'CÃ©leri branche',6,33),(555,'Courges',6,33),(556,'PensÃ©e sauvage',6,8),(557,'Reine des prÃ©s',6,8),(558,'Potimarron',6,33),(559,'Tomate',6,33),(560,'Topinambour',6,33),(561,'Sarriette',6,8),(562,'Ail',6,33),(563,'Blette',6,33),(564,'Concombres',6,33),(565,'Artichaut',6,33),(566,'Asperge',6,33),(567,'Aubergine',6,33),(568,'Cornichons',6,33),(569,'Epinards',6,33),(570,'Betterave',6,33),(571,'Carottes',6,33),(572,'Poivron',6,33),(573,'Petits pois',6,33),(574,'Chocolat en poudre',14,48),(575,'Pois gourmands',6,33),(576,'Tilleul',6,8),(577,'Verveine citronnelle',6,8),(578,'Vigne rouge',6,8),(579,'Nougat',14,48),(580,'Banane plantain',6,33),(581,'Banane Poyo',6,33),(582,'Fruit Ã  pain',6,33),(583,'Giraumon',6,33),(584,'Courgettes',6,33),(585,'Crosne',6,33),(586,'Tablette de chocolat',14,48),(587,'Confiserie Ã  base de chocolat',14,48),(588,'Champignon',6,33),(589,'Ã‰chalote',6,33),(590,'Endives',6,33),(591,'Gombo',6,33),(592,'Sureau',6,8),(593,'Confiserie',14,48),(594,'Chocolat',14,48),(595,'Aneth',6,8),(596,'Autres plantes sauvages',6,8),(597,'Pois chiches',6,52),(598,'Brocolis',6,33),(599,'Fenouil',6,33),(600,'FÃ¨ve',6,52),(601,'FÃ¨ve',6,33),(602,'Citronnelle',6,8),(603,'Estragon',6,8),(604,'Fenouil',6,8),(605,'Fenugrec',6,8),(606,'Lamier blanc',6,8),(607,'Pois cassÃ©s',6,52),(608,'Coquelicot',6,8),(609,'Cerfeuil',6,8),(610,'Bonbon',14,48),(611,'Huile essentielle alimentaire',6,8),(612,'Houblon',6,8),(613,'Butternut',6,33),(614,'Igname',6,33),(615,'Framboisier',6,8),(616,'Curry nain (helichrysum)',6,8),(617,'Lavande',6,8),(618,'Navets',6,33),(619,'Cardon',6,33),(620,'CÃ©leri vivace (livÃ¨che)',6,8),(621,'Ronce',6,8),(622,'Galette vÃ©gÃ©tale',6,33),(623,'Baies de GenÃ©vrier',6,8),(624,'Cassis feuille',6,8),(625,'Consoude',6,8),(626,'AchillÃ©e',6,8),(627,'Pomme de terre',6,33),(628,'Coriandre',6,8),(629,'Marjolaine',6,8),(630,'MÃ©lange',6,8),(631,'MÃ©lisse',6,8),(632,'Millepertuis',6,8),(633,'Oseille',6,8),(634,'Choux',6,33),(635,'Ciboulette',6,8),(636,'Eau florale (alimentaire)',6,8),(637,'Rougail',6,30),(638,'PrÃªle',6,8),(639,'MÃ©lange',6,40),(640,'Quenette',6,39),(641,'Papaye',6,39),(642,'Pistache',6,40),(643,'PÃªche',6,39),(644,'Abricot des Antilles',6,39),(645,'PastÃ¨que',6,39),(646,'Melon',6,39),(647,'Orange',6,39),(648,'Fruit de la passion',6,39),(649,'Achards',6,30),(650,'Noix',6,40),(651,'Noix de cajou',6,40),(652,'Pomme de cajou',6,39),(653,'Mirabelle',6,39),(654,'ChÃ¢taigne',6,39),(655,'Datte',6,40),(656,'Fruits rouges',6,39),(657,'Durian',6,39),(658,'Barbadine',6,39);
/*!40000 ALTER TABLE `TxpProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TxpSubCategory`
--

DROP TABLE IF EXISTS `TxpSubCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TxpSubCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `categoryId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `TxpSubCategory_category` (`categoryId`),
  CONSTRAINT `TxpSubCategory_category` FOREIGN KEY (`categoryId`) REFERENCES `TxpCategory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TxpSubCategory`
--

LOCK TABLES `TxpSubCategory` WRITE;
/*!40000 ALTER TABLE `TxpSubCategory` DISABLE KEYS */;
INSERT INTO `TxpSubCategory` VALUES (1,'Poissons',1),(2,'Livraison Ã  domicile',2),(3,'HygiÃ¨ne',3),(4,'Traiteur',4),(5,'CosmÃ©tiques',3),(6,'Maison et Entretien',5),(7,'Jardin & Potager',5),(8,'Herbes et Plantes',6),(9,'PÃ¢tisserie',7),(10,'Beurre & CrÃ¨me FraÃ®che',8),(11,'Boissons alcoolisÃ©es',9),(12,'Fruits de mer',1),(13,'Viennoiseries',7),(14,'Autres Viandes',10),(15,'Poissons et crustacÃ©s',1),(16,'Escargots',10),(17,'Animaux',11),(18,'Artisanat',12),(19,'Glaces & Sorbets',8),(20,'Paniers composÃ©s',13),(21,'Objets culturels',12),(22,'Atelier, Cours et Visite',12),(23,'Boissons sans alcool',9),(24,'Information',12),(25,'Jouets',12),(26,'Fromage',8),(27,'Habillement',12),(28,'Jus de Fruits',9),(29,'Yaourts & Fromages Frais',8),(30,'Soupes et Conserves',6),(31,'Galettes et CrÃªpes',7),(32,'Pains',7),(33,'LÃ©gumes',6),(34,'Confitures, miel, compotes',14),(35,'CÃ©rÃ©ales / Farines / Graines',14),(36,'Rillettes et PÃ¢tÃ©s',10),(37,'Paniers composÃ©s',6),(38,'Condiments, Ã©pices, sucres',14),(39,'Fruits',6),(40,'Fruits secs',6),(41,'ApÃ©ritif',14),(42,'ComplÃ©ments alimentaires',14),(43,'CafÃ©, thÃ© et infusions',14),(44,'Soupes et Rillettes',1),(45,'Rillettes et PÃ¢tÃ©s',10),(46,'Poissons fumÃ©s',1),(47,'Sauces',14),(48,'Confiseries & Chocolat',14),(49,'Artisanat et culture',12),(50,'Å’ufs',8),(51,'Huiles',14),(52,'LÃ©gumes secs',6),(53,'Boissons fraÃ®ches',9),(54,'Lait',8),(55,'Sirop',9),(56,'Volailles et gibiers',10),(57,'Boeuf',10),(58,'Foie Gras et Confits',10),(59,'Agneau',10),(60,'Charcuterie',10),(61,'Porc',10),(62,'Veau',10);
/*!40000 ALTER TABLE `TxpSubCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) NOT NULL,
  `pass` tinytext NOT NULL,
  `rights` int(11) NOT NULL,
  `firstName` varchar(32) NOT NULL,
  `lastName` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(19) DEFAULT NULL,
  `firstName2` varchar(32) DEFAULT NULL,
  `lastName2` varchar(32) DEFAULT NULL,
  `email2` varchar(64) DEFAULT NULL,
  `phone2` varchar(19) DEFAULT NULL,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(64) DEFAULT NULL,
  `zipCode` varchar(32) DEFAULT NULL,
  `city` varchar(25) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `nationality` varchar(2) DEFAULT NULL,
  `countryOfResidence` varchar(2) DEFAULT NULL,
  `cdate` date NOT NULL,
  `ldate` datetime DEFAULT NULL,
  `flags` int(11) NOT NULL,
  `tos` tinyint(1) NOT NULL,
  `tutoState` mediumblob,
  `apiKey` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_email` (`email`),
  KEY `User_email2` (`email2`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'fr','85b7bb7786dc54ccdc187d246eaae67c',0,'Alix','VINIGIER','admin@cagette.net',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-04-13','2022-04-21 17:46:02',6,0,NULL,NULL),(2,'fr','d695081830b98fd4978d81d1e9ead134',0,'Guillaume','PENAUD','guillaume.penaud@gmail.com','06 66 22 24 75',NULL,NULL,NULL,NULL,'9 Rue de Cretey',NULL,'71270','Torpes','1984-07-17','FR','FR','2022-04-13','2022-04-14 07:55:13',4,0,NULL,NULL),(3,'fr','88587623c254caa96909038d2d699ee6',0,'OcÃ©ane','PEISEY','oceanep.lilas@riseup.net',NULL,NULL,NULL,NULL,NULL,'9 Rue de Cretey',NULL,'71270','Torpes','1989-04-13','FR','FR','2022-04-13',NULL,4,0,NULL,NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserGroup`
--

DROP TABLE IF EXISTS `UserGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroup` (
  `rights` mediumblob,
  `rights2` text,
  `balance` double NOT NULL,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`groupId`),
  KEY `UserGroup_group` (`groupId`),
  CONSTRAINT `UserGroup_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `UserGroup_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserGroup`
--

LOCK TABLES `UserGroup` WRITE;
/*!40000 ALTER TABLE `UserGroup` DISABLE KEYS */;
INSERT INTO `UserGroup` VALUES (_binary 'ajy8:db.Right:0:0jR0:2:0jR0:3:0jR0:1:1nh','[{\"right\":\"GroupAdmin\",\"params\":null},{\"right\":\"Membership\",\"params\":null},{\"right\":\"Messages\",\"params\":null},{\"right\":\"CatalogAdmin\",\"params\":null}]',0,1,1),(NULL,NULL,0,1,2),(NULL,NULL,0,1,3);
/*!40000 ALTER TABLE `UserGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserOrder`
--

DROP TABLE IF EXISTS `UserOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserOrder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double NOT NULL,
  `productPrice` double NOT NULL,
  `feesRate` double NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `date` datetime NOT NULL,
  `flags` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `userId2` int(11) DEFAULT NULL,
  `productId` int(11) NOT NULL,
  `distributionId` int(11) NOT NULL,
  `basketId` int(11) DEFAULT NULL,
  `subscriptionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `UserOrder_user` (`userId`),
  KEY `UserOrder_user2` (`userId2`),
  KEY `UserOrder_product` (`productId`),
  KEY `UserOrder_distribution` (`distributionId`),
  KEY `UserOrder_basket` (`basketId`),
  KEY `UserOrder_subscription` (`subscriptionId`),
  CONSTRAINT `UserOrder_basket` FOREIGN KEY (`basketId`) REFERENCES `Basket` (`id`) ON DELETE SET NULL,
  CONSTRAINT `UserOrder_distribution` FOREIGN KEY (`distributionId`) REFERENCES `Distribution` (`id`) ON DELETE CASCADE,
  CONSTRAINT `UserOrder_product` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `UserOrder_subscription` FOREIGN KEY (`subscriptionId`) REFERENCES `Subscription` (`id`) ON DELETE SET NULL,
  CONSTRAINT `UserOrder_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE,
  CONSTRAINT `UserOrder_user2` FOREIGN KEY (`userId2`) REFERENCES `User` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserOrder`
--

LOCK TABLES `UserOrder` WRITE;
/*!40000 ALTER TABLE `UserOrder` DISABLE KEYS */;
INSERT INTO `UserOrder` VALUES (2,0,3.4,0,1,'2022-04-13 11:49:52',0,2,NULL,6,19,1,NULL);
/*!40000 ALTER TABLE `UserOrder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Variable`
--

DROP TABLE IF EXISTS `Variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Variable` (
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Variable`
--

LOCK TABLES `Variable` WRITE;
/*!40000 ALTER TABLE `Variable` DISABLE KEYS */;
INSERT INTO `Variable` VALUES ('mailer','smtp'),('smtp_host','smtp.mandrillapp.com'),('smtp_pass','A3694icatEhoERG9wWkhpA'),('smtp_port','587'),('smtp_user','Ecolieu Le Portail');
/*!40000 ALTER TABLE `Variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendor`
--

DROP TABLE IF EXISTS `Vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vendor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `peopleName` varchar(128) DEFAULT NULL,
  `profession` int(11) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(19) DEFAULT NULL,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(64) DEFAULT NULL,
  `zipCode` varchar(32) NOT NULL,
  `city` varchar(25) NOT NULL,
  `country` varchar(64) DEFAULT NULL,
  `desc` mediumtext,
  `cdate` date DEFAULT NULL,
  `companyNumber` varchar(128) DEFAULT NULL,
  `siretInfos` mediumblob,
  `linkText` varchar(256) DEFAULT NULL,
  `linkUrl` varchar(256) DEFAULT NULL,
  `directory` tinyint(1) NOT NULL,
  `longDesc` mediumtext,
  `offCagette` mediumtext,
  `status` varchar(32) DEFAULT NULL,
  `isTest` tinyint(1) NOT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `imageId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Vendor_image` (`imageId`),
  KEY `Vendor_user` (`userId`),
  CONSTRAINT `Vendor_image` FOREIGN KEY (`imageId`) REFERENCES `File` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Vendor_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendor`
--

LOCK TABLES `Vendor` WRITE;
/*!40000 ALTER TABLE `Vendor` DISABLE KEYS */;
INSERT INTO `Vendor` VALUES (1,'Jean Martin EURL',NULL,NULL,'jean.martin@cagette.net',NULL,NULL,NULL,'00000','Martignac',NULL,NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(2,'Ferme du Jointout','Thomas et AdÃ¨le',51,'fermedujointout@riseup.net','06 54 23 87 09','7 Rue du Portail',NULL,'71270','Torpes','FR','MaraÃ®chage, fromage','2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(3,'Ferme Adiiris','Adrien et Iris Reichlin',29,'adiiris@riseup.net','06 54 87 32 14','149 route de Sens',NULL,'71330','Saint-Germain-du-Bois','FR',NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(4,'Ferme Adiiris','Adrien et Iris Reichlin',29,'adiiris@riseup.net','06 84 25 76 98','149 Route de Sens',NULL,'71330','Saint-Germain-Du-Bois','FR',NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(5,'Ferme du Jointout',NULL,51,'fermedujointout@riseup.net','06 34 89 56 43','7 Rue du Portail',NULL,'71270','Torpes','FR',NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Volunteer`
--

DROP TABLE IF EXISTS `Volunteer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Volunteer` (
  `userId` int(11) NOT NULL,
  `multiDistribId` int(11) NOT NULL,
  `volunteerRoleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`multiDistribId`,`volunteerRoleId`),
  KEY `Volunteer_multiDistrib` (`multiDistribId`),
  KEY `Volunteer_volunteerRole` (`volunteerRoleId`),
  CONSTRAINT `Volunteer_multiDistrib` FOREIGN KEY (`multiDistribId`) REFERENCES `MultiDistrib` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Volunteer_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Volunteer_volunteerRole` FOREIGN KEY (`volunteerRoleId`) REFERENCES `VolunteerRole` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Volunteer`
--

LOCK TABLES `Volunteer` WRITE;
/*!40000 ALTER TABLE `Volunteer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Volunteer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VolunteerRole`
--

DROP TABLE IF EXISTS `VolunteerRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VolunteerRole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `groupId` int(11) NOT NULL,
  `catalogId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `VolunteerRole_group` (`groupId`),
  KEY `VolunteerRole_catalog` (`catalogId`),
  CONSTRAINT `VolunteerRole_catalog` FOREIGN KEY (`catalogId`) REFERENCES `Catalog` (`id`) ON DELETE SET NULL,
  CONSTRAINT `VolunteerRole_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VolunteerRole`
--

LOCK TABLES `VolunteerRole` WRITE;
/*!40000 ALTER TABLE `VolunteerRole` DISABLE KEYS */;
INSERT INTO `VolunteerRole` VALUES (2,'Distribution',1,NULL);
/*!40000 ALTER TABLE `VolunteerRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WaitingList`
--

DROP TABLE IF EXISTS `WaitingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WaitingList` (
  `date` datetime NOT NULL,
  `message` mediumtext NOT NULL,
  `amapId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`amapId`),
  KEY `WaitingList_group` (`amapId`),
  CONSTRAINT `WaitingList_group` FOREIGN KEY (`amapId`) REFERENCES `Group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `WaitingList_user` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WaitingList`
--

LOCK TABLES `WaitingList` WRITE;
/*!40000 ALTER TABLE `WaitingList` DISABLE KEYS */;
/*!40000 ALTER TABLE `WaitingList` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-21 17:49:20
