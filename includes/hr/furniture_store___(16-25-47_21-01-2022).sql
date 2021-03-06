SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
--
-- Database: `furniture_store`
--




CREATE TABLE `employees` (
  `idemployees` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pasport` varchar(11) NOT NULL,
  `inn` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `used` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`idemployees`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;


INSERT INTO employees VALUES
("1","Хмелько Богдан Игоревич","3104 547896","243232313747","8(988) 548-5544","Ростов-на-Дону, ул. Седова, дом. 11","bogdan@gmail.com","0"),
("3","Петров Александр Андреевич","0000000","243232313700","89995553344","Ростов-на-Дону ул. Варфоломеева дом. 10","petrov@gmail.com","1"),
("5","Стрелка Виталий Евгеньевич","0000002","243232313742","89097895455","Ростов-на-Дону, ул. Мечникова дом. 120","strelok@gmail.com","1"),
("10","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1");




CREATE TABLE `temp_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idemployees` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pasport` varchar(11) NOT NULL,
  `inn` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;


INSERT INTO temp_employees VALUES
("2","2021-12-28 02:01:53","insert","2","Хмелько Богдан Игоревич","3104 547800","243232313700","8(988) 548-5500","Ростов-на-Дону, ул. Седова, дом. 11","bogdan@gmail.co","0"),
("3","2021-12-28 02:02:20","update","2","Хмелько Богдан Игоревич","3104 547800","243232313700","8(988) 548-5500","Ростов-на-Дону, ул. Седова, дом. 11","bogdan@gmail.co","0"),
("4","2021-12-28 02:02:35","delete","2","Хмелько Богдан Игоревич","3104 547801","243232313700","8(988) 548-5500","Ростов-на-Дону, ул. Седова, дом. 11","bogdan@gmail.co","0"),
("5","2021-12-28 03:52:47","update","1","Хмелько Богдан Игоревич","3104 547896","243232313747","8(988) 548-5544","Ростов-на-Дону, ул. Седова, дом. 11","bogdan@gmail.com","0"),
("6","2021-12-28 03:52:53","update","1","Хмелько Богдан Игореви","3104 547896","243232313747","8(988) 548-5544","Ростов-на-Дону, ул. Седова, дом. 11","bogdan@gmail.com","0"),
("7","2021-12-28 10:46:53","insert","2","Петров Александр Андреевич","0000000","243232313742","89995553344","Ростов-на-Дону ул. Варфоломеева дом. 10","petrov@gmail.com","1"),
("8","2021-12-28 10:47:24","update","2","Петров Александр Андреевич","0000000","243232313742","89995553344","Ростов-на-Дону ул. Варфоломеева дом. 10","petrov@gmail.com","1"),
("9","2021-12-28 10:48:10","insert","3","Петров Александр Андреевич","0000000","243232313700","89995553344","Ростов-на-Дону ул. Варфоломеева дом. 10","petrov@gmail.com","1"),
("10","2021-12-28 10:48:17","update","3","Петров Александр Андреевич","0000000","243232313700","89995553344","Ростов-на-Дону ул. Варфоломеева дом. 10","petrov@gmail.com","1"),
("12","2021-12-28 10:54:56","update","3","Петров Александр Андрееви","0000000","243232313700","89995553344","Ростов-на-Дону ул. Варфоломеева дом. 10","petrov@gmail.com","1"),
("16","2021-12-28 10:58:53","insert","4","Стрелка Виталий Евгеньевич","0000001","243232313742","89097895455","Ростов-на-Дону, ул. Мечникова дом. 120","strelok@gmail.com","1"),
("17","2021-12-28 10:59:03","update","4","Стрелка Виталий Евгеньевич","0000002","243232313742","89097895455","Ростов-на-Дону, ул. Мечникова дом. 120","strelok@gmail.com","1"),
("18","2022-01-14 22:39:28","update","4","Стрелка Виталий Евгеньевич","0000001","243232313742","89097895455","Ростов-на-Дону, ул. Мечникова дом. 120","strelok@gmail.com","1"),
("19","2022-01-14 22:41:06","delete","4","Стрелка Виталий Евгеньевич","0000002","243232313742","89097895455","Ростов-на-Дону, ул. Мечникова дом. 120","strelok@gmail.com","1"),
("20","2022-01-14 22:45:33","insert","5","Стрелка Виталий Евгеньевич","0000002","243232313742","89097895455","Ростов-на-Дону, ул. Мечникова дом. 120","strelok@gmail.com","1"),
("21","2022-01-14 22:46:14","insert","6","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("22","2022-01-14 22:46:19","delete","6","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("23","2022-01-14 22:46:42","insert","7","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("24","2022-01-14 22:46:44","delete","7","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("25","2022-01-14 22:46:45","insert","8","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("26","2022-01-14 22:46:47","delete","8","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("27","2022-01-14 22:46:47","insert","9","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("28","2022-01-14 22:46:50","delete","9","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("29","2022-01-14 22:46:52","insert","10","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("30","2022-01-14 22:50:04","update","10","Кот Антон Сергеевич","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1"),
("31","2022-01-14 22:50:14","update","10","Кот Антон Сергеевич 33","0000000","243232313741","89205757575","Ростов-на-Дону,  ул. Тельмана дом. 10","kot@gmail.com","1");




CREATE TABLE `users` (
  `idusers` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


INSERT INTO users VALUES
("1","Alex","$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy"),
("2","Max","$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy"),
("3","Artem","$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy");




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;