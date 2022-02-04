SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;


--
-- База данных: `furniture_store`
--

-- INSERT INTO `temp_posts` (`id`, `date`, `query`, `idposts`, `post_name`, `salary`, `used`) VALUES
-- (1, '2021-12-11 17:44:46', 'update', 1, 'Кадровик', '35000.00', 0);

-- INSERT INTO `temp_employees` (`id`, `date`, `query`, `idemployees`, `name`, `pasport`, `inn`, `phone`, `address`, `email`,`used`) VALUES
-- (1, '2021-12-11 17:44:46', 'update', 1, 'Хмелько Богдан Игоревич', '3104 547000', '243232313747', '8(988) 548-5544', 'Ростов-на-Дону, ул. Седова, дом. 11', 'bogdan@gmail.com', 0);



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `employees` (`idemployees`, `name`, `email`, `phone`, `address`, `pasport`, `inn`, `used`) VALUES
(1, 'Хмелько Богдан Игоревич', 'bogdan@gmail.com', '8(988) 548-5544', 'Ростов-на-Дону, ул. Седова, дом. 11', '3104 547896', '243232313747', 0);


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
   `used` tinyint(1) NOT NULL DEFAULT '1',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `temp_employees` (`id`, `date`, `query`, `idemployees`, `name`, `pasport`, `inn`, `phone`, `address`, `email`,`used`) VALUES
(1, '2021-12-11 17:44:46', 'update', 1, 'Хмелько Богдан Игоревич', '3104 547000', '243232313747', '8(988) 548-5544', 'Ростов-на-Дону, ул. Седова, дом. 11', 'bogdan@gmail.com', 0);


CREATE TABLE `users` (
   `idusers` int(11) NOT NULL AUTO_INCREMENT,
   `login` varchar(100) NOT NULL,
   `password` varchar(100) NOT NULL,
   PRIMARY KEY (`idusers`)
)
ENGINE = InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `users` (`idusers`, `login`, `password`) VALUES
(1, 'Alextxnk', '$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy');

--
-- Процедуры
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_employees` (IN `ids` INT)  BEGIN
   declare idIn int(11);
   declare nameIn varchar(100);
   declare pasportIn varchar(11);
   declare innIn varchar(12);
   declare phoneIn varchar(15);
   declare addressIn varchar(255);
   declare emailIn varchar(255);
   declare usedIn tinyint(1);
   declare queryIn varchar(15);

   set queryIn = (SELECT query FROM temp_employees where id = ids);
   set innIn = (SELECT idemployees FROM temp_employees where id = ids);
   set nameIn = (SELECT name FROM temp_employees where id = ids);
   set pasportIn = (SELECT pasport FROM temp_employees where id = ids);
   set innIn = (SELECT inn FROM temp_employees where id = ids);
   set phoneIn = (SELECT phone FROM temp_employees where id = ids);
   set addressIn = (SELECT address FROM temp_employees where id = ids);
   set emailIn = (SELECT email FROM temp_employees where id = ids);
   set usedIn = (SELECT used FROM temp_employees where id = ids);

	case queryIn
   when 'insert' then
      update employees set used = 0 where `idemployees` = idIn;
   when 'delete' then 
      insert into employees (`name`, `pasport`, `inn`, `phone`, `address`, `email`, `used`) values (nameIn, pasportIn, innIn, phoneIn, addressIn, emailIn, usedIn);
   when 'update' then
      update employees set `name`= nameIn, `pasport` = pasportIn, `inn` = innIn, `phone` = phoneIn, `address` =  addressIn, `email` = emailIn, `used` =usedIn where `idemployees`=idIn;
   end case;
   #delete from temp_employees where `idemployees`= idTemp;
END$$
DELIMITER ;






-- DELIMITER $$
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_employees` (IN `ids` INT)  BEGIN
--    declare idIn int;
--    declare nameIn varchar(100);
--    declare pasportIn varchar(11);
--    declare innIn varchar(12);
--    declare phoneIn varchar(15);
--    declare addressIn varchar(255);
--    declare dateIn datetime;
--    declare emailIn varchar(255);
--    declare usedIn tinyint(1);
--    declare queryIn varchar(15);

--    set queryIn = (SELECT query FROM furniture_store.temp_employees where id = ids);
--    set idIn = (SELECT idemployees FROM furniture_store.temp_employees where id = ids);
--    set nameIn = (SELECT name FROM furniture_store.temp_employees where id = ids);
--    set pasportIn = (SELECT pasport FROM furniture_store.temp_employees where id = ids);
--    set innIn = (SELECT inn FROM furniture_store.temp_employees where id = ids);
--    set phoneIn = (SELECT phone FROM furniture_store.temp_employees where id = ids);
--    set addressIn = (SELECT address FROM furniture_store.temp_employees where id = ids);
--    set dateIn = (SELECT date FROM furniture_store.temp_employees where id = ids);
--    set emailIn = (SELECT email FROM furniture_store.temp_employees where id = ids);
--    set usedIn = (SELECT used FROM furniture_store.temp_employees where id = ids);

-- 	case queryIn
--    when 'insert' then
--       update employees set used = 0 where `idemployees` = idIn;
--    when 'delete' then 
--       insert into employees (`name`, `pasport`, `inn`, `phone`, `address`, `date`, `email`, `used`) values (nameIn, pasportIn, innIn, phoneIn, addressIn, dateIn, emailIn, usedIn);
--    when 'update' then
--       update employees set `name`= nameIn, `pasport` = pasportIn, `inn` = innIn, `phone` = phoneIn, `address` =  addressIn, `date` = dateIn `email` = emailIn, `used` =usedIn where `idemployees` = idIn;
--    end case;
--    #delete from temp_employees where `idemployees`= idTemp;
-- END$$
-- DELIMITER ;




--
-- Триггеры `employees`
--


DELIMITER $$
CREATE TRIGGER `delete_employees` AFTER DELETE ON `employees` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_employees SET date = now(),

            query = 'delete',

            idemployees = OLD.idemployees,

            name = OLD.name,

            pasport = OLD.pasport,

            inn = OLD.inn,

            phone = OLD.phone,

            address = OLD.address,

            email = OLD.email,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_employees` AFTER INSERT ON `employees` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_employees Set date = now(),

            query = 'insert',

            idemployees = NEW.idemployees,

            name = NEW.name,

            pasport = NEW.pasport,

            inn = NEW.inn,

            phone = NEW.phone,

            address = NEW.address,

            email = NEW.email,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_employees` AFTER UPDATE ON `employees` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_employees SET date = now(),

            query = 'update',

            idemployees = OLD.idemployees,

            name = OLD.name,

            pasport = OLD.pasport,

            inn = OLD.inn,

            phone = OLD.phone,

            address = OLD.address,

            email = OLD.email,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;