-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2024 at 07:04 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bsmis`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `thumbnail` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `content`, `thumbnail`, `created_at`, `updated_at`, `deleted_at`) VALUES
(42, 'Assembly meeting', 'meeting garod', '20240920033155172683911566ed794bab88b.png', '2024-09-20 13:31:55', NULL, NULL),
(43, 'Distribution of Fertilizer', 'Distribustion Of abobo on September 29, 2024. 9 AM at the covered Court', '20240927022435172743987566f6a4036de25.png', '2024-09-27 12:24:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificates`
--

INSERT INTO `certificates` (`id`, `name`, `url`) VALUES
(1, 'Barangay Certificate', 'generate_brgy_cert.php'),
(3, '4ps Certification', 'generate_fpscert.php'),
(4, 'Certificate of Indigency', 'generate_indi_cert.php'),
(5, 'Business Clearance', 'generate_business_permit.php'),
(6, 'Cutting Permit', 'generate_cuttingpermit.php');

-- --------------------------------------------------------

--
-- Table structure for table `certificate_requests`
--

CREATE TABLE `certificate_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `resident_id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(10) UNSIGNED DEFAULT NULL,
  `certificate_id` int(10) UNSIGNED NOT NULL,
  `status` enum('resolved','rejected','pending') NOT NULL DEFAULT 'pending',
  `memo` varchar(100) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `url` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificate_requests`
--

INSERT INTO `certificate_requests` (`id`, `resident_id`, `payment_id`, `certificate_id`, `status`, `memo`, `data`, `url`, `created_at`, `updated_at`, `deleted_at`) VALUES
(11, 9, NULL, 6, 'pending', '123', '{\"location\": \"buri\", \"material\": \"123\", \"quantity\": \"123\"}', 'generate_cuttingpermit.php?id=9&request_id=11', '2022-06-03 15:29:54', '2022-06-03 16:42:29', NULL),
(12, 9, NULL, 6, 'pending', '123', '{\"location\": \"3asdf asdf asdf asdf\", \"material\": \"fdsfwre asdf\", \"quantity\": \"12312 asdf asdf \"}', 'generate_cuttingpermit.php?id=9&request_id=12', '2022-06-03 16:48:22', '2022-06-03 16:48:22', NULL),
(13, 18, 31, 1, 'resolved', 'sbgjkarbionk', '{}', 'generate_brgy_cert.php?id=18&request_id=13', '2024-09-20 13:48:47', '2024-09-28 12:03:43', NULL),
(14, 5, 18, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-24 13:49:06', NULL, NULL),
(15, 18, 19, 1, 'resolved', 'Barangay Clearance Payment', NULL, NULL, '2024-09-24 13:53:17', NULL, NULL),
(16, 1, 20, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-24 13:53:38', NULL, NULL),
(17, 18, 21, 1, 'resolved', 'Barangay Clearance Payment', NULL, NULL, '2024-09-24 14:07:40', NULL, NULL),
(18, 1, 22, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-24 14:20:33', NULL, NULL),
(19, 1, 23, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-24 14:26:36', NULL, NULL),
(20, 5, 24, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-24 14:42:56', NULL, NULL),
(21, 1, 25, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-24 15:14:14', NULL, NULL),
(22, 9, 26, 5, 'resolved', 'Business Permit Payment', NULL, NULL, '2024-09-24 15:17:40', NULL, NULL),
(23, 9, 27, 5, 'resolved', 'Business Permit Payment', NULL, NULL, '2024-09-24 15:38:24', NULL, NULL),
(24, 18, 28, 5, 'resolved', 'okinnam', '{\"name\":\"eatery\",\"owner_1\":\"jobart\",\"owner_2\":\"andrew\",\"nature\":\"panganan\"}', 'generate_business_permit.php?id=18&request_id=24', '2024-09-24 15:46:21', '2024-09-24 15:47:05', NULL),
(25, 18, 29, 4, 'resolved', 'for scholar', '{}', 'generate_indi_cert.php?id=18&request_id=25', '2024-09-27 13:14:21', '2024-09-27 13:15:26', NULL),
(26, 18, 37, 4, 'resolved', 'dhhbzd', '{}', 'generate_indi_cert.php?id=18&request_id=26', '2024-09-28 10:01:54', '2024-09-28 12:08:04', NULL),
(28, 5, 30, 6, 'resolved', 'Cutting Permit Payment', NULL, NULL, '2024-09-28 11:33:59', NULL, NULL),
(29, 18, 36, 1, 'resolved', 'barangay clearance po ', '{}', 'generate_brgy_cert.php?id=18&request_id=29', '2024-09-28 12:00:16', '2024-09-28 12:07:36', NULL),
(30, 18, 35, 3, 'resolved', 'porpis', '{}', 'generate_fpscert.php?id=18&request_id=30', '2024-09-28 12:00:34', '2024-09-28 12:05:40', NULL),
(31, 18, 34, 4, 'resolved', 'indigent', '{}', 'generate_indi_cert.php?id=18&request_id=31', '2024-09-28 12:00:46', '2024-09-28 12:05:16', NULL),
(32, 18, 33, 5, 'resolved', 'until tomorrow morning', '{\"name\":\"Papaitan eatery\",\"owner_1\":\"jobart\",\"owner_2\":\"andrew\",\"nature\":\"mini restaurant\"}', 'generate_business_permit.php?id=18&request_id=32', '2024-09-28 12:01:55', '2024-09-28 12:04:47', NULL),
(33, 18, 32, 6, 'resolved', 'jy tinga baybay', '{\"material\":\"nara\",\"quantity\":\"10\",\"location\":\"suso\"}', 'generate_cuttingpermit.php?id=18&request_id=33', '2024-09-28 12:02:39', '2024-09-28 12:04:21', NULL),
(34, 18, 38, 3, 'resolved', '4PS Certification Payment', NULL, NULL, '2024-10-01 04:17:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `resident_id` int(10) UNSIGNED DEFAULT NULL,
  `details` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `mode` enum('online','cash') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `resident_id`, `details`, `amount`, `mode`, `created_at`, `updated_at`, `deleted_at`) VALUES
(20, 11, 1, 'Cutting Permit Payment', 21345.00, 'cash', '2024-09-24 13:53:38', NULL, NULL),
(21, 11, 18, 'Barangay Clearance Payment', 123.00, 'cash', '2024-09-24 14:07:40', NULL, NULL),
(22, 11, 1, 'Cutting Permit Payment', 1.00, 'cash', '2024-09-24 14:20:33', NULL, NULL),
(23, 11, 1, 'Cutting Permit Payment', 150.00, 'cash', '2024-09-24 14:26:35', NULL, NULL),
(24, 11, 5, 'Cutting Permit Payment', 15.00, 'cash', '2024-09-24 14:42:56', NULL, NULL),
(25, 11, 1, 'Cutting Permit Payment', 43.00, 'cash', '2024-09-24 15:14:14', NULL, NULL),
(26, 11, 9, 'Business Permit Payment', 123.00, 'cash', '2024-09-24 15:17:40', NULL, NULL),
(27, 11, 9, 'Business Permit Payment', 211.00, 'cash', '2024-09-24 15:38:24', NULL, NULL),
(28, 11, 18, 'Business Permit Payment', 60.00, 'cash', '2024-09-24 15:47:05', NULL, NULL),
(29, 11, 18, 'Certificate of Indigency Payment', 130.00, 'cash', '2024-09-27 13:15:26', NULL, NULL),
(30, 11, 5, 'Cutting Permit Payment', 3.00, 'cash', '2024-09-28 11:33:59', NULL, NULL),
(31, 11, 18, 'Barangay Clearance Payment', 1.00, 'cash', '2024-09-28 12:03:43', NULL, NULL),
(32, 11, 18, 'Cutting Permit Payment', 2.00, 'cash', '2024-09-28 12:04:21', NULL, NULL),
(33, 11, 18, 'Business Permit Payment', 4.00, 'cash', '2024-09-28 12:04:47', NULL, NULL),
(34, 11, 18, 'Certificate of Indigency Payment', 5.00, 'cash', '2024-09-28 12:05:16', NULL, NULL),
(35, 11, 18, '4PS Certification Payment', 6.00, 'cash', '2024-09-28 12:05:40', NULL, NULL),
(36, 11, 18, 'Barangay Clearance Payment', 7.00, 'cash', '2024-09-28 12:07:36', NULL, NULL),
(37, 11, 18, 'Certificate of Indigency Payment', 8.00, 'cash', '2024-09-28 12:08:04', NULL, NULL),
(38, 11, 18, '4PS Certification Payment', 15.00, 'cash', '2024-10-01 04:17:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purok`
--

