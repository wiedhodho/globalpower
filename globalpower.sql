-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2020 at 03:54 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `globalpower`
--

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `settings_id` varchar(50) NOT NULL,
  `settings_value` varchar(255) NOT NULL,
  `settings_lastupdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`settings_id`, `settings_value`, `settings_lastupdate`) VALUES
('allowed_filetypes', 'audio/*|image/*|png|psd|pdf|xls|xlsx|doc|docx|ppt|pptx', '2020-04-20 14:57:33'),
('app_name', 'e-Surat', '2020-04-11 12:14:12'),
('footer', 'Copyright © 2020 Diskominfo Kabupaten Berau', '2020-04-11 12:15:13'),
('max_size', '5', '2020-04-18 08:20:17'),
('site_name', 'eSurat Dinas Kominfo Berau', '2020-04-11 12:14:29'),
('site_title', 'Aplikasi Pengiriman Berkas Kabupaten Berau', '2020-04-09 12:54:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
