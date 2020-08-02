-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2020 at 11:16 PM
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
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `history_id` int(11) NOT NULL,
  `history_quo` int(11) NOT NULL,
  `history_status` tinyint(4) NOT NULL,
  `history_user` varchar(50) NOT NULL,
  `history_lastupdate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`history_id`, `history_quo`, `history_status`, `history_user`, `history_lastupdate`) VALUES
(1, 1, 1, 'wiedhodho', '2020-07-31 11:13:05'),
(2, 3, -1, 'wiedhodho', '2020-07-31 11:16:16'),
(3, 4, 1, 'wiedhodho', '2020-07-31 15:27:26'),
(4, 5, 1, 'wiedhodho', '2020-07-31 15:27:28'),
(5, 3, -1, 'wiedhodho', '2020-07-31 15:30:18'),
(6, 4, 2, 'wiedhodho', '2020-07-31 15:27:26'),
(7, 8, 1, 'wiedhodho', '2020-07-31 16:18:02'),
(8, 9, 0, 'wiedhodho', '2020-07-31 16:20:10'),
(9, 9, 1, 'wiedhodho', '2020-07-31 16:20:17'),
(10, 8, 2, 'wiedhodho', '2020-08-01 07:48:24'),
(11, 9, 2, 'wiedhodho', '2020-08-01 07:49:32'),
(12, 8, 2, 'wiedhodho', '2020-08-01 08:06:57'),
(13, 8, 1, 'wiedhodho', '2020-08-01 11:52:53'),
(14, 5, 2, 'wiedhodho', '2020-08-01 11:58:39'),
(15, 5, 3, 'wiedhodho', '2020-08-01 12:15:02'),
(16, 5, 1, 'wiedhodho', '2020-08-01 12:24:30'),
(17, 8, 2, 'wiedhodho', '2020-08-01 12:25:58'),
(18, 8, 3, 'wiedhodho', '2020-08-01 12:26:04'),
(19, 7, 1, 'wiedhodho', '2020-08-01 13:21:06'),
(20, 6, 1, 'wiedhodho', '2020-08-01 13:21:25'),
(21, 4, 2, 'wiedhodho', '2020-08-01 13:23:22'),
(22, 8, 4, 'wiedhodho', '2020-08-02 12:16:58'),
(23, 9, 3, 'wiedhodho', '2020-08-02 12:35:28'),
(24, 9, 4, 'wiedhodho', '2020-08-02 12:38:02'),
(25, 9, 5, 'wiedhodho', '2020-08-02 12:54:05'),
(26, 8, 5, 'wiedhodho', '2020-08-02 12:57:23'),
(27, 4, 3, 'wiedhodho', '2020-08-02 13:04:14'),
(28, 4, 4, 'wiedhodho', '2020-08-02 13:05:22'),
(29, 4, 3, 'wiedhodho', '2020-08-02 14:57:46');

--
-- Triggers `history`
--
DELIMITER $$
CREATE TRIGGER `update_status` AFTER INSERT ON `history` FOR EACH ROW BEGIN
 UPDATE quotation SET
 quotation_status = NEW.history_status
 WHERE quotation_id=NEW.history_quo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `inv_id` int(11) NOT NULL,
  `inv_quo` int(11) NOT NULL,
  `inv_customer` int(11) NOT NULL,
  `inv_nomor` int(11) NOT NULL,
  `inv_tanggal` date NOT NULL,
  `inv_total` int(11) NOT NULL,
  `inv_pajak` int(11) NOT NULL,
  `inv_discount` int(11) NOT NULL,
  `inv_status` tinyint(4) NOT NULL,
  `inv_user` varchar(50) NOT NULL,
  `inv_lastupdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `inv_tahun` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`inv_id`, `inv_quo`, `inv_customer`, `inv_nomor`, `inv_tanggal`, `inv_total`, `inv_pajak`, `inv_discount`, `inv_status`, `inv_user`, `inv_lastupdate`, `inv_tahun`) VALUES
(1, 8, 3, 1, '2020-08-03', 14000, 10, 1000, 1, 'wiedhodho', '2020-08-02 12:16:58', 2020),
(2, 9, 2, 2, '2020-08-02', 5212116, 10, 1000, 1, 'wiedhodho', '2020-08-02 12:38:02', 2020);