CREATE TABLE `purok` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purok`
--

INSERT INTO `purok` (`id`, `name`, `details`) VALUES
(9, 'zone 1', 'sfdgharh'),
(10, 'zone 2', 'aegsf'),
(11, 'zone 3', 'sreg'),
(12, 'zone 4', 'dfhszrdh'),
(13, 'zone 5', 'srhzdrh'),
(14, 'zone 6', 'zdfhgzfh'),
(15, 'sitio', 'Cappa-Cappa'),
(16, 'sitio', 'uno');

-- --------------------------------------------------------

--
-- Table structure for table `residents`
--

CREATE TABLE `residents` (
  `id` int(10) UNSIGNED NOT NULL,
  `national_id` varchar(100) DEFAULT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `citizenship` varchar(50) DEFAULT NULL,
  `picture` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `middlename` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lastname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alias` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `birthplace` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `civilstatus` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `purok_id` int(10) UNSIGNED NOT NULL,
  `voterstatus` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `identified_as` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resident_type` int(11) DEFAULT 1,
  `is_4ps` tinyint(1) DEFAULT 0,
  `is_pwd` tinyint(1) DEFAULT 0,
  `is_senior` tinyint(1) DEFAULT 0,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `residents`
--

INSERT INTO `residents` (`id`, `national_id`, `account_id`, `citizenship`, `picture`, `firstname`, `middlename`, `lastname`, `alias`, `birthplace`, `birthdate`, `age`, `civilstatus`, `gender`, `purok_id`, `voterstatus`, `identified_as`, `phone`, `email`, `occupation`, `address`, `resident_type`, `is_4ps`, `is_pwd`, `is_senior`, `remarks`, `created_at`, `updated_at`, `deleted_at`) VALUES
(18, '123456789', 108, 'filipino', NULL, 'Jobart', 'Dollente', 'Quijencio', 'bart', 'suso', '2003-07-22', 21, 'Single', 'Male', 9, 'Yes', 'Positive', '09266033318', 'jobartquijencio21@gmail.com', 'student', ' suso ', 1, 1, 0, 0, NULL, '2024-09-20 13:48:07', '2024-10-01 04:37:33', NULL),
(19, '123234466547457457', 109, 'Filipino', NULL, 'Donji Bronzon', 'Gargabite', 'Dausen', 'Babaero', 'Delpilar, Ilocos Sur', '2001-11-22', 22, 'Single', 'Male', 9, 'Yes', 'Positive', '09123456789', 'Donji@gmail.com', 'Agbabae', 'Suso', 1, 0, 0, 0, NULL, '2024-10-01 04:41:54', NULL, NULL),
(20, '2314452', 110, 'filipino', NULL, 'Donji', 'G', 'Dausen', 'babaero', 'Sto.Nino', '2001-11-22', 22, 'Single', 'Male', 9, 'Yes', 'Positive', '09123344556', 'Donji@gmail.com', 'Babaero', 'Suso, Santa Maria Ilocos Sur', 1, 0, 0, 0, NULL, '2024-10-01 04:51:05', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblblotter`
--

