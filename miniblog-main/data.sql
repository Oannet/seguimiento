-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: posts
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `posts`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `posts` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `posts`;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `author` varchar(100) DEFAULT NULL,
  `access` tinyint(1) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `img` text,
  `text` text,
  `likes` int NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'anayanzi',1,'Be careful','img/post/FB_IMG_1627251261585.jpg','The eyes of truth are always watching you',2,'2024-09-10 21:02:16'),(2,'ivan_galindo',1,'Si soy','img/post/FB_IMG_1590990843960.jpg','La materia no se crea ni se destruye, solo se transforma',0,'2024-09-17 21:21:11'),(3,'peperevalo',1,'Dodge this!','img/post/FB_IMG_1577581434442.jpg','O no ono o nononononononononono',1,'2024-09-17 21:29:45'),(4,'davidshiro',1,'Fortune','img/post/FB_IMG_1616020448914.jpg','Nothing is impossible. The word itself says \"I\'M POSSIBLE\"',0,'2024-09-17 21:38:06'),(5,'anayanzi',1,'La zorra y el cuervo',NULL,'Una zorra muy hambrienta vio a un cuervo posado sobre un árbol, con un trozo de queso en el pico. La zorra, que era muy astuta, ideó un plan para conseguir el queso.\r\n\r\n—¡Qué hermosas son tus plumas, amigo cuervo! ¡Qué brillo! ¡Qué color! Eres la envidia de todas las aves.\r\n\r\nEl cuervo se estiró sobre la rama, sacó pecho y extendió sus alas con orgullo. La zorra siguió piropeando al cuervo, pero todavía agarraba el queso con recelo. Hasta que…\r\n\r\n—Me han dicho que el cantar del cuervo supera cualquier cantar. ¿Es cierto, amigo cuervo? ¿Tan hermosa es tu voz? ¿Cantarías algo para mí?\r\n\r\nEntonces, lleno de vanidad, el cuervo tomó aire, abrió el pico y graznó lo más fuerte que pudo. Cuando terminó, vio a la zorra alejarse feliz con el trozo de queso en su boca.',1,'2024-09-17 21:46:51'),(6,'cc.villatoro',0,'Don\'t throw away what you love','img/post/FB_IMG_1548909879452.jpg','',0,'2024-09-19 13:30:04'),(7,'cc.villatoro',1,'Frida, la perrita rescatista','img/post/IMG_20170921_103739.jpg','Frida, de raza labrador color miel, nació el 12 de abril de 2009 en la Unidad Canina de la Secretaría de Marina, hoy Subgrupo de Control Canino, perteneciente al Estado Mayor de la Armada de México.\r\n\r\nDe acuerdo con sus entrenadores, desde los primeros días de nacida la cachorrita mostró aptitudes y cualidades que la destacaron del resto. Sus manejadores caninos encontraron en ella concentración, temperamento, intrepidez, curiosidad, disposición, facilidad de aprendizaje, empatía y capacidad de convivencia.\r\n\r\nAdemás, debido a las características naturales de su raza como lo son resistencia física, oídos finos para distinguir órdenes entre gritos o ruido, y una alta capacidad olfativa, se convirtió en un ejemplar idóneo para la búsqueda y el rescate.\r\n  \r\n<a href=\"https://youtu.be/R9scZieDxJk?si=M9muX2JcuDr6p4lX\">Frida, la perrita rescatista </a>',2,'2024-09-19 13:39:17'),(9,'ivan_galindo',0,'SimSimi','img/post/FB_IMG_1479705811526.jpg','Dolió, pero tiene toda la razón',0,'2024-09-20 18:20:12'),(10,'ivan_galindo',1,'Por eso joven','img/post/20881990_1115624445235671_3130721242794330948_n.jpg','Como cuando un perro sale antes de un exámen de Algebra lineal 2 antes que tú',0,'2024-09-20 18:22:29'),(11,'peperevalo',1,'Lamentable','img/post/FB_IMG_1579500042256.jpg','',0,'2024-09-23 10:00:14'),(12,'peperevalo',1,'¿Qué número es P?','img/post/FB_IMG_1617056783998.jpg','P es primo.\r\nLa posición de P en los primos, es un primo Q.\r\nLos dígitos de P al multiplicarlos, nos da Q.\r\nP[::-1] es primo.\r\nLa posición en los primos de P[::-1] es Q[::-1]\r\nP es el único número que cumple todas estas propiedades.\r\n\r\nHint: Big Bang theory\r\nQ[::-1]',0,'2024-09-23 10:28:27'),(13,'cc.villatoro',1,'Los caminos de la vida','img/post/FB_IMG_1563893718899.jpg','',1,'2024-09-23 10:31:57'),(14,'davidshiro',1,'CS behaviour','img/post/FB_IMG_1564516475362.jpg','Yo en toda la carrera',0,'2024-09-23 10:34:43'),(15,'davidshiro',0,'Felicidad','img/post/FB_IMG_1598024248264.jpg','A pan de muerto',0,'2024-09-23 10:36:27'),(16,'anayanzi',1,'Regalos navideños','img/post/FB_IMG_1608458199019.jpg','Calcetines, ropa, tuppers, o un iphone :D',0,'2024-09-23 10:40:27');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(100) NOT NULL,
  `password` varchar(162) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `second_name` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('anayanzi','ReprobarAlumnos.com','Anayanzi','Martínez','1999-12-31'),('cc.villatoro','gansito919','Cecilia','Villatoro','1999-04-02'),('davidshiro','Patito001','David','Silva','1998-09-23'),('ivan_galindo','monetosh021','Ivan','Galindo','1998-09-11'),('peperevalo','PerroSalchichaGordoBachicha','Jose','Arévalo','1996-11-23');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-23 11:17:51
