-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 19 2021 г., 00:28
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
-- База данных: `furniture`
--

-- --------------------------------------------------------

--
-- Структура таблицы `buyers`
--

CREATE TABLE `buyers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `date` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `pasport` varchar(11) NOT NULL,
  `inn` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`id`, `name`, `email`, `phone`, `date`, `address`, `pasport`, `inn`) VALUES
(6, 'Хмелько Богдан Игоревич', 'bogdan@gmail.com', '8(988) 548-5544', 634424400, 'Ростов-на-Дону, ул. Седова, дом. 11', '3104 547896', '243232313747'),
(10, 'Петров Александр Андреевич', 'petrov@gmail.com', '8(999) 555-3344', 592606800, 'Ростов-на-Дону ул. Варфоломеева дом. 10', '3104 547897', '243232313741'),
(13, 'Иванов Иван Иванович', 'ivanivanov@gmail.com', '8(989) 777-8888', 667861200, 'Ростов-на-Дону, ул. Волкова, дом. 7', '5734 567891', '543232313744'),
(14, 'Кот Антон Сергеевич', 'kot@gmail.com', '8(920) 575-7575', 345416400, 'Ростов-на-Дону,  ул. Тельмана 10', '5804 567891', '973232313742'),
(17, 'Стрелка Виталий Евгеньевич', 'strelok@gmail.com', '8(909) 789-5455', 581112000, 'Ростов-на-Дону, ул. Мечникова 120', '5784 567891', '965232313742');

-- --------------------------------------------------------

--
-- Структура таблицы `monetary_transactions`
--

CREATE TABLE `monetary_transactions` (
  `id` int(11) NOT NULL,
  `appointment` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `order_products`
--

CREATE TABLE `order_products` (
  `id` int(11) NOT NULL,
  `quantity` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `post_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `quantity` int(10) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `units` varchar(50) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `purchase_products`
--

CREATE TABLE `purchase_products` (
  `id` int(11) NOT NULL,
  `quantity` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `salary_payments`
--

CREATE TABLE `salary_payments` (
  `id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`) VALUES
(1, 'Alextxnk', '$2y$10$E5RDeRAZGOgFCzXyfEIMHO/y8TXFCRmvwOfGa6PfFm3T7XV6cSJSy');

--
-- Индексы сохранённых таблиц
--

-- Индексы таблицы `buyers`

ALTER TABLE `buyers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

-- Индексы таблицы `employees`

ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pasport` (`pasport`),
  ADD UNIQUE KEY `inn` (`inn`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`);

-- Индексы таблицы `monetary_transactions`

ALTER TABLE `monetary_transactions`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `orders`

ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `order_products`

ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `posts`

ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `products`

ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `purchases`

ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `purchase_products`

ALTER TABLE `purchase_products`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `salary_payments`

ALTER TABLE `salary_payments`
  ADD PRIMARY KEY (`id`);

-- Индексы таблицы `users`

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);





--
-- AUTO_INCREMENT для сохранённых таблиц
--

-- AUTO_INCREMENT для таблицы `buyers`

ALTER TABLE `buyers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `employees`

ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

-- AUTO_INCREMENT для таблицы `monetary_transactions`

ALTER TABLE `monetary_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `orders`

ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `order_products`

ALTER TABLE `order_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `posts`

ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `products`

ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `purchases`

ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `purchase_products`

ALTER TABLE `purchase_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `salary_payments`

ALTER TABLE `salary_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT для таблицы `users`

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
