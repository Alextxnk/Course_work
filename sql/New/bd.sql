SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

--
-- База данных: `furniture_store`
--

-- CREATE DATABASE IF NOT EXISTS `furniture_store` DEFAULT CHARACTER SET utf8;
-- USE `furniture_store`;

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `idposts` int(11) NOT NULL AUTO_INCREMENT,
  `post_name` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `used` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`idposts`)
  ) 
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `posts` (`idposts`, `post_name`, `salary`, `used`) VALUES
(1, 'Кадровик', '40000.00', 1),
(2, 'Продавец', '30000.00', 1);

--
-- Структура таблицы `temp_posts`
--

CREATE TABLE `temp_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idposts` int(11) NOT NULL,
  `post_name` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `employees`
--

CREATE TABLE `employees`  (
  `idemployees` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pasport` varchar(11) NOT NULL,
  `inn` varchar(12) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `posts_idposts` int NOT NULL,
  `used` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`idemployees`, `posts_idposts`),
  KEY `fk_employees_posts1_idx` (`posts_idposts`),
  CONSTRAINT `fk_employees_posts1` FOREIGN KEY (`posts_idposts`) REFERENCES `posts` (`idposts`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `employees` (`idemployees`, `name`, `pasport`, `inn`, `phone`, `address`, `email`, `posts_idposts`, `used`) VALUES
(1, 'Хмелько Богдан Игоревич', '3104 547896', '243232313747', '8(988) 548-5544', 'Ростов-на-Дону, ул. Седова, дом. 11', 'bogdan@gmail.com', 1, 1);

--
-- Структура таблицы `temp_employees`
--

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
  `posts_idposts` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `monetary_transactions`
--

CREATE TABLE `monetary_transactions` (
  `idmonetary_transactions` int(11) NOT NULL AUTO_INCREMENT,
  `appointment` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date_tr` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idmonetary_transactions`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_monetary_transactions`
--

CREATE TABLE `temp_monetary_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idmonetary_transactions` int(11) NOT NULL,
  `appointment` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date_tr` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `purchases`
--

CREATE TABLE `purchases` (
  `idpurchases` int(11) NOT NULL AUTO_INCREMENT,
  `date_prch` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  `monetary_transactions_idmonetary_transactions` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idpurchases`, `monetary_transactions_idmonetary_transactions`),
  KEY `fk_purchases_monetary_transactions1_idx` (`monetary_transactions_idmonetary_transactions`),
  CONSTRAINT `fk_purchases_monetary_transactions1` FOREIGN KEY (`monetary_transactions_idmonetary_transactions`)  REFERENCES `monetary_transactions` (`idmonetary_transactions`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_purchases`
--

CREATE TABLE `temp_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idpurchases` int(11) NOT NULL,
  `date_prch` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  `monetary_transactions_idmonetary_transactions` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `idproducts` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
  `quantity` int(10) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idproducts`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_products`
--

CREATE TABLE `temp_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idproducts` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `quantity` int(10) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `purchase_products`
--

CREATE TABLE `purchase_products` (
  `idpurchase_products` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `purchases_idpurchases` int NOT NULL,
  `products_idproducts` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idpurchase_products`, `purchases_idpurchases`, `products_idproducts`),
  KEY `fk_purchase_products_purchases1_idx` (`purchases_idpurchases`),
  KEY `fk_purchase_products_products1_idx` (`products_idproducts`),
  CONSTRAINT `fk_purchase_products_purchases1` FOREIGN KEY (`purchases_idpurchases`) REFERENCES `purchases` (`idpurchases`),
  CONSTRAINT `fk_purchase_products_products1` FOREIGN KEY (`products_idproducts`) REFERENCES `products` (`idproducts`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_purchase_products`
--

CREATE TABLE `temp_purchase_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idpurchase_products` int(11) NOT NULL,
  `quantity` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `purchases_idpurchases` int NOT NULL,
  `products_idproducts` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `buyers`
--

CREATE TABLE `buyers` (
  `idbuyers` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idbuyers`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_buyers`
--

CREATE TABLE `temp_buyers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idbuyers` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `idorders` int(11) NOT NULL AUTO_INCREMENT,
  `date_ord` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  `employees_idemployees` int NOT NULL,
  `monetary_transactions_idmonetary_transactions` int NOT NULL,
  `buyers_idbuyers` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idorders`, `employees_idemployees`, `monetary_transactions_idmonetary_transactions`, `buyers_idbuyers`),
  KEY `fk_orders_employees1_idx` (`employees_idemployees`),
  KEY `fk_orders_monetary_transactions1_idx` (`monetary_transactions_idmonetary_transactions`),
  KEY `fk_orders_buyers1_idx` (`buyers_idbuyers`),
  CONSTRAINT `fk_orders_employees1` FOREIGN KEY (`employees_idemployees`) REFERENCES `employees` (`idemployees`),
  CONSTRAINT `fk_orders_monetary_transactions1` FOREIGN KEY (`monetary_transactions_idmonetary_transactions`)   REFERENCES `monetary_transactions` (`idmonetary_transactions`),
  CONSTRAINT `fk_orders_buyers1` FOREIGN KEY (`buyers_idbuyers`) REFERENCES `buyers` (`idbuyers`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_orders`
--

CREATE TABLE `temp_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idorders` int(11) NOT NULL,
  `date_ord` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  `employees_idemployees` int NOT NULL,
  `monetary_transactions_idmonetary_transactions` int NOT NULL,
  `buyers_idbuyers` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `order_products`
--

CREATE TABLE `order_products` (
  `idorder_products` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `orders_idorders` int NOT NULL,
  `products_idproducts` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idorder_products`, `orders_idorders`, `products_idproducts`),
  KEY `fk_order_products_orders1_idx` (`orders_idorders`),
  KEY `fk_order_products_products1_idx` (`products_idproducts`),
  CONSTRAINT `fk_order_products_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`),
  CONSTRAINT `fk_order_products_products1` FOREIGN KEY (`products_idproducts`) REFERENCES `products` (`idproducts`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `temp_order_products`
--

CREATE TABLE `temp_order_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `query` varchar(15) DEFAULT NULL,
  `idorder_products` int(11) NOT NULL,
  `quantity` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `orders_idorders` int NOT NULL,
  `products_idproducts` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `idusers` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `posts_idposts` int NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idusers`, `posts_idposts`),
  KEY `fk_users_posts1_idx` (`posts_idposts`),
  CONSTRAINT `fk_users_posts1` FOREIGN KEY (`posts_idposts`) REFERENCES `posts` (`idposts`)
  )
ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`idusers`, `login`, `password`, `posts_idposts`, `used`) VALUES
(1,'Alex','$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy', 1, 1),
(2,'Max','$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy', 1, 1),
(3,'Artem','$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy', 1, 1);

