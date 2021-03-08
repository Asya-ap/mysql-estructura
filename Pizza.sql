CREATE DATABASE  IF NOT EXISTS `Pizzeria` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `Pizzeria`;
-- MySQL dump 10.13  Distrib 5.7.32, for osx10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: Pizzeria
-- ------------------------------------------------------
-- Server version	5.7.32

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
-- Table structure for table `Categoria_pizza`
--

DROP TABLE IF EXISTS `Categoria_pizza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Categoria_pizza` (
  `Categoria_id` int(11) NOT NULL AUTO_INCREMENT,
  `Categoria_nombre` varchar(50) NOT NULL,
  `Categoria_pizza_Categoria_id` int(11) NOT NULL,
  PRIMARY KEY (`Categoria_id`,`Categoria_pizza_Categoria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categoria_pizza`
--

LOCK TABLES `Categoria_pizza` WRITE;
/*!40000 ALTER TABLE `Categoria_pizza` DISABLE KEYS */;
/*!40000 ALTER TABLE `Categoria_pizza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cliente` (
  `Cliente_id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellidos` varchar(45) NOT NULL,
  `Direccion` varchar(50) NOT NULL,
  `Codigo_postal` int(11) NOT NULL,
  `Telefono` int(11) NOT NULL,
  `Localidad_Localidad_id` int(11) NOT NULL,
  `Provincia_Provincia_id` int(11) NOT NULL,
  PRIMARY KEY (`Cliente_id`,`Localidad_Localidad_id`,`Provincia_Provincia_id`),
  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`),
  UNIQUE KEY `Apellidos_UNIQUE` (`Apellidos`),
  UNIQUE KEY `Codigo_postal_UNIQUE` (`Codigo_postal`),
  KEY `fk_Cliente_Localidad_idx` (`Localidad_Localidad_id`),
  CONSTRAINT `fk_Cliente_Localidad` FOREIGN KEY (`Localidad_Localidad_id`) REFERENCES `Localidad` (`Localidad_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Empleado`
--

DROP TABLE IF EXISTS `Empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Empleado` (
  `Empleado_id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellidos` varchar(45) NOT NULL,
  `Nif` varchar(20) NOT NULL,
  `Tlf` int(11) NOT NULL,
  `Tipo` varchar(60) NOT NULL COMMENT 'Cocinero/Repartidor',
  `Restaurante_Restaurante_id` int(11) NOT NULL,
  `Restaurante_Localidad_Localidad_id` int(11) NOT NULL,
  `Restaurante_Localidad_Provincia_Provincia_id` int(11) NOT NULL,
  PRIMARY KEY (`Empleado_id`,`Restaurante_Restaurante_id`,`Restaurante_Localidad_Localidad_id`,`Restaurante_Localidad_Provincia_Provincia_id`),
  UNIQUE KEY `Nif_UNIQUE` (`Nif`),
  UNIQUE KEY `Apellidos_UNIQUE` (`Apellidos`),
  KEY `fk_Empleado_Restaurante1_idx` (`Restaurante_Restaurante_id`,`Restaurante_Localidad_Localidad_id`,`Restaurante_Localidad_Provincia_Provincia_id`),
  CONSTRAINT `fk_Empleado_Restaurante1` FOREIGN KEY (`Restaurante_Restaurante_id`, `Restaurante_Localidad_Localidad_id`, `Restaurante_Localidad_Provincia_Provincia_id`) REFERENCES `Restaurante` (`Restaurante_id`, `Localidad_Localidad_id`, `Localidad_Provincia_Provincia_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleado`
--

LOCK TABLES `Empleado` WRITE;
/*!40000 ALTER TABLE `Empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `Empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Entrega_domicilio`
--

DROP TABLE IF EXISTS `Entrega_domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Entrega_domicilio` (
  `Repartidor_id` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` datetime NOT NULL,
  PRIMARY KEY (`Repartidor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Entrega_domicilio`
--

LOCK TABLES `Entrega_domicilio` WRITE;
/*!40000 ALTER TABLE `Entrega_domicilio` DISABLE KEYS */;
/*!40000 ALTER TABLE `Entrega_domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Localidad`
--

DROP TABLE IF EXISTS `Localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Localidad` (
  `Localidad_id` int(11) NOT NULL AUTO_INCREMENT,
  `Provincia_Provincia_id` int(11) NOT NULL,
  `Localidad_nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Localidad_id`,`Provincia_Provincia_id`),
  KEY `fk_Localidad_Provincia1_idx` (`Provincia_Provincia_id`),
  CONSTRAINT `fk_Localidad_Provincia1` FOREIGN KEY (`Provincia_Provincia_id`) REFERENCES `Provincia` (`Provincia_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Localidad`
--

LOCK TABLES `Localidad` WRITE;
/*!40000 ALTER TABLE `Localidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `Localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pedido` (
  `Pedido_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Productos del pedido',
  `Restaurante_Restaurante_id` int(11) NOT NULL,
  `Repartidor_Repartidor_id` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  PRIMARY KEY (`Pedido_id`,`Restaurante_Restaurante_id`,`Repartidor_Repartidor_id`),
  KEY `fk_Pedido_Restaurante1_idx` (`Restaurante_Restaurante_id`),
  KEY `fk_Pedido_Repartidor1_idx` (`Repartidor_Repartidor_id`),
  CONSTRAINT `fk_Pedido_Repartidor1` FOREIGN KEY (`Repartidor_Repartidor_id`) REFERENCES `Entrega_domicilio` (`Repartidor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Restaurante1` FOREIGN KEY (`Restaurante_Restaurante_id`) REFERENCES `Restaurante` (`Restaurante_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pizza`
--

DROP TABLE IF EXISTS `Pizza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pizza` (
  `Categorai_pizza_Categoria_id` int(11) NOT NULL,
  `Tipo_productos_Productos_id` int(11) NOT NULL,
  `Categoria_pizza_Categoria_id` int(11) NOT NULL,
  `Categoria_pizza_Categoria_pizza_Categoria_id` int(11) NOT NULL,
  PRIMARY KEY (`Categorai_pizza_Categoria_id`,`Tipo_productos_Productos_id`,`Categoria_pizza_Categoria_id`,`Categoria_pizza_Categoria_pizza_Categoria_id`),
  KEY `fk_Pizza_Tipo_productos1_idx` (`Tipo_productos_Productos_id`),
  KEY `fk_Pizza_Categoria_pizza1_idx` (`Categoria_pizza_Categoria_id`,`Categoria_pizza_Categoria_pizza_Categoria_id`),
  CONSTRAINT `fk_Pizza_Categoria_pizza1` FOREIGN KEY (`Categoria_pizza_Categoria_id`, `Categoria_pizza_Categoria_pizza_Categoria_id`) REFERENCES `Categoria_pizza` (`Categoria_id`, `Categoria_pizza_Categoria_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Pizza_Tipo_productos1` FOREIGN KEY (`Tipo_productos_Productos_id`) REFERENCES `Tipo_productos` (`Productos_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pizza`
--

LOCK TABLES `Pizza` WRITE;
/*!40000 ALTER TABLE `Pizza` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pizza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pizzeria_web`
--

DROP TABLE IF EXISTS `Pizzeria_web`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pizzeria_web` (
  `Pedido_id` int(11) NOT NULL AUTO_INCREMENT,
  `Cliente_Cliente_id` int(11) NOT NULL,
  `Cliente_Localidad_Localidad_id` int(11) NOT NULL,
  `Cliente_Provincia_Provincia_id` int(11) NOT NULL,
  `Pedido` datetime NOT NULL,
  `Tipo_productos` varchar(90) NOT NULL COMMENT 'numero de productos seleccionados',
  `Entrega` bit(1) NOT NULL COMMENT 'Entrega a domicilio o recogida en el restaurante',
  `Precio_total` decimal(8,0) NOT NULL,
  `Pedido_Pedido_id` int(11) NOT NULL,
  `Cliente_Cliente_id1` int(11) NOT NULL,
  `Cliente_Localidad_Localidad_id1` int(11) NOT NULL,
  `Cliente_Provincia_Provincia_id1` int(11) NOT NULL,
  `Pedido_Pedido_id1` int(11) NOT NULL,
  `Pedido_Restaurante_Restaurante_id` int(11) NOT NULL,
  `Pedido_Repartidor_Repartidor_id` int(11) NOT NULL,
  PRIMARY KEY (`Pedido_id`,`Cliente_Cliente_id`,`Cliente_Localidad_Localidad_id`,`Cliente_Provincia_Provincia_id`,`Pedido_Pedido_id`,`Cliente_Cliente_id1`,`Cliente_Localidad_Localidad_id1`,`Cliente_Provincia_Provincia_id1`,`Pedido_Pedido_id1`,`Pedido_Restaurante_Restaurante_id`,`Pedido_Repartidor_Repartidor_id`),
  KEY `fk_Pizzeria_web_Cliente1_idx` (`Cliente_Cliente_id1`,`Cliente_Localidad_Localidad_id1`,`Cliente_Provincia_Provincia_id1`),
  KEY `fk_Pizzeria_web_Pedido1_idx` (`Pedido_Pedido_id1`,`Pedido_Restaurante_Restaurante_id`,`Pedido_Repartidor_Repartidor_id`),
  CONSTRAINT `fk_Pizzeria_web_Cliente1` FOREIGN KEY (`Cliente_Cliente_id1`, `Cliente_Localidad_Localidad_id1`, `Cliente_Provincia_Provincia_id1`) REFERENCES `Cliente` (`Cliente_id`, `Localidad_Localidad_id`, `Provincia_Provincia_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Pizzeria_web_Pedido1` FOREIGN KEY (`Pedido_Pedido_id1`, `Pedido_Restaurante_Restaurante_id`, `Pedido_Repartidor_Repartidor_id`) REFERENCES `Pedido` (`Pedido_id`, `Restaurante_Restaurante_id`, `Repartidor_Repartidor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pizzeria_web`
--

LOCK TABLES `Pizzeria_web` WRITE;
/*!40000 ALTER TABLE `Pizzeria_web` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pizzeria_web` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Provincia`
--

DROP TABLE IF EXISTS `Provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Provincia` (
  `Provincia_id` int(11) NOT NULL AUTO_INCREMENT,
  `Provincia_nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Provincia_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Provincia`
--

LOCK TABLES `Provincia` WRITE;
/*!40000 ALTER TABLE `Provincia` DISABLE KEYS */;
/*!40000 ALTER TABLE `Provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restaurante`
--

DROP TABLE IF EXISTS `Restaurante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Restaurante` (
  `Restaurante_id` int(11) NOT NULL AUTO_INCREMENT,
  `Direccion` varchar(60) NOT NULL,
  `Codigo_postal` int(10) unsigned NOT NULL,
  `Localidad_Localidad_id` int(11) NOT NULL,
  `Localidad_Provincia_Provincia_id` int(11) NOT NULL,
  PRIMARY KEY (`Restaurante_id`,`Localidad_Localidad_id`,`Localidad_Provincia_Provincia_id`),
  KEY `fk_Restaurante_Localidad1_idx` (`Localidad_Localidad_id`,`Localidad_Provincia_Provincia_id`),
  CONSTRAINT `fk_Restaurante_Localidad1` FOREIGN KEY (`Localidad_Localidad_id`, `Localidad_Provincia_Provincia_id`) REFERENCES `Localidad` (`Localidad_id`, `Provincia_Provincia_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurante`
--

LOCK TABLES `Restaurante` WRITE;
/*!40000 ALTER TABLE `Restaurante` DISABLE KEYS */;
/*!40000 ALTER TABLE `Restaurante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tipo_productos`
--

DROP TABLE IF EXISTS `Tipo_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tipo_productos` (
  `Productos_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `Descripcion` varchar(90) NOT NULL,
  `Imagen` varbinary(8000) NOT NULL,
  `Precio` int(11) NOT NULL,
  `Pedido_Pedido_id` int(11) NOT NULL,
  `Pedido_Restaurante_Restaurante_id` int(11) NOT NULL,
  `Pedido_Repartidor_Repartidor_id` int(11) NOT NULL,
  PRIMARY KEY (`Productos_id`),
  UNIQUE KEY `Hamburguesa_nombre_UNIQUE` (`nombre`),
  KEY `fk_Tipo_productos_Pedido1_idx` (`Pedido_Pedido_id`,`Pedido_Restaurante_Restaurante_id`,`Pedido_Repartidor_Repartidor_id`),
  CONSTRAINT `fk_Tipo_productos_Pedido1` FOREIGN KEY (`Pedido_Pedido_id`, `Pedido_Restaurante_Restaurante_id`, `Pedido_Repartidor_Repartidor_id`) REFERENCES `Pedido` (`Pedido_id`, `Restaurante_Restaurante_id`, `Repartidor_Repartidor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipo_productos`
--

LOCK TABLES `Tipo_productos` WRITE;
/*!40000 ALTER TABLE `Tipo_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tipo_productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-08  9:37:49
