-- MySQL dump 10.13  Distrib 5.5.29, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sgctf_sqldemo
-- ------------------------------------------------------
-- Server version	5.5.29-0ubuntu0.12.04.2

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
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `Id` int(11) DEFAULT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Culture` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Siu Puglisi','spuglisi','vfo45flAjL','en-ZW'),(2,'Dewey Luk','dluk','n8kw02nwVe','en-US'),(3,'Aleshia Butters','abutters','Bf3Xe3oioB','en-US'),(4,'Azalee Loughman','aloughman','17n02VO1E5','en-US'),(5,'Nancey Daigre','ndaigre','Cv24815Gdf','de-DE'),(6,'Manie Gossard','mgossard','k54m1l2YHX','en-US'),(7,'Andres Anderton','aanderton','d30o4962Rx','en-US'),(8,'Alla Kirts','akirts','ic4O15GPQ6','en-US'),(9,'Lacie Waddy','lwaddy','p2Ft8lcI7Q','en-US'),(10,'Argelia Callender','acallender','u2D5t6Y96J','de-DE'),(11,'Mireille Frasier','mfrasier','42Qn0Ofgek','en-US'),(13,'Lorenza Scheider','lscheider','1T7lkEtgF6','en-US'),(14,'Cecelia Augustus','caugustus','1e47I146Xh','en-US'),(15,'Nelly Lemonds','nlemonds','01J45M156c','en-US'),(16,'Hai Polinsky','hpolinsky','7YxCs1S141','de-DE'),(17,'Susan Benfield','sbenfield','84rtE632j2','de-DE'),(18,'Leif Halbrook','lhalbrook','d4570f83Z0','en-ZW'),(19,'Saran Appleby','sappleby','mAP7M8iRu6','en-ZW'),(20,'Colin Riffe','criffe','25c23M7ILD','de-DE');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testTable`
--

DROP TABLE IF EXISTS `testTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testTable` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testTable`
--

LOCK TABLES `testTable` WRITE;
/*!40000 ALTER TABLE `testTable` DISABLE KEYS */;
INSERT INTO `testTable` VALUES (1,'Test','Hello, World'),(2,'Test2','Good-bye, World'),(3,'Test3','Hola, World'),(4,'Test4','Gutn, World');
/*!40000 ALTER TABLE `testTable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-03 23:53:30