--
-- Индексы сохранённых таблиц
--

-- Индексы таблицы `buyers`

ALTER TABLE `buyers`
  ADD UNIQUE KEY `phone` (`phone`);

-- Индексы таблицы `employees`

ALTER TABLE `employees`
  ADD UNIQUE KEY `pasport` (`pasport`),
  ADD UNIQUE KEY `inn` (`inn`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`);

-- Индексы таблицы `users`

ALTER TABLE `users`
  ADD UNIQUE KEY `login` (`login`);


--
-- Процедуры `posts`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_posts` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare post_nameIn varchar(50);
  declare salaryIn decimal(10,2);
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_posts where id = ids);
  set idIn = (SELECT idposts FROM temp_posts where id = ids);
  set post_nameIn = (SELECT post_name FROM temp_posts where id = ids);
  set salaryIn = (SELECT salary FROM temp_posts where id = ids);
  set usedIn = (SELECT used FROM temp_posts where id = ids);

	case queryIn
  when 'insert' then
      update posts set used = 0 where `idposts` = idIn;
  when 'delete' then 
      insert into posts (`post_name`, `salary`, `used`) values (post_nameIn, salaryIn, usedIn);
  when 'update' then
      update posts set `post_name`= post_nameIn, `salary` = salaryIn, `used` = usedIn where `idposts` = idIn;
  end case;
  #delete from temp_posts where `idposts`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `posts`
