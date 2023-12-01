-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2023 at 12:16 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_nt3102`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `empid` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `empid`, `username`, `password`) VALUES
(1, 1, 'Admin', 'admin123'),

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `sr_code` int(11) NOT NULL,
  `studid` int(11) NOT NULL,
  `date` date NOT NULL,
  `time_in` time NOT NULL,
  `status` int(1) NOT NULL,
  `time_out` time NOT NULL,
  `num_hr` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `studid` int(11) NOT NULL,
  `sr_code` varchar(300) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `studid`, `sr_code`) VALUES
(1, 1, '21-34990'),
(2, 2, '21-35881'),
(3, 3, '21-36992'),
(4, 4, '21-56882');

-- --------------------------------------------------------

--
-- Table structure for table `tbemployee`
--

CREATE TABLE `tbemployee` (
  `empid` int(11) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `department` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbemployee`
--

INSERT INTO `tbemployee` (`empid`, `lastname`, `firstname`, `department`) VALUES
(1, 'Tagle', 'Maiko', 'Library'),
(2, 'Igle', ' Mikko', 'Library');

-- --------------------------------------------------------

--
-- Table structure for table `tb_studentinfo`
--

CREATE TABLE `tb_studentinfo` (
  `studid` int(11) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `course` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_studentinfo`
--

INSERT INTO `tb_studentinfo` (`studid`, `lastname`, `firstname`, `course`) VALUES
(1, 'ALINSUNURIN', 'ALEISTER', 'BSIT'),
(2, 'ANUYO', 'YVAN JEFF L.', 'BSIT'),
(3, 'ARADA', 'BERNARD ANGELO E.', 'BSIT'),
(4, 'BAYBAY', 'EMMANUEL T.', 'BSIT'),
(5, 'CANUEL', 'JED MHARWAYNE P.', 'BSIT'),
(6, 'DE LA CRUZ', 'LEOMAR P.', 'BSIT'),
(7, 'DIEZ', 'ROYSHANE MARU P.', 'BSIT'),
(8, 'ESGUERRA', 'AUBREY A.', 'BSIT'),
(9, 'FIESTADA', 'CEDRICK JHON', 'BSIT'),
(10, 'GRENIAS', 'GENELLA MAE E.', 'BSIT'),
(11, 'HORARIO', 'JOHN MATTHEW I.', 'BSIT'),
(12, 'IGLE', 'MIKKO D.', 'BSIT'),
(13, 'LATORRE', 'JOHN AERON D.', 'BSIT'),
(14, 'LAYLO', 'JULIUS MELWIN D.', 'BSIT'),
(15, 'MALUPA', 'JHON MARK L.', 'BSIT'),
(16, 'MARANAN', 'DON-DON C.', 'BSIT'),
(17, 'MARANAN', 'MIKAELA A.', 'BSIT'),
(18, 'MERCADO', 'KURT DRAHCIR C.', 'BSIT'),
(19, 'NEBRES', 'ELBERT D.', 'BSIT'),
(20, 'PANALIGAN', 'JOMARI M.', 'BSIT'),
(21, 'RAMOS', 'ALLEN EIDRIAN S.', 'BSIT'),
(22, 'RITUAL', 'JUN MARK C.', 'BSIT'),
(23, 'RONGAVILLA', 'EMJAY R.', 'BSIT'),
(24, 'SALANGSANG', 'MIKO JASPER M.', 'BSIT'),
(25, 'VALDEZ', 'FRYAN AURIC L.', 'BSIT'),
(26, 'VILLANUEVA', 'KURT XAVIER L. ', 'BSIT');
--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
