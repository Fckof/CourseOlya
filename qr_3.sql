-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 26, 2022 at 10:51 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qr`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Группы` (IN `id_g` INT(6))  SELECT s.`Фамилия`, s.`Имя`, s.`Отчество`, q.`Привит`, q.`Переболел`, q.`Дата окончания QR` FROM `student` AS s JOIN `qr_code` AS q ON s.`id student` = q.`id student`WHERE`id group` = id_g$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Завершившиеся QR` ()  SELECT g.`Название группы`, s.`Фамилия`, s.`Имя`, s.`Отчество`, q.`Привит`, q.`Переболел`, q.`Дата окончания QR` FROM `student` AS s JOIN `qr_code` AS q ON s.`id student` = q.`id student` JOIN `group` AS g ON s.`id group` = g.`id group` WHERE q.`Дата окончания QR` <= NOW()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Изменить информацию о QR` (IN `privit` TINYINT(3), IN `id_v` VARCHAR(255), IN `perebolel` TINYINT(3), IN `dat` DATETIME, IN `id_s` VARCHAR(255))  UPDATE `qr_code` SET `Привит` = privit, `id vac` = id_v, `Переболел` = perebolel, `Дата окончания QR` = dat WHERE `id student` = id_s$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Нет QR` ()  SELECT g.`Название группы`, s.`Фамилия`, s.`Имя`, s.`Отчество`, q.`Привит`, q.`Переболел`, q.`Дата окончания QR` FROM `student` AS s JOIN `qr_code` AS q ON s.`id student` = q.`id student` JOIN `group` AS g ON s.`id group` = g.`id group` WHERE q.`Дата окончания QR` IN(00)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Поиск студента` (IN `id_s` INT(10))  SELECT  g.`Название группы`, s.`Фамилия`, s.`Имя`, s.`Отчество`, q.`Привит`, q.`Переболел`, q.`Дата окончания QR` FROM `student` AS s JOIN `qr_code` AS q ON s.`id student` = q.`id student` JOIN `group` AS g ON s.`id group` = g.`id group` WHERE s.`id student` = id_s$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Статистика вакцин` ()  SELECT `vacina`.`Название вакцины`, Count(`qr_code`.`id vac`) AS `Колличество вакцинаций`
FROM `vacina` INNER JOIN `qr_code` ON `vacina`.`id vac` = `qr_code`.`id vac`
GROUP BY `vacina`.`Название вакцины`$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `id group` int(10) NOT NULL DEFAULT '0',
  `id napr` int(10) NOT NULL DEFAULT '0',
  `Название группы` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id group`, `id napr`, `Название группы`) VALUES
(11, 1, 'ЭВМ 1-1'),
(12, 1, 'ЭВМ 2-1'),
(13, 1, 'ЭВМ 3-1'),
(14, 1, 'ЭВМ 4-1'),
(21, 2, 'БИТ 1-1'),
(22, 2, 'БИТ 2-1'),
(23, 2, 'БИТ 3-1'),
(24, 2, 'БИТ 4-1'),
(25, 2, 'БИТ 5-1'),
(31, 3, 'ПМ 1-1'),
(32, 3, 'ПМ 1-2'),
(33, 3, 'ПМ 1-3'),
(34, 3, 'ПМ 1-4');

-- --------------------------------------------------------

--
-- Table structure for table `napr`
--