--

DELIMITER $$
CREATE TRIGGER `delete_posts` AFTER DELETE ON `posts` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_posts SET date = now(),

            query = 'delete',

            idposts = OLD.idposts,

            post_name = OLD.post_name,

            salary = OLD.salary,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_posts` AFTER INSERT ON `posts` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_posts Set date = now(),

            query = 'insert',

            idposts = NEW.idposts,

            post_name = NEW.post_name,

            salary = NEW.salary,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_posts` AFTER UPDATE ON `posts` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_posts SET date = now(),

            query = 'update',

            idposts = OLD.idposts,

            post_name = OLD.post_name,

            salary = OLD.salary,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `employees`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_employees` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare nameIn varchar(100);
  declare pasportIn varchar(11);
  declare innIn varchar(12);
  declare phoneIn varchar(15);
  declare addressIn varchar(255);
  declare emailIn varchar(255);
  declare posts_idpostsIn int;
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_employees where id = ids);
  set idIn = (SELECT idemployees FROM temp_employees where id = ids);
  set nameIn = (SELECT name FROM temp_employees where id = ids);
  set pasportIn = (SELECT pasport FROM temp_employees where id = ids);
  set innIn = (SELECT inn FROM temp_employees where id = ids);
  set phoneIn = (SELECT phone FROM temp_employees where id = ids);
  set addressIn = (SELECT address FROM temp_employees where id = ids);
  set emailIn = (SELECT email FROM temp_employees where id = ids);
  set posts_idpostsIn = (SELECT posts_idposts FROM temp_employees where id = ids);
  set usedIn = (SELECT used FROM temp_employees where id = ids);

	case queryIn
  when 'insert' then
      update employees set used = 0 where `idemployees` = idIn;
  when 'delete' then 
      insert into employees (`name`, `pasport`, `inn`, `phone`, `address`, `email`, `posts_idposts`, `used`) values (nameIn, pasportIn, innIn, phoneIn, addressIn, emailIn, posts_idpostsIn, usedIn);
  when 'update' then
      update employees set `name`= nameIn, `pasport` = pasportIn, `inn` = innIn, `phone` = phoneIn, `address` =  addressIn, `email` = emailIn, `posts_idposts` = posts_idpostsIn, `used` = usedIn where `idemployees` = idIn;
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

            posts_idposts = OLD.posts_idposts,

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

            posts_idposts = NEW.posts_idposts,

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

            posts_idposts = OLD.posts_idposts,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `monetary_transactions`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_monetary_transactions` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare appointmentIn varchar(50);
  declare amountIn decimal(10,2);
  declare date_trIn datetime;
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_monetary_transactions where id = ids);
  set idIn = (SELECT idmonetary_transactions FROM temp_monetary_transactions where id = ids);
  set appointmentIn = (SELECT appointment FROM temp_monetary_transactions where id = ids);
  set amountIn = (SELECT amount FROM temp_monetary_transactions where id = ids);
  set date_trIn = (SELECT date_tr FROM temp_monetary_transactions where id = ids);
  set usedIn = (SELECT used FROM temp_monetary_transactions where id = ids);

	case queryIn
  when 'insert' then
      update monetary_transactions set used = 0 where `idmonetary_transactions` = idIn;
  when 'delete' then 
      insert into monetary_transactions (`appointment`, `amount`, `date_tr`, `used`) values (appointmentIn, amountIn, date_trIn, usedIn);
  when 'update' then
      update monetary_transactions set `appointment`= appointmentIn, `amount` = amountIn, `date_tr`= date_trIn,`used` = usedIn where `idmonetary_transactions` = idIn;
  end case;
  #delete from temp_monetary_transactions where `idmonetary_transactions`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `monetary_transactions`
