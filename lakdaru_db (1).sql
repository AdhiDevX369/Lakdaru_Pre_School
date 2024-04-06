-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2024 at 12:02 PM
-- Server version: 8.0.34
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lakdaru_db`
--
CREATE DATABASE IF NOT EXISTS `lakdaru_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `lakdaru_db`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `UpdateParentWithChildIDs`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateParentWithChildIDs` ()   BEGIN
    -- Disable safe update mode for the session
    SET SQL_SAFE_UPDATES = 0;

    -- Update parent table with child IDs
    UPDATE parent_data pd
    JOIN child_data cd ON pd.parent_id = cd.parent_id
    SET pd.child_id = cd.child_id
    WHERE pd.parent_id IN (SELECT parent_id FROM child_data);

    -- Re-enable safe update mode
    SET SQL_SAFE_UPDATES = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `child_data`
--
-- Creation: Apr 04, 2024 at 08:44 AM
-- Last update: Apr 04, 2024 at 08:45 AM
--

DROP TABLE IF EXISTS `child_data`;
CREATE TABLE IF NOT EXISTS `child_data` (
  `child_id` int NOT NULL AUTO_INCREMENT,
  `child_name` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `gender_id` int DEFAULT NULL,
  PRIMARY KEY (`child_id`),
  KEY `fk_child_data_parent` (`parent_id`),
  KEY `fk_child_data_language` (`language_id`),
  KEY `fk_child_data_gender_idx` (`gender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `child_data`:
--   `gender_id`
--       `gender` -> `gender_id`
--   `language_id`
--       `language` -> `language_id`
--   `parent_id`
--       `parent_data` -> `parent_id`
--

--
-- Truncate table before insert `child_data`
--

TRUNCATE TABLE `child_data`;
--
-- Dumping data for table `child_data`
--

