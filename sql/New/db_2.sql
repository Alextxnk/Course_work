-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 24 2021 г., 06:58
-- Версия сервера: 5.7.33
-- Версия PHP: 7.2.34

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

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_dishes` (IN `ids` INT)  BEGIN
	declare idIn int;
    declare nameIn varchar(45);
    declare cost_priceIn double;
    declare priceIn double;
    declare usedIn tinyint(1);
    declare queryIn varchar(15);

    set queryIn = (SELECT `query` FROM mydb.temp_dishes where id = ids);
    set idIn = (SELECT id_row FROM mydb.temp_dishes where id = ids);
    set nameIn = (SELECT `name` FROM mydb.temp_dishes where id = ids);
    set cost_priceIn = (SELECT cost_price FROM mydb.temp_dishes where id = ids);
    set priceIn = (SELECT price FROM mydb.temp_dishes where id = ids);
	set usedIn = (SELECT used FROM mydb.temp_dishes where id = ids);

	case queryIn
    when 'insert' then
		update dishes set used = 0 where `id` = idIn;
        update recipe set used = 0 where `ID_dish` = idIn;
	when 'delete' then 
		insert into dishes (`name`,`cost_price`,`price`,`used`) values (nameIn,cost_priceIn,priceIn, usedIn);
	when 'update' then
		update dishes set `name`=nameIn, cost_price=cost_priceIn, price=priceIn, used=usedIn where `id`=idIn;
        update recipe set used = usedIn where `ID_dish` = idIn;
	end case;
    #delete from temp_dishes where id=idTemp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_drinks` (IN `ids` INT)  BEGIN
	declare idIn int;
    declare nameIn varchar(45);
    declare cost_priceIn double;
    declare priceIn double;
    declare usedIn tinyint(1);
    declare queryIn varchar(15);

    set queryIn = (SELECT `query` FROM mydb.temp_drinks where id = ids);
    set idIn = (SELECT id_row FROM mydb.temp_drinks where id = ids);
    set nameIn = (SELECT `name` FROM mydb.temp_drinks where id = ids);
    set cost_priceIn = (SELECT cost_price FROM mydb.temp_drinks where id = ids);
    set priceIn = (SELECT price FROM mydb.temp_drinks where id = ids);
	set usedIn = (SELECT used FROM mydb.temp_drinks where id = ids);

	case queryIn
    when 'insert' then
		update drinks set used = 0 where `id` = idIn;
	when 'delete' then 
		insert into drinks (`name`, `cost_price`, `price`, `used`) values (nameIn, cost_priceIn, priceIn, usedIn);
	when 'update' then
		update drinks set `name`=nameIn, cost_price=cost_priceIn, price=priceIn, used=usedIn where `id`=idIn;
	end case;
    #delete from temp_drinks where id=idTemp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_ingredients` (IN `ids` INT)  BEGIN
	declare idIn int;
    declare nameIn varchar(45);
    declare costIn double;
    declare unitIn varchar(45);
    declare usedIn tinyint(1);
    declare idTemp int;
    declare queryIn varchar(15);

    set idTemp = (SELECT id FROM mydb.temp_ingredients ORDER BY id desc LIMIT 1);
    set queryIn = (SELECT `query` FROM mydb.temp_ingredients where id = ids);
    set idIn = (SELECT ID_ingredient FROM mydb.temp_ingredients where id = ids);
    set nameIn = (SELECT `name` FROM mydb.temp_ingredients where id = ids);
    set costIn = (SELECT cost FROM mydb.temp_ingredients where id = ids);
    set unitIn = (SELECT unit FROM mydb.temp_ingredients where id = ids);
	set usedIn = (SELECT used FROM mydb.temp_ingredients where id = ids);

	case queryIn
    when 'insert' then
		update ingredients set used = 0 where ID_ingredient = idIn;
	when 'delete' then 
		insert into ingredients (`name`, `cost`, `unit`, `used`) values (nameIn,costIn,unitIn, usedIn);
	when 'update' then
		update ingredients set `name`=nameIn, cost=costIn, unit=unitIn, used=usedIn where ID_ingredient=idIn;
	end case;
   # delete from temp_ingredients where id=idTemp;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `dishes`
--

CREATE TABLE `dishes` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `cost_price` double NOT NULL,
  `price` double NOT NULL,
  `used` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `dishes`
--

INSERT INTO `dishes` (`id`, `name`, `cost_price`, `price`, `used`) VALUES
(66, 'Борщ', 61, 150, 1),
(67, 'Плов', 50.5, 150, 1);

