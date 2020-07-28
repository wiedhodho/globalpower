-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2020 at 12:55 AM
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
(1, 'PT. Pama Persada1', 'Jl. APT Pranoto1', 'Jl. APT Pranoto1', NULL, '0856540126661', 'pama@gmail.com1', '2020-07-28 13:24:38', '0'),
(2, 'PT.  Buma', 'Jl. APT Pranoto Buma', 'Tanjung Redeb', 'Samburakat', '0554', 'wiedhodho@gmail.com', '2020-07-28 13:20:32', '0'),
(3, 'PT. SIS', 'Jl. Teluk Bayur', 'Jakarta', 'Binungan', '0554', 'wiedhodho@gmail.com', '2020-07-28 13:20:55', '0'),
(4, 'PT. Pama Persada', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '0554', 'wiedhodho@gmail.com', '2020-07-26 16:08:10', '1'),
(5, 'PT. Pama Persada', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '', '', '2020-07-26 16:04:08', '1'),
(6, '', 'Jl. APT Pranoto', 'Berau - Kaltim', 'Samburakat', '', '', '2020-07-26 16:03:48', '1');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `items_id` int(11) NOT NULL,
  `items_quo` int(11) NOT NULL,
  `items_desc` varchar(255) NOT NULL,
  `items_qty` int(11) NOT NULL,
  `items_satuan` varchar(50) NOT NULL,
  `items_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`items_id`, `items_quo`, `items_desc`, `items_qty`, `items_satuan`, `items_price`) VALUES
(1, 3, 'barang 1', 10, '0', 10000),
(2, 3, 'barang 2', 5, '0', 15000),
(3, 4, 'barang 1', 10, '0', 15000),
(4, 4, 'barang 2', 7, '0', 5000),
(5, 5, 'fasd', 32, '0', 31),
(6, 6, 'fasd', 42, '5', 42),
(7, 7, 'eytrwert', 45, '8', 6546456);

-- --------------------------------------------------------

--
-- Table structure for table `logger`
--

CREATE TABLE `logger` (
  `log_id` int(11) NOT NULL,
  `log_user` varchar(50) NOT NULL,
  `log_password` varchar(50) NOT NULL,
  `log_ip` varchar(15) NOT NULL,
  `log_status` enum('0','1') NOT NULL,
  `log_lastupdate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logger`
--

INSERT INTO `logger` (`log_id`, `log_user`, `log_password`, `log_ip`, `log_status`, `log_lastupdate`) VALUES
(1, 'wiedhodho', 'admin', '::1', '0', '2020-07-27 14:08:51'),
(2, 'wiedhodho', 'admin', '::1', '0', '2020-07-27 14:08:52'),
(3, 'wiedhodho', 'admin', '::1', '0', '2020-07-27 14:09:44'),
(4, 'wiedhodho', 'admin', '::1', '0', '2020-07-27 14:09:45'),
(5, 'wiedhodho', 'admin', '::1', '0', '2020-07-27 14:10:09'),
(6, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 14:11:44'),
(7, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 14:23:28'),
(8, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 14:55:13'),
(9, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 14:55:49'),
(10, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 14:58:56'),
(11, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 14:59:03'),
(12, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 15:02:23'),
(13, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 15:07:17'),
(14, 'wiedhodho', 'admin', '::1', '1', '2020-07-27 15:08:14'),
(15, 'wiedhodho', 'admin', '::1', '1', '2020-07-28 13:01:40');

-- --------------------------------------------------------

--
-- Table structure for table `quotation`
--

CREATE TABLE `quotation` (
  `quotation_id` int(11) NOT NULL,
  `quotation_cash` tinyint(4) NOT NULL,
  `quotation_jenis` tinyint(4) NOT NULL,
  `quotation_nomor` int(11) NOT NULL,
  `quotation_customer` int(11) NOT NULL,
  `quotation_nama` varchar(50) DEFAULT NULL,
  `quotation_telp` varchar(20) DEFAULT NULL,
  `quotation_tanggal` date NOT NULL,
  `quotation_total` int(11) NOT NULL,
  `quotation_pajak` tinyint(4) NOT NULL,
  `quotation_discount` int(11) NOT NULL,
  `quotation_user` varchar(50) NOT NULL,
  `quotation_lastupdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quotation_tahun` year(4) NOT NULL,
  `quotation_status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quotation`
--

INSERT INTO `quotation` (`quotation_id`, `quotation_cash`, `quotation_jenis`, `quotation_nomor`, `quotation_customer`, `quotation_nama`, `quotation_telp`, `quotation_tanggal`, `quotation_total`, `quotation_pajak`, `quotation_discount`, `quotation_user`, `quotation_lastupdate`, `quotation_tahun`, `quotation_status`) VALUES
(1, 0, 1, 1, 1, NULL, NULL, '2020-07-28', 10000, 10, 1000, '1', '2020-07-28 16:03:44', 2021, 0),
(3, 0, 0, 1, 1, NULL, NULL, '2020-07-29', 175, 10, 2500, 'wiedhodho', '2020-07-28 16:19:53', 2020, 0),
(4, 0, 0, 2, 2, NULL, NULL, '2020-07-29', 185000, 10, 0, 'wiedhodho', '2020-07-28 16:25:24', 2020, 0),
(5, 0, 1, 3, 3, NULL, NULL, '2020-07-29', 992, 10, 0, 'wiedhodho', '2020-07-28 16:49:55', 2020, 0),
(6, 0, 1, 4, 1, NULL, NULL, '2020-07-29', 1764, 10, 0, 'wiedhodho', '2020-07-28 16:51:22', 2020, 0),
(7, 1, 2, 5, 3, NULL, NULL, '2020-07-29', 294590520, 10, 0, 'wiedhodho', '2020-07-28 16:51:53', 2020, 0);

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
('app_name', 'Global Power System', '2020-07-27 14:06:04'),
('footer', 'Copyright © 2020 Diskominfo Kabupaten Berau', '2020-04-11 12:15:13'),
('max_size', '5', '2020-04-18 08:20:17'),
('site_name', 'GLOBAL POWER', '2020-07-26 13:44:27'),
('site_title', 'Aplikasi Invoice', '2020-07-27 14:23:03');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `users_id` int(11) NOT NULL,
  `users_name` varchar(50) NOT NULL,
  `users_pass` varchar(50) NOT NULL,
  `users_salt` varchar(50) NOT NULL,
  `users_level` tinyint(4) NOT NULL,
  `users_nama` varchar(100) NOT NULL,
  `users_lastlogin` timestamp NULL DEFAULT NULL,
  `users_lastip` varchar(15) DEFAULT NULL,
  `users_lastupdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `users_deleted` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`users_id`, `users_name`, `users_pass`, `users_salt`, `users_level`, `users_nama`, `users_lastlogin`, `users_lastip`, `users_lastupdate`, `users_deleted`) VALUES
