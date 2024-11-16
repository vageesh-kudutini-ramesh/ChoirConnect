-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2024-11-16 05:19:43
-- 服务器版本： 10.4.28-MariaDB
-- PHP 版本： 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `choir_management`
--

-- --------------------------------------------------------

--
-- 表的结构 `Attendance`
--

CREATE TABLE `Attendance` (
  `attendance_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `absence_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `Attendance`
--

INSERT INTO `Attendance` (`attendance_id`, `member_id`, `date`, `status`, `absence_reason`) VALUES
(1, 1, '2024-11-15', 1, 'N/A');

-- --------------------------------------------------------

--
-- 表的结构 `Dues`
--

CREATE TABLE `Dues` (
  `dues_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_method` enum('Venmo','Check','Mail') DEFAULT NULL,
  `payment_frequency` enum('Monthly','Yearly') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `Dues`
--

INSERT INTO `Dues` (`dues_id`, `member_id`, `amount`, `payment_date`, `payment_method`, `payment_frequency`) VALUES
(1, 1, 50.00, '2023-03-01', 'Venmo', 'Monthly'),
(2, 2, 100.00, '2023-03-01', 'Check', 'Yearly');

-- --------------------------------------------------------

--
-- 表的结构 `Member`
--

CREATE TABLE `Member` (
  `member_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `voice_part_id` int(11) DEFAULT NULL,
  `status_flag` tinyint(1) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `Member`
--

INSERT INTO `Member` (`member_id`, `first_name`, `last_name`, `email`, `phone_number`, `address`, `join_date`, `voice_part_id`, `status_flag`, `notes`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', '2023-01-01', NULL, 1, 'Choir Leader'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St', '2023-02-15', NULL, 1, 'Section Leader');

-- --------------------------------------------------------

--
-- 表的结构 `Role`
--

CREATE TABLE `Role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `Role`
--

INSERT INTO `Role` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'Treasurer'),
(3, 'Secretary'),
(4, 'Member');

-- --------------------------------------------------------

--
-- 表的结构 `User`
--

CREATE TABLE `User` (
  `user_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转储表的索引
--

--
-- 表的索引 `Attendance`
--
ALTER TABLE `Attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `idx_member_id` (`member_id`),
  ADD KEY `idx_date` (`date`);

--
-- 表的索引 `Dues`
--
ALTER TABLE `Dues`
  ADD PRIMARY KEY (`dues_id`),
  ADD KEY `member_id` (`member_id`);

--
-- 表的索引 `Member`
--
ALTER TABLE `Member`
  ADD PRIMARY KEY (`member_id`);

--
-- 表的索引 `Role`
--
ALTER TABLE `Role`
  ADD PRIMARY KEY (`role_id`);

--
-- 表的索引 `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `role_id` (`role_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `Attendance`
--
ALTER TABLE `Attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `Dues`
--
ALTER TABLE `Dues`
  MODIFY `dues_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `Member`
--
ALTER TABLE `Member`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `Role`
--
ALTER TABLE `Role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 限制导出的表
--

--
-- 限制表 `Attendance`
--
ALTER TABLE `Attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`);

--
-- 限制表 `Dues`
--
ALTER TABLE `Dues`
  ADD CONSTRAINT `dues_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`);

--
-- 限制表 `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `Role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