--
-- Триггеры `dishes`
--
DELIMITER $$
CREATE TRIGGER `delete_dishes` AFTER DELETE ON `dishes` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_dishes SET date = now(),

                            query = 'delete',

                            id_row = OLD.id,

                            name = OLD.name,

                            cost_price = OLD.cost_price,

                            price = OLD.price,

                            used = OLD.used;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_dishes` AFTER INSERT ON `dishes` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_dishes Set date = now(),

                            query = 'insert',

                            id_row = NEW.id,

                            name = NEW.name,

                            cost_price = NEW.cost_price,

                            price = NEW.price,

                            used = NEW.used;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_dishes` AFTER UPDATE ON `dishes` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_dishes SET

                            date = now(),

                            query = 'update',

                            id_row = OLD.id,

                            name = OLD.name,

                            cost_price = OLD.cost_price,

                            price = OLD.price,

                            used = OLD.used;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `dish_order`
--

CREATE TABLE `dish_order` (
  `ID_order` int(11) NOT NULL,
  `ID_total` int(11) NOT NULL,
  `ID_dish` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `cond` tinyint(1) DEFAULT NULL,
  `wait` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `dish_order`
--

INSERT INTO `dish_order` (`ID_order`, `ID_total`, `ID_dish`, `count`, `cond`, `wait`) VALUES
(8, 1, 66, 2, 1, 0),
(9, 2, 67, 3, 1, 0);

--
-- Триггеры `dish_order`
--
DELIMITER $$
CREATE TRIGGER `delete_dish_order` AFTER DELETE ON `dish_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_dish_order SET date = now(),

                                query = 'delete',

                                ID_order = OLD.ID_order,

                                ID_total = OLD.ID_total,

                                ID_dish = OLD.ID_dish,

                                count = OLD.count,

                                cond = OLD.cond,

                                wait = OLD.wait;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_dish_order` AFTER INSERT ON `dish_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_dish_order Set date = now(),

                                query = 'insert',

                                ID_order = NEW.ID_order,

                                ID_total = NEW.ID_total,

                                ID_dish = NEW.ID_dish,

                                count = NEW.count,

                                cond = NEW.cond,

                                wait = NEW.wait;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_dish_order` AFTER UPDATE ON `dish_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_dish_order SET

                                date = now(),

                                query = 'update',

                                ID_order = OLD.ID_order,

                                ID_total = OLD.ID_total,

                                ID_dish = OLD.ID_dish,

                                count = OLD.count,

                                cond = OLD.cond,

                                wait = OLD.wait;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `drinks`
--

CREATE TABLE `drinks` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `cost_price` double NOT NULL,
  `price` double NOT NULL,
  `used` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `drinks`
--

INSERT INTO `drinks` (`id`, `name`, `cost_price`, `price`, `used`) VALUES
(28, 'Sprite', 5, 100, 0),
(29, 'Sprite', 50, 100, 0),
(30, 'Sprite', 50, 100, 0);

--
-- Триггеры `drinks`
--
DELIMITER $$
CREATE TRIGGER `delete_drinks` AFTER DELETE ON `drinks` FOR EACH ROW BEGIN if @can_use is null then begin

    INSERT INTO temp_drinks SET date = now(),

                                query = 'delete',

                                id_row = OLD.id,

                                name = OLD.name,

                                cost_price = OLD.cost_price,

                                price = OLD.price,

                                used = OLD.used;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_drinks` AFTER INSERT ON `drinks` FOR EACH ROW BEGIN if @can_use is null then begin

    INSERT INTO temp_drinks Set date = now(),

                                query = 'insert',

                                id_row = NEW.id,

                                name = NEW.name,

                                cost_price = NEW.cost_price,

                                price = NEW.price,

                                used = NEW.used;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_drinks` AFTER UPDATE ON `drinks` FOR EACH ROW BEGIN if @can_use is null then begin

    INSERT INTO temp_drinks SET

                                date = now(),

                                query = 'update',

                                id_row = OLD.id,

                                name = OLD.name,

                                cost_price = OLD.cost_price,

                                price = OLD.price,

                                used = OLD.used;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `drink_order`
--

CREATE TABLE `drink_order` (
  `ID_order` int(11) NOT NULL,
  `ID_drink` int(11) NOT NULL,
  `ID_total` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `cond` tinyint(1) DEFAULT NULL,
  `wait` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Триггеры `drink_order`
--
DELIMITER $$
CREATE TRIGGER `delete_drink_order` AFTER DELETE ON `drink_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_drink_order SET date = now(),

                                 query = 'delete',

                                 ID_order = OLD.ID_order,

                                 ID_total = OLD.ID_total,

                                 ID_drink = OLD.ID_drink,

                                 count = OLD.count,

                                 cond = OLD.cond,

                                 wait = OLD.wait;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_drink_order` AFTER INSERT ON `drink_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_drink_order Set date = now(),

                                 query = 'insert',

                                 ID_order = NEW.ID_order,

                                 ID_total = NEW.ID_total,

                                 ID_drink = NEW.ID_drink,

                                 count = NEW.count,

                                 cond = NEW.cond,

                                 wait = NEW.wait;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_drink_order` AFTER UPDATE ON `drink_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_drink_order SET

                                 date = now(),

                                 query = 'update',

                                 ID_order = OLD.ID_order,

                                 ID_total = OLD.ID_total,

                                 ID_drink = OLD.ID_drink,

                                 count = OLD.count,

                                 cond = OLD.cond,

                                 wait = OLD.wait;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `employees`
--

CREATE TABLE `employees` (
  `ID_empl` int(11) NOT NULL,
  `post` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `patronymic` varchar(50) NOT NULL,
  `used` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`ID_empl`, `post`, `name`, `surname`, `patronymic`, `used`) VALUES
(1, 'Администратор', 'Никита', 'Сюремов', 'Георгиевич', 1),
(2, 'Официант', 'Иван', 'Иванов', 'Иванович', 1),
(3, 'Повар', 'Геннадий', 'Пупкин', 'Агдреевич', 1),
(4, 'Директор', 'Виталя', 'Смотрящий', 'Васильевич', 1);

--
-- Триггеры `employees`
--
DELIMITER $$
CREATE TRIGGER `delete_employees` AFTER DELETE ON `employees` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_employees SET date = now(),

                              query = 'delete',

                              ID_empl = OLD.ID_empl,

                              -- passport_id = OLD.passport_id,

                              -- adress = OLD.adress,

                              -- phone_number = OLD.phone_number,

                              -- age = OLD.age,

                              post = OLD.post,

                              name = OLD.name,

                              surname = OLD.surname,

                              patronymic = OLD.patronymic;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_employees` AFTER INSERT ON `employees` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_employees Set date = now(),

                              query = 'insert',

                              ID_empl = NEW.ID_empl,

                              -- passport_id = NEW.passport_id,

                              -- adress = NEW.adress,

                              -- phone_number = NEW.phone_number,

                              -- age = NEW.age,

                              post = NEW.post,

                              name = NEW.name,

                              surname = NEW.surname,

                              patronymic = NEW.patronymic;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_employees` AFTER UPDATE ON `employees` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_employees SET

                              date = now(),

                              query = 'update',

                              ID_empl = OLD.ID_empl,

                              -- passport_id = OLD.passport_id,

                              -- adress = OLD.adress,

                              -- phone_number = OLD.phone_number,

                              -- age = OLD.age,

                              post = OLD.post,

                              name = OLD.name,

                              surname = OLD.surname,

                              patronymic = OLD.patronymic;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `ingredients`
--

CREATE TABLE `ingredients` (
  `ID_ingredient` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `cost` double NOT NULL,
  `unit` varchar(45) DEFAULT NULL,
  `used` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ingredients`
--

INSERT INTO `ingredients` (`ID_ingredient`, `name`, `cost`, `unit`, `used`) VALUES
(14, 'Картошка', 30, 'кг', 0),
(15, 'Вода', 1, 'кг', 0),
(16, 'Лук', 30, 'кг', 1),
(17, 'Морковь', 30, 'кг', 0),
(18, 'Горошек', 40, 'кг', 0),
(19, 'Рис', 40, 'кг', 0),
(20, 'Гречка', 40, 'кг', 0),
(21, 'Спагетти', 40, 'кг', 0),
(22, 'Рис', 60, 'кг', 0),
(23, 'Рис', 60, 'кг', 0),
(24, 'Рис', 60, 'кг', 0),
(25, 'Рис', 100, 'кг', 0);

--
-- Триггеры `ingredients`
--
DELIMITER $$
CREATE TRIGGER `delete_ingredients` AFTER DELETE ON `ingredients` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_ingredients SET date = now(),

                                 query = 'delete',

                                 ID_ingredient = OLD.ID_ingredient,

                                 name = OLD.name,

                                 cost = OLD.cost,

                                 unit = OLD.unit,

                                 used = OLD.used;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_ingredients` AFTER INSERT ON `ingredients` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_ingredients Set date = now(),

                                 query = 'insert',

                                 ID_ingredient = NEW.ID_ingredient,

                                 name = NEW.name,

                                 cost = NEW.cost,

                                 unit = NEW.unit,

                                 used = NEW.used;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_ingredients` AFTER UPDATE ON `ingredients` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_ingredients SET

                                 date = now(),

                                 query = 'update',

                                 ID_ingredient = OLD.ID_ingredient,

                                 name = OLD.name,

                                 cost = OLD.cost,

                                 unit = OLD.unit,

                                 used = OLD.used;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `recipe`
--

CREATE TABLE `recipe` (
  `ID_ingredient` int(11) NOT NULL,
  `ID_dish` int(11) NOT NULL,
  `count` double NOT NULL,
  `used` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `recipe`
--

INSERT INTO `recipe` (`ID_ingredient`, `ID_dish`, `count`, `used`) VALUES
(14, 66, 1, 1),
(15, 66, 1, 1),
(15, 67, 0.5, 1),
(16, 66, 1, 1),
(16, 67, 0.5, 1),
(17, 67, 0.5, 1),
(19, 67, 0.5, 1);

--
-- Триггеры `recipe`
--
DELIMITER $$
CREATE TRIGGER `delete_recipe` AFTER DELETE ON `recipe` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_recipe SET date = now(),

                            query = 'delete',

                            ID_ingredient = OLD.ID_ingredient,

                            ID_dish = OLD.ID_dish,

                            count = OLD.count;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_recipe` AFTER INSERT ON `recipe` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_recipe Set date = now(),

                            query = 'insert',

                            ID_ingredient = NEW.ID_ingredient,

                            ID_dish = NEW.ID_dish,

                            count = NEW.count;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_recipe` AFTER UPDATE ON `recipe` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_recipe SET

                            date = now(),

                            query = 'update',

                            ID_ingredient = OLD.ID_ingredient,

                            ID_dish = OLD.ID_dish,

                            count = OLD.count;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `tables`
--

CREATE TABLE `tables` (
  `ID_table` int(11) NOT NULL,
  `cond` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tables`
--

INSERT INTO `tables` (`ID_table`, `cond`) VALUES
(1, 1),
(2, 1),
(3, 0),
(4, 0),
(5, 0);

--
-- Триггеры `tables`
--
DELIMITER $$
CREATE TRIGGER `delete_tables` AFTER DELETE ON `tables` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_tables SET date = now(),

                            query = 'delete',

                            ID_table = OLD.ID_table,

                            cond = OLD.cond;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_tables` AFTER INSERT ON `tables` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_tables Set date = now(),

                            query = 'insert',

                            ID_table = NEW.ID_table,

                            cond = NEW.cond;

end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_tables` AFTER UPDATE ON `tables` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_tables SET

                            date = now(),

                            query = 'update',

                            ID_table = OLD.ID_table,

                            cond = OLD.cond;

end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `temp_dishes`
--

CREATE TABLE `temp_dishes` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `id_row` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `cost_price` double NOT NULL,
  `price` double NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `temp_dish_order`
--

CREATE TABLE `temp_dish_order` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) NOT NULL,
  `ID_order` int(11) NOT NULL,
  `ID_total` int(11) NOT NULL,
  `ID_dish` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `cond` tinyint(1) DEFAULT NULL,
  `wait` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `temp_dish_order`
--

INSERT INTO `temp_dish_order` (`id`, `date`, `query`, `ID_order`, `ID_total`, `ID_dish`, `count`, `cond`, `wait`) VALUES
(14, '2021-12-07 23:40:20', 'insert', 8, 1, 66, 2, 0, 0),
(15, '2021-12-07 23:47:11', 'insert', 9, 2, 67, 3, 0, 0),
(16, '2021-12-07 23:52:44', 'update', 9, 2, 67, 3, 0, 0),
(17, '2021-12-07 23:52:45', 'update', 8, 1, 66, 2, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `temp_drinks`
--

CREATE TABLE `temp_drinks` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `id_row` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `cost_price` double NOT NULL,
  `price` double NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `temp_drinks`
--

INSERT INTO `temp_drinks` (`id`, `date`, `query`, `id_row`, `name`, `cost_price`, `price`, `used`) VALUES
(106, '2021-12-11 17:44:46', 'delete', 24, 'Сок', 50, 100, 0),
(107, '2021-12-11 17:44:46', 'delete', 18, 'Cola', 50, 100, 0),
(108, '2021-12-11 17:44:46', 'delete', 27, 'Сок', 55, 100, 0),
(109, '2021-12-11 17:44:46', 'delete', 19, 'Fanta', 50, 100, 0),
(110, '2021-12-11 17:44:46', 'delete', 22, 'Сок', 50, 100, 0),
(111, '2021-12-11 17:44:46', 'delete', 21, 'Сок', 50, 100, 0),
(112, '2021-12-11 17:44:46', 'delete', 23, 'Сок', 50, 100, 0),
(113, '2021-12-11 17:44:46', 'delete', 26, 'Fanta', 55, 100, 0),
(114, '2021-12-11 17:44:46', 'delete', 25, 'Sprite', 5, 100, 0),
(115, '2021-12-11 17:44:46', 'delete', 20, 'Sprite', 50, 100, 0),
(116, '2021-12-11 17:48:26', 'insert', 28, 'Sprite', 5, 100, 0),
(117, '2021-12-11 17:48:26', 'insert', 29, 'Sprite', 50, 100, 0),
(118, '2021-12-11 17:48:29', 'update', 28, 'Sprite', 5, 100, 0),
(119, '2021-12-11 17:48:29', 'update', 29, 'Sprite', 50, 100, 0),
(120, '2021-12-11 17:48:43', 'update', 29, 'Sprite', 50, 100, 0),
(121, '2021-12-11 17:48:43', 'update', 28, 'Sprite', 5, 100, 0),
(122, '2021-12-11 17:48:43', 'update', 29, 'Sprite', 50, 100, 0),
(123, '2021-12-11 17:48:51', 'insert', 30, 'Sprite', 50, 100, 0),
(124, '2021-12-11 17:48:51', 'update', 28, 'Sprite', 5, 100, 0),
(125, '2021-12-11 17:48:51', 'update', 29, 'Sprite', 50, 100, 0),
(126, '2021-12-11 17:48:51', 'update', 28, 'Sprite', 5, 100, 0),
(127, '2021-12-11 17:48:51', 'update', 29, 'Sprite', 50, 100, 0),
(128, '2021-12-11 17:48:51', 'update', 29, 'Sprite', 50, 100, 0),
(129, '2021-12-11 17:48:51', 'update', 28, 'Sprite', 5, 100, 0),
(130, '2021-12-11 17:48:51', 'update', 29, 'Sprite', 50, 100, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `temp_drink_order`
--

CREATE TABLE `temp_drink_order` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `ID_order` int(11) NOT NULL,
  `ID_drink` int(11) NOT NULL,
  `ID_total` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `cond` tinyint(1) DEFAULT NULL,
  `wait` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `temp_employees`
--

CREATE TABLE `temp_employees` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `ID_empl` int(11) NOT NULL,
  `post` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `patronymic` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `temp_ingredients`
--

CREATE TABLE `temp_ingredients` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `ID_ingredient` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `cost` double NOT NULL,
  `unit` varchar(45) DEFAULT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `temp_recipe`
--

CREATE TABLE `temp_recipe` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `ID_ingredient` int(11) NOT NULL,
  `ID_dish` int(11) NOT NULL,
  `count` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `temp_recipe`
--

INSERT INTO `temp_recipe` (`id`, `date`, `query`, `ID_ingredient`, `ID_dish`, `count`) VALUES
(220, '2021-12-07 23:39:46', 'insert', 14, 66, 1),
(221, '2021-12-07 23:39:46', 'insert', 15, 66, 1),
(222, '2021-12-07 23:39:46', 'insert', 16, 66, 1),
(223, '2021-12-07 23:40:08', 'insert', 16, 67, 0.5),
(224, '2021-12-07 23:40:08', 'insert', 15, 67, 0.5),
(225, '2021-12-07 23:40:08', 'insert', 17, 67, 0.5),
(226, '2021-12-07 23:40:08', 'insert', 19, 67, 0.5),
(227, '2021-12-11 17:41:36', 'update', 15, 67, 0.5),
(228, '2021-12-11 17:41:36', 'update', 16, 67, 0.5),
(229, '2021-12-11 17:41:36', 'update', 17, 67, 0.5),
(230, '2021-12-11 17:41:36', 'update', 19, 67, 0.5),
(231, '2021-12-11 17:41:43', 'update', 15, 67, 0.5),
(232, '2021-12-11 17:41:43', 'update', 16, 67, 0.5),
(233, '2021-12-11 17:41:43', 'update', 17, 67, 0.5),
(234, '2021-12-11 17:41:43', 'update', 19, 67, 0.5),
(235, '2021-12-11 17:41:43', 'update', 15, 67, 0.5),
(236, '2021-12-11 17:41:43', 'update', 16, 67, 0.5),
(237, '2021-12-11 17:41:43', 'update', 17, 67, 0.5),
(238, '2021-12-11 17:41:43', 'update', 19, 67, 0.5);

-- --------------------------------------------------------

--
-- Структура таблицы `temp_tables`
--

CREATE TABLE `temp_tables` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `ID_table` int(11) NOT NULL,
  `cond` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `temp_tables`
--

INSERT INTO `temp_tables` (`id`, `date`, `query`, `ID_table`, `cond`) VALUES
(20, '2021-12-07 19:25:52', 'update', 2, 0),
(21, '2021-12-07 23:40:28', 'update', 4, 0),
(22, '2021-12-07 23:52:44', 'update', 4, 1),
(23, '2021-12-07 23:52:45', 'update', 2, 1),
(24, '2021-12-07 23:55:27', 'update', 2, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `temp_total_order`
--

CREATE TABLE `temp_total_order` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `ID_total` int(11) NOT NULL,
  `ID_table` int(11) NOT NULL,
  `date_row` date DEFAULT NULL,
  `time` time NOT NULL,
  `sum` double NOT NULL,
  `cond` tinyint(1) DEFAULT NULL,
  `performer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `temp_total_order`
--

INSERT INTO `temp_total_order` (`id`, `date`, `query`, `ID_total`, `ID_table`, `date_row`, `time`, `sum`, `cond`, `performer`) VALUES
(809, '2021-11-30 20:31:01', 'delete', 4, 1, '2021-11-30', '10:38:52', 0, 0, 2),
(810, '2021-11-30 20:31:01', 'delete', 3, 1, '2021-11-30', '10:34:30', 1200, 1, 2),
(811, '2021-12-07 19:25:52', 'insert', 1, 2, '2021-12-07', '19:25:52', 0, 0, 2),
(812, '2021-12-07 23:40:28', 'insert', 2, 4, '2021-12-07', '23:40:28', 0, 0, 2),
(813, '2021-12-07 23:52:44', 'update', 2, 4, '2021-12-07', '23:40:28', 0, 0, 2),
(814, '2021-12-07 23:52:45', 'update', 1, 2, '2021-12-07', '19:25:52', 0, 0, 2),
(815, '2021-12-07 23:55:27', 'insert', 3, 2, '2021-12-07', '23:55:27', 0, 0, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `temp_users`
--

CREATE TABLE `temp_users` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `query` varchar(15) DEFAULT NULL,
  `id_row` int(11) NOT NULL,
  `ID_empl` int(11) DEFAULT NULL,
  `login` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `logged` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `temp_users`
--

INSERT INTO `temp_users` (`id`, `date`, `query`, `id_row`, `ID_empl`, `login`, `pass`, `logged`) VALUES
(6, '2021-11-30 20:37:48', 'update', 2, 2, 'ivan', '2222', 0),
(7, '2021-11-30 20:37:50', 'update', 4, 4, 'vita', '4444', 0),
(8, '2021-11-30 22:54:35', 'update', 4, 4, 'vita', '4444', 0),
(9, '2021-11-30 23:50:50', 'update', 4, 4, 'vita', '4444', 0),
(10, '2021-11-30 23:51:38', 'update', 4, 4, 'vita', '4444', 0),
(11, '2021-12-01 13:25:21', 'update', 4, 4, 'vita', '4444', 0),
(12, '2021-12-01 15:32:03', 'update', 4, 4, 'vita', '4444', 0),
(13, '2021-12-01 16:08:21', 'update', 4, 4, 'vita', '4444', 0),
(14, '2021-12-01 20:08:31', 'update', 4, 4, 'vita', '4444', 0),
(15, '2021-12-01 20:08:34', 'update', 4, 4, 'vita', '4444', 1),
(16, '2021-12-01 20:09:08', 'update', 3, 3, 'gena', '3333', 0),
(17, '2021-12-01 20:09:12', 'update', 3, 3, 'gena', '3333', 1),
(18, '2021-12-01 20:09:20', 'update', 2, 2, 'ivan', '2222', 0),
(19, '2021-12-01 20:09:23', 'update', 2, 2, 'ivan', '2222', 1),
(20, '2021-12-01 20:09:29', 'update', 1, 1, 'nik', '1111', 0),
(21, '2021-12-01 20:09:34', 'update', 1, 1, 'nik', '1111', 1),
(22, '2021-12-01 20:09:39', 'update', 4, 4, 'vita', '4444', 0),
(23, '2021-12-01 20:17:52', 'update', 4, 4, 'vita', '4444', 1),
(24, '2021-12-04 10:41:55', 'update', 4, 4, 'vita', '4444', 0),
(25, '2021-12-04 10:42:01', 'update', 4, 4, 'vita', '4444', 0),
(26, '2021-12-04 16:51:07', 'update', 4, 4, 'vita', '4444', 0),
(27, '2021-12-04 18:37:25', 'update', 4, 4, 'vita', '4444', 0),
(28, '2021-12-07 16:59:17', 'update', 4, 4, 'vita', '4444', 0),
(29, '2021-12-07 17:04:54', 'update', 4, 4, 'vita', '4444', 0),
(30, '2021-12-07 18:36:39', 'update', 2, 2, 'ivan', '2222', 0),
(31, '2021-12-07 19:57:41', 'update', 2, 2, 'ivan', '2222', 0),
(32, '2021-12-07 20:20:58', 'update', 4, 4, 'vita', '4444', 0),
(33, '2021-12-07 23:37:49', 'update', 2, 2, 'ivan', '2222', 0),
(34, '2021-12-07 23:37:56', 'update', 2, 2, 'ivan', '2222', 0),
(35, '2021-12-07 23:54:31', 'update', 4, 4, 'vita', '4444', 0),
(36, '2021-12-07 23:58:25', 'update', 2, 2, 'ivan', '2222', 1),
(37, '2021-12-08 00:19:47', 'update', 4, 4, 'vita', '4444', 0),
(38, '2021-12-11 11:45:46', 'update', 4, 4, 'vita', '4444', 0),
(39, '2021-12-11 17:51:12', 'update', 4, 4, 'vita', '4444', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `total_order`
--

CREATE TABLE `total_order` (
  `ID_total` int(11) NOT NULL,
  `ID_table` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time NOT NULL,
  `sum` double NOT NULL,
  `cond` tinyint(1) DEFAULT NULL,
  `performer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `total_order`
--

INSERT INTO `total_order` (`ID_total`, `ID_table`, `date`, `time`, `sum`, `cond`, `performer`) VALUES
(1, 2, '2021-12-07', '19:25:52', 300, 1, 2),
(2, 4, '2021-12-07', '23:40:28', 450, 1, 2),
(3, 2, '2021-12-07', '23:55:27', 0, 0, 2);

--
-- Триггеры `total_order`
--
DELIMITER $$
CREATE TRIGGER `delete_total_order` BEFORE DELETE ON `total_order` FOR EACH ROW BEGIN if @can_use is null then begin

    INSERT INTO temp_total_order SET date = now(),

                                    query = 'delete',

                                     ID_total = OLD.ID_total,

                                     ID_table = OLD.ID_table,

                                     date_row = OLD.date,

                                     time = OLD.time,

                                     sum = OLD.sum,

                                     cond = OLD.cond,

                                     performer = OLD.performer;

    end; end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_total_order` AFTER INSERT ON `total_order` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_total_order Set date = now(),

                                query = 'insert',

                                ID_total = NEW.ID_total,

                                 ID_table = NEW.ID_table,

                                 date_row = NEW.date,

                                 time = NEW.time,

                                 sum = NEW.sum,

                                 cond = NEW.cond,

                                 performer = NEW.performer;

end; end if;



END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_order` BEFORE UPDATE ON `total_order` FOR EACH ROW BEGIN if @can_use is null then begin

    INSERT INTO temp_total_order SET

        date = now(),

        query = 'update',

        ID_total = OLD.ID_total,

        ID_table = OLD.ID_table,

        date_row = OLD.date,

        time = OLD.time,

        sum = OLD.sum,

        cond = OLD.cond,

        performer = OLD.performer;

    end; end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `ID_empl` int(11) DEFAULT NULL,
  `login` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `logged` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `ID_empl`, `login`, `pass`, `logged`) VALUES
(1, 1, 'nik', '1111', 0),
(2, 2, 'ivan', '2222', 0),
(3, 3, 'gena', '3333', 0),
(4, 4, 'vita', '4444', 0);

--
-- Триггеры `users`
--
DELIMITER $$
CREATE TRIGGER `delete_users` AFTER DELETE ON `users` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_users SET date = now(),

                           query = 'delete',

                           id_row = OLD.id,

                           ID_empl = OLD.ID_empl,

                           login = OLD.login,

                           pass = OLD.pass,

                           logged = OLD.logged;

end; end if;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_users` AFTER INSERT ON `users` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_users Set date = now(),

                           query = 'insert',

                           id_row = NEW.id,

                           ID_empl = NEW.ID_empl,

                           login = NEW.login,

                           pass = NEW.pass,

                           logged = NEW.logged;

end;

end if;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_users` AFTER UPDATE ON `users` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_users SET

                           date = now(),

                           query = 'update',

                           id_row = OLD.id,

                           ID_empl = OLD.ID_empl,

                           login = OLD.login,

                           pass = OLD.pass,

                           logged = OLD.logged;

end; end if;

END
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `dish_order`
--
ALTER TABLE `dish_order`
  ADD PRIMARY KEY (`ID_order`,`ID_total`,`ID_dish`),
  ADD KEY `fk_Dish_order_Total_order1_idx` (`ID_total`),
  ADD KEY `fk_Dish_order_Dishes1_idx` (`ID_dish`);

--
-- Индексы таблицы `drinks`
--
ALTER TABLE `drinks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `drink_order`
--
ALTER TABLE `drink_order`
  ADD PRIMARY KEY (`ID_order`,`ID_drink`,`ID_total`),
  ADD KEY `fk_Drink_order_Total_order1_idx` (`ID_total`),
  ADD KEY `fk_Drink_order_Drinks1_idx` (`ID_drink`);

--
-- Индексы таблицы `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`ID_empl`);

--
-- Индексы таблицы `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ID_ingredient`);

--
-- Индексы таблицы `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`ID_ingredient`,`ID_dish`),
  ADD KEY `fk_Ingredients_has_Dish_order_Ingredients1_idx` (`ID_ingredient`),
  ADD KEY `fk_Recipe_Dishes1_idx` (`ID_dish`);

--
-- Индексы таблицы `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`ID_table`);