(1, 'wiedhodho', 'dd94709528bb1c83d08f3088d4043f4742891f4f', 'admin', 0, 'EDI WAHYU WIDODO', '2020-07-28 13:01:40', '::1', '2020-07-28 13:01:40', '0'),
(5, 'disdik', '236d19eff90e99870777cf274fa6ec1e4ae6af46', '_Wp4&S8*ctVnq%R5fLr$~CP(w', 1, 'Arie Sudiantoro', '2020-07-26 07:42:36', '::1', '2020-07-26 13:42:36', '0'),
(6, 'admin', '11369382927675e31fb83c4033b04e303f441c09', '0IXKBEdn!9(p)%D6lr2QhfT~S', 2, 'Arief Wiedhartono', '2020-06-16 07:07:43', '::1', '2020-06-16 13:07:43', '0'),
(7, 'setda', '0f85e5084f67e665ef64233346f5370c0fe09428', 'mvgR!DOe6qw2QA8%&1T_XuCBh', 1, 'setda', '2020-07-19 20:01:49', '::1', '2020-07-20 02:01:49', '0'),
(8, 'disdik2', '7650567ef76c30756924ad263e2cdd5adeef52f1', 'JQqcjp)9tUIoWV!NG86YryA74', 2, 'Disdik 2', NULL, NULL, '2020-07-28 13:01:51', '1'),
(9, 'coba123', '93d96284ebffe74b8a2594d8dde24bb188fe2bbf', '9ryG+cb@6(RiC2Z4JmX*~OuF#', 0, 'coba coba 123', NULL, NULL, '2020-07-27 14:52:58', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`items_id`);

--
-- Indexes for table `logger`
--
ALTER TABLE `logger`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `quotation`
--
ALTER TABLE `quotation`
  ADD PRIMARY KEY (`quotation_id`),
  ADD UNIQUE KEY `quotation_nomor` (`quotation_nomor`,`quotation_tahun`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`users_id`),
  ADD UNIQUE KEY `users_name` (`users_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `logger`
--
ALTER TABLE `logger`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `quotation`
--
ALTER TABLE `quotation`
  MODIFY `quotation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