--

DELIMITER $$
CREATE TRIGGER `delete_monetary_transactions` AFTER DELETE ON `monetary_transactions` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_monetary_transactions SET date = now(),

            query = 'delete',

            idmonetary_transactions = OLD.idmonetary_transactions,

            appointment = OLD.appointment,

            amount = OLD.amount,

            date_tr = OLD.date_tr,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_monetary_transactions` AFTER INSERT ON `monetary_transactions` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_monetary_transactions Set date = now(),

            query = 'insert',

            idmonetary_transactions = NEW.idmonetary_transactions,

            appointment = NEW.appointment,

            amount = NEW.amount,

            date_tr = NEW.date_tr,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_monetary_transactions` AFTER UPDATE ON `monetary_transactions` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_monetary_transactions SET date = now(),

            query = 'update',

            idmonetary_transactions = OLD.idmonetary_transactions,

            appointment = OLD.appointment,

            amount = OLD.amount,

            date_tr = OLD.date_tr,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `purchases`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_purchases` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare date_prchIn datetime;
  declare statusIn varchar(255);
  declare monetary_transactions_idmonetary_transactionsIn int;
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_purchases where id = ids);
  set idIn = (SELECT idpurchases FROM temp_purchases where id = ids);
  set date_prchIn = (SELECT date_prch FROM temp_purchases where id = ids);
  set statusIn = (SELECT status FROM temp_purchases where id = ids);
  set monetary_transactions_idmonetary_transactionsIn = (SELECT monetary_transactions_idmonetary_transactions FROM temp_purchases where id = ids);
  set usedIn = (SELECT used FROM temp_purchases where id = ids);

	case queryIn
  when 'insert' then
      update purchases set used = 0 where `idpurchases` = idIn;
  when 'delete' then 
      insert into purchases (`date_prch`, `status`, `monetary_transactions_idmonetary_transactions`, `used`) values (date_prchIn, statusIn, monetary_transactions_idmonetary_transactions, usedIn);
  when 'update' then
      update purchases set `date_prch`= date_prchIn, `status` = statusIn, `monetary_transactions_idmonetary_transactions`= monetary_transactions_idmonetary_transactions,`used` = usedIn where `idpurchases` = idIn;
  end case;
  #delete from temp_purchases where `idpurchases`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `purchases`
--

DELIMITER $$
CREATE TRIGGER `delete_purchases` AFTER DELETE ON `purchases` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_purchases SET date = now(),

            query = 'delete',

            idpurchases = OLD.idpurchases,

            date_prch = OLD.date_prch,

            status = OLD.status,

            monetary_transactions_idmonetary_transactions = OLD.monetary_transactions_idmonetary_transactions,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_purchases` AFTER INSERT ON `purchases` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_purchases Set date = now(),

            query = 'insert',

            idpurchases = NEW.idpurchases,

            date_prch = NEW.date_prch,

            status = NEW.status,

            monetary_transactions_idmonetary_transactions = NEW.monetary_transactions_idmonetary_transactions,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_purchases` AFTER UPDATE ON `purchases` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_purchases SET date = now(),

            query = 'update',

            idpurchases = OLD.idpurchases,

            date_prch = OLD.date_prch,

            status = OLD.status,

            monetary_transactions_idmonetary_transactions = OLD.monetary_transactions_idmonetary_transactions,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `products`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_products` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare product_nameIn varchar(50);
  declare quantityIn int(10);
  declare purchase_priceIn decimal(10,2);
  declare selling_priceIn decimal(10,2);
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_products where id = ids);
  set idIn = (SELECT idproducts FROM temp_products where id = ids);
  set product_nameIn = (SELECT product_name FROM temp_products where id = ids);
  set quantityIn = (SELECT quantity FROM temp_products where id = ids);
  set purchase_priceIn = (SELECT purchase_price FROM temp_products where id = ids);
  set selling_priceIn = (SELECT selling_price FROM temp_products where id = ids);
  set usedIn = (SELECT used FROM temp_products where id = ids);

	case queryIn
  when 'insert' then
      update products set used = 0 where `idproducts` = idIn;
  when 'delete' then 
      insert into products (`product_name`, `quantity`, `purchase_price`, `selling_price`, `used`) values (product_nameIn, quantityIn, purchase_priceIn, selling_priceIn, usedIn);
  when 'update' then
      update products set `product_name`= product_nameIn, `quantity` = quantityIn, `purchase_price`= purchase_priceIn, `selling_price` = selling_priceIn,`used` = usedIn where `idproducts` = idIn;
  end case;
  #delete from temp_products where `idproducts`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `products`