--
-- Triggers `invoice`
--
DELIMITER $$
CREATE TRIGGER `update_inv` AFTER DELETE ON `invoice` FOR EACH ROW BEGIN
 INSERT INTO history(history_quo, history_status, history_user) VALUES (OLD.inv_quo, 3, OLD.inv_user);
END
$$
DELIMITER ;

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
(3, 4, 'barang 1', 10, '1', 15000),
(5, 5, 'fasd', 32, '0', 31),
(6, 6, 'fasd', 42, '5', 42),
(7, 7, 'eytrwert', 45, '8', 6546456),
(8, 4, 'barang 3', 3, '2', 3000),
(9, 4, 'barang 4', 1, '1', 13000),
(10, 4, 'barang 5', 3, '2', 3000),
(11, 4, 'barang 6', 1, '1', 13000),
(12, 4, 'barang 7', 3, '2', 3000),
(13, 4, 'barang 8', 1, '1', 13000),
(14, 4, 'barang 9', 3, '2', 3000),
(15, 4, 'barang 10', 1, '1', 13000),
(16, 4, 'barang 31', 3, '2', 3000),
(17, 4, 'barang 41', 1, '1', 13000),
(18, 4, 'barang 51', 3, '2', 3000),
(19, 4, 'barang 61', 1, '1', 13000),
(20, 4, 'barang 71', 3, '2', 3000),
(21, 4, 'barang 81', 1, '1', 13000),
(22, 4, 'barang 91', 3, '2', 3000),
(23, 4, 'barang 101', 1, '1', 13000),
(24, 8, 'fasd', 12, '1', 1212),
(25, 9, 'haha', 12, '0', 434343);

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
(15, 'wiedhodho', 'admin', '::1', '1', '2020-07-28 13:01:40'),
(16, 'wiedhodho', 'admin', '::1', '1', '2020-07-29 04:02:17'),
(17, 'wiedhodho', 'admin', '::1', '1', '2020-07-30 11:23:24'),
(18, 'wiedhodho', 'admin', '::1', '1', '2020-07-31 10:59:48'),
(19, 'wiedhodho', 'admin', '::1', '1', '2020-08-01 07:08:11'),
(20, 'wiedhodho', 'admin', '::1', '1', '2020-08-01 11:01:18'),
(21, 'wiedhodho', 'admin', '::1', '1', '2020-08-02 11:59:23'),
(22, 'admin', 'nimda', '::1', '1', '2020-08-02 15:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `quotation`
--

CREATE TABLE `quotation` (
  `quotation_id` int(11) NOT NULL,
  `quotation_cash` tinyint(4) NOT NULL,
  `quotation_jenis` tinyint(4) NOT NULL,
  `quotation_nomor` int(11) NOT NULL,
  `quotation_customer` int(11) DEFAULT NULL,
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
(1, 0, 1, 1, 1, NULL, NULL, '2020-07-28', 10000, 10, 1000, '1', '2020-07-31 11:42:35', 2021, 0),
(3, 0, 0, 1, 1, NULL, NULL, '2020-07-29', 175, 10, 2500, 'wiedhodho', '2020-07-31 15:30:18', 2020, -1),
(4, 0, 0, 2, 2, NULL, NULL, '2020-07-29', 159000, 10, 20000, 'wiedhodho', '2020-08-02 14:57:46', 2020, 3),
(5, 0, 2, 3, 3, NULL, NULL, '2020-07-29', 992, 10, 0, 'wiedhodho', '2020-08-01 12:24:30', 2020, 1),
(6, 0, 1, 4, 1, NULL, NULL, '2020-07-29', 1764, 10, 0, 'wiedhodho', '2020-08-01 13:21:25', 2020, 1),
(7, 1, 2, 5, 3, NULL, NULL, '2020-07-29', 294590520, 10, 0, 'wiedhodho', '2020-08-01 13:21:06', 2020, 1),
(8, 0, 1, 6, 3, NULL, NULL, '2020-08-01', 14544, 5, 100, 'wiedhodho', '2020-08-02 12:57:23', 2020, 5),
(9, 0, 0, 7, 2, NULL, NULL, '2020-08-01', 5212116, 10, 0, 'wiedhodho', '2020-08-02 12:54:05', 2020, 5);

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
('alamat', 'JL. GATOT SUBROTO, NO. 13 A', '2020-08-02 13:36:18'),
('allowed_filetypes', 'audio/*|image/*|png|psd|pdf|xls|xlsx|doc|docx|ppt|pptx', '2020-04-20 14:57:33'),
('app_name', 'Global Power System', '2020-07-27 14:06:04'),
('footer', 'Copyright © 2020 Diskominfo Kabupaten Berau', '2020-04-11 12:15:13'),
('kota', 'TANJUNG REDEB , BERAU - KALTIM', '2020-08-02 13:36:18'),
('max_size', '5', '2020-04-18 08:20:17'),
('site_name', 'GLOBAL POWER', '2020-07-26 13:44:27'),
('site_title', 'Aplikasi Invoice', '2020-07-27 14:23:03'),
('website', 'http://www.globalpower.co.id', '2020-08-02 13:38:11');

-- --------------------------------------------------------

--
-- Table structure for table `spb`
--

CREATE TABLE `spb` (
  `spb_id` int(11) NOT NULL,
  `spb_nomor` int(11) NOT NULL,
  `spb_quo` int(11) NOT NULL,
  `spb_customer` int(11) NOT NULL,
  `spb_tanggal` date NOT NULL,
  `spb_ref` varchar(50) NOT NULL,
  `spb_user` varchar(50) NOT NULL,
  `spb_pengirim` varchar(50) NOT NULL,
  `spb_lastupdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `spb_tahun` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `spb`
--

INSERT INTO `spb` (`spb_id`, `spb_nomor`, `spb_quo`, `spb_customer`, `spb_tanggal`, `spb_ref`, `spb_user`, `spb_pengirim`, `spb_lastupdate`, `spb_tahun`) VALUES
(1, 1, 9, 2, '2020-08-03', '1234', 'wiedhodho', 'widodo1', '2020-08-02 12:35:28', 2020),
(4, 2, 8, 3, '2020-08-01', '42352', 'wiedhodho', 'wdd', '2020-08-01 13:07:29', 2020),
(5, 3, 4, 2, '2020-08-01', 'asdf', 'wiedhodho', 'widodo1', '2020-08-02 13:04:14', 2020);

--
-- Triggers `spb`
--
DELIMITER $$
CREATE TRIGGER `update_spb` AFTER DELETE ON `spb` FOR EACH ROW BEGIN
 INSERT INTO history(history_quo, history_status, history_user) VALUES (OLD.spb_quo, 1, OLD.spb_user);
END
$$
DELIMITER ;

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
(1, 'wiedhodho', 'dd94709528bb1c83d08f3088d4043f4742891f4f', 'admin', 0, 'EDI WAHYU WIDODO', '2020-08-02 15:08:09', '::1', '2020-08-02 15:08:09', '0'),
(5, 'disdik', '236d19eff90e99870777cf274fa6ec1e4ae6af46', '_Wp4&S8*ctVnq%R5fLr$~CP(w', 1, 'Arie Sudiantoro', '2020-07-26 07:42:36', '::1', '2020-07-26 13:42:36', '0'),
(6, 'admin', '513e829fdc3e53b00625b4d3c9717cc8719b503f', 'eg_yJ~Z#vYTw$HbQUm6)c*OoC', 0, 'Bidin', '2020-08-02 15:08:12', '::1', '2020-08-02 15:08:12', '0'),
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
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`inv_id`),
  ADD UNIQUE KEY `inv_nomor` (`inv_nomor`,`inv_tahun`);

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
-- Indexes for table `spb`
--
ALTER TABLE `spb`
  ADD PRIMARY KEY (`spb_id`),
  ADD UNIQUE KEY `spb_nomor` (`spb_nomor`,`spb_tahun`);

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
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `inv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `logger`
--
ALTER TABLE `logger`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `quotation`
--
ALTER TABLE `quotation`
  MODIFY `quotation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `spb`
--
ALTER TABLE `spb`
  MODIFY `spb_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
