SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `db_2`
--


--
-- Процедуры
--


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_employees` (IN `ids` INT)  BEGIN
    declare idIn int;
    declare nameIn varchar(100);
    declare pasportIn varchar(11);
    declare innIn varchar(12);
    declare phoneIn varchar(15);
    declare addressIn varchar(255);
    declare dateIn timestamp;
    declare emailIn varchar(255);
    declare usedIn tinyint(1);
    declare queryIn varchar(15);

    set queryIn = (SELECT `query` FROM furniture_store.temp_employees where id = ids);
    set idIn = (SELECT `id_row` FROM furniture_store.temp_employees where id = ids);
    set nameIn = (SELECT `name` FROM furniture_store.temp_employees where id = ids);
    set pasportIn = (SELECT `pasport` FROM furniture_store.temp_employees where id = ids);
    set innIn = (SELECT `inn` FROM furniture_store.temp_employees where id = ids);
    set phoneIn = (SELECT `phone` FROM furniture_store.temp_employees where id = ids);
    set addressIn = (SELECT `address` FROM furniture_store.temp_employees where id = ids);
    -- set dateIn = (SELECT `date` FROM furniture_store.temp_employees where id = ids);
    set emailIn = (SELECT `email` FROM furniture_store.temp_employees where id = ids);
    set usedIn = (SELECT `used` FROM furniture_store.temp_employees where id = ids);

	case queryIn
    when 'insert' then
      update employees set used = 0 where `idemployees` = idIn;
    when 'delete' then 
      insert into employees (`name`, `pasport`, `inn`, `phone`, `address`, `date`, `email`, `used`) values (nameIn, pasportIn, innIn, phoneIn, addressIn, dateIn, emailIn, usedIn);
    when 'update' then
      update employees set `name`= nameIn, `pasport` = pasportIn, `inn` = innIn, `phone` = phoneIn, `address` =  addressIn, `date` = dateIn, `email` = emailIn, `used` =usedIn where `idemployees`=idIn;
    end case;
    #delete from temp_employees where `idemployees`= idTemp;
END$$
DELIMITER ;





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

end; end if;

END$$
DELIMITER ;



CREATE TABLE `temp_employees` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idemployees` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pasport` varchar(11) NOT NULL,
  `inn` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `employees` (
  `idemployees` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pasport` varchar(11) NOT NULL,
  `inn` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `used` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `employees` (`idemployees`, `name`, `email`, `phone`, `address`, `pasport`, `inn`, `posts_idposts`) VALUES
(6, 'Хмелько Богдан Игоревич', 'bogdan@gmail.com', '8(988) 548-5544', 'Ростов-на-Дону, ул. Седова, дом. 11', '3104 547896', '243232313747', 1);


-- CREATE TABLE `temp_employees` (
--   `id` int(11) NOT NULL,
--   `date` datetime NOT NULL,
--   `query` varchar(15) DEFAULT NULL,
--   `ID_empl` int(11) NOT NULL,
--   `post` varchar(50) DEFAULT NULL,
--   `name` varchar(50) NOT NULL,
--   `surname` varchar(50) NOT NULL,
--   `patronymic` varchar(50) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `employees`
--

-- CREATE TABLE `employees` (
--   `ID_empl` int(11) NOT NULL,
--   `post` varchar(50) DEFAULT NULL,
--   `name` varchar(50) NOT NULL,
--   `surname` varchar(50) NOT NULL,
--   `patronymic` varchar(50) NOT NULL,
--   `used` tinyint(4) DEFAULT '1'
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `employees`
--

-- INSERT INTO `employees` (`ID_empl`, `post`, `name`, `surname`, `patronymic`, `used`) VALUES
-- (1, 'Администратор', 'Никита', 'Сюремов', 'Георгиевич', 1),
-- (2, 'Официант', 'Иван', 'Иванов', 'Иванович', 1),
-- (3, 'Повар', 'Геннадий', 'Пупкин', 'Агдреевич', 1),
-- (4, 'Директор', 'Виталя', 'Смотрящий', 'Васильевич', 1);