--

DELIMITER $$
CREATE TRIGGER `delete_products` AFTER DELETE ON `products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_products SET date = now(),

            query = 'delete',

            idproducts = OLD.idproducts,

            product_name = OLD.product_name,

            quantity = OLD.quantity,

            purchase_price = OLD.purchase_price,

            selling_price = OLD.selling_price,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_products` AFTER INSERT ON `products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_products Set date = now(),

            query = 'insert',

            idproducts = NEW.idproducts,

            product_name = NEW.product_name,

            quantity = NEW.quantity,

            purchase_price = NEW.purchase_price,

            selling_price = NEW.selling_price,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_products` AFTER UPDATE ON `products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_products SET date = now(),

            query = 'update',

            idproducts = OLD.idproducts,

            product_name = OLD.product_name,

            quantity = OLD.quantity,

            purchase_price = OLD.purchase_price,

            selling_price = OLD.selling_price,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `purchase_products`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_purchase_products` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare quantityIn int(10);
  declare amountIn decimal(10,2);
  declare purchases_idpurchasesIn int;
  declare products_idproductsIn int;
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_purchase_products where id = ids);
  set idIn = (SELECT idpurchase_products FROM temp_purchase_products where id = ids);
  set quantityIn = (SELECT quantity FROM temp_purchase_products where id = ids);
  set amountIn = (SELECT amount FROM temp_purchase_products where id = ids);
  set purchases_idpurchasesIn = (SELECT purchases_idpurchases FROM temp_purchase_products where id = ids);
  set products_idproductsIn = (SELECT products_idproducts FROM temp_purchase_products where id = ids);
  set usedIn = (SELECT used FROM temp_purchase_products where id = ids);

	case queryIn
  when 'insert' then
      update purchase_products set used = 0 where `idpurchase_products` = idIn;
  when 'delete' then 
      insert into purchase_products (`quantity`, `amount`, `purchases_idpurchases`, `products_idproducts`, `used`) values (quantityIn, amountIn, purchases_idpurchasesIn, products_idproductsIn, usedIn);
  when 'update' then
      update purchase_products set `quantity`= quantityIn, `amount` = amountIn, `purchases_idpurchases`= purchases_idpurchasesIn, `products_idproducts` = products_idproductsIn,`used` = usedIn where `idpurchase_products` = idIn;
  end case;
  #delete from temp_purchase_products where `idpurchase_products`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `purchase_products`
--