INSERT INTO `child_data` (`child_id`, `child_name`, `dob`, `parent_id`, `language_id`, `gender_id`) VALUES
(1, 'Sumudu Galpatha', '2010-01-01', 2, 1, 1),
(2, 'Kumuduni Alapatha', '2012-03-15', 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--
-- Creation: Apr 04, 2024 at 07:41 AM
-- Last update: Apr 04, 2024 at 08:23 AM
--

DROP TABLE IF EXISTS `gender`;
CREATE TABLE IF NOT EXISTS `gender` (
  `gender_id` int NOT NULL AUTO_INCREMENT,
  `gender` enum('male','female') NOT NULL,
  PRIMARY KEY (`gender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `gender`:
--

--
-- Truncate table before insert `gender`
--

TRUNCATE TABLE `gender`;
--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`gender_id`, `gender`) VALUES
(1, 'male'),
(2, 'female');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--
-- Creation: Apr 04, 2024 at 07:41 AM
-- Last update: Apr 04, 2024 at 08:24 AM
--

DROP TABLE IF EXISTS `language`;
CREATE TABLE IF NOT EXISTS `language` (
  `language_id` int NOT NULL AUTO_INCREMENT,
  `language` enum('Sinhala','Tamil','English') NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `language`:
--

--
-- Truncate table before insert `language`
--

TRUNCATE TABLE `language`;
--
-- Dumping data for table `language`
--

INSERT INTO `language` (`language_id`, `language`) VALUES
(1, 'Sinhala'),
(2, 'Tamil'),
(3, 'English');

-- --------------------------------------------------------

--
-- Table structure for table `login_log`
--
-- Creation: Apr 04, 2024 at 11:04 AM
--

DROP TABLE IF EXISTS `login_log`;
CREATE TABLE IF NOT EXISTS `login_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('success','failed') NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `login_log`:
--

--
-- Truncate table before insert `login_log`
--

TRUNCATE TABLE `login_log`;
-- --------------------------------------------------------

--
-- Table structure for table `login_type`
--
-- Creation: Apr 04, 2024 at 09:13 AM
--

DROP TABLE IF EXISTS `login_type`;
CREATE TABLE IF NOT EXISTS `login_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type` enum('superadmin','admin','parent') NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `login_type`:
--

--
-- Truncate table before insert `login_type`
--

TRUNCATE TABLE `login_type`;
--
-- Dumping data for table `login_type`
--

INSERT INTO `login_type` (`type_id`, `type`) VALUES
(1, 'superadmin'),
(2, 'admin'),
(3, 'parent');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--
-- Creation: Apr 04, 2024 at 08:30 AM
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `child_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `size_id` int DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `req_type_id` int DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`child_id`,`parent_id`),
  KEY `fk_order_parent` (`parent_id`),
  KEY `fk_order_pending_req_idx` (`req_type_id`),
  KEY `fk_order_size` (`size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `order`:
--   `child_id`
--       `child_data` -> `child_id`
--   `parent_id`
--       `parent_data` -> `parent_id`
--   `req_type_id`
--       `pending_request_data` -> `req_type_id`
--   `size_id`
--       `size` -> `size_id`
--

--
-- Truncate table before insert `order`
--

TRUNCATE TABLE `order`;
-- --------------------------------------------------------

--
-- Table structure for table `parent_data`
--
-- Creation: Apr 04, 2024 at 08:44 AM
-- Last update: Apr 04, 2024 at 08:47 AM
--

DROP TABLE IF EXISTS `parent_data`;
CREATE TABLE IF NOT EXISTS `parent_data` (
  `parent_id` int NOT NULL AUTO_INCREMENT,
  `child_id` int DEFAULT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  `address` text,
  `contact` varchar(20) DEFAULT NULL,
  `gender_id` int DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`parent_id`),
  KEY `fk_parent_data_child` (`child_id`),
  KEY `fk_parent_data_gender_idx` (`gender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `parent_data`:
--   `child_id`
--       `child_data` -> `child_id`
--   `gender_id`
--       `gender` -> `gender_id`
--

--
-- Truncate table before insert `parent_data`
--

TRUNCATE TABLE `parent_data`;
--
-- Dumping data for table `parent_data`
--

INSERT INTO `parent_data` (`parent_id`, `child_id`, `parent_name`, `address`, `contact`, `gender_id`, `status`) VALUES
(1, 2, 'Amal Kumara', '123 Main St, Colombo', '123456789', 1, 0),
(2, 1, 'Nayana Madavi', '456 Oak Ave, Kandy', '987654321', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pending_request_data`
--
-- Creation: Apr 04, 2024 at 07:41 AM
-- Last update: Apr 04, 2024 at 08:26 AM
--

DROP TABLE IF EXISTS `pending_request_data`;
CREATE TABLE IF NOT EXISTS `pending_request_data` (
  `req_type_id` int NOT NULL AUTO_INCREMENT,
  `req_type` enum('order','registration','application') NOT NULL,
  PRIMARY KEY (`req_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `pending_request_data`:
--

--
-- Truncate table before insert `pending_request_data`
--

TRUNCATE TABLE `pending_request_data`;
--
-- Dumping data for table `pending_request_data`
--

INSERT INTO `pending_request_data` (`req_type_id`, `req_type`) VALUES
(1, 'order'),
(2, 'registration'),
(3, 'application');

-- --------------------------------------------------------

--
-- Table structure for table `size`
--
-- Creation: Apr 04, 2024 at 07:41 AM
-- Last update: Apr 04, 2024 at 08:26 AM
--

DROP TABLE IF EXISTS `size`;
CREATE TABLE IF NOT EXISTS `size` (
  `size_id` int NOT NULL AUTO_INCREMENT,
  `size` enum('M','S','L','XL') NOT NULL,
  PRIMARY KEY (`size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `size`:
--

--
-- Truncate table before insert `size`
--

TRUNCATE TABLE `size`;
--
-- Dumping data for table `size`
--

INSERT INTO `size` (`size_id`, `size`) VALUES
(1, 'M'),
(2, 'S'),
(3, 'L'),
(4, 'XL');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_applications`
--
-- Creation: Apr 04, 2024 at 08:29 AM
--

DROP TABLE IF EXISTS `teacher_applications`;
CREATE TABLE IF NOT EXISTS `teacher_applications` (
  `req_type_id` int DEFAULT NULL,
  `application_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `nic` varchar(12) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text,
  `qualifications` text,
  `language_id` int DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `gender_id` int DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`application_id`),
  KEY `fk_teacher_applications_req_type` (`req_type_id`),
  KEY `fk_teacher_applications_language` (`language_id`),
  KEY `fk_teacher_applications_gender_idx` (`gender_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `teacher_applications`:
--   `gender_id`
--       `gender` -> `gender_id`
--   `language_id`
--       `language` -> `language_id`
--   `req_type_id`
--       `pending_request_data` -> `req_type_id`
--

--
-- Truncate table before insert `teacher_applications`
--

TRUNCATE TABLE `teacher_applications`;
-- --------------------------------------------------------

--
-- Table structure for table `users`
--
-- Creation: Apr 05, 2024 at 06:47 AM
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type_id` int DEFAULT '3',
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_users_login_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELATIONSHIPS FOR TABLE `users`:
--   `type_id`
--       `login_type` -> `type_id`
--

--
-- Truncate table before insert `users`
--

TRUNCATE TABLE `users`;
--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `username`, `password`, `type_id`, `last_login`) VALUES
(1, 'John Doe', 'amal', '$2y$10$Rt/h1vIZnN3SygdjDwEFoOUtIyh9HgUsfXBhi/ZYXfxLAS.zz2x32', 3, NULL),
(2, 'Jane Smith', 'nayana', '$2y$10$Tr0YOi8aTx6QWMWRd53uHOXviuDOh8d6HbEk064J7ph7UzbrqhLNq', 2, NULL),
(3, 'Alawaka yasssaya', 'admin', '$2y$10$PpGtyiFkTe1Xn8ps92DVTOn6aFSPlbYNBLf98ONc8PpbZfsex02Fu', 1, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `child_data`
--
ALTER TABLE `child_data`
  ADD CONSTRAINT `fk_child_data_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`),
  ADD CONSTRAINT `fk_child_data_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`),
  ADD CONSTRAINT `fk_child_data_parent` FOREIGN KEY (`parent_id`) REFERENCES `parent_data` (`parent_id`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_child` FOREIGN KEY (`child_id`) REFERENCES `child_data` (`child_id`),
  ADD CONSTRAINT `fk_order_parent` FOREIGN KEY (`parent_id`) REFERENCES `parent_data` (`parent_id`),
  ADD CONSTRAINT `fk_order_pending_req` FOREIGN KEY (`req_type_id`) REFERENCES `pending_request_data` (`req_type_id`),
  ADD CONSTRAINT `fk_order_size` FOREIGN KEY (`size_id`) REFERENCES `size` (`size_id`);

--
-- Constraints for table `parent_data`
--
ALTER TABLE `parent_data`
  ADD CONSTRAINT `fk_parent_data_child` FOREIGN KEY (`child_id`) REFERENCES `child_data` (`child_id`),
  ADD CONSTRAINT `fk_parent_data_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`);

--
-- Constraints for table `teacher_applications`
--
ALTER TABLE `teacher_applications`
  ADD CONSTRAINT `fk_teacher_applications_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`),
  ADD CONSTRAINT `fk_teacher_applications_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`),
  ADD CONSTRAINT `fk_teacher_applications_req_type` FOREIGN KEY (`req_type_id`) REFERENCES `pending_request_data` (`req_type_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_login_type` FOREIGN KEY (`type_id`) REFERENCES `login_type` (`type_id`) ON DELETE SET NULL;


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata for table child_data
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table gender
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table language
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table login_log
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table login_type
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table order
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table parent_data
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table pending_request_data
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table size
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table teacher_applications
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table users
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for database lakdaru_db
--

--
-- Truncate table before insert `pma__bookmark`
--

TRUNCATE TABLE `pma__bookmark`;
--
-- Truncate table before insert `pma__relation`
--

TRUNCATE TABLE `pma__relation`;
--
-- Truncate table before insert `pma__savedsearches`
--

TRUNCATE TABLE `pma__savedsearches`;
--
-- Truncate table before insert `pma__central_columns`
--

TRUNCATE TABLE `pma__central_columns`;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
