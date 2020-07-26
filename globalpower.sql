-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 26, 2020 at 06:08 PM
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
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `customer_nama` varchar(100) NOT NULL,
  `customer_alamat` varchar(255) DEFAULT NULL,
  `customer_kota` varchar(100) DEFAULT NULL,
  `customer_site` varchar(100) DEFAULT NULL,
  `customer_telp` varchar(25) DEFAULT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `customer_lastupdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `customer_deleted` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_nama`, `customer_alamat`, `customer_kota`, `customer_site`, `customer_telp`, `customer_email`, `customer_lastupdate`, `customer_deleted`) VALUES
(1, 'PT. Pama Persada1', 'Jl. APT Pranoto1', 'Jl. APT Pranoto1', 'Samburakat1', '0856540126661', 'pama@gmail.com1', '2020-07-26 16:07:51', '0'),
(2, 'PT. Pama Persada', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '0554', 'wiedhodho@gmail.com', '2020-07-26 15:46:39', '0'),
(3, 'PT. Pama Persada', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '0554', 'wiedhodho@gmail.com', '2020-07-26 15:47:34', '0'),
(4, 'PT. Pama Persada', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '0554', 'wiedhodho@gmail.com', '2020-07-26 16:08:10', '1'),
(5, 'PT. Pama Persada', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '', '', '2020-07-26 16:04:08', '1'),
(6, '', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '', '', '2020-07-26 16:03:48', '1');

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
('site_name', 'GLOBAL POWER', '2020-07-26 13:44:27'),
('site_title', 'Aplikasi Pengiriman Berkas Kabupaten Berau', '2020-04-09 12:54:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