DELIMITER $$
CREATE TRIGGER `delete_purchase_products` AFTER DELETE ON `purchase_products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_purchase_products SET date = now(),

            query = 'delete',

            idpurchase_products = OLD.idpurchase_products,

            quantity = OLD.quantity,

            amount = OLD.amount,

            purchases_idpurchases = OLD.purchases_idpurchases,

            products_idproducts = OLD.products_idproducts,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_purchase_products` AFTER INSERT ON `purchase_products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_purchase_products Set date = now(),

            query = 'insert',

            idpurchase_products = NEW.idpurchase_products,

            quantity = NEW.quantity,

            amount = NEW.amount,

            purchases_idpurchases = NEW.purchases_idpurchases,

            products_idproducts = NEW.products_idproducts,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_purchase_products` AFTER UPDATE ON `purchase_products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_purchase_products SET date = now(),

            query = 'update',

            idpurchase_products = OLD.idpurchase_products,

            quantity = OLD.quantity,

            amount = OLD.amount,

            purchases_idpurchases = OLD.purchases_idpurchases,

            products_idproducts = OLD.products_idproducts,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `buyers`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_buyers` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare nameIn varchar(255);
  declare addressIn varchar(255);
  declare phoneIn varchar(15);
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_buyers where id = ids);
  set idIn = (SELECT idbuyers FROM temp_buyers where id = ids);
  set nameIn = (SELECT name FROM temp_buyers where id = ids);
  set addressIn = (SELECT address FROM temp_buyers where id = ids);
  set phoneIn = (SELECT phone FROM temp_buyers where id = ids);
  set usedIn = (SELECT used FROM temp_buyers where id = ids);

	case queryIn
  when 'insert' then
      update buyers set used = 0 where `idbuyers` = idIn;
  when 'delete' then 
      insert into buyers (`name`, `address`, `phone`, `used`) values (nameIn, addressIn, phoneIn, usedIn);
  when 'update' then
      update buyers set `name`= nameIn, `address` = addressIn, `phone`= phoneIn, `used` = usedIn where `idbuyers` = idIn;
  end case;
  #delete from temp_buyers where `idbuyers`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `buyers`
--

