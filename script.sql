-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: maintenance
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `incidence_picture`
--

DROP TABLE IF EXISTS `incidence_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidence_picture` (
  `id_picture` int NOT NULL AUTO_INCREMENT,
  `picture` blob NOT NULL,
  `datetime` datetime NOT NULL,
  `id_incidence` int NOT NULL,
  PRIMARY KEY (`id_picture`),
  UNIQUE KEY `id_picture_UNIQUE` (`id_picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidence_picture`
--

LOCK TABLES `incidence_picture` WRITE;
/*!40000 ALTER TABLE `incidence_picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidence_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidence_types`
--

DROP TABLE IF EXISTS `incidence_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidence_types` (
  `id_incidence_type` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_incidence_type`),
  UNIQUE KEY `id_incidence_type_UNIQUE` (`id_incidence_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidence_types`
--

LOCK TABLES `incidence_types` WRITE;
/*!40000 ALTER TABLE `incidence_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidence_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidences`
--

DROP TABLE IF EXISTS `incidences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidences` (
  `id_incidence` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(350) NOT NULL,
  `datetime` datetime NOT NULL,
  `id_user` int NOT NULL,
  `id_incidence_type` int NOT NULL,
  PRIMARY KEY (`id_incidence`),
  UNIQUE KEY `id_incidence_UNIQUE` (`id_incidence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidences`
--

LOCK TABLES `incidences` WRITE;
/*!40000 ALTER TABLE `incidences` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id_location` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` varchar(350) NOT NULL,
  `lat` varchar(45) NOT NULL,
  `long` varchar(45) NOT NULL,
  PRIMARY KEY (`id_location`),
  UNIQUE KEY `id_location_UNIQUE` (`id_location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_pictures`
--

DROP TABLE IF EXISTS `maintenance_pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_pictures` (
  `id_picture` int NOT NULL AUTO_INCREMENT,
  `picture` blob NOT NULL,
  `datetime` datetime NOT NULL,
  `id_maintenance` int NOT NULL,
  PRIMARY KEY (`id_picture`),
  UNIQUE KEY `id_picture_UNIQUE` (`id_picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_pictures`
--

LOCK TABLES `maintenance_pictures` WRITE;
/*!40000 ALTER TABLE `maintenance_pictures` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_types`
--

DROP TABLE IF EXISTS `maintenance_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_types` (
  `id_maintenance_type` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_maintenance_type`),
  UNIQUE KEY `id_maintenance_type_UNIQUE` (`id_maintenance_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_types`
--

LOCK TABLES `maintenance_types` WRITE;
/*!40000 ALTER TABLE `maintenance_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenances` (
  `id_maintenance` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(350) NOT NULL,
  `datetime` datetime NOT NULL,
  `id_maintenance_type` int NOT NULL,
  `id_location` int NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id_maintenance`),
  UNIQUE KEY `id_maintenance_UNIQUE` (`id_maintenance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `idusers_UNIQUE` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-30 11:06:43