CREATE TABLE `tblblotter` (
  `id` int(11) NOT NULL,
  `complainant` varchar(100) DEFAULT NULL,
  `respondent` varchar(100) DEFAULT NULL,
  `victim` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `details` varchar(10000) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblblotter`
--

INSERT INTO `tblblotter` (`id`, `complainant`, `respondent`, `victim`, `type`, `location`, `date`, `time`, `details`, `status`) VALUES
(28, 'Yves Pichi', 'ni artek', 'Yves pichi', 'Incident', 'santa maria', '2024-09-20', '09:30:00', 'nagboksing da', 'Settled');

-- --------------------------------------------------------

--
-- Table structure for table `tblbrgy_info`
--

CREATE TABLE `tblbrgy_info` (
  `id` int(11) NOT NULL,
  `province` varchar(100) DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `brgy_name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `city_logo` varchar(100) DEFAULT NULL,
  `brgy_logo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblbrgy_info`
--

INSERT INTO `tblbrgy_info` (`id`, `province`, `town`, `brgy_name`, `number`, `text`, `image`, `city_logo`, `brgy_logo`) VALUES
(1, 'Ilocos Sur', 'Municipality of Sta. Maria', 'Barangay Suso', '0919-1234569', 'barangay suso', '27092024082708CircularFashionLogoinBeigeClassicStyle.jpg', '28092024051105logo1-removebg-preview.png', '27092024084608CircularFashionLogoinBeigeClassicStyle.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tblchairmanship`
--

CREATE TABLE `tblchairmanship` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblchairmanship`
--

INSERT INTO `tblchairmanship` (`id`, `title`) VALUES
(2, 'Punong Barangay'),
(3, 'Committee on Appropriation'),
(4, 'Committee on Peace & Order'),
(5, 'Committee on Health'),
(6, 'Committee on Education'),
(7, 'Committee on Rules'),
(8, 'Committee on Infrastructure '),
(9, 'Committee on Solid Waste'),
(10, 'Committee on Sports'),
(11, 'No Chairmanship'),
(12, 'Chief Tanod'),
(13, 'Deputy Tanod');

-- --------------------------------------------------------

--
-- Table structure for table `tbldocuments`
--

CREATE TABLE `tbldocuments` (
  `no` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `requested_documents` varchar(50) DEFAULT NULL,
  `purpose` varchar(50) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbldocuments`
--

INSERT INTO `tbldocuments` (`no`, `name`, `email`, `number`, `requested_documents`, `purpose`, `date`) VALUES
(1, 'amar', 'amar@gmail.com', 910201645, 'certificate', 'school', '2022-04-20 06:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tblfpscert`
--

CREATE TABLE `tblfpscert` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `current_location` varchar(100) DEFAULT NULL,
  `applied` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblfpscert`
--

INSERT INTO `tblfpscert` (`id`, `name`, `current_location`, `applied`) VALUES
(1, 'RENATO R. ALMO', 'Metro Manila', '2022-04-15'),
(2, 'Annie May Barrera', 'Manila', '2022-04-18'),
(3, 'trytr', '5454', '2022-05-21');

-- --------------------------------------------------------

--
-- Table structure for table `tblofficials`
--

CREATE TABLE `tblofficials` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `chairmanship` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `termstart` date DEFAULT NULL,
  `termend` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblofficials`
--

INSERT INTO `tblofficials` (`id`, `name`, `chairmanship`, `position`, `termstart`, `termend`, `status`) VALUES
(1, 'Gilbert R. De Luna', '2', '4', '2024-04-29', '2024-11-09', 'Active'),
(14, 'Ernie Jeash Villahermosa', '5', NULL, '2022-05-18', '2022-05-20', 'Active'),
(15, 'Ernie Jeash Villahermosa', '5', NULL, '2022-05-18', '2022-05-20', 'Active'),
(16, 'Ernie Jeash Villahermosa', '5', NULL, '2022-05-18', '2022-05-20', 'Active'),
(20, 'Gener J. Dumot', '3', '7', '2023-04-27', '2024-11-27', 'Active'),
(21, 'Susan D. Escobar', '4', '8', '2023-04-27', '2024-11-27', 'Active'),
(22, 'Juvy S. Dato', '3', '9', '2023-04-27', '2024-04-27', 'Active'),
(23, 'Leo C. Ferino', '4', '10', '2023-04-27', '2024-04-27', 'Active'),
(24, 'Jesus E. Ordonez', '6', '11', '2023-04-27', '2024-11-27', 'Active'),
(25, 'Katrick P. Raguindin', '7', '12', '2023-04-27', '2024-04-27', 'Active'),
(26, 'Tirso C. Latosa', '8', '13', '2023-04-27', '2024-11-27', 'Active'),
(27, 'Elisa F. Reduca', '11', '15', '2023-04-27', '2024-11-27', 'Active'),
(28, 'Mila R. Asuncion', '11', '16', '2023-04-27', '2024-11-27', 'Active'),
(29, 'Pia Dumot', '11', '14', '2023-04-27', '2024-11-27', 'Active'),
(30, 'Roger Corpuz', '12', '17', '2023-04-27', '2024-11-27', 'Active'),
(31, 'Jeffray Peralta', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(32, 'Leonardo Perilla', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(33, 'Ernesto Umipig', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(34, 'Danilo Repollo', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(35, 'Jonathan Purugganan', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(36, 'Rumualdo Tamayo', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(37, 'Raymundo Dar', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(38, 'Manolito Calibuso', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(39, 'Fely San pedro', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(40, 'Jecris Peralta', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(41, 'Joseph', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(42, 'Joseph Coloma', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(43, 'Rommel Realizo', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(44, 'Adrian Cabalo', '13', '17', '2023-04-27', '2024-11-27', 'Active'),
(45, 'Victoria Garcia', '13', '17', '2023-04-27', '2024-11-27', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `tblpermit`
--

CREATE TABLE `tblpermit` (
  `id` int(11) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `owner1` varchar(200) DEFAULT NULL,
  `owner2` varchar(80) DEFAULT NULL,
  `nature` varchar(220) DEFAULT NULL,
  `applied` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblpermit`
--

INSERT INTO `tblpermit` (`id`, `name`, `owner1`, `owner2`, `nature`, `applied`) VALUES
(9, 'chris', 'Jobart', 'Jobart', 'Eatery', '2024-09-24'),
(10, 'Ponsyo D. pilapil', 'dada', 'icic', 'Eatery', '2024-09-24');

-- --------------------------------------------------------

--
-- Table structure for table `tblposition`
--

CREATE TABLE `tblposition` (
  `id` int(11) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblposition`
--

INSERT INTO `tblposition` (`id`, `position`, `order`) VALUES
(4, 'Barangay Captain', 1),
(7, 'Barangay Kagawad', 2),
(8, 'Barangay Kagawad', 3),
(9, 'Barangay Kagawad', 4),
(10, 'Barangay Kagawad', 5),
(11, 'Barangay Kagawad', 6),
(12, 'Barangay Kagawad', 7),
(13, 'Barangay Kagawad', 8),
(14, 'SK Chairman', 9),
(15, 'Secretary', 10),
(16, 'Treasurer', 11),
(17, 'Tanod', 12);

-- --------------------------------------------------------

--
-- Table structure for table `tblprecinct`
--

CREATE TABLE `tblprecinct` (
  `id` int(11) NOT NULL,
  `precinct` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblprecinct`
--

INSERT INTO `tblprecinct` (`id`, `precinct`, `details`) VALUES
(1, '09266033318', 'Developer');

-- --------------------------------------------------------

--
-- Table structure for table `tblrequest`
--

CREATE TABLE `tblrequest` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pcs` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `applied` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblrequest`
--

INSERT INTO `tblrequest` (`id`, `name`, `pcs`, `type`, `location`, `applied`) VALUES
(5, 'Ponsyo D. pilapil', 5, 'mahogany', 'Suso', '2024-09-28');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_support`
--

CREATE TABLE `tbl_support` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` enum('administrator','staff','user') NOT NULL,
  `avatar` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `user_type`, `avatar`, `created_at`) VALUES
(11, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'administrator', '20240927125852172743473266f68fec30664.jpg', '2021-05-03 02:33:03'),
(108, 'jobart123', '3650c195b6eb82db3818ec19c7c055b6f91b9675', 'user', 'data:image/jpeg;base64,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', '2024-09-20 13:48:07'),
(110, 'Donji@gmail.com', 'don_22', 'user', '20241001065105172775826566fb7fb94f707.jpg', '2024-10-01 04:51:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `certificate_requests`
--
ALTER TABLE `certificate_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resident_id` (`resident_id`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `certificate_id` (`certificate_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `resident_id` (`resident_id`);

--
-- Indexes for table `purok`
--
ALTER TABLE `purok`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `residents`
--
ALTER TABLE `residents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `purok_id` (`purok_id`);

--
-- Indexes for table `tblblotter`
--
ALTER TABLE `tblblotter`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbrgy_info`
--
ALTER TABLE `tblbrgy_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblchairmanship`
--
ALTER TABLE `tblchairmanship`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbldocuments`
--
ALTER TABLE `tbldocuments`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `tblfpscert`
--
ALTER TABLE `tblfpscert`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblofficials`
--
ALTER TABLE `tblofficials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblpermit`
--
ALTER TABLE `tblpermit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblposition`
--
ALTER TABLE `tblposition`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblprecinct`
--
ALTER TABLE `tblprecinct`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblrequest`
--
ALTER TABLE `tblrequest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_support`
--
ALTER TABLE `tbl_support`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `certificate_requests`
--
ALTER TABLE `certificate_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `purok`
--
ALTER TABLE `purok`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `residents`
--
ALTER TABLE `residents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tblblotter`
--
ALTER TABLE `tblblotter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `tblbrgy_info`
--
ALTER TABLE `tblbrgy_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblchairmanship`
--
ALTER TABLE `tblchairmanship`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbldocuments`
--
ALTER TABLE `tbldocuments`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblfpscert`
--
ALTER TABLE `tblfpscert`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblofficials`
--
ALTER TABLE `tblofficials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `tblpermit`
--
ALTER TABLE `tblpermit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tblposition`
--
ALTER TABLE `tblposition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tblprecinct`
--
ALTER TABLE `tblprecinct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblrequest`
--
ALTER TABLE `tblrequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_support`
--
ALTER TABLE `tbl_support`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