DELIMITER $$
CREATE TRIGGER `delete_buyers` AFTER DELETE ON `buyers` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_buyers SET date = now(),

            query = 'delete',

            idbuyers = OLD.idbuyers,

            name = OLD.name,

            address = OLD.address,

            phone = OLD.phone,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_buyers` AFTER INSERT ON `buyers` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_buyers Set date = now(),

            query = 'insert',

            idbuyers = NEW.idbuyers,

            name = NEW.name,

            address = NEW.address,

            phone = NEW.phone,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_buyers` AFTER UPDATE ON `buyers` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_buyers SET date = now(),

            query = 'update',

            idbuyers = OLD.idbuyers,

            name = OLD.name,

            address = OLD.address,

            phone = OLD.phone,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `orders`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_orders` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare date_ordIn datetime;
  declare statusIn varchar(255);
  declare employees_idemployeesIn int;
  declare monetary_transactions_idmonetary_transactionsIn int;
  declare buyers_idbuyersIn int;
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_orders where id = ids);
  set idIn = (SELECT idorders FROM temp_orders where id = ids);
  set date_ordIn = (SELECT date_ord FROM temp_orders where id = ids);
  set statusIn = (SELECT status FROM temp_orders where id = ids);
  set employees_idemployeesIn = (SELECT employees_idemployees FROM temp_orders where id = ids);
  set monetary_transactions_idmonetary_transactionsIn = (SELECT monetary_transactions_idmonetary_transactions FROM temp_orders where id = ids);
  set buyers_idbuyersIn = (SELECT buyers_idbuyers FROM temp_orders where id = ids);
  set usedIn = (SELECT used FROM temp_orders where id = ids);

	case queryIn
  when 'insert' then
      update orders set used = 0 where `idorders` = idIn;
  when 'delete' then 
      insert into orders (`date_ord`, `status`, `employees_idemployees`, `monetary_transactions_idmonetary_transactions`, `buyers_idbuyers`, `used`) values (date_ordIn, statusIn, employees_idemployeesIn, monetary_transactions_idmonetary_transactionsIn, buyers_idbuyersIn, usedIn);
  when 'update' then
      update orders set `date_ord`= date_ordIn, `status` = statusIn, `employees_idemployees`= employees_idemployeesIn, `monetary_transactions_idmonetary_transactions` = monetary_transactions_idmonetary_transactionsIn, `buyers_idbuyers` = buyers_idbuyersIn, `used` = usedIn where `idorders` = idIn;
  end case;
  #delete from temp_orders where `idorders`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `orders`
--

DELIMITER $$
CREATE TRIGGER `delete_orders` AFTER DELETE ON `orders` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_orders SET date = now(),

            query = 'delete',

            idorders = OLD.idorders,

            date_ord = OLD.date_ord,

            status = OLD.status,

            employees_idemployees = OLD.employees_idemployees,

            monetary_transactions_idmonetary_transactions = OLD.monetary_transactions_idmonetary_transactions,

            buyers_idbuyers = OLD.buyers_idbuyers,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_orders` AFTER INSERT ON `orders` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_orders Set date = now(),

            query = 'insert',

            idorders = NEW.idorders,

            date_ord = NEW.date_ord,

            status = NEW.status,

            employees_idemployees = NEW.employees_idemployees,

            monetary_transactions_idmonetary_transactions = NEW.monetary_transactions_idmonetary_transactions,

            buyers_idbuyers = NEW.buyers_idbuyers,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_orders` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_orders SET date = now(),

            query = 'update',

            idorders = OLD.idorders,

            date_ord = OLD.date_ord,

            status = OLD.status,

            employees_idemployees = OLD.employees_idemployees,

            monetary_transactions_idmonetary_transactions = OLD.monetary_transactions_idmonetary_transactions,

            buyers_idbuyers = OLD.buyers_idbuyers,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;

--
-- Процедуры `order_products`
--

DELIMITER $$
CREATE DEFINER=`root`@`localhost1` PROCEDURE `restore_order_products` (IN `ids` INT)  BEGIN
  declare idIn int;
  declare quantityIn int(10);
  declare amountIn decimal(10,2);
  declare orders_idordersIn int;
  declare products_idproductsIn int;
  declare usedIn tinyint(1);
  declare queryIn varchar(15);

  set queryIn = (SELECT query FROM temp_order_products where id = ids);
  set idIn = (SELECT idorder_products FROM temp_order_products where id = ids);
  set quantityIn = (SELECT quantity FROM temp_order_products where id = ids);
  set amountIn = (SELECT amount FROM temp_order_products where id = ids);
  set orders_idordersIn = (SELECT orders_idorders FROM temp_order_products where id = ids);
  set products_idproductsIn = (SELECT products_idproducts FROM temp_order_products where id = ids);
  set usedIn = (SELECT used FROM temp_order_products where id = ids);

	case queryIn
  when 'insert' then
      update order_products set used = 0 where `idorder_products` = idIn;
  when 'delete' then 
      insert into order_products (`quantity`, `amount`, `orders_idorders`, `products_idproducts`, `used`) values (quantityIn, amountIn, orders_idordersIn, products_idproductsIn, usedIn);
  when 'update' then
      update order_products set `quantity`= quantityIn, `amount` = amountIn, `orders_idorders`= orders_idordersIn, `products_idproducts` = products_idproductsIn, `used` = usedIn where `idorder_products` = idIn;
  end case;
  #delete from temp_order_products where `idorder_products`= idTemp;
END$$
DELIMITER ;

--
-- Триггеры `order_products`
--

DELIMITER $$
CREATE TRIGGER `delete_order_products` AFTER DELETE ON `order_products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_order_products SET date = now(),

            query = 'delete',

            idorder_products = OLD.idorder_products,

            quantity = OLD.quantity,

            amount = OLD.amount,

            orders_idorders = OLD.orders_idorders,

            products_idproducts = OLD.products_idproducts,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER `insert_order_products` AFTER INSERT ON `order_products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_order_products Set date = now(),

            query = 'insert',

            idorder_products = NEW.idorder_products,

            quantity = NEW.quantity,

            amount = NEW.amount,

            orders_idorders = NEW.orders_idorders,

            products_idproducts = NEW.products_idproducts,

            used = NEW.used;

end; end if;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_order_products` AFTER UPDATE ON `order_products` FOR EACH ROW BEGIN if @can_use is null then begin

INSERT INTO temp_order_products SET date = now(),

            query = 'update',

            idorder_products = OLD.idorder_products,

            quantity = OLD.quantity,

            amount = OLD.amount,

            orders_idorders = OLD.orders_idorders,

            products_idproducts = OLD.products_idproducts,

            used = OLD.used;

end; end if;

END$$
DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;