CREATE TABLE `napr` (
  `id napr` int(10) NOT NULL DEFAULT '0',
  `Название направления` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `napr`
--

INSERT INTO `napr` (`id napr`, `Название направления`) VALUES
(1, 'ЭВМ'),
(2, 'БИТ'),
(3, 'ПМ');

-- --------------------------------------------------------

--
-- Table structure for table `qr_code`
--

CREATE TABLE `qr_code` (
  `Привит` tinyint(3) NOT NULL DEFAULT '0',
  `id vac` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Дата окончания QR` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `id student` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Переболел` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `qr_code`
--

INSERT INTO `qr_code` (`Привит`, `id vac`, `Дата окончания QR`, `id student`, `Переболел`) VALUES
(1, 'A', '2022-11-01 00:00:00', '1101', 0),
(1, 'A', '2022-07-04 00:00:00', '1102', 1),
(0, NULL, '2022-10-10 00:00:00', '1103', 1),
(1, 'A', '2022-10-09 00:00:00', '1104', 0),
(1, 'B', '2022-04-14 16:03:47', '1105', 1),
(1, 'A', '2022-04-01 00:00:00', '1106', 0),
(1, 'B', '2022-10-14 00:00:00', '1107', 1),
(1, 'A', '2022-06-03 00:00:00', '1108', 0),
(1, 'A', '2022-11-12 00:00:00', '1109', 0),
(0, NULL, '0000-00-00 00:00:00', '1110', 0),
(0, NULL, '2022-04-17 00:00:00', '1111', 1),
(1, 'A', '2022-03-05 00:00:00', '1112', 0),
(1, 'B', '2022-03-31 00:00:00', '1113', 1),
(1, 'A', '2022-09-23 00:00:00', '1114', 0),
(0, NULL, '2022-09-23 00:00:00', '1115', 1),
(1, 'A', '2022-08-19 00:00:00', '1116', 0),
(1, 'C', '2022-01-13 00:00:00', '1117', 0),
(1, 'B', '2022-04-10 00:00:00', '1118', 0),
(1, 'A', '2022-10-21 00:00:00', '1119', 1),
(1, 'A', '2022-05-18 00:00:00', '1120', 1),
(1, 'C', '2022-04-02 00:00:00', '1121', 0),
(0, NULL, '2022-07-30 00:00:00', '1122', 1),
(1, 'A', '2022-10-11 00:00:00', '1201', 1),
(1, 'A', '2022-01-11 00:00:00', '1202', 0),
(1, 'A', '2021-12-28 00:00:00', '1203', 0),
(0, NULL, '0000-00-00 00:00:00', '1204', 0),
(1, 'A', '2022-02-14 00:00:00', '1205', 0),
(1, 'B', '2021-12-20 00:00:00', '1206', 0),
(1, 'A', '2022-06-10 00:00:00', '1207', 1),
(1, 'A', '2022-01-21 00:00:00', '1208', 1),
(1, 'C', '2022-02-14 00:00:00', '1209', 0),
(0, NULL, '0000-00-00 00:00:00', '1210', 0),
(0, NULL, '2022-09-12 00:00:00', '1211', 1),
(1, 'A', '2022-11-05 00:00:00', '1212', 0),
(1, 'B', '2022-01-29 00:00:00', '1213', 0),
(1, 'C', '2022-05-18 00:00:00', '1214', 0),
(1, 'C', '2022-10-09 00:00:00', '1215', 0),
(1, 'A', '2022-09-01 00:00:00', '1216', 0),
(0, NULL, '2022-01-05 00:00:00', '1217', 1),
(1, 'A', '2022-07-23 00:00:00', '1218', 0),
(1, 'A', '2022-11-16 00:00:00', '1219', 1),
(1, 'A', '2022-03-07 00:00:00', '1220', 1),
(1, 'A', '2022-04-05 00:00:00', '1301', 0),
(0, NULL, '0000-00-00 00:00:00', '1302', 0),
(1, 'A', '2022-05-17 00:00:00', '1303', 1),
(1, 'A', '2022-01-05 00:00:00', '1304', 1),
(1, 'B', '2022-09-14 00:00:00', '1305', 0),
(1, 'A', '2022-10-11 00:00:00', '1306', 0),
(1, 'C', '2022-08-04 00:00:00', '1307', 1),
(1, 'A', '2022-04-29 00:00:00', '1308', 1),
(1, 'A', '2022-03-24 00:00:00', '1309', 0),
(1, 'A', '2022-10-02 00:00:00', '1310', 0),
(1, 'A', '2022-02-01 00:00:00', '1311', 0),
(1, 'C', '2022-03-14 00:00:00', '1312', 0),
(0, NULL, '2022-11-15 00:00:00', '1313', 1),
(1, 'A', '2022-10-15 00:00:00', '1314', 0),
(1, 'A', '2022-07-05 00:00:00', '1315', 0),
(1, 'B', '2021-12-15 00:00:00', '1316', 0),
(1, 'B', '2022-03-06 00:00:00', '1317', 0),
(1, 'A', '2022-08-20 00:00:00', '1318', 1),
(1, 'A', '2022-10-14 00:00:00', '1401', 0),
(1, 'A', '2022-05-22 00:00:00', '1402', 1),
(0, NULL, '2021-11-28 00:00:00', '1403', 1),
(0, NULL, '2022-04-27 00:00:00', '1404', 1),
(0, NULL, '0000-00-00 00:00:00', '1405', 0),
(1, 'A', '2022-05-11 00:00:00', '1406', 0),
(1, 'A', '2022-08-13 00:00:00', '1407', 0),
(1, 'B', '2022-08-21 00:00:00', '1408', 0),
(0, NULL, '2022-11-27 00:00:00', '1409', 1),
(0, NULL, '2022-09-02 00:00:00', '1410', 1),
(1, 'A', '2022-05-01 00:00:00', '1411', 0),
(0, NULL, '2022-06-02 00:00:00', '1412', 1),
(1, 'A', '2022-06-04 00:00:00', '1413', 0),
(1, 'A', '2022-05-31 00:00:00', '1414', 1),
(1, 'A', '2022-05-17 00:00:00', '1415', 0),
(1, 'B', '2021-12-11 00:00:00', '1416', 0),
(1, 'B', '2022-07-25 00:00:00', '1417', 1),
(1, 'A', '2022-05-16 00:00:00', '1418', 0),
(0, NULL, '2022-02-20 00:00:00', '1419', 1),
(1, 'A', '2022-03-15 00:00:00', '1420', 0),
(1, 'A', '2022-01-02 00:00:00', '1421', 1),
(1, 'A', '2022-02-03 00:00:00', '2101', 0),
(1, 'A', '2022-07-16 00:00:00', '2102', 0),
(1, 'A', '2022-04-11 00:00:00', '2103', 0),
(1, 'B', '2022-10-11 00:00:00', '2104', 1),
(1, 'A', '2022-07-10 00:00:00', '2105', 0),
(1, 'A', '2022-02-24 00:00:00', '2106', 1),
(1, 'A', '2022-10-27 00:00:00', '2107', 1),
(1, 'A', '2022-02-19 00:00:00', '2108', 0),
(1, 'B', '2021-12-29 00:00:00', '2109', 0),
(1, 'A', '2022-08-22 00:00:00', '2110', 1),
(1, 'A', '2022-03-15 00:00:00', '2111', 0),
(1, 'A', '2022-05-15 00:00:00', '2112', 1),
(1, 'A', '2022-02-03 00:00:00', '2113', 0),
(1, 'B', '2022-07-31 00:00:00', '2114', 1),
(0, NULL, '0000-00-00 00:00:00', '2115', 0),
(0, NULL, '2022-06-20 00:00:00', '2116', 1),
(1, 'A', '2021-12-11 00:00:00', '2117', 0),
(1, 'C', '2022-01-07 00:00:00', '2118', 0),
(0, NULL, '0000-00-00 00:00:00', '2119', 0),
(1, 'A', '2022-07-28 00:00:00', '2120', 0),
(1, 'A', '2022-02-20 00:00:00', '2121', 0),
(1, 'A', '2022-05-06 00:00:00', '2122', 0),
(1, 'C', '2022-10-16 00:00:00', '2123', 1),
(0, NULL, '2022-03-25 00:00:00', '2201', 1),
(1, 'A', '2021-12-11 00:00:00', '2202', 1),
(0, NULL, '2021-12-07 00:00:00', '2203', 1),
(1, 'A', '2022-07-24 00:00:00', '2204', 0),
(1, 'A', '2022-05-04 00:00:00', '2205', 0),
(1, 'C', '2022-02-20 00:00:00', '2206', 1),
(0, NULL, '2022-09-16 00:00:00', '2207', 1),
(1, 'B', '2022-02-27 00:00:00', '2208', 0),
(1, 'A', '2022-10-11 00:00:00', '2209', 0),
(1, 'A', '2022-03-19 00:00:00', '2210', 0),
(1, 'A', '2022-10-04 00:00:00', '2211', 0),
(0, NULL, '2022-05-26 00:00:00', '2212', 1),
(0, NULL, '2022-01-20 00:00:00', '2213', 1),
(1, 'A', '2022-10-18 00:00:00', '2214', 0),
(1, 'A', '2022-05-23 00:00:00', '2215', 0),
(0, NULL, '2022-06-05 00:00:00', '2216', 1),
(0, NULL, '0000-00-00 00:00:00', '2217', 0),
(1, 'C', '2022-02-04 00:00:00', '2218', 0),
(1, 'A', '2021-12-29 00:00:00', '2219', 0),
(1, 'B', '2022-03-23 00:00:00', '2220', 1),
(1, 'A', '2022-10-01 00:00:00', '2221', 0),
(1, 'A', '2022-11-10 00:00:00', '2222', 1),
(1, 'C', '2022-09-23 00:00:00', '2301', 0),
(0, NULL, '2022-07-09 00:00:00', '2302', 1),
(1, 'A', '2022-11-20 00:00:00', '2303', 0),
(1, 'B', '2022-07-06 00:00:00', '2304', 0),
(1, 'A', '2022-02-13 00:00:00', '2305', 1),
(0, NULL, '2022-05-11 00:00:00', '2306', 1),
(0, NULL, '2022-03-01 00:00:00', '2307', 1),
(1, 'B', '2022-05-30 00:00:00', '2308', 0),
(1, 'A', '2022-09-27 00:00:00', '2309', 0),
(0, NULL, '2022-01-25 00:00:00', '2310', 1),
(1, 'A', '2022-09-09 00:00:00', '2311', 0),
(1, 'A', '2022-08-22 00:00:00', '2312', 0),
(0, NULL, '0000-00-00 00:00:00', '2313', 0),
(1, 'A', '2022-11-03 00:00:00', '2314', 1),
(1, 'A', '2021-12-16 00:00:00', '2315', 0),
(1, 'B', '2022-11-05 00:00:00', '2316', 1),
(0, NULL, '2022-01-29 00:00:00', '2317', 1),
(0, NULL, '2021-12-29 00:00:00', '2318', 1),
(1, 'B', '2022-10-18 00:00:00', '2319', 0),
(1, 'A', '2022-02-19 00:00:00', '2320', 1),
(1, 'A', '2022-04-08 00:00:00', '2401', 1),
(0, NULL, '2022-02-02 00:00:00', '2402', 1),
(1, 'A', '2022-03-31 00:00:00', '2403', 1),
(1, 'A', '2022-03-13 00:00:00', '2404', 0),
(1, 'C', '2022-05-16 00:00:00', '2405', 0),
(0, NULL, '0000-00-00 00:00:00', '2406', 0),
(1, 'A', '2022-04-26 00:00:00', '2407', 0),
(1, 'B', '2022-05-13 00:00:00', '2408', 1),
(1, 'A', '2022-09-16 00:00:00', '2409', 0),
(1, 'A', '2022-09-09 00:00:00', '2410', 1),
(1, 'A', '2022-06-29 00:00:00', '2411', 1),
(1, 'A', '2022-05-02 00:00:00', '2412', 0),
(0, NULL, '2022-03-04 00:00:00', '2413', 1),
(0, NULL, '0000-00-00 00:00:00', '2414', 0),
(1, 'A', '2022-04-23 00:00:00', '2415', 1),
(1, 'B', '2022-10-01 00:00:00', '2416', 0),
(0, NULL, '0000-00-00 00:00:00', '2417', 0),
(1, 'A', '2021-12-04 00:00:00', '2418', 1),
(1, 'A', '2022-01-31 00:00:00', '2501', 0),
(0, NULL, '2022-05-01 00:00:00', '2502', 1),
(1, 'A', '2022-08-15 00:00:00', '2503', 1),
(1, 'A', '2022-05-01 00:00:00', '2504', 1),
(1, 'B', '2022-08-11 00:00:00', '2505', 0),
(1, 'A', '2022-10-09 00:00:00', '2506', 1),
(1, 'A', '2022-04-07 00:00:00', '2507', 1),
(0, NULL, '2022-06-21 00:00:00', '2508', 1),
(1, 'B', '2022-05-05 00:00:00', '2509', 0),
(1, 'A', '2022-03-17 00:00:00', '2510', 0),
(1, 'B', '2021-12-30 00:00:00', '2511', 0),
(1, 'A', '2022-03-14 00:00:00', '2512', 1),
(1, 'A', '2022-06-04 00:00:00', '2513', 1),
(1, 'A', '2022-07-21 00:00:00', '2514', 0),
(0, NULL, '2022-11-20 00:00:00', '2515', 1),
(1, 'A', '2022-10-25 00:00:00', '2516', 1),
(0, NULL, '0000-00-00 00:00:00', '3101', 0),
(0, NULL, '2022-02-21 00:00:00', '3102', 1),
(1, 'A', '2022-02-21 00:00:00', '3103', 0),
(0, NULL, '2022-08-16 00:00:00', '3104', 1),
(1, 'A', '2022-03-31 00:00:00', '3105', 0),
(1, 'A', '2021-12-24 00:00:00', '3106', 0),
(0, NULL, '0000-00-00 00:00:00', '3107', 0),
(1, 'C', '2022-09-12 00:00:00', '3108', 1),
(1, 'A', '2022-11-17 00:00:00', '3109', 0),
(1, 'A', '2022-08-25 00:00:00', '3110', 0),
(0, NULL, '2022-06-10 00:00:00', '3111', 1),
(0, NULL, '2022-06-23 00:00:00', '3112', 1),
(1, 'A', '2022-09-05 00:00:00', '3113', 0),
(1, 'C', '2022-05-02 00:00:00', '3114', 1),
(1, 'A', '2022-07-04 00:00:00', '3115', 0),
(1, 'B', '2022-10-23 00:00:00', '3116', 0),
(0, NULL, '2022-07-17 00:00:00', '3117', 1),
(1, 'A', '2022-03-12 00:00:00', '3118', 0),
(1, 'B', '2022-07-20 00:00:00', '3119', 1),
(1, 'C', '2021-12-09 00:00:00', '3120', 0),
(0, NULL, '2022-05-17 00:00:00', '3121', 1),
(1, 'A', '2022-08-31 00:00:00', '3122', 0),
(1, 'A', '2022-07-19 00:00:00', '3201', 0),
(1, 'A', '2022-11-18 00:00:00', '3202', 1),
(1, 'A', '2022-07-03 00:00:00', '3203', 0),
(0, NULL, '2022-06-30 00:00:00', '3204', 1),
(0, NULL, '2022-10-25 00:00:00', '3205', 1),
(1, 'A', '2022-04-14 00:00:00', '3206', 1),
(1, 'B', '2022-08-26 00:00:00', '3207', 0),
(0, NULL, '2022-11-08 00:00:00', '3208', 1),
(1, 'A', '2022-09-15 00:00:00', '3209', 1),
(1, 'A', '2022-03-26 00:00:00', '3210', 1),
(1, 'A', '2022-07-05 00:00:00', '3211', 0),
(1, 'A', '2022-03-07 00:00:00', '3212', 1),
(1, 'B', '2022-09-11 00:00:00', '3213', 0),
(1, 'A', '2022-10-11 00:00:00', '3214', 1),
(0, NULL, '2022-11-21 00:00:00', '3215', 1),
(1, 'A', '2021-12-13 00:00:00', '3216', 1),
(1, 'B', '2022-09-12 00:00:00', '3217', 0),
(1, 'A', '2022-01-13 00:00:00', '3218', 1),
(0, NULL, '0000-00-00 00:00:00', '3219', 0),
(1, 'C', '2021-12-02 00:00:00', '3220', 1),
(1, 'A', '2022-11-22 00:00:00', '3221', 0),
(1, 'A', '2021-12-15 00:00:00', '3301', 1),
(0, NULL, '2022-07-15 00:00:00', '3302', 1),
(0, NULL, '0000-00-00 00:00:00', '3303', 0),
(1, 'A', '2022-04-02 00:00:00', '3304', 1),
(1, 'A', '2021-12-16 00:00:00', '3305', 0),
(0, NULL, '2021-12-10 00:00:00', '3306', 1),
(1, 'A', '2022-05-02 00:00:00', '3307', 1),
(0, NULL, '0000-00-00 00:00:00', '3308', 0),
(1, 'A', '2022-04-15 00:00:00', '3309', 1),
(0, NULL, '0000-00-00 00:00:00', '3310', 0),
(1, 'A', '2022-06-03 00:00:00', '3311', 1),
(0, NULL, '2022-06-08 00:00:00', '3312', 1),
(1, 'B', '2021-12-02 00:00:00', '3313', 1),
(0, NULL, '2022-01-17 00:00:00', '3314', 1),
(1, 'A', '2022-01-07 00:00:00', '3315', 0),
(1, 'A', '2022-10-11 00:00:00', '3316', 1),
(1, 'A', '2022-01-28 00:00:00', '3317', 0),
(1, 'A', '2022-10-17 00:00:00', '3318', 1),
(1, 'A', '2022-03-03 00:00:00', '3319', 0),
(1, 'A', '2022-06-03 00:00:00', '3401', 1),
(1, 'A', '2022-07-09 00:00:00', '3402', 0),
(1, 'A', '2021-12-13 00:00:00', '3403', 1),
(0, NULL, '2022-04-13 00:00:00', '3405', 1),
(1, 'B', '2022-07-13 00:00:00', '3406', 0),
(1, 'A', '2022-04-16 00:00:00', '3407', 1),
(1, 'A', '2022-10-25 00:00:00', '3408', 1),
(0, NULL, '0000-00-00 00:00:00', '3409', 0),
(1, 'B', '2022-01-09 00:00:00', '3410', 1),
(1, 'A', '2022-10-14 00:00:00', '3411', 0),
(1, 'A', '2022-02-16 00:00:00', '3412', 1),
(1, 'A', '2021-12-17 00:00:00', '3413', 1),
(1, 'A', '2022-05-31 00:00:00', '3414', 1),
(1, 'B', '2022-06-16 00:00:00', '3415', 0),
(1, 'A', '2021-12-17 00:00:00', '3416', 0),
(1, 'A', '2022-05-13 00:00:00', '3417', 1),
(1, 'A', '2022-01-16 00:00:00', '3418', 0),
(0, NULL, '2022-10-09 00:00:00', '3419', 1),
(1, 'A', '2022-11-22 00:00:00', '3420', 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id role` int(11) NOT NULL,
  `role` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id role`, `role`) VALUES
(1, 'admin'),
(2, 'users');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Фамилия` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Имя` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Отчество` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `id student` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id group`, `Фамилия`, `Имя`, `Отчество`, `id student`) VALUES
('11', 'Покровская', 'Аиша', 'Алексеевна', '1101'),
('11', 'Юдина', 'Елизавета', 'Александровна', '1102'),
('11', 'Иванов', 'Иван', 'Богданович', '1103'),
('11', 'Никитина', 'Маргарита', 'Денисовна', '1104'),
('11', 'Петрова', 'София', 'Петрова София', '1105'),
('11', 'Шевелев', 'Виктор', 'Егорович', '1106'),
('11', 'Козлов', 'Борис', 'Артёмович', '1107'),
('11', 'Крюкова', 'Анна', 'Артёмовна', '1108'),
('11', 'Мальцев', 'Елисей', 'Ярославович', '1109'),
('11', 'Шаповалов', 'Дмитрий', 'Арсентьевич', '1110'),
('11', 'Евсеева', 'София', 'Денисовна', '1111'),
('11', 'Макаров', 'Пётр', 'Максимович', '1112'),
('11', 'Давыдова', 'Анна', 'Николаевна', '1113'),
('11', 'Тарасова', 'Алиса', 'Александровна', '1114'),
('11', 'Левина', 'Дарина', 'Вячеславовна', '1115'),
('11', 'Богданов', 'Артемий', 'Маркович', '1116'),
('11', 'Владимирова', 'Ева', 'Кирилловна', '1117'),
('11', 'Ушаков', 'Никита', 'Тимурович', '1118'),
('11', 'Горбунов', 'Степан', 'Артёмович', '1119'),
('11', 'Николаев', 'Иван', 'Матвеевич', '1120'),
('11', 'Сахаров', 'Илья', 'Григорьевич', '1121'),
('11', 'Колесникова', 'Анна', 'Львовна', '1122'),
('12', 'Лебедева', 'София', 'Петровна', '1201'),
('12', 'Рубцов', 'Тихон', 'Даниилович', '1202'),
('12', 'Максимова', 'Агата', 'Марковна', '1203'),
('12', 'Токарев', 'Тимофей', 'Константинович', '1204'),
('12', 'Белоусов', 'Арсен', 'Максимович', '1205'),
('12', 'Чумакова', 'Елизавета', 'Игоревна', '1206'),
('12', 'Павлова', 'Валерия', 'Максимовна', '1207'),
('12', 'Макарова', 'Аделина', 'Максимовна', '1208'),
('12', 'Никитина', 'Анна', 'Михайловна', '1209'),
('12', 'Михайлова', 'Виктория', 'Тимофеевна', '1210'),
('12', 'Громов', 'Даниил', 'Сергеевич', '1211'),
('12', 'Ермакова', 'Вероника', 'Руслановна', '1212'),
('12', 'Константинов', 'Максим', 'Сергеевич', '1213'),
('12', 'Пименова', 'Милана', 'Андреевна', '1214'),
('12', 'Орлова', 'Полина', 'Макаровна', '1215'),
('12', 'Макаров', 'Матвей', 'Макарович', '1216'),
('12', 'Прохорова', 'Мила', 'Максимовна', '1217'),
('12', 'Смирнов', 'Максим', 'Даниилович', '1218'),
('12', 'Смирнов', 'Николай', 'Юрьевич', '1219'),
('12', 'Крылова', 'Екатерина', 'Григорьевна', '1220'),
('13', 'Дмитриев', 'Иван', 'Тихонович', '1301'),
('13', 'Сухова', 'Елизавета', 'Михайловна', '1302'),
('13', 'Шаповалов', 'Тимофей', 'Александрович', '1303'),
('13', 'Терентьева', 'Арина', 'Михайловна', '1304'),
('13', 'Кондратова', 'Елизавета', 'Артёмовна', '1305'),
('13', 'Пономарев', 'Егор', 'Александрович', '1306'),
('13', 'Васильева', 'Виктория', 'Арсентьевна', '1307'),
('13', 'Пономарев', 'Сергей', 'Александрович', '1308'),
('13', 'Панкратов', 'Максим', 'Владимирович', '1309'),
('13', 'Степанова', 'Вероника', 'Дмитриевна', '1310'),
('13', 'Плотникова', 'Анастасия', 'Львовна', '1311'),
('13', 'Ермакова', 'Мария', 'Владимировна', '1312'),
('13', 'Кузьмина', 'Арина', 'Сергеевна', '1313'),
('13', 'Лосев', 'Леонид', 'Денисович', '1314'),
('13', 'Филиппова', 'София', 'Марковна', '1315'),
('13', 'Козлов', 'Лев', 'Даниилович', '1316'),
('13', 'Жукова', 'Екатерина', 'Николаевна', '1317'),
('13', 'Савельев', 'Мирослав', 'Эмильевич', '1318'),
('14', 'Григорьев', 'Алексей', 'Георгиевич', '1401'),
('14', 'Константинова', 'Александра', 'Романовна', '1402'),
('14', 'Спиридонова', 'Валерия', 'Матвеевна', '1403'),
('14', 'Архипов', 'Александр', 'Александрович', '1404'),
('14', 'Смирнова', 'Виктория', 'Артёмовна', '1405'),
('14', 'Иванова', 'Таисия', 'Семёновна', '1406'),
('14', 'Кузьмина', 'Стевания', 'Ивановна', '1407'),
('14', 'Родионова', 'Яна', 'Кирилловна', '1408'),
('14', 'Филиппова', 'Дарья', 'Сергеевна', '1409'),
('14', 'Ефимов', 'Степан', 'Тимурович', '1410'),
('14', 'Давыдова', 'Алёна', 'Александровна', '1411'),
('14', 'Ушакова', 'Дарья', 'Максимовна', '1412'),
('14', 'Фомин', 'Даниэль', 'Миронович', '1413'),
('14', 'Лебедев', 'Леонид', 'Давидович', '1414'),
('14', 'Бондарев', 'Арсений', 'Даниэльевич', '1415'),
('14', 'Егоров', 'Александр', 'Маркович', '1416'),
('14', 'Гаврилов', 'Руслан', 'Алексеевич', '1417'),
('14', 'Мартынова', 'Ульяна', 'Дмитриевна', '1418'),
('14', 'Сухова', 'Кристина', 'Максимовна', '1419'),
('14', 'Кузнецов', 'Алексей', 'Сергеевич', '1420'),
('14', 'Жуков', 'Никита', 'Арсентьевич', '1421'),
('21', 'Виноградова', 'Стевания', 'Демьяновна', '2101'),
('21', 'Беляева', 'Злата', 'Владимировна', '2102'),
('21', 'Хромова', 'Мирослава', 'Юрьевна', '2103'),
('21', 'Туманова', 'Вероника', 'Артемьевна', '2104'),
('21', 'Курочкина', 'Софья', 'Владиславовна', '2105'),
('21', 'Иванова', 'Мирослава', 'Демьяновна', '2106'),
('21', 'Воробьева', 'Дарья', 'Андреевна', '2107'),
('21', 'Кузнецова', 'Таисия', 'Александровна', '2108'),
('21', 'Данилов', 'Святослав', 'Маркович', '2109'),
('21', 'Щербакова', 'Агата', 'Михайловна', '2110'),
('21', 'Грачева', 'Мария', 'Артёмовна', '2111'),
('21', 'Дорохова', 'Анна', 'Никитична', '2112'),
('21', 'Литвинова', 'Лейла', 'Андреевна', '2113'),
('21', 'Зубков', 'Фёдор', 'Егорович', '2114'),
('21', 'Громова', 'Мария', 'Артёмовна', '2115'),
('21', 'Розанов', 'Марк', 'Вадимович', '2116'),
('21', 'Волкова', 'Софья', 'Петровна', '2117'),
('21', 'Сорокин', 'Григорий', 'Дмитриевич', '2118'),
('21', 'Лазарев', 'Тимофей', 'Петрович', '2119'),
('21', 'Сергеева', 'Ева', 'Макаровна', '2120'),
('21', 'Миронов', 'Николай', 'Павлович', '2121'),
('21', 'Ефремова', 'Светлана', 'Платоновна', '2122'),
('21', 'Комаров', 'Сергей', 'Тимурович', '2123'),
('22', 'Васильев', 'Олег', 'Андреевич', '2201'),
('22', 'Казаков', 'Леонид', 'Станиславович', '2202'),
('22', 'Васильева', 'Авмелия', 'Романовна', '2203'),
('22', 'Павлова', 'Елизавета', 'Сергеевна', '2204'),
('22', 'Афанасьев', 'Андрей', 'Богданович', '2205'),
('22', 'Виноградова', 'Вера', 'Даниловна', '2206'),
('22', 'Власов', 'Эмиль', 'Романович', '2207'),
('22', 'Михайлов', 'Фёдор', 'Максимович', '2208'),
('22', 'Мартынова', 'Алёна', 'Максимовна', '2209'),
('22', 'Ковалев', 'Артемий', 'Романович', '2210'),
('22', 'Озеров', 'Арсений', 'Артёмович', '2211'),
('22', 'Колесов', 'Илья', 'Тимофеевич', '2212'),
('22', 'Сергеева', 'Елизавета', 'Артемьевна', '2213'),
('22', 'Герасимова', 'Виктория', 'Андреевна', '2214'),
('22', 'Давыдов', 'Артём', 'Маркович', '2215'),
('22', 'Ковалев', 'Иван', 'Артёмович', '2216'),
('22', 'Волкова', 'Кристина', 'Тимуровна', '2217'),
('22', 'Афанасьев', 'Илья', 'Алексеевич', '2218'),
('22', 'Гладков', 'Марк', 'Денисович', '2219'),
('22', 'Соловьева', 'Анастасия', 'Михайловна', '2220'),
('22', 'Кузьмин', 'Фёдор', 'Константинович', '2221'),
('22', 'Бобров', 'Роман', 'Денисович', '2222'),
('23', 'Зайцева', 'Юлия', 'Васильевна', '2301'),
('23', 'Чистяков', 'Максим', 'Алексеевич', '2302'),
('23', 'Шилова', 'Анна', 'Ивановна', '2303'),
('23', 'Соловьева', 'Дарья', 'Марковна', '2304'),
('23', 'Зверев', 'Марк', 'Михайлович', '2305'),
('23', 'Никитин', 'Даниил', 'Александрович', '2306'),
('23', 'Волков', 'Сергей', 'Макарович', '2307'),
('23', 'Тимофеева', 'Анна', 'Александровна', '2308'),
('23', 'Макарова', 'Кира', 'Георгиевна', '2309'),
('23', 'Грачева', 'Арина', 'Сергеевна', '2310'),
('23', 'Ершова', 'София', 'Юрьевна', '2311'),
('23', 'Кириллов', 'Николай', 'Михайлович', '2312'),
('23', 'Аксенова', 'Ульяна', 'Артёмовна', '2313'),
('23', 'Власов', 'Алексей', 'Степанович', '2314'),
('23', 'Черкасова', 'Анна', 'Арсентьевна', '2315'),
('23', 'Богомолов', 'Глеб', 'Михайлович', '2316'),
('23', 'Сидоров', 'Фёдор', 'Романович', '2317'),
('23', 'Павлова', 'Милана', 'Семёновна', '2318'),
('23', 'Князев', 'Константин', 'Максимович', '2319'),
('23', 'Туманова', 'Евгения', 'Денисовна', '2320'),
('24', 'Беляева', 'Екатерина', 'Николаевна', '2401'),
('24', 'Бирюков', 'Артём', 'Даниилович', '2402'),
('24', 'Григорьев', 'Максим', 'Матвеевич', '2403'),
('24', 'Елизаров', 'Кирилл', 'Романович', '2404'),
('24', 'Кузнецова', 'Софья', 'Вячеславовна', '2405'),
('24', 'Зотова', 'Виктория', 'Юрьевна', '2406'),
('24', 'Седов', 'Дмитрий', 'Олегович', '2407'),
('24', 'Степанов', 'Демид', 'Андреевич', '2408'),
('24', 'Федотова', 'Оливия', 'Георгиевна', '2409'),
('24', 'Волков', 'Иван', 'Тимурович', '2410'),
('24', 'Иванов', 'Владимир', 'Павлович', '2411'),
('24', 'Волков', 'Леонид', 'Александрович', '2412'),
('24', 'Александрова', 'Анна', 'Семёновна', '2413'),
('24', 'Майоров', 'Иван', 'Артёмович', '2414'),
('24', 'Соколов', 'Роман', 'Маркович', '2415'),
('24', 'Орлов', 'Матвей', 'Михайлович', '2416'),
('24', 'Беляева', 'Ева', 'Алиевна', '2417'),
('24', 'Мальцев', 'Андрей', 'Романович', '2418'),
('25', 'Соколов', 'Артём', 'Артёмович', '2501'),
('25', 'Козлов', 'Егор', 'Александрович', '2502'),
('25', 'Елисеев', 'Глеб', 'Богданович', '2503'),
('25', 'Дмитриев', 'Степан', 'Алексеевич', '2504'),
('25', 'Соколова', 'Варвара', 'Богдановна', '2505'),
('25', 'Кузьмин', 'Степан', 'Евгеньевич', '2506'),
('25', 'Головин', 'Ярослав', 'Дмитриевич', '2507'),
('25', 'Горбунова', 'Есения', 'Максимовна', '2508'),
('25', 'Петрова', 'Елизавета', 'Михайловна', '2509'),
('25', 'Еремин', 'Максим', 'Арсентьевич', '2510'),
('25', 'Романчева', 'Василиса', 'Давидовна', '2511'),
('25', 'Сергеев', 'Михаил', 'Сергеевич', '2512'),
('25', 'Романова', 'Виктория', 'Ивановна', '2513'),
('25', 'Степанов', 'Игорь', 'Кириллович', '2514'),
('25', 'Титов', 'Михаил', 'Иванович', '2515'),
('25', 'Сухов', 'Александр', 'Александрович', '2516'),
('31', 'Колосова', 'Виктория', 'Артёмовна', '3101'),
('31', 'Завьялов', 'Олег', 'Константинович', '3102'),
('31', 'Иванов', 'Алексей', 'Леонович', '3103'),
('31', 'Ларин', 'Иван', 'Иванович', '3104'),
('31', 'Фролова', 'Александра', 'Денисовна', '3105'),
('31', 'Соколов', 'Василий', 'Ярославович', '3106'),
('31', 'Петрова', 'Анна', 'Александровна', '3107'),
('31', 'Горелова', 'Арина', 'Эмировна', '3108'),
('31', 'Борисов', 'Роберт', 'Павлович', '3109'),
('31', 'Пахомов', 'Георгий', 'Артёмович', '3110'),
('31', 'Комарова', 'Валерия', 'Ильинична', '3111'),
('31', 'Фокина', 'Маргарита', 'Сергеевна', '3112'),
('31', 'Денисов', 'Платон', 'Георгиевич', '3113'),
('31', 'Новиков', 'Герман', 'Михайлович', '3114'),
('31', 'Федотова', 'Алиса', 'Ильинична', '3115'),
('31', 'Дмитриева', 'Елена', 'Данииловна', '3116'),
('31', 'Иванова', 'Варвара', 'Алиевна', '3117'),
('31', 'Симонов', 'Егор', 'Александрович', '3118'),
('31', 'Соколов', 'Кирилл', 'Владимирович', '3119'),
('31', 'Гончаров', 'Григорий', 'Сергеевич', '3120'),
('31', 'Крылов', 'Иван', 'Никитич', '3121'),
('31', 'Назаров', 'Дмитрий', 'Николаевич', '3122'),
('32', 'Волков', 'Александр', 'Иванович', '3201'),
('32', 'Попова', 'Ольга', 'Данииловна', '3202'),
('32', 'Рыжов', 'Руслан', 'Владиславович', '3203'),
('32', 'Назаров', 'Алексей', 'Ярославович', '3204'),
('32', 'Маслов', 'Давид', 'Иванович', '3205'),
('32', 'Хохлов', 'Марсель', 'Давидович', '3206'),
('32', 'Дубова', 'Алёна', 'Александровна', '3207'),
('32', 'Антипова', 'Аиша', 'Никитична', '3208'),
('32', 'Коновалова', 'Екатерина', 'Егоровна', '3209'),
('32', 'Платонова', 'Ева', 'Дмитриевна', '3210'),
('32', 'Захаров', 'Александр', 'Миронович', '3211'),
('32', 'Миронов', 'Владимир', 'Миронович', '3212'),
('32', 'Иванова', 'Алиса', 'Леоновна', '3213'),
('32', 'Пахомов', 'Ярослав', 'Артурович', '3214'),
('32', 'Макеева', 'Ника', 'Кирилловна', '3215'),
('32', 'Воронин', 'Ярослав', 'Никитич', '3216'),
('32', 'Рудакова', 'Дарья', 'Ивановна', '3217'),
('32', 'Кузнецов', 'Кирилл', 'Иванович', '3218'),
('32', 'Захарова', 'Марина', 'Ивановна', '3219'),
('32', 'Смирнов', 'Мирослав', 'Миронович', '3220'),
('32', 'Шишкина', 'Алиса', 'Николаевна', '3221'),
('33', 'Зверев', 'Владимир', 'Давидович', '3301'),
('33', 'Нефедов', 'Олег', 'Даниилович', '3302'),
('33', 'Степанов', 'Андрей', 'Максимович', '3303'),
('33', 'Шилов', 'Алексей', 'Антонович', '3304'),
('33', 'Синицын', 'Олег', 'Ярославович', '3305'),
('33', 'Богданова', 'Полина', 'Андреевна', '3306'),
('33', 'Киселева', 'Алиса', 'Максимовна', '3307'),
('33', 'Виноградов', 'Кирилл', 'Андреевич', '3308'),
('33', 'Федоров', 'Михаил', 'Дмитриевич', '3309'),
('33', 'Чернова', 'Нина', 'Михайловна', '3310'),
('33', 'Николаев', 'Владимир', 'Александрович', '3311'),
('33', 'Черныч', 'Николай', 'Святославович', '3312'),
('33', 'Баранова', 'Таисия', 'Степановна', '3313'),
('33', 'Петрова', 'Лилия', 'Семёновна', '3314'),
('33', 'Афанасьев', 'Глеб', 'Артёмович', '3315'),
('33', 'Комиссарова', 'Елизавета', 'Артёмовна', '3316'),
('33', 'Герасимов', 'Роман', 'Максимович', '3317'),
('33', 'Логинов', 'Фёдор', 'Артёмович', '3318'),
('33', 'Седова', 'Александра', 'Артёмовна', '3319'),
('34', 'Морозов', 'Константин', 'Михайлович', '3401'),
('34', 'Климова', 'Арина', 'Матвеевна', '3402'),
('34', 'Григорьева', 'Милана', 'Данииловна', '3403'),
('34', 'Кузнецова', 'Эмилия', 'Егоровна', '3405'),
('34', 'Котова', 'Алисия', 'Тимофеевна', '3406'),
('34', 'Никифоров', 'Леонид', 'Максимович', '3407'),
('34', 'Нестерова', 'Дарья', 'Александровна', '3408'),
('34', 'Наумова', 'Виктория', 'Владимировна', '3409'),
('34', 'Горелов', 'Леонид', 'Александрович', '3410'),
('34', 'Самойлова', 'Полина', 'Егоровна', '3411'),
('34', 'Романов', 'Павел', 'Константинович', '3412'),
('34', 'Демин', 'Владимир', 'Сергеевич', '3413'),
('34', 'Ефимов', 'Дамир', 'Семёнович', '3414'),
('34', 'Волкова', 'София', 'Никитична', '3415'),
('34', 'Егоров', 'Иван', 'Тимурович', '3416'),
('34', 'Крючков', 'Артём', 'Матвеевич', '3417'),
('34', 'Антонов', 'Владислав', 'Миронович', '3418'),
('34', 'Кузнецов', 'Максим', 'Артёмович', '3419'),
('34', 'Лопатин', 'Роман', 'Владимирович', '3420');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id user` int(11) NOT NULL,
  `login` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `id role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id user`, `login`, `pass`, `id role`) VALUES
(1, 'admin', 'admin123', 1),
(2, 'Olya', 'user123', 2);

-- --------------------------------------------------------

--
-- Table structure for table `vacina`
--

CREATE TABLE `vacina` (
  `Название вакцины` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `id vac` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vacina`
--

INSERT INTO `vacina` (`Название вакцины`, `id vac`) VALUES
('Спутник V', 'A'),
('КовиВак', 'B'),
('ЭпиВакКорона', 'C');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id group`),
  ADD KEY `id napr` (`id napr`);

--
-- Indexes for table `napr`
--
ALTER TABLE `napr`
  ADD PRIMARY KEY (`id napr`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id role`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id student`),
  ADD KEY `id group` (`id group`),
  ADD KEY `id group_2` (`id group`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id user`),
  ADD KEY `id role` (`id role`);

--
-- Indexes for table `vacina`
--
ALTER TABLE `vacina`
  ADD PRIMARY KEY (`id vac`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `group_ibfk_1` FOREIGN KEY (`id napr`) REFERENCES `napr` (`id napr`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id role`) REFERENCES `roles` (`id role`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
