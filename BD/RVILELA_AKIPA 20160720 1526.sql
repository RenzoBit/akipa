-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.21


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema rvilela_akipa
--

CREATE DATABASE IF NOT EXISTS rvilela_akipa;
USE rvilela_akipa;

--
-- Definition of table `anuncio`
--

DROP TABLE IF EXISTS `anuncio`;
CREATE TABLE `anuncio` (
  `idanuncio` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al anuncio',
  `idcampana` int(10) unsigned NOT NULL COMMENT 'Número que identifica a la campaña al cual el anuncio se encuentra sujeto.',
  `descripcion` varchar(45) NOT NULL COMMENT 'Describe brevemente al anuncio.',
  `mensaje` varchar(100) NOT NULL COMMENT 'Mensaje que se enviará en forma de notificación al cliente',
  PRIMARY KEY (`idanuncio`),
  KEY `idcampana` (`idcampana`),
  CONSTRAINT `anuncio_ibfk_1` FOREIGN KEY (`idcampana`) REFERENCES `campana` (`idcampana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Anuncios que son enviados a los clientes a manera de notificación en su dispositivo móvil';

--
-- Dumping data for table `anuncio`
--

/*!40000 ALTER TABLE `anuncio` DISABLE KEYS */;
/*!40000 ALTER TABLE `anuncio` ENABLE KEYS */;


--
-- Definition of table `campana`
--

DROP TABLE IF EXISTS `campana`;
CREATE TABLE `campana` (
  `idcampana` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la campaña',
  `descripcion` varchar(45) NOT NULL COMMENT 'Describe brevemente a la campaña para entender rapidamente su propósito',
  `horainicio` time DEFAULT NULL COMMENT 'Hora del día desde que se encuentra activa la campaña',
  `horafin` time DEFAULT NULL COMMENT 'Hora del día en que finaliza la campaña',
  `fechainicio` date NOT NULL COMMENT 'Día desde que la campaña se encuentra vigente',
  `fechafin` date NOT NULL COMMENT 'Día en que la campaña deja de estar vigente',
  `objetivo` varchar(255) NOT NULL COMMENT 'Objetivo detallado de lo que se espera lograr con la campaña, para luego evaluar su logro',
  `tiempo` int(10) unsigned NOT NULL COMMENT 'Tiempo de estrega estimado en minutos para los platos que se despachan dentro de la campaña',
  `tipo` enum('A','C','P') NOT NULL COMMENT 'Tipo de campaña, puede ser "A" por campaña anual, "C" por campaña para clientes específicos y "P" por campaña que solo envía promociones',
  PRIMARY KEY (`idcampana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Se utiliza para delimitar en un período de tiempo las restricciones para la entrega de pedidos';

--
-- Dumping data for table `campana`
--

/*!40000 ALTER TABLE `campana` DISABLE KEYS */;
/*!40000 ALTER TABLE `campana` ENABLE KEYS */;


--
-- Definition of table `campanacliente`
--

DROP TABLE IF EXISTS `campanacliente`;
CREATE TABLE `campanacliente` (
  `idcampana` int(10) unsigned NOT NULL COMMENT 'Número que identifica a la campaña del tipo cliente.',
  `idcliente` int(10) unsigned NOT NULL COMMENT 'Número que identifica a los clientes específicos a los que se les enviará promociones y anuncios por campaña',
  PRIMARY KEY (`idcampana`,`idcliente`),
  KEY `idcliente` (`idcliente`),
  CONSTRAINT `campanacliente_ibfk_1` FOREIGN KEY (`idcampana`) REFERENCES `campana` (`idcampana`),
  CONSTRAINT `campanacliente_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Clientes que pertenecen a una campaña específica a quienes se les enviará promociones y anuncios';

--
-- Dumping data for table `campanacliente`
--

/*!40000 ALTER TABLE `campanacliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `campanacliente` ENABLE KEYS */;


--
-- Definition of table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `idcategoria` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la categoría de platos',
  `tipo` enum('A','B') NOT NULL COMMENT 'Tipo de categoría puede ser "A" por almuerzos o "B" por bebidas',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombra a la categoría de platos.',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción detallada de las características de la categoría',
  PRIMARY KEY (`idcategoria`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='La categoría clasifica a los plato en determinados grupos, tal como se muestra en la carta del restaurante';

--
-- Dumping data for table `categoria`
--

/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`idcategoria`,`tipo`,`nombre`,`descripcion`) VALUES 
 (1,'A','Menú del Día',NULL),
 (2,'A','Para Empezar',NULL),
 (3,'A','Para Compartir',NULL),
 (4,'A','Copas Marinas',NULL),
 (5,'A','Los caseros de toda la vida',NULL),
 (6,'A','Del Mar',NULL),
 (7,'A','Aves',NULL),
 (8,'A','Carnes',NULL),
 (9,'A','Tequeños ni tacaños ni pequeños',NULL),
 (10,'A','Ensaladas',NULL),
 (11,'A','Postres',NULL),
 (12,'B','Jugos & Frozen',NULL),
 (13,'B','Gaseosas',NULL),
 (14,'B','Infusiones',NULL),
 (15,'B','Café',NULL),
 (16,'B','Milshakes',NULL),
 (17,'B','Sour',NULL),
 (18,'B','Bebidas de la Case',NULL),
 (19,'B','Cocktails',NULL),
 (20,'B','Cervezas',NULL),
 (21,'B','Vinos',NULL),
 (22,'B','Chilcanos',NULL),
 (23,'B','Agua',NULL);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;


--
-- Definition of table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `idcliente` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al cliente',
  `idusuario` int(10) unsigned DEFAULT NULL COMMENT 'Número que identifica al usuario de sistema del cliente',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombres de cliente',
  `apellido` varchar(45) DEFAULT NULL COMMENT 'Apellidos paterno y materno del cliente',
  `correo` varchar(45) DEFAULT NULL COMMENT 'Correo electronico del cliente',
  `telefono` varchar(45) DEFAULT NULL COMMENT 'Numero de telefono para contactar al cliente y confirmar sus pedidos',
  `domicilio1` varchar(255) DEFAULT NULL COMMENT 'Domicilio principal del cliente para las entregas',
  `domicilio2` varchar(255) DEFAULT NULL COMMENT 'Primer domicilio alternativo del cliente',
  `domicilio3` varchar(255) DEFAULT NULL COMMENT 'Segundo domicilio alternativo del cliente',
  `sexo` varchar(45) NOT NULL DEFAULT 'I' COMMENT 'Sexo del cliente M por masculino, F por femenino e I por no especificado',
  `fechanacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento del cliente',
  `facebook` varchar(45) DEFAULT NULL COMMENT 'Codigo que identifica la cuenta de facebook del cliente, si es que se registro por ese medio',
  PRIMARY KEY (`idcliente`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='Cliente previamente registrado en el sistema o nuevo que se registra por medio de la aplicación móvil';

--
-- Dumping data for table `cliente`
--

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`idcliente`,`idusuario`,`nombre`,`apellido`,`correo`,`telefono`,`domicilio1`,`domicilio2`,`domicilio3`,`sexo`,`fechanacimiento`,`facebook`) VALUES 
 (1,5,'Renzo','Vilela','tegobijava00@gmail.com',NULL,'Av. 01',NULL,NULL,'M',NULL,'renzo.vilela'),
 (2,6,'Yanett','Huaroc Pocomucha','yhuaroc@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (3,7,'Monica','Arcelles','marcelles@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (4,8,'Gina','Gonzales','ggonzales@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (5,9,'Carlos','Gutierrez','cgutierrez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (6,10,'Marco','Carlotto','mcarlotto@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (7,11,'Singrid','Grados','sgrados@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (8,12,'Miyuki','Aguero','mcamac@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (9,13,'Eroy','Diaz','ediaz@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (10,14,'Yenne','Chavez','ychavez@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (11,15,'Rosario','Perez','rperez@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (12,16,'Rafael','Guillen','rguillen@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (13,17,'Carlos','Cahuana','ccahuana@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (14,18,'Alan','Pillaca','apillaca@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (15,19,'Rosalyn','Pillaca','rpillaca@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (16,20,'Angie','Abregu','aabregu@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (17,21,'Fiorella','Mendo','fmendo@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (18,22,'Julissa Joshanny','Montalvo Guerrero','jmontalvo@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (19,23,'Juan Carlos','Villar','jvillar@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (20,24,'Karin Elman','Coz Martel','kcoz@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (21,25,'Yaquelin Marghot','Laura Najarro','ylaura@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (22,26,'Soledad Silvia','Canaza Choque','scanaza@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (23,27,'Paolo Cesar','Mercedes Salazar','pmercedes@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (24,28,'Tania Margoth','Huarancca Quispe','thuarancca@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (25,29,'Jennifer Fiorella','Cajavilca Montero','fcajavilca@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (26,30,'Pablo Roberto','Vargas Marquina','pvargas@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (27,31,'Jessica Strit','Iberico Castro','jiberico@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (28,32,'Lizet Cecilia','Arango Quispe','larango@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (29,33,'Angel Felipe','Vasquez Levano','avasquez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (30,34,'Luis','Portuguez','lportuguez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (31,35,'Elizabeth','Vargas','evargas@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (32,36,'Wilber','Yataco Saravia','wyataco@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (33,37,'Pablo Daniel','Sanchez Rodriguez','psanchez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (34,38,'Sara Mercedes','Gonzales Carrasco','sgonzales@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (35,39,'Yanina','Guardia Villalobos','yguardia@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (36,40,'Sheila Lidia','Marquez Montoya','smarquez@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (37,41,'Elena Elizabeth','Hidalgo Fernandez','ehidalgo@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (38,42,'Carmen Rosa','Quintana Rodriguez','cquintana@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (39,43,'Maritza Liliana','Asmat Mallma','masmat@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (40,44,'Quely Hayne','Quispe Chacon','qquispe@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (41,45,'Karin Rosmery','Gomez Cruz','kgomez@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (42,46,'Karina Judith','Ortiz Galarza','kortiz@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (43,47,'Jose Carlos','Arroyo Quispe','jarroyo@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (44,48,'Sonia Gisela','Soto Medina','ssoto@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (45,49,'Juan Oscar','Barba Barboza','jbarba@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (46,50,'William','Pisfil Llontop','wpisfil@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (47,51,'Julia Nilda','Campos Cordova','jcampos@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (48,52,'Olga Mercedes','Donayre Revoredo','odonayre@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (49,53,'Natalia','Ascona Cerna','nascona@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (50,54,'Eva Janet','Chavez Campos','echavez@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (51,55,'Jose Antonio','Yauri Martinez','jyauri@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (52,56,'Sally Jackelyn','Tejada Pinto','stejada@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (53,57,'Cecilia Janet','Torres Condor','ctorres@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (54,58,'Michelee','Castillo Cruz','mcastillo@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (55,59,'Maria Isabel','Ulloa Lara','mulloa@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (56,60,'Maritza Jaquelli','Roca Estrada','mroca@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (57,61,'Liliana Marisol','Zegarra Zuñiga','lzegarra@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (58,62,'David Ademir','Guanilo Gamboa','dguanilo@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (59,63,'Cecilia Alicia','Ascencion Varela','cascencion@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (60,64,'Juan Carlos','Utia Yataco','jutia@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (61,65,'Alexis Miguel','Verastegui Azalde','averastegui@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (62,66,'Teresa','Sanchez Sabogal','tsanchez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (63,67,'Katherine Evelyn','Medina Acaro','kmedina@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (64,68,'Elisa','Cuaresma Barrientos','ecuaresma@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (65,69,'Michael Julio','Leyva Minaya','mleyva@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (66,70,'Edita','Yance','eyance@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (67,71,'Romina','Marcial','rmarcial@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (68,72,'Jeyssy','Franco','jfranco@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (69,73,'Evelyn','Ocrospoma','eocrospoma@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (70,74,'Sebastianino','Mengoni Uzategui','mengoni@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (71,75,'Jorge Cipriano','Berrocal Quinto','jberrocal@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (72,76,'Jonatan','Alvarez Oshiro','jalvarez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (73,77,'Yuri Zoraida','Diaz Arce','ydiaz@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (74,78,'Denisse Zarela','Durand Gutierrez','zdurand@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (75,79,'Edwin Mauro','Gamarra Quispe','egamarra@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (76,80,'Gianfranco','Peña Torres','gpena@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (77,81,'Karin','Sahuaraura Simbron','ksahuaraura@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (78,82,'Christian Fernando','Andrade Montalvo','candrade@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (79,83,'Gonzalo Edward','Rodriguez Moreno','grodriguez@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (80,84,'Raul','Soto','rsoto@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (81,85,'Daice','Huachaca','dhuachaca @gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (82,86,'Daniel','Heredia','dheredia@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (83,87,'Elizabeth','Chumpitaz','echumpitaz@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (84,88,'Lilian','Quintanilla','lquintanilla@gmail.com',NULL,NULL,NULL,NULL,'F',NULL,NULL),
 (85,89,'Harry','Bueno','hbueno@gmail.com',NULL,NULL,NULL,NULL,'M',NULL,NULL),
 (86,90,'Tyrion','Lannister','tyrion2@gmail.com','948994444',NULL,NULL,NULL,'I',NULL,'tyrion.lannister'),
 (87,91,'Tyrion','Lannister','tyrion3@gmail.com','948994444',NULL,NULL,NULL,'I',NULL,'tyrion.lannister'),
 (88,92,'','','cheetahmen3@yahoo.com','',NULL,NULL,NULL,'I',NULL,''),
 (89,93,'First Name','Last Name','email@address.com','+918444880702',NULL,NULL,NULL,'I',NULL,'123456789'),
 (90,94,'First Name','Last Name','email@addres.com','+918444880702',NULL,NULL,NULL,'I',NULL,'123456789'),
 (91,95,'First Name','Last Name','email@add.com','+918444880702',NULL,NULL,NULL,'I',NULL,'123456789'),
 (92,96,'Tyrion','Lannister','tyrion6@gmail.com','948994444',NULL,NULL,NULL,'Male',NULL,'tyrion.lannister'),
 (93,97,'','','coco@gmail.com','',NULL,NULL,NULL,'',NULL,''),
 (94,98,'Daenerys','Targaryen','daenerys@gmail.com','948994444',NULL,NULL,NULL,'Female',NULL,'danny'),
 (95,99,'test1','test1','Female','test1@gmail.com',NULL,NULL,NULL,'',NULL,'qwertyyui'),
 (96,100,'','','Male','',NULL,NULL,NULL,'',NULL,''),
 (97,101,'test2','test2','test2@gmail.com','963563968',NULL,NULL,NULL,'Male',NULL,''),
 (98,102,'Bumba','Rock','mrbumba.jana1@gmail.com','92362916364',NULL,NULL,NULL,'Male',NULL,'mrbumba.jana1@gmail.com'),
 (99,103,'Daenerys','Targaryen','daenerys2@gmail.com','987698765',NULL,NULL,NULL,'Female',NULL,''),
 (100,104,'Renzo','Bit','cheetahmen2@yahoo.com','987987987',NULL,NULL,NULL,'Male',NULL,'cheetahmen2@yahoo.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;


--
-- Definition of table `cobertura`
--

DROP TABLE IF EXISTS `cobertura`;
CREATE TABLE `cobertura` (
  `idcobertura` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la cobertura',
  `idcampana` int(10) unsigned NOT NULL COMMENT 'Número que identifica a la campaña a la cual se limitará su cobertura geográfica',
  `latitud` varchar(45) NOT NULL COMMENT 'Punto de latitud que delimita el área de cobertura',
  `longitud` varchar(45) NOT NULL COMMENT 'Punto de longitud que delimita el área de cobertura',
  PRIMARY KEY (`idcobertura`),
  KEY `idcampana` (`idcampana`),
  CONSTRAINT `cobertura_ibfk_1` FOREIGN KEY (`idcampana`) REFERENCES `campana` (`idcampana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Delimita el área geográfica hacia donde pueden entregarse los pedidos';

--
-- Dumping data for table `cobertura`
--

/*!40000 ALTER TABLE `cobertura` DISABLE KEYS */;
/*!40000 ALTER TABLE `cobertura` ENABLE KEYS */;


--
-- Definition of table `dispositivo`
--

DROP TABLE IF EXISTS `dispositivo`;
CREATE TABLE `dispositivo` (
  `iddispositivo` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al dispositivo',
  `idcliente` int(10) unsigned DEFAULT NULL COMMENT 'Número que identifica al cliente propietario del dispositivo si es que no fuera uno usado para delivery',
  `imei` varchar(45) DEFAULT NULL COMMENT 'Código IMEI del dispositivo',
  `mac` varchar(45) DEFAULT NULL COMMENT 'Dirección MAC del dispositivo',
  `token` varchar(45) DEFAULT NULL COMMENT 'Token de activación para el envío de notificaciones hacia el dispositivo',
  `delivery` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si es o no un dispositivo usado por el repartidor para realizar entregas',
  PRIMARY KEY (`iddispositivo`),
  KEY `idcliente` (`idcliente`),
  CONSTRAINT `dispositivo_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dispositivos móviles propiedad del cliente para sus pedidos y los que son usados por los repartidores para sus entregas';

--
-- Dumping data for table `dispositivo`
--

/*!40000 ALTER TABLE `dispositivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispositivo` ENABLE KEYS */;


--
-- Definition of table `formapago`
--

DROP TABLE IF EXISTS `formapago`;
CREATE TABLE `formapago` (
  `idformapago` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la forma de pago',
  `descripcion` varchar(45) NOT NULL COMMENT 'Descripción concisa de la forma de pago',
  `token` varchar(45) DEFAULT NULL COMMENT 'Token de acceso al método de pago',
  `activo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si es un método de pago que se mostrará en la aplicación móvil',
  PRIMARY KEY (`idformapago`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Métodos de pago ofrecidos por el restaurante';

--
-- Dumping data for table `formapago`
--

/*!40000 ALTER TABLE `formapago` DISABLE KEYS */;
INSERT INTO `formapago` (`idformapago`,`descripcion`,`token`,`activo`) VALUES 
 (1,'Contraentrega',NULL,1),
 (2,'Paypal','8277e0910d750195b448797616e091ad',1),
 (3,'Google Wallet','c4ca4238a0b923820dcc509a6f75849b',0);
/*!40000 ALTER TABLE `formapago` ENABLE KEYS */;


--
-- Definition of table `interes`
--

DROP TABLE IF EXISTS `interes`;
CREATE TABLE `interes` (
  `idinteres` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la tabla',
  `idcliente` int(10) unsigned NOT NULL COMMENT 'Número que identifica al cliente que mostró interés por un plato',
  `idplato` int(10) unsigned NOT NULL COMMENT 'Número que identifica al plato visitado por el cliente',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora en la que se dió la visita',
  PRIMARY KEY (`idinteres`),
  KEY `idcliente` (`idcliente`),
  KEY `idplato` (`idplato`),
  CONSTRAINT `interes_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `interes_ibfk_2` FOREIGN KEY (`idplato`) REFERENCES `plato` (`idplato`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 COMMENT='Guarda las visitas de los clientes al detalle de los platos, que luego le podrán ser recomendados';

--
-- Dumping data for table `interes`
--

/*!40000 ALTER TABLE `interes` DISABLE KEYS */;
INSERT INTO `interes` (`idinteres`,`idcliente`,`idplato`,`fecha`) VALUES 
 (1,1,145,'2014-01-01 00:00:00'),
 (2,1,14,'2014-01-01 00:00:00'),
 (3,1,61,'2014-01-01 00:00:00'),
 (4,1,10,'2014-01-01 00:00:00'),
 (5,1,3,'2014-01-01 00:00:00'),
 (6,1,1,'2014-01-01 00:00:00'),
 (7,1,27,'2014-01-01 00:00:00'),
 (8,1,47,'2014-01-01 00:00:00'),
 (9,1,46,'2014-01-01 00:00:00'),
 (10,1,42,'2014-01-01 00:00:00'),
 (11,1,52,'2014-12-01 00:00:00'),
 (12,1,60,'2014-12-01 00:00:00'),
 (13,1,16,'2014-12-01 00:00:00'),
 (14,1,63,'2014-12-01 00:00:00'),
 (15,1,55,'2014-12-01 00:00:00'),
 (16,1,64,'2014-02-01 00:00:00'),
 (17,1,39,'2014-02-01 00:00:00'),
 (18,1,14,'2014-02-01 00:00:00'),
 (19,1,21,'2014-02-01 00:00:00'),
 (20,1,145,'2014-02-01 00:00:00'),
 (21,1,51,'2014-02-01 00:00:00'),
 (22,1,8,'2014-02-01 00:00:00'),
 (23,1,31,'2014-02-01 00:00:00'),
 (24,1,1,'2014-02-01 00:00:00'),
 (25,1,66,'2014-02-01 00:00:00'),
 (26,1,67,'2014-12-01 00:00:00'),
 (27,1,6,'2014-12-01 00:00:00'),
 (28,1,21,'2014-12-01 00:00:00'),
 (29,1,34,'2014-12-01 00:00:00'),
 (30,1,66,'2014-12-01 00:00:00'),
 (31,1,60,'2014-03-01 00:00:00'),
 (32,1,9,'2014-03-01 00:00:00'),
 (33,1,20,'2014-03-01 00:00:00'),
 (34,1,31,'2014-03-01 00:00:00'),
 (35,1,59,'2014-03-01 00:00:00'),
 (36,1,8,'2014-03-01 00:00:00'),
 (37,1,46,'2014-03-01 00:00:00'),
 (38,1,32,'2014-03-01 00:00:00'),
 (39,1,30,'2014-03-01 00:00:00'),
 (40,1,7,'2014-03-01 00:00:00'),
 (41,1,48,'2014-11-01 00:00:00'),
 (42,1,31,'2014-11-01 00:00:00'),
 (43,1,7,'2014-11-01 00:00:00'),
 (44,1,60,'2014-11-01 00:00:00'),
 (45,1,15,'2014-11-01 00:00:00'),
 (46,1,52,'2014-04-01 00:00:00'),
 (47,1,38,'2014-04-01 00:00:00'),
 (48,1,144,'2014-04-01 00:00:00'),
 (49,1,60,'2014-04-01 00:00:00'),
 (50,1,19,'2014-04-01 00:00:00'),
 (51,1,56,'2014-04-01 00:00:00'),
 (52,1,33,'2014-04-01 00:00:00'),
 (53,1,63,'2014-04-01 00:00:00'),
 (54,1,28,'2014-04-01 00:00:00'),
 (55,1,68,'2014-04-01 00:00:00'),
 (56,1,144,'2014-11-01 00:00:00'),
 (57,1,14,'2014-11-01 00:00:00'),
 (58,1,57,'2014-11-01 00:00:00'),
 (59,1,20,'2014-11-01 00:00:00'),
 (60,1,6,'2014-11-01 00:00:00'),
 (61,1,29,'2014-05-01 00:00:00'),
 (62,1,14,'2014-05-01 00:00:00'),
 (63,1,32,'2014-05-01 00:00:00'),
 (64,1,37,'2014-05-01 00:00:00'),
 (65,1,45,'2014-05-01 00:00:00'),
 (66,1,65,'2014-05-01 00:00:00'),
 (67,1,25,'2014-05-01 00:00:00'),
 (68,1,10,'2014-05-01 00:00:00'),
 (69,1,21,'2014-05-01 00:00:00'),
 (70,1,6,'2014-05-01 00:00:00'),
 (71,1,55,'2014-10-01 00:00:00'),
 (72,1,10,'2014-10-01 00:00:00'),
 (73,1,8,'2014-10-01 00:00:00'),
 (74,1,67,'2014-10-01 00:00:00'),
 (75,1,38,'2014-10-01 00:00:00'),
 (76,1,13,'2014-06-01 00:00:00'),
 (77,1,11,'2014-06-01 00:00:00'),
 (78,1,24,'2014-06-01 00:00:00'),
 (79,1,21,'2014-06-01 00:00:00'),
 (80,1,38,'2014-06-01 00:00:00'),
 (81,1,9,'2014-06-01 00:00:00'),
 (82,1,15,'2014-06-01 00:00:00'),
 (83,1,56,'2014-06-01 00:00:00'),
 (84,1,64,'2014-06-01 00:00:00'),
 (85,1,145,'2014-06-01 00:00:00'),
 (86,1,33,'2014-10-01 00:00:00'),
 (87,1,57,'2014-10-01 00:00:00'),
 (88,1,25,'2014-10-01 00:00:00'),
 (89,1,51,'2014-10-01 00:00:00'),
 (90,1,35,'2014-10-01 00:00:00'),
 (91,1,40,'2014-07-01 00:00:00'),
 (92,1,32,'2014-07-01 00:00:00'),
 (93,1,36,'2014-07-01 00:00:00'),
 (94,1,52,'2014-07-01 00:00:00'),
 (95,1,28,'2014-07-01 00:00:00'),
 (96,1,9,'2014-07-01 00:00:00'),
 (97,1,60,'2014-07-01 00:00:00'),
 (98,1,35,'2014-07-01 00:00:00'),
 (99,1,15,'2014-07-01 00:00:00'),
 (100,1,58,'2014-07-01 00:00:00'),
 (101,1,1,'2014-09-01 00:00:00'),
 (102,1,52,'2014-09-01 00:00:00'),
 (103,1,17,'2014-09-01 00:00:00'),
 (104,1,57,'2014-09-01 00:00:00'),
 (105,1,36,'2014-09-01 00:00:00'),
 (106,1,51,'2014-08-01 00:00:00'),
 (107,1,8,'2014-08-01 00:00:00'),
 (108,1,17,'2014-08-01 00:00:00'),
 (109,1,63,'2014-08-01 00:00:00'),
 (110,1,10,'2014-08-01 00:00:00'),
 (111,1,61,'2014-08-01 00:00:00'),
 (112,1,7,'2014-08-01 00:00:00'),
 (113,1,44,'2014-08-01 00:00:00'),
 (114,1,144,'2014-08-01 00:00:00'),
 (115,1,14,'2014-08-01 00:00:00'),
 (116,1,19,'2014-09-01 00:00:00'),
 (117,1,63,'2014-09-01 00:00:00'),
 (118,1,33,'2014-09-01 00:00:00'),
 (119,1,13,'2014-09-01 00:00:00'),
 (120,1,64,'2014-09-01 00:00:00'),
 (121,2,30,'2014-11-27 12:35:28'),
 (122,1,1,'2014-11-30 22:51:25'),
 (123,1,2,'2014-11-30 22:51:33'),
 (124,2,9,'2014-12-01 07:43:44'),
 (125,2,28,'2014-12-01 07:46:15'),
 (126,1,1,'2014-12-06 01:16:07'),
 (127,1,15,'2014-12-06 01:20:20'),
 (128,1,1,'2014-12-06 01:23:01'),
 (129,1,33,'2014-12-06 01:25:36'),
 (130,2,7,'2014-12-06 01:26:03'),
 (131,2,7,'2014-12-06 01:26:40'),
 (132,2,7,'2014-12-06 01:26:48'),
 (133,2,7,'2014-12-06 01:27:06'),
 (134,2,7,'2014-12-06 01:27:07'),
 (135,2,7,'2014-12-06 01:27:08'),
 (136,2,7,'2014-12-06 01:27:09'),
 (137,2,7,'2014-12-06 01:27:10'),
 (138,2,7,'2014-12-06 01:27:11'),
 (139,2,63,'2014-12-06 01:40:24'),
 (140,2,63,'2014-12-06 01:40:27'),
 (141,2,63,'2014-12-06 01:40:28'),
 (142,2,63,'2014-12-06 01:40:30'),
 (143,2,63,'2014-12-06 01:40:45'),
 (144,2,63,'2014-12-06 01:40:46'),
 (145,1,1,'2014-12-06 02:29:33'),
 (146,1,21,'2014-12-06 02:30:05'),
 (147,1,1,'2014-12-06 02:30:17'),
 (148,1,57,'2014-12-06 02:30:22'),
 (149,1,33,'2014-12-06 02:30:28'),
 (150,1,15,'2014-12-06 02:30:33'),
 (151,2,147,'2014-12-06 02:31:34'),
 (152,1,1,'2014-12-06 02:42:45'),
 (153,1,1,'2014-12-06 02:43:38'),
 (154,1,1,'2014-12-06 02:45:02'),
 (155,1,21,'2014-12-06 02:47:50'),
 (156,1,21,'2014-12-06 02:49:05'),
 (157,1,6,'2014-12-06 02:50:12'),
 (158,1,60,'2014-12-06 02:51:18'),
 (159,1,1,'2014-12-06 02:51:31'),
 (160,1,55,'2014-12-06 02:52:11'),
 (161,1,64,'2014-12-06 02:52:22'),
 (162,1,13,'2014-12-06 02:53:38'),
 (163,1,1,'2014-12-06 02:55:43'),
 (164,1,33,'2014-12-06 02:56:03'),
 (165,1,1,'2014-12-06 03:22:24'),
 (166,1,1,'2014-12-06 03:23:14'),
 (167,1,1,'2014-12-06 03:24:50'),
 (168,1,64,'2014-12-06 03:25:10'),
 (169,1,28,'2014-12-06 03:26:20'),
 (170,1,64,'2014-12-06 03:32:26'),
 (171,1,1,'2014-12-06 03:47:19'),
 (172,1,64,'2014-12-06 03:47:34'),
 (173,1,1,'2014-12-06 03:48:27'),
 (174,1,64,'2014-12-06 03:48:38'),
 (175,1,21,'2014-12-06 03:49:34'),
 (176,1,21,'2014-12-06 03:50:45'),
 (177,1,21,'2014-12-06 03:52:12'),
 (178,1,33,'2014-12-06 03:52:23'),
 (179,1,33,'2014-12-06 03:52:57'),
 (180,1,57,'2014-12-06 03:53:29'),
 (181,1,33,'2014-12-06 03:55:53'),
 (182,1,21,'2014-12-06 03:56:15'),
 (183,1,1,'2014-12-06 03:56:29'),
 (184,3,31,'2014-12-06 03:58:32'),
 (185,3,31,'2014-12-06 04:00:10'),
 (186,4,31,'2014-12-06 04:02:23'),
 (187,4,31,'2014-12-06 04:02:31'),
 (188,1,31,'2014-12-06 06:22:58'),
 (189,1,15,'2014-12-06 06:35:27'),
 (190,1,105,'2014-12-06 06:42:11'),
 (191,1,105,'2014-12-06 06:42:53'),
 (192,5,64,'2014-12-06 06:44:17'),
 (193,5,15,'2014-12-06 06:45:01'),
 (194,5,1,'2014-12-06 06:45:35'),
 (195,1,15,'2014-12-06 07:57:11'),
 (196,1,64,'2014-12-06 07:58:27'),
 (197,1,60,'2014-12-06 07:59:05'),
 (198,1,5,'2015-01-12 17:47:13'),
 (199,1,18,'2015-01-12 18:32:08'),
 (200,1,144,'2015-01-16 19:41:35'),
 (201,1,5,'2015-01-16 20:33:17'),
 (202,1,21,'2015-01-16 20:33:35'),
 (203,1,5,'2015-01-18 07:48:19'),
 (204,1,21,'2015-01-18 07:48:30'),
 (205,1,54,'2015-01-18 07:48:42'),
 (206,1,18,'2015-01-18 07:48:53'),
 (207,1,15,'2015-01-21 19:21:16'),
 (208,1,18,'2015-01-21 19:21:34'),
 (209,5,18,'2015-01-21 19:21:56'),
 (210,1,18,'2015-01-25 10:46:22'),
 (211,10,10,'2015-01-29 22:09:02'),
 (212,1,43,'2015-01-31 21:45:17'),
 (213,1,126,'2015-01-31 21:45:36'),
 (214,1,21,'2015-01-31 21:45:58'),
 (215,1,15,'2015-01-31 21:46:08'),
 (216,1,22,'2015-02-01 00:27:37'),
 (217,1,21,'2015-02-01 02:42:27');
/*!40000 ALTER TABLE `interes` ENABLE KEYS */;


--
-- Definition of table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `idpedido` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al pedido',
  `idcliente` int(10) unsigned NOT NULL COMMENT 'Número que identifica al cliente que realizó el pedido',
  `idformapago` int(10) unsigned NOT NULL COMMENT 'Número que identifica a la forma de pago elegida por el cliente',
  `idviaje` int(10) unsigned DEFAULT NULL COMMENT 'Número que identifica al viaje en el cual es repartido el pedido',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Día y hora en que se realizó el pedido',
  `domicilio` varchar(255) NOT NULL COMMENT 'Domicilio de entrega seleccionado por el cliente',
  `latitud` varchar(45) DEFAULT NULL COMMENT 'Coordenada de latitud capturada por el dispositivo al momento de realizar el pedido',
  `longitud` varchar(45) DEFAULT NULL COMMENT 'Coordenada de longitud capturada por el dispositivo al momento de realizar el pedido',
  `hora` time DEFAULT NULL COMMENT 'Hora que el cliente desea que se le entregué el pedido',
  `comentario` varchar(255) DEFAULT NULL COMMENT 'Comentario adicional realizado por el cliente respecto a su pedido',
  `aqui` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el lugar desde donde realizó el pedido también refiere al domicilio seleccionado',
  `estado` enum('P','A','C','E','R') NOT NULL DEFAULT 'P' COMMENT 'Estado del pedido, puede ser "P" por pendiente, "A" por aceptado, "C" por cancelado, "E" por entregado o "R" por rechazado',
  `cuenta` varchar(45) DEFAULT NULL COMMENT 'Nombre de la cuenta desde don de pago el pedido, si fue en línea',
  `transaccion` varchar(45) DEFAULT NULL COMMENT 'Identificador de la transacción del pago realizado',
  PRIMARY KEY (`idpedido`),
  KEY `idformapago` (`idformapago`),
  KEY `idviaje` (`idviaje`),
  KEY `idcliente` (`idcliente`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`idformapago`) REFERENCES `formapago` (`idformapago`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`idviaje`) REFERENCES `viaje` (`idviaje`),
  CONSTRAINT `pedido_ibfk_3` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Pedido de comida realizado por el cliente y que deberá ser atendido por el restaurante';

--
-- Dumping data for table `pedido`
--

/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` (`idpedido`,`idcliente`,`idformapago`,`idviaje`,`fecha`,`domicilio`,`latitud`,`longitud`,`hora`,`comentario`,`aqui`,`estado`,`cuenta`,`transaccion`) VALUES 
 (1,2,1,NULL,'2014-11-26 12:00:00','Av. Angamos 555','1','2','13:00:00',NULL,1,'P',NULL,NULL),
 (2,3,1,NULL,'2014-09-01 14:00:00','Chacarilla 1','2','3','14:30:00',NULL,1,'P',NULL,NULL),
 (3,4,1,NULL,'2014-07-10 11:00:00','Chacarilla 2','2','1','12:20:00',NULL,1,'P',NULL,NULL),
 (4,5,1,NULL,'2014-05-02 13:00:00','Chacarilla 3','1','1',NULL,NULL,1,'P',NULL,NULL),
 (5,6,1,NULL,'2014-11-03 13:00:00','Chacarilla 4','1','1',NULL,NULL,1,'P',NULL,NULL);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;


--
-- Definition of table `pedidodetalle`
--

DROP TABLE IF EXISTS `pedidodetalle`;
CREATE TABLE `pedidodetalle` (
  `idpedidodetalle` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la tabla',
  `idpedido` int(10) unsigned NOT NULL COMMENT 'Número que identifica al pedido al cual pertenece el detalle',
  `idplato` int(10) unsigned NOT NULL COMMENT 'Número que identifica al plato que forma parte del pedido',
  `cantidad` int(10) unsigned NOT NULL COMMENT 'Cantidad de platos solicitada',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio unitario del plato al momento de realizar el pedido',
  `descuento` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'El descuento, si lo hubiere, aplicado al precio del plato',
  `comentario` varchar(255) DEFAULT NULL COMMENT 'Comentario de recomendación del plato realizado por el cliente',
  `calificacion` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Calificación que da al cliente al plato',
  `aclaracion` varchar(255) DEFAULT NULL COMMENT 'Especifica la aclaración realizada por el cliente respecto al plato que pide',
  PRIMARY KEY (`idpedidodetalle`),
  KEY `idpedido` (`idpedido`),
  KEY `idplato` (`idplato`),
  CONSTRAINT `pedidodetalle_ibfk_1` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`),
  CONSTRAINT `pedidodetalle_ibfk_2` FOREIGN KEY (`idplato`) REFERENCES `plato` (`idplato`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='La información de los platos que solicita el cliente en su pedido';

--
-- Dumping data for table `pedidodetalle`
--

/*!40000 ALTER TABLE `pedidodetalle` DISABLE KEYS */;
INSERT INTO `pedidodetalle` (`idpedidodetalle`,`idpedido`,`idplato`,`cantidad`,`precio`,`descuento`,`comentario`,`calificacion`,`aclaracion`) VALUES 
 (1,1,1,1,'23.00','0.00','Llego a tiempo y todo perfecto',5,NULL),
 (2,1,15,1,'33.00','0.00','Me encanta su comida, siempre llega calentita y son buenas porciones',4,NULL),
 (3,1,21,2,'31.00','0.00','El pedido llego en el tiempo estimado y estaba todo realmente muy rico, quede muy satisfecha',5,NULL),
 (4,2,4,1,'30.00','0.00','Estaba super sabroso, les doy 4 estrellas',4,NULL),
 (5,2,18,3,'15.00','0.00','Siempre pedimos este plato en familia, a todos les encanta!',3,NULL),
 (6,2,28,2,'30.00','0.00','Debo comentar porque realmente el servicio es excelente.',5,NULL),
 (7,3,5,2,'27.00','0.00','Me gusta todo, muy rico y caliente!',5,NULL),
 (8,3,54,1,'19.00','0.00','Excelente variedad!',4,NULL),
 (9,3,64,3,'12.00','0.00','Llegaron a tiempo, muy buen sabor y excelente presentación',4,NULL),
 (10,4,1,1,'23.00','0.00','Sin dudas los mejores',5,NULL),
 (11,4,21,1,'31.00','0.00','Esta increible. La comida llega a tiempo :)',5,NULL),
 (12,5,18,1,'15.00','0.00','Llego al tiempo esperado, el producto era de calidad ',5,NULL),
 (13,5,28,1,'30.00','0.00','Estuvo bien la comida, a tiempo. Gracias.',4,NULL);
/*!40000 ALTER TABLE `pedidodetalle` ENABLE KEYS */;


--
-- Definition of table `plato`
--

DROP TABLE IF EXISTS `plato`;
CREATE TABLE `plato` (
  `idplato` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al plato',
  `idcategoria` int(10) unsigned NOT NULL COMMENT 'Número correlativo y autoincremental que identifica como único al ',
  `idexterno` varchar(10) DEFAULT NULL COMMENT 'Identificador del plato en Cheff2000',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre con el cual se promociona el plato',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción detallada sobre las caracteristicas del plato',
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Precio de venta unitario del plato',
  `delivery` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si el plato se encuentra disponible para entrega a domicilio',
  `relevancia` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Relevancia del plato mientras más menor sea, mayor exposición tendrá',
  `imagen` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sera 0 si no tiene una imagen cargada, diferente de 0 si la tuviera',
  `estado` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Estado del plato 0 inactivo o 1 activo',
  PRIMARY KEY (`idplato`),
  UNIQUE KEY `idexterno` (`idexterno`),
  KEY `idcategoria` (`idcategoria`),
  CONSTRAINT `plato_ibfk_1` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COMMENT='Guarda la información de los platos que ofrece el restaurante';

--
-- Dumping data for table `plato`
--

/*!40000 ALTER TABLE `plato` DISABLE KEYS */;
INSERT INTO `plato` (`idplato`,`idcategoria`,`idexterno`,`nombre`,`descripcion`,`precio`,`delivery`,`relevancia`,`imagen`,`estado`) VALUES 
 (1,2,'0000000001','Causa de Langostinos','Masa de papa amarilla rellena de langostinos en salsa golf, palta fuerte y huevo rallado','23.00',1,1,1,0),
 (2,2,'0000000002','Causa de Pulpo al Olivo','Masa de papa amarilla rellena de pulpo en salsa de aceituna negra, palta y huevo rallado','23.00',1,0,0,1),
 (3,2,'0000000003','Causa de Atún','Masitas de camote adornadas con atún en nuestro marinado de la casa','22.00',1,0,0,1),
 (4,2,'0000000004','Musciame de Pulpo','Láminas de pulpo marinadas en una salsa especial. Servido con crackers','30.00',1,1,4,1),
 (5,2,'0000000005','Cebiche','Dados de pescado marinados en limón, cebolla, ají limo. Servido con choclo y camote','27.00',1,1,0,1),
 (6,2,'0000000006','Cebiche Mixto','Pruébalo también en su versión mixta','30.00',1,0,0,1),
 (7,2,'0000000007','Tiradito a la Crema de Rocoto','Láminas de pesca del día en jugo de cebiche, salsa de rocoto con camote y choclo','27.00',1,0,0,1),
 (8,2,'0000000008','Tiradito a la Crema de Ají Amarillo','Láminas de pesca del día, ají amarillo, siempre con choclo y camotes glaseados','26.00',1,0,0,1),
 (9,2,'0000000009','Tiradito Nikkei','Láminas de pesca del día marinadas en salsa de soya y maracuyá. Estilo oriental','26.00',1,0,0,1),
 (10,2,'0000000010','Pulpo al Olivo','Láminas de pulpo tierno marinadas en nuestra salsa al olivo. Servido con crackers','28.00',1,0,10,1),
 (11,2,'0000000011','Brochetas Marinas','De pescado y pulpo a la parrilla. Acompañadas con chimichurri y malarrabia','26.00',1,0,11,1),
 (12,2,'0000000012','Pulpo Anticuchero','A la parrilla en salsa anticuchera, servido con papas cocktail y chimichurri','28.00',1,0,12,1),
 (13,2,'0000000013','Choritos a la Chalaca','En shots x 6. Infaltable en el verano. Pídelos fritos o al natural','18.00',1,0,13,1),
 (14,2,'0000000014','Almejas del Pacífico','En shots x 6. Pídelas en una crema de ají amarillo o marinadas al limón','21.00',1,0,0,1),
 (15,3,'0000000015','Trio de Causitas 2','Causa Amarilla con Langostinos, de Camote con Atún marinado y de Espinaca con Pulpo','43.00',1,1,15,1),
 (16,3,'0000000016','Piqueo de la Casa','Pulpo anticuchero, Tequeños de Ají de Gallina y Causita de pollo para picar','36.00',1,0,0,1),
 (17,3,'0000000017','Piqueo Marino','Causita de Langostinos, Tiradito a la Chalaca y Pulpo al Olivo para picar','38.00',1,0,17,1),
 (18,4,'0000000018','Leche de Tigre','Para levantar cualquier ánimo. Alma de cebiche rendida en una copa','25.00',1,1,18,1),
 (19,4,'0000000019','Leche de Canario','Si no la conocías tienes que probarla. Leche de tigre mas su pasta de ají','16.00',1,0,19,1),
 (20,4,'0000000020','Leche de Caimán','Poderoso. Le agregamos nuestra salsa de pesto especial','19.00',1,0,20,1),
 (21,5,'0000000021','Tallarines al Pesto con Bistec Apanado y Huevo frito','Se fué, pero volvió como el favorito de todos','31.00',1,1,0,1),
 (22,5,'0000000022','Asado con Puré y Arroz','La receta de tu abuela porque la mía no cocina','27.00',1,0,22,1),
 (23,5,'0000000023','Spaghetti a la Carbonara','Con tocino, huevo y una dócil salsa blanca especial','27.00',1,0,23,1),
 (24,5,'0000000024','Arroz Tapado','El verídico, hecho como en casa','26.00',1,0,24,1),
 (25,5,'0000000025','Bistec a lo Pobre','Sábana de carne más su huevo, arroz, papas fritas y plátano frito','30.00',1,0,25,1),
 (26,5,'0000000026','Milanesa con Ensalada y Arroz','Un plato de pocas calorías','24.00',1,0,26,1),
 (27,5,'0000000027','Ají de Gallina','Se quedó. Criollísimo plato por fin en casa','26.00',1,0,27,1),
 (28,6,'0000000028','Spaghetti a lo Macho','Spaghetti con mariscos bañados en nuestra salsa a lo macho','30.00',1,1,1,0),
 (29,6,'0000000029','Fusillis del Mar','Fusillis al pesto con milanesa de pescado','28.00',1,0,29,1),
 (30,6,'0000000030','Pescado en Salsa de Alcachofas','Acompañado de arroz y verduras salteadas','29.00',1,0,30,1),
 (31,6,'0000000031','Acorazado','Pescado y langostinos en salsa de langostinos con tacu tacu de pallares ','35.00',1,0,31,1),
 (32,6,'0000000032','Sudado de Pescado','Humeante pescado con yuca sancochada, acompañado con arroz','30.00',1,0,32,1),
 (33,6,'0000000033','Arroz con Mariscos','Clásico infaltable que reúne lo mejor del mar','30.00',1,0,33,1),
 (34,6,'0000000034','Miyagi San','Pescado a la plancha con verduras salteadas, sillao y hoisin. Con puré y fansi','27.00',1,0,34,1),
 (35,6,'0000000035','Pescado en Salsa de Champiñones','Acompañado de un puré rústico y ratatouille criollo','30.00',1,0,0,1),
 (36,6,'0000000036','Pescado en Salsa de Alcaparras','Acompañado de arroz y verduras salteadas','30.00',1,0,36,1),
 (37,6,'0000000037','Chaufa de Pescado','Te encantalá','27.00',1,0,0,1),
 (38,6,'0000000038','Pescado en Salsa de Vino Blanco','Acompañado de arroz y verduras salteadas','30.00',1,0,38,1),
 (39,6,'0000000039','Frejolada de Pescado','Cama de frejoles y chorizo, tendida con un pescado a la plancha y arroz','33.00',1,0,39,1),
 (40,6,'0000000040','Pescado a la Meniere','Acompañado de papas doradas y verduras salteadas','28.00',1,0,40,1),
 (41,7,'0000000041','Pollito al Tomillo','Con puré de papa amarilla, salteado de espinacas y champiñones ','26.00',1,0,41,1),
 (42,7,'0000000042','Risotto del Huerto','Acompañado de una pechuga de pollo y reducción de vino tinto','30.00',1,0,0,1),
 (43,7,'0000000043','Tallarín Saltado de Pollo Carretillero','Todos los sabores de un saltado con tallarines','27.00',1,0,0,1),
 (44,7,'0000000044','Pollo al Chimichurri','Servido con papas amarillas en su piel y ensalada ','29.00',1,0,44,1),
 (45,7,'0000000045','Chaufita Pon Tú','Dados de pollo, cebolla china, aroma de kion, tortilla de huevo, zanahoria y pimiento','26.00',1,0,0,1),
 (46,7,'0000000046','Fusillis a la Huancaína con Milanesa de Pollo','El plato más vendido de la temporada','27.00',1,0,46,1),
 (47,7,'0000000047','Chicken Teriyaki','Acompañado de arroz y una ensalada de col y zanahoria','26.00',1,0,0,1),
 (48,7,'0000000048','Maracuyakay','Chaufa de la casa servido con pollo estilo oriental en salsa de maracuyá','28.00',1,0,48,1),
 (49,7,'0000000049','Fusillis Caseros','Con una pasta de tomate al ají amarillo, albahaca picada y tocino. Con pollo a la plancha ','27.00',1,0,49,1),
 (50,8,'0000000050','Lomo Saltado','La especialidad de la casa. Acompañado de papas amarillas fritas y arroz','33.00',1,0,50,1),
 (51,8,'0000000051','Lomo marinado en Chimichurri','A la parrilla. Servido con papas amarillas en su piel y ensalada','37.00',1,0,0,1),
 (52,8,'0000000052','Spaghetti a la Huancaína con Lomo Saltado','Para el que tiene buen filo','37.00',1,0,52,1),
 (53,8,'0000000053','Risotto de Seco','Con este plato fuimos a Mistura. Servido con lomo fino y virutas de parmesano','35.00',1,0,53,1),
 (54,9,'0000000054','Tequeños de Ají de Gallina','Versión atrevida. Acompañados de una salsa de aceitunas','19.00',1,1,0,1),
 (55,9,'0000000055','Tequeños de Lomo Saltado','En su versión más peruana. Acompañados de una huancaína ligera','21.00',1,0,0,1),
 (56,9,'0000000056','Tequeños de Queso Cajamarquino','Los de siempre, pero esta vez le agregamos el queso andino. Servido con guacamole','16.00',1,0,0,1),
 (57,10,'0000000057','Fusión','Mix de lechugas, pollo, piña, palta y crocante de wantanes. Vinagreta honey mustard','18.00',1,0,0,1),
 (58,10,'0000000058','Thunnus','Mix de lechugas, atún, espinaca, tomate, palta, huevo, choclo y aceitunas negras. Vinagreta de pepino','19.00',1,0,58,1),
 (59,10,'0000000059','Sumaq','Papa sancochada en daditos, zanahoria, brócoli, vainita y choclito. Vinagreta casera','18.00',1,0,0,1),
 (60,10,'0000000060','Monte Real','Lechuga americana, pollo, espinaca, choclo, tomate, palta y queso fresco. Vinagreta de mostaza y hierbas','18.00',1,0,0,1),
 (61,10,'0000000061','Campestre','Mix de lechugas, atún, tomate, palta, zanahoria, pepino y huevo duro. Vinagreta cítrica','19.00',1,0,61,1),
 (62,10,'0000000062','Monte Grande','Mix de lechugas, pollo, tomate, zanahoria, palta y tocino. Vinagreta casera','18.00',1,0,62,1),
 (63,10,'0000000063','Delicia','Mix de lechugas, espinaca, huevo, pollo, pasas y tocino. Vinagreta ligera','18.00',1,0,0,1),
 (64,11,'0000000064','Crema Volteada','La clásica receta de casa','50.00',1,1,1,1),
 (65,11,'0000000065','Pie de Limón','Una versión moderna con menos merengue y más relleno','12.00',1,0,65,1),
 (66,11,'0000000066','Brownie con helado','Un postre que no tiene pierde','10.00',1,0,66,1),
 (67,11,'0000000067','Amelcochado de Coco con helado','Casi una cocada hecha postre para los amantes del coco','12.00',1,0,67,1),
 (68,11,'0000000068','Crocante de Manzana con helado','Como lo hacía la abuela. Costra dulce rellena de manzana al horno','12.00',1,0,68,1),
 (69,12,'0000000069','Limonada',NULL,'5.00',0,0,0,1),
 (70,12,'0000000070','Chicha',NULL,'5.00',0,0,0,1),
 (71,12,'0000000071','Maracuyá',NULL,'6.00',0,0,0,1),
 (72,12,'0000000072','Limonada Frozen',NULL,'8.00',0,0,0,1),
 (73,12,'0000000073','Chicha Frozen',NULL,'8.00',0,0,0,1),
 (74,12,'0000000074','Maracuyá Frozen',NULL,'9.00',0,0,0,1),
 (75,12,'0000000075','Hierbaluisa Frozen',NULL,'10.00',0,0,75,1),
 (76,13,'0000000076','Inca Kola (Zero)',NULL,'5.00',0,0,0,1),
 (77,13,'0000000077','Coca Cola (Zero)',NULL,'5.00',0,0,0,1),
 (78,13,'0000000078','Sprite (Zero)',NULL,'5.00',0,0,0,1),
 (79,13,'0000000079','Fanta',NULL,'5.00',0,0,0,1),
 (80,14,'0000000080','Manzanilla',NULL,'4.00',0,0,0,1),
 (81,14,'0000000081','Hierbaluisa',NULL,'4.00',0,0,0,1),
 (82,14,'0000000082','Anís',NULL,'4.00',0,0,0,1),
 (83,14,'0000000083','Té con Canela y Hierba buena',NULL,'4.00',0,0,0,1),
 (84,14,'0000000084','Hierba buena',NULL,'4.00',0,0,0,1),
 (85,15,'0000000085','Americano',NULL,'5.00',0,0,0,1),
 (86,15,'0000000086','Café con Leche',NULL,'6.00',0,0,0,1),
 (87,15,'0000000087','Capuccino',NULL,'6.00',0,0,0,1),
 (88,15,'0000000088','Expresso',NULL,'5.00',0,0,0,1),
 (89,16,'0000000089','Chocolate',NULL,'12.00',0,0,0,1),
 (90,16,'0000000090','Fresa',NULL,'12.00',0,0,0,1),
 (91,16,'0000000091','Vainilla',NULL,'12.00',0,0,0,1),
 (92,16,'0000000092','Banana y Chocolate',NULL,'13.00',0,0,92,1),
 (93,16,'0000000093','Oreo',NULL,'14.00',0,0,93,1),
 (94,16,'0000000094','Nutella',NULL,'15.00',0,0,0,1),
 (95,17,'0000000095','Pisco Sour',NULL,'16.00',0,0,0,1),
 (96,17,'0000000096','Pisco Sour Doble',NULL,'20.00',0,0,0,1),
 (97,17,'0000000097','Maracuyá Sour ',NULL,'18.00',0,0,0,1),
 (98,17,'0000000098','Hierbaluisa Sour',NULL,'18.00',0,0,0,1),
 (99,17,'0000000099','Chicha Sour',NULL,'18.00',0,0,0,1),
 (100,18,'0000000100','Warmicha','Jugo de lima, jugo de manzana y jugo de maracuyá','11.00',0,0,0,1),
 (101,18,'0000000101','Lula','Frutas de estación, hierba buena y agua con gas','13.00',0,0,101,1),
 (102,18,'0000000102','Tía Justina','Vino tinto, jugo de naranja, manzana y ginger ale','15.00',0,0,0,1),
 (103,18,'0000000103','Tía Gertrudis','Vino blanco, jugo de naranja, manzana y ginger ale','15.00',0,0,103,1),
 (104,19,'0000000104','Tequila Sunrise',NULL,'18.00',0,0,0,1),
 (105,2,'0000000105','Choclito Anticuchero',NULL,'22.00',1,0,1,1),
 (106,19,'0000000106','Miami Ice Tea',NULL,'22.00',0,0,0,1),
 (107,19,'0000000107','Algarrobina',NULL,'18.00',0,0,0,1),
 (108,19,'0000000108','Dry Martini',NULL,'20.00',0,0,0,1),
 (109,19,'0000000109','Cosmopolitan',NULL,'20.00',0,0,0,1),
 (110,19,'0000000110','Manhattan',NULL,'20.00',0,0,0,1),
 (111,19,'0000000111','Apple Martini',NULL,'20.00',0,0,0,1),
 (112,19,'0000000112','Mimosa',NULL,'19.00',0,0,0,1),
 (113,19,'0000000113','Bellini',NULL,'19.00',0,0,0,1),
 (114,19,'0000000114','Kir Royal',NULL,'19.00',0,0,0,1),
 (115,19,'0000000115','Piña Colada',NULL,'18.00',0,0,0,1),
 (116,19,'0000000116','Daiquiri','Daiquiris de Fresa, Limón y Maracuyá','18.00',0,0,0,1),
 (117,20,'0000000117','Pilsen',NULL,'8.00',0,0,1,1),
 (118,20,'0000000118','Cristal',NULL,'8.00',0,0,0,1),
 (119,20,'0000000119','Cuzqueña',NULL,'9.00',0,0,0,1),
 (120,20,'0000000120','Cuzqueña Malta',NULL,'10.00',0,0,0,1),
 (121,20,'0000000121','Cuzqueña Red Lager',NULL,'10.00',0,0,0,1),
 (122,20,'0000000122','Inti Golden Ale',NULL,'15.00',0,0,0,1),
 (123,20,'0000000123','Huaracina Pale Ale',NULL,'15.00',0,0,0,1),
 (124,20,'0000000124','Alpamayo Amber Ale',NULL,'15.00',0,0,0,1),
 (125,20,'0000000125','Don Juan Porter',NULL,'15.00',0,0,0,1),
 (126,20,'0000000126','Chimay',NULL,'35.00',1,0,0,1),
 (127,20,'0000000127','ESB Fuller\'s',NULL,'16.00',0,0,0,1),
 (128,20,'0000000128','Floris Chocolat',NULL,'22.00',0,0,0,1),
 (129,20,'0000000129','Golden Pride',NULL,'16.00',0,0,0,1),
 (130,20,'0000000130','Delirium Tremens',NULL,'23.00',0,0,0,1),
 (131,20,'0000000131','Heineken',NULL,'10.00',0,0,0,1),
 (132,22,'0000000132','Clásico','Pisco y ginger ale con el toque de la casa','18.00',0,0,127,1),
 (133,22,'0000000133','Chicha Morada','Peruanísimo macerado','18.00',0,0,0,1),
 (134,22,'0000000134','Nativo','Camu camu y coca para sentir el punche','18.00',0,0,0,1),
 (135,22,'0000000135','Kuntu','De hierbaluisa, menta y canela','18.00',0,0,0,1),
 (136,22,'0000000136','Doña Luisa','Uva borgoña y hierbaluisa','18.00',0,0,0,1),
 (137,22,'0000000137','Kion','Una vez que lo pruebes no hay vuelta atrás','18.00',0,0,0,1),
 (138,22,'0000000138','Valle Lindo','De higo y damasco, dulce y apasionado','18.00',0,0,0,1),
 (139,22,'0000000139','Papagayo','De Granada y menta','18.00',0,0,0,1),
 (140,22,'0000000140','Fresa','Infaltable macerado, coqueto y delicioso','18.00',0,0,0,1),
 (141,22,'0000000141','Citrus','De lima y maracuyá, ideal para el verano','18.00',0,0,0,1),
 (142,22,'0000000142','Aguarina','Aguaymanto y mandarina, receta de Faustina','18.00',0,0,0,1),
 (143,23,'0000000143','Mineral San Mateo Con o sin Gas',NULL,'5.00',0,0,0,1),
 (144,5,'0000000144','Arroz con Pollo','Hecho como en casa','30.00',1,0,127,1),
 (145,11,'0000000145','Arroz con Leche','La clásica receta de casa','30.00',0,5,127,1),
 (146,6,'0000000146','Pescado a la Chorrillana',NULL,'30.00',1,0,127,1),
 (147,1,NULL,'Menú Ejecutivo',NULL,'20.00',1,1,0,1),
 (148,1,NULL,'Menú Especial',NULL,'30.00',1,1,0,1);
/*!40000 ALTER TABLE `plato` ENABLE KEYS */;


--
-- Definition of table `promocion`
--

DROP TABLE IF EXISTS `promocion`;
CREATE TABLE `promocion` (
  `idpromocion` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la promoción',
  `idcampana` int(10) unsigned DEFAULT NULL COMMENT 'Número que identifica a la campaña a la cual pertenece la promoción',
  `descripcion` varchar(45) NOT NULL COMMENT 'Describe brevemente a la promoción',
  `codigo` varchar(45) DEFAULT NULL COMMENT 'Código de la promoción',
  `inicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de inicio desde la cual se mostrará la promoción',
  `fin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Fecha hasta la cual se mostrará la promoción',
  PRIMARY KEY (`idpromocion`),
  KEY `idcampana` (`idcampana`),
  CONSTRAINT `promocion_ibfk_1` FOREIGN KEY (`idcampana`) REFERENCES `campana` (`idcampana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Promociones que se mostrarán a los clientes cada vez que ingresen a la aplicación móvil';

--
-- Dumping data for table `promocion`
--

/*!40000 ALTER TABLE `promocion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promocion` ENABLE KEYS */;


--
-- Definition of table `promociondetalle`
--

DROP TABLE IF EXISTS `promociondetalle`;
CREATE TABLE `promociondetalle` (
  `idpromociondetalle` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como única a la tabla',
  `idpromocion` int(10) unsigned NOT NULL COMMENT 'Número que identifica a la promoción a la cual pertenece el detalle',
  `idplato` int(10) unsigned NOT NULL COMMENT 'Número que identifica al plato que es parte de la promoción',
  `cantidad` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Cantidad mínima del plato para que la promoción sea efectiva',
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Precio de venta de promoción del plato',
  `descuento` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Descuento aplicado al precio normal del plato',
  PRIMARY KEY (`idpromociondetalle`),
  KEY `idpromocion` (`idpromocion`),
  KEY `idplato` (`idplato`),
  CONSTRAINT `promociondetalle_ibfk_1` FOREIGN KEY (`idpromocion`) REFERENCES `promocion` (`idpromocion`),
  CONSTRAINT `promociondetalle_ibfk_2` FOREIGN KEY (`idplato`) REFERENCES `plato` (`idplato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Platos y precios ofrecidos dentro de una promoción';

--
-- Dumping data for table `promociondetalle`
--

/*!40000 ALTER TABLE `promociondetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `promociondetalle` ENABLE KEYS */;


--
-- Definition of table `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `idrol` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al rol',
  `descripcion` varchar(45) NOT NULL COMMENT 'Describe al rol para que pueda ser identificado',
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Rol dentro del sistema para el usuario';

--
-- Dumping data for table `rol`
--

/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`idrol`,`descripcion`) VALUES 
 (1,'Cliente'),
 (2,'Administrador'),
 (3,'Repartidor'),
 (4,'Delivery Manager'),
 (5,'Marketing');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;


--
-- Definition of table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `idusuario` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al usuario',
  `idrol` int(10) unsigned NOT NULL COMMENT 'Número que identifica al rol que posee el usuario dentro del sistema',
  `username` varchar(45) NOT NULL COMMENT 'Nombre de usuario, si es cliente será su correo electrónico',
  `password` char(32) NOT NULL COMMENT 'Constraseña del usuario en el sistema, encriptada mediante un algoritmo hash',
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `username` (`username`),
  KEY `idrol` (`idrol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='Usuario con el cual un trabajador o cliente puede ingresar e interactuar en el sistema';

--
-- Dumping data for table `usuario`
--

/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`idusuario`,`idrol`,`username`,`password`) VALUES 
 (1,2,'admin','a906449d5769fa7361d7ecc6aa3f6d28'),
 (2,3,'repar','a906449d5769fa7361d7ecc6aa3f6d28'),
 (3,4,'deliv','a906449d5769fa7361d7ecc6aa3f6d28'),
 (4,5,'marke','a906449d5769fa7361d7ecc6aa3f6d28'),
 (5,1,'tegobijava00@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (6,1,'yhuaroc@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (7,1,'marcelles@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (8,1,'ggonzales@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (9,1,'cgutierrez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (10,1,'mcarlotto@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (11,1,'sgrados@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (12,1,'mcamac@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (13,1,'ediaz@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (14,1,'ychavez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (15,1,'rperez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (16,1,'rguillen@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (17,1,'ccahuana@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (18,1,'apillaca@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (19,1,'rpillaca@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (20,1,'aabregu@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (21,1,'fmendo@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (22,1,'jmontalvo@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (23,1,'jvillar@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (24,1,'kcoz@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (25,1,'ylaura@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (26,1,'scanaza@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (27,1,'pmercedes@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (28,1,'thuarancca@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (29,1,'fcajavilca@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (30,1,'pvargas@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (31,1,'jiberico@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (32,1,'larango@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (33,1,'avasquez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (34,1,'lportuguez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (35,1,'evargas@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (36,1,'wyataco@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (37,1,'psanchez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (38,1,'sgonzales@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (39,1,'yguardia@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (40,1,'smarquez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (41,1,'ehidalgo@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (42,1,'cquintana@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (43,1,'masmat@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (44,1,'qquispe@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (45,1,'kgomez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (46,1,'kortiz@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (47,1,'jarroyo@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (48,1,'ssoto@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (49,1,'jbarba@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (50,1,'wpisfil@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (51,1,'jcampos@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (52,1,'odonayre@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (53,1,'nascona@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (54,1,'echavez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (55,1,'jyauri@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (56,1,'stejada@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (57,1,'ctorres@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (58,1,'mcastillo@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (59,1,'mulloa@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (60,1,'mroca@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (61,1,'lzegarra@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (62,1,'dguanilo@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (63,1,'cascencion@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (64,1,'jutia@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (65,1,'averastegui@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (66,1,'tsanchez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (67,1,'kmedina@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (68,1,'ecuaresma@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (69,1,'mleyva@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (70,1,'eyance@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (71,1,'rmarcial@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (72,1,'jfranco@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (73,1,'eocrospoma@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (74,1,'mengoni@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (75,1,'jberrocal@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (76,1,'jalvarez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (77,1,'ydiaz@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (78,1,'zdurand@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (79,1,'egamarra@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (80,1,'gpena@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (81,1,'ksahuaraura@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (82,1,'candrade@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (83,1,'grodriguez@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (84,1,'rsoto@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (85,1,'dhuachaca @gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (86,1,'dheredia@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (87,1,'echumpitaz@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (88,1,'lquintanilla@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (89,1,'hbueno@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (90,1,'tyrion2@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (91,1,'tyrion3@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (92,1,'cheetahmen3@yahoo.com','d41d8cd98f00b204e9800998ecf8427e'),
 (93,1,'email@address.com','06b831fba586b57519c7f4f863528004'),
 (94,1,'email@addres.com','06b831fba586b57519c7f4f863528004'),
 (95,1,'email@add.com','06b831fba586b57519c7f4f863528004'),
 (96,1,'tyrion6@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (97,1,'coco@gmail.com','d41d8cd98f00b204e9800998ecf8427e'),
 (98,1,'daenerys@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (99,1,'Female','25f9e794323b453885f5181f1b624d0b'),
 (100,1,'Male','d41d8cd98f00b204e9800998ecf8427e'),
 (101,1,'test2@gmail.com','85c06fb1355cefbd2eaa2d83222a5998'),
 (102,1,'mrbumba.jana1@gmail.com','a384b6463fc216a5f8ecb6670f86456a'),
 (103,1,'daenerys2@gmail.com','a906449d5769fa7361d7ecc6aa3f6d28'),
 (104,1,'cheetahmen2@yahoo.com','a906449d5769fa7361d7ecc6aa3f6d28');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;


--
-- Definition of table `viaje`
--

DROP TABLE IF EXISTS `viaje`;
CREATE TABLE `viaje` (
  `idviaje` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número correlativo y autoincremental que identifica como único al viaje',
  `idusuario` int(10) unsigned NOT NULL COMMENT 'Número que identifica al usuario con rol repartidor que realiza el viaje de entrega',
  `latitud` varchar(45) NOT NULL COMMENT 'Última coordenada de latitud registrada por el dispositivo del repartidor durante su recorrido',
  `longitud` varchar(45) NOT NULL COMMENT 'Última coordenada de longitud registrada por el dispositivo del repartidor durante su recorrido',
  `inicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Día y hora de inicio del recorrido',
  `fin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Día y hora de finalización del recorrido',
  PRIMARY KEY (`idviaje`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `viaje_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Viaje donde se despachan uno o más pedidos';

--
-- Dumping data for table `viaje`
--

/*!40000 ALTER TABLE `viaje` DISABLE KEYS */;
/*!40000 ALTER TABLE `viaje` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