--
-- Индексы таблицы `temp_dishes`
--
ALTER TABLE `temp_dishes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_dish_order`
--
ALTER TABLE `temp_dish_order`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_drinks`
--
ALTER TABLE `temp_drinks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_drink_order`
--
ALTER TABLE `temp_drink_order`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_employees`
--
ALTER TABLE `temp_employees`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_ingredients`
--
ALTER TABLE `temp_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_recipe`
--
ALTER TABLE `temp_recipe`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_tables`
--
ALTER TABLE `temp_tables`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_total_order`
--
ALTER TABLE `temp_total_order`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `temp_users`
--
ALTER TABLE `temp_users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `total_order`
--
ALTER TABLE `total_order`
  ADD PRIMARY KEY (`ID_total`,`ID_table`),
  ADD KEY `fk_Total_order_Tables1_idx` (`ID_table`),
  ADD KEY `performer` (`performer`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ID_empl` (`ID_empl`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT для таблицы `dish_order`
--
ALTER TABLE `dish_order`
  MODIFY `ID_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `drinks`
--
ALTER TABLE `drinks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `drink_order`
--
ALTER TABLE `drink_order`
  MODIFY `ID_order` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `employees`
--
ALTER TABLE `employees`
  MODIFY `ID_empl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ID_ingredient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `tables`
--
ALTER TABLE `tables`
  MODIFY `ID_table` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `temp_dishes`
--
ALTER TABLE `temp_dishes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `temp_dish_order`
--
ALTER TABLE `temp_dish_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `temp_drinks`
--
ALTER TABLE `temp_drinks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT для таблицы `temp_drink_order`
--
ALTER TABLE `temp_drink_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `temp_employees`
--
ALTER TABLE `temp_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `temp_ingredients`
--
ALTER TABLE `temp_ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `temp_recipe`
--
ALTER TABLE `temp_recipe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT для таблицы `temp_tables`
--
ALTER TABLE `temp_tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `temp_total_order`
--
ALTER TABLE `temp_total_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=816;

--
-- AUTO_INCREMENT для таблицы `temp_users`
--
ALTER TABLE `temp_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT для таблицы `total_order`
--
ALTER TABLE `total_order`
  MODIFY `ID_total` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `dish_order`
--
ALTER TABLE `dish_order`
  ADD CONSTRAINT `fk_Dish_order_Dishes1` FOREIGN KEY (`ID_dish`) REFERENCES `dishes` (`id`),
  ADD CONSTRAINT `fk_Dish_order_Total_order1` FOREIGN KEY (`ID_total`) REFERENCES `total_order` (`ID_total`);

--
-- Ограничения внешнего ключа таблицы `drink_order`
--
ALTER TABLE `drink_order`
  ADD CONSTRAINT `fk_Drink_order_Drinks1` FOREIGN KEY (`ID_drink`) REFERENCES `drinks` (`id`),
  ADD CONSTRAINT `fk_Drink_order_Total_order1` FOREIGN KEY (`ID_total`) REFERENCES `total_order` (`ID_total`);

--
-- Ограничения внешнего ключа таблицы `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `fk_Ingredients_has_Dish_order_Ingredients1` FOREIGN KEY (`ID_ingredient`) REFERENCES `ingredients` (`ID_ingredient`),
  ADD CONSTRAINT `fk_Recipe_Dishes1` FOREIGN KEY (`ID_dish`) REFERENCES `dishes` (`id`);

--
-- Ограничения внешнего ключа таблицы `total_order`
--
ALTER TABLE `total_order`
  ADD CONSTRAINT `fk_Total_order_Tables1` FOREIGN KEY (`ID_table`) REFERENCES `tables` (`ID_table`),
  ADD CONSTRAINT `total_order_ibfk_1` FOREIGN KEY (`performer`) REFERENCES `employees` (`ID_empl`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`ID_empl`) REFERENCES `employees` (`ID_empl`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
