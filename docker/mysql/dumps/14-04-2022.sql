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
INSERT INTO `Cache` VALUES ('productsExcerpt161','aoy4:namey10:Lait%20cruy3:ridi408y5:imagey41:%2Fimg%2Ftaxo%2Fgrey%2Ffruits-legumes.pnggoR0y39:Courlis%20doux%20-%20Tomme%20de%20vacheR2i373R3R4goR0y42:Fromage%20blanc%20%C3%A0%20la%20cr%C3%A8meR2i324R3R4goR0y5:SkyyrR2i131R3R4goR0y41:Fromage%20de%20ch%C3%A8vre%20-%20demi-secR2i60R3R4goR0y7:EpinardR2i16R3R4gh','2022-04-14 19:55:47','2022-04-14 07:55:47'),('productsExcerpt162','aoy4:namey5:Skyyry3:ridi491y5:imagey41:%2Fimg%2Ftaxo%2Fgrey%2Ffruits-legumes.pnggoR0y41:Fromage%20de%20ch%C3%A8vre%20-%20demi-secR2i308R3R4goR0y7:EpinardR2i151R3R4goR0y42:Fromage%20blanc%20%C3%A0%20la%20cr%C3%A8meR2i143R3R4goR0y10:Lait%20cruR2i74R3R4goR0y39:Courlis%20doux%20-%20Tomme%20de%20vacheR2i27R3R4gh','2022-04-14 19:55:19','2022-04-14 07:55:19');
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
INSERT INTO `Group` VALUES (1,'Alterconso du Val de Brenne',NULL,'Welcome in the group of Alterconso du Val de Brenne!\n You can look at the delivery planning or make a new order.',NULL,NULL,NULL,NULL,_binary 'by5:20%25i20y8:5%2C5%25d5.5h',18,1,1,NULL,'2022-04-13 09:30:56',2,'Ã¢â€šÂ¬','EUR',NULL,'',NULL,NULL,4,'<b>Rappel : Vous ÃƒÂªtes inscrit(e) ÃƒÂ  la permanence du [DATE_DISTRIBUTION],</b><br/>\n		Lieu de distribution : [LIEU_DISTRIBUTION]<br/>\n		<br/>\n		Voici la liste des bÃƒÂ©nÃƒÂ©voles inscrits :<br/>\n		[LISTE_BENEVOLES]<br/>',7,60,'Nous avons besoin de <b>bÃƒÂ©nÃƒÂ©voles pour la permanence du [DATE_DISTRIBUTION]</b><br/>\n		Lieu de distribution : [LIEU_DISTRIBUTION]<br/>\n		Les roles suivants sont ÃƒÂ  pourvoir :<br/>\n		[ROLES_MANQUANTS]<br/>\n		Cliquez sur \"calendrier des permanences\" pour vous inscrire !',1,NULL,2,NULL);
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
INSERT INTO `Message` VALUES (1,'1',_binary 'ay26:oceanep.lilas%40riseup.nety28:guillaume.penaud%40gmail.comy19:admin%40cagette.neth','Test','<style>\ntable.table{\n    border-collapse: collapse;\n}\n\ntable.table td{\n	border: 1px solid #ddd;\n	padding: 6px;\n}    \n</style>\n\n	\n<div>\n	\n\n\n<p>test</p>\n\n\n\n\n</div>\n\n<hr/>\n\n<div style=\"color:#666;font-size:12px;\">\n\n	<!-- btn -->\n	\n	<div style=\"width:50%;max-width:300px;margin: 12px auto;padding: 8px;text-decoration: none;background: #070;border-radius: 3px;text-align: center;\">\n		<a href=\"http://localhost/group/1\" style=\"color: white;font-weight: bold;text-decoration: none;font-size:1.2em;\">\n			&rarr; Alterconso du Val de Brenne\n		</a>\n	</div>\n	\n\n	Cet email a ÃƒÂ©tÃƒÂ© envoyÃƒÂ© depuis <a href=\"http://localhost\">Cagette.net</a>.\n\n	\n		<br/>\n		Vous recevez ce message car vous faites partie de <b>Alterconso du Val de Brenne</b>\n		 ( Tout le monde ) \n		<br/>\n		\n	\n\n	\n\n	\n\n</div>','2022-04-13 11:46:09',1,1);
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
INSERT INTO `Product` VALUES (3,'Epinard','000-001',2.8,5.5,'Une botte d\'ÃƒÂ©pinard.',100,2,500,1,0,0,0,0,0,0,1,5,NULL,NULL),(4,'Fromage de chÃƒÂ¨vre - demi-sec','000-002',3.2,5.5,NULL,20,0,1,1,0,0,0,0,0,0,1,5,NULL,NULL),(5,'Courlis doux - Tomme de vache','000-003',10,5.5,NULL,20,2,600,1,0,0,0,0,0,0,1,5,NULL,NULL),(6,'Fromage blanc ÃƒÂ  la crÃƒÂ¨me','000-004',3.4,5.5,NULL,10,2,500,0,0,0,0,0,0,0,1,4,NULL,NULL),(7,'Skyyr','000-01',2.4,5.5,NULL,10,2,500,0,0,0,0,0,0,0,1,4,NULL,NULL),(8,'Lait cru','000-002',1.6,5.5,NULL,10,3,1,0,0,0,0,0,0,0,1,4,NULL,NULL);
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
INSERT INTO `Session` VALUES ('F8CI6aJoLcIRqMlMo4ksqFYdxdIUXbba','172.23.0.1','fr',_binary 'ah','2022-04-13 12:02:27','2022-04-13 11:44:35',_binary 'o–)¾\Ëi\0\0\0È¬‹i\0\0\0\0Žð 5N¿ö>=N\0\0\0\0z',1),('ftbsSBpAqujRDfw4ABxbk0wBbVJCDRhF','172.22.0.1','fr',_binary 'ah','2022-04-14 08:13:55','2022-04-14 07:55:36',_binary 'o–)¾\Ëi\0\0\0È¬‹i\0\0\0\0Žð 5N¿ö>=N\0\0\0\0z',2),('IDMhMYDDMJWqSbmqfDY3vX76CMk0q9mv','172.24.0.1','fr',_binary 'ah','2022-04-13 09:38:53','2022-04-13 09:35:31',_binary 'o–)¾\Ëi\0\0\0È¬‹i\0\0\0\0Žð 5N¿ö>=N\0\0\0\0z',1),('OEjo2J4noCp6xQSIwK4YCnS2TX1N2JWj','172.24.0.1','en',_binary 'ah','2022-04-12 14:57:20','2022-04-12 14:54:14',_binary 'o\0\0\0\0z',NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TxpCategory`
--

LOCK TABLES `TxpCategory` WRITE;
/*!40000 ALTER TABLE `TxpCategory` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TxpProduct`
--

LOCK TABLES `TxpProduct` WRITE;
/*!40000 ALTER TABLE `TxpProduct` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TxpSubCategory`
--

LOCK TABLES `TxpSubCategory` WRITE;
/*!40000 ALTER TABLE `TxpSubCategory` DISABLE KEYS */;
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
INSERT INTO `User` VALUES (1,'fr','85b7bb7786dc54ccdc187d246eaae67c',0,'Alix','VINIGIER','admin@cagette.net',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-04-13','2022-04-14 07:55:44',6,0,NULL,NULL),(2,'fr','d695081830b98fd4978d81d1e9ead134',0,'Guillaume','PENAUD','guillaume.penaud@gmail.com','06 66 22 24 75',NULL,NULL,NULL,NULL,'9 Rue de Cretey',NULL,'71270','Torpes','1984-07-17','FR','FR','2022-04-13','2022-04-14 07:55:13',4,0,NULL,NULL),(3,'fr','88587623c254caa96909038d2d699ee6',0,'OcÃƒÂ©ane','PEISEY','oceanep.lilas@riseup.net',NULL,NULL,NULL,NULL,NULL,'9 Rue de Cretey',NULL,'71270','Torpes','1989-04-13','FR','FR','2022-04-13',NULL,4,0,NULL,NULL);
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
INSERT INTO `Vendor` VALUES (1,'Jean Martin EURL',NULL,NULL,'jean.martin@cagette.net',NULL,NULL,NULL,'00000','Martignac',NULL,NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(2,'Ferme du Jointout','Thomas et AdÃƒÂ¨le',51,'fermedujointout@riseup.net','06 54 23 87 09','7 Rue du Portail',NULL,'71270','Torpes','FR','MaraÃƒÂ®chage, fromage','2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(3,'Ferme Adiiris','Adrien et Iris Reichlin',29,'adiiris@riseup.net','06 54 87 32 14','149 route de Sens',NULL,'71330','Saint-Germain-du-Bois','FR',NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(4,'Ferme Adiiris','Adrien et Iris Reichlin',29,'adiiris@riseup.net','06 84 25 76 98','149 Route de Sens',NULL,'71330','Saint-Germain-Du-Bois','FR',NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(5,'Ferme du Jointout',NULL,51,'fermedujointout@riseup.net','06 34 89 56 43','7 Rue du Portail',NULL,'71270','Torpes','FR',NULL,'2022-04-13',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL);
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

-- Dump completed on 2022-04-14  8:14:04
