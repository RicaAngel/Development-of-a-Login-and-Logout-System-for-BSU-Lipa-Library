-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2023 at 02:08 PM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `EventManager` (IN `eventNameVal` VARCHAR(255), IN `eventDescVal` VARCHAR(255), IN `eventDateVal` TIMESTAMP, IN `orgIDVal` INT)   BEGIN
	SET @statusID = 1;
    INSERT INTO events (eventName,eventDesc,e_date,org_ID,statusID) VALUES (eventNameVal,eventDescVal,eventDateVal,orgIDVal,@statusID);
    SET @eventID = LAST_INSERT_ID();
    SET @superID = orgIDVal;
    INSERT INTO eventrecords(eventID,superID) VALUES ( @eventID, orgIDVal);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterModerator` (IN `org_namevalue` VARCHAR(255), IN `passwordvalue` VARCHAR(255), IN `usernamevalue` VARCHAR(255), IN `deptIDvalue` INT)   BEGIN
	SET @salt = (SUBSTRING(MD5(RAND()), 1, 10));
    SET @password = SHA2(CONCAT(passwordvalue,@salt),256);
    INSERT INTO superusers (username,password,salt) VALUES (usernamevalue,@password,@salt);
    SET @superID = LAST_INSERT_ID();
    
    INSERT INTO organization (dept_ID,org_name,superID) VALUES ( deptIDvalue, org_namevalue,@superID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registerStudents` (IN `sr_codeIN` VARCHAR(10), IN `firstnameIN` VARCHAR(255), IN `lastnameIN` VARCHAR(255))   BEGIN
    INSERT INTO tb_studentinfo(lastname, firstname, course) VALUES (lastnameIN, firstnameIN, 'BSIT'); 
    SET @studid = LAST_INSERT_ID();
    INSERT INTO students(sr_code, courseID, year, section, stud_id) VALUES (sr_codeIN, 6, '3rd', 'NT-3102', @studid);
    SET @salt =  SUBSTRING(MD5(RAND()) FROM 1 FOR 10);
	SET @password = SHA2(CONCAT(sr_codeIN,@salt),256);
	INSERT INTO userstudents(sr_code,password,salt) values(sr_codeIN,@password,@salt);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `add_stocks`
--

CREATE TABLE `add_stocks` (
  `Product_ID` int(100) NOT NULL,
  `Quantity` int(50) NOT NULL,
  `Transaction_No` int(50) NOT NULL,
  `Date` date NOT NULL,
  `empid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(2, 2, 'Librarian', 'librarian123');

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `administratorID` int(11) NOT NULL,
  `empid` int(11) NOT NULL,
  `administratorPassword` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`administratorID`, `empid`, `administratorPassword`) VALUES
(1, 1001, 'password1'),
(2, 1002, 'password2'),
(3, 1003, 'password3');

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE `announcement` (
  `id` int(50) NOT NULL,
  `announcement` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `atendees_view`
-- (See below for the actual view)
--
CREATE TABLE `atendees_view` (
`userID` int(11)
,`stud_deptid` int(11)
,`eventName` varchar(50)
,`eventDesc` varchar(50)
,`department_Name` varchar(100)
,`event_deptid` int(11)
,`org_Name` varchar(255)
,`attendeeID` int(11)
,`eventID` int(11)
,`DateRegistered` timestamp
);

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
  `status` int(11) NOT NULL,
  `time_out` time NOT NULL,
  `num_hr` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance_tbl`
--

CREATE TABLE `attendance_tbl` (
  `AttendanceID` int(11) NOT NULL,
  `FacultyID` int(11) NOT NULL,
  `studid` varchar(25) NOT NULL,
  `AttendanceDate` varchar(25) NOT NULL,
  `ClassSection` varchar(25) NOT NULL,
  `Room` varchar(25) NOT NULL,
  `TimeStart` time(6) NOT NULL,
  `TimeEnd` time(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `attendance_tbl`
--

INSERT INTO `attendance_tbl` (`AttendanceID`, `FacultyID`, `studid`, `AttendanceDate`, `ClassSection`, `Room`, `TimeStart`, `TimeEnd`) VALUES
(31, 1, '3', '2023-11-25', 'BSCS-NT-1102', 'HEB 402', '12:00:00.000000', '16:00:00.000000'),
(32, 1, '1', '2023-11-25', 'BSCS-NT-1102', 'HEB 402', '12:00:00.000000', '16:00:00.000000');

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `authorID` int(11) NOT NULL,
  `authorFn` text DEFAULT NULL,
  `authorLn` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`authorID`, `authorFn`, `authorLn`) VALUES
(1, 'Aia', 'Amare'),
(2, 'Fulgur', 'Ovid'),
(3, 'John', 'Doe'),
(4, 'Milie', 'Parfait'),
(5, 'Johns', 'Doe'),
(6, 'John', 'Doo'),
(7, 'millie', 'Parfait'),
(8, 'Enna', 'alouette');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `bookID` int(11) NOT NULL,
  `authorID` int(11) DEFAULT NULL,
  `publisherID` int(11) DEFAULT NULL,
  `bookTitle` text DEFAULT NULL,
  `ISBN` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `genre` text DEFAULT NULL,
  `publishDate` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`bookID`, `authorID`, `publisherID`, `bookTitle`, `ISBN`, `description`, `genre`, `publishDate`) VALUES
(1, 2, 1, 'Dork', '0-2029-2791-1', 'ILUNA Institute of the Mystics 2nd Year. An angelic maiden who descended from Heaven to observe mankind. Her gentle appearance hides a rather mischievous disposition 1', 'Non-Fiction', '2023-01-01'),
(2, 3, 2, 'Legatus 404', '0-1260-6478-4', 'A Cyborg from the future with unparalleled strength. His body is partly cold steel, and who is to say if he has a heart', 'Fiction', '2023-02-02'),
(3, 4, 3, 'though Doe', '0-4319-1393-5', 'A typical AI generated name', 'Comedy', '2023-03-03'),
(5, 6, 1, 'Flat is justice', '32141', 'A monster cat creeping through hell. A bit aggressive, but maybe she just needs some attention.[1]', 'Fantasy', '2023-01-01'),
(8, 8, 3, 'Song Bird', '2432', 'A blue bird fluttering in the heavens. She sings a love song for the souls of the living', 'Fantasy', '2023-11-01');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `courseID` int(11) NOT NULL,
  `courseName` text NOT NULL,
  `dept_ID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`courseID`, `courseName`, `dept_ID`) VALUES
(1, 'Bachelor of Science in Business Administration', 1),
(2, 'Bachelor of Science in Management Accounting', 1),
(3, 'Bachelor of Science in Psychology', 2),
(4, 'Bachelor of Arts in Communication', 2),
(5, 'Bachelor of Industrial Technology', 3),
(6, 'Bachelor of Science in Information Technology', 4),
(7, 'Bachelor of Science in Computer Science', 4),
(8, 'Bachelor of Secondary Education', 5),
(9, 'Bachelor of Science in Industrial Engineering ', 6);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_ID` int(11) NOT NULL,
  `department_Name` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_ID`, `department_Name`) VALUES
(0, 'General Department'),
(1, 'CABEIHM'),
(2, 'CAS'),
(3, 'CIT'),
(4, 'CICS'),
(5, 'CTE'),
(6, 'CE');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emp_data`
--

CREATE TABLE `emp_data` (
  `empid` int(11) NOT NULL,
  `empCode` varchar(50) NOT NULL,
  `User_Type` varchar(100) NOT NULL,
  `User_Email` varchar(100) NOT NULL,
  `User_Password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eventattendees`
--

CREATE TABLE `eventattendees` (
  `attendeeID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `sr_code` varchar(11) NOT NULL,
  `DateRegistered` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eventattendees`
--

INSERT INTO `eventattendees` (`attendeeID`, `eventID`, `sr_code`, `DateRegistered`) VALUES
(1, 1, '21-33273', '2023-11-20 01:28:13');

-- --------------------------------------------------------

--
-- Table structure for table `eventrecords`
--

CREATE TABLE `eventrecords` (
  `recordID` int(11) NOT NULL,
  `eventID` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) NOT NULL,
  `superID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eventrecords`
--

INSERT INTO `eventrecords` (`recordID`, `eventID`, `remarks`, `superID`) VALUES
(1, '1', 'NA', 1);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eventID` int(11) NOT NULL,
  `eventName` varchar(50) NOT NULL,
  `eventDesc` varchar(50) NOT NULL,
  `org_ID` int(11) NOT NULL,
  `statusID` int(11) NOT NULL,
  `e_date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`eventID`, `eventName`, `eventDesc`, `org_ID`, `statusID`, `e_date`) VALUES
(1, 'sample', 'sample', 1, 1, '2023-11-19 09:32:12'),
(2, 'sample2', 'sample3', 1, 1, '2023-11-19 13:44:43');

-- --------------------------------------------------------

--
-- Table structure for table `eventstatus`
--

CREATE TABLE `eventstatus` (
  `statusID` int(11) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eventstatus`
--

INSERT INTO `eventstatus` (`statusID`, `status`) VALUES
(1, 'Pending'),
(2, 'Approved'),
(3, 'Cancelled');

-- --------------------------------------------------------

--
-- Stand-in structure for view `event_info`
-- (See below for the actual view)
--
CREATE TABLE `event_info` (
`statusID` int(11)
,`status` varchar(255)
,`eventID` int(11)
,`eventName` varchar(50)
,`eventDesc` varchar(50)
,`org_ID` int(11)
,`e_date` datetime
,`department_Name` varchar(100)
,`dept_ID` int(11)
,`org_Name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `faculty_tbl`
--

CREATE TABLE `faculty_tbl` (
  `FacultyID` int(11) NOT NULL,
  `empid` int(11) NOT NULL,
  `FacultyUsername` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `FacultyPassword` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty_tbl`
--

INSERT INTO `faculty_tbl` (`FacultyID`, `empid`, `FacultyUsername`, `FacultyPassword`) VALUES
(1, 1, 'Jennifer Reyes', 'jenniferreyes123');

-- --------------------------------------------------------

--
-- Table structure for table `librarian`
--

CREATE TABLE `librarian` (
  `libID` int(11) NOT NULL,
  `empid` int(11) NOT NULL,
  `librarianPassword` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `librarian`
--

INSERT INTO `librarian` (`libID`, `empid`, `librarianPassword`) VALUES
(4, 1004, 'password4'),
(5, 1005, 'password5'),
(6, 1006, 'password6');

-- --------------------------------------------------------

--
-- Table structure for table `lost_items`
--

CREATE TABLE `lost_items` (
  `id` int(11) NOT NULL,
  `item_number` varchar(255) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `date_found` date NOT NULL,
  `date_claimed` date DEFAULT NULL,
  `Userid` int(11) DEFAULT NULL,
  `StudentId` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lost_items`
--

INSERT INTO `lost_items` (`id`, `item_number`, `item_name`, `date_found`, `date_claimed`, `Userid`, `StudentId`) VALUES
(1, '000001', 'Cellphone', '2023-11-13', '2023-11-24', NULL, NULL),
(2, '000002', 'Ballpen', '2023-11-14', '2023-11-24', NULL, NULL),
(3, '000003', 'Book', '2023-11-14', '2023-11-24', NULL, NULL),
(4, '000004', 'Pencil', '2023-11-15', '2023-11-24', NULL, NULL),
(5, '000005', 'Bag', '2023-11-17', '2023-11-24', NULL, NULL),
(6, '000006', 'Money', '2023-11-17', '2023-11-24', NULL, NULL),
(7, '000007', 'Shoes', '2023-11-18', '2023-11-24', NULL, NULL),
(8, '000008', 'Ballpen', '2023-11-18', '2023-11-24', NULL, NULL),
(9, '000009', 'Wallet', '2023-11-19', '2023-11-24', NULL, NULL),
(10, '000010', 'ID Lace', '2023-11-20', '2023-11-25', NULL, NULL),
(11, '000011', 'Shades', '2023-11-20', NULL, NULL, NULL),
(12, '000012', 'Key', '2023-11-21', NULL, NULL, NULL),
(13, '000013', 'ID', '2023-11-21', NULL, NULL, NULL),
(14, '000014', 'Money', '2023-11-21', NULL, NULL, NULL),
(15, '000015', 'Headphone', '2023-11-22', NULL, NULL, NULL),
(16, '000016', 'Cellphone', '2023-11-22', NULL, NULL, NULL),
(17, '000017', 'Handkerchief', '2023-11-22', NULL, NULL, NULL),
(18, '000018', 'Adaptor', '2023-11-25', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `moderatorcookies`
-- (See below for the actual view)
--
CREATE TABLE `moderatorcookies` (
`superID` int(11)
,`userName` varchar(255)
,`password` varchar(255)
,`salt` varchar(10)
,`org_ID` int(11)
,`dept_ID` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `moderators`
-- (See below for the actual view)
--
CREATE TABLE `moderators` (
`superID` int(11)
,`username` varchar(255)
,`org_Name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `notifications`
-- (See below for the actual view)
--
CREATE TABLE `notifications` (
`statusID` int(11)
,`status` varchar(255)
,`eventID` int(11)
,`eventName` varchar(50)
,`eventDesc` varchar(50)
,`org_ID` int(11)
,`e_date` datetime
,`department_Name` varchar(100)
,`dept_ID` int(11)
,`org_Name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `org_ID` int(11) NOT NULL,
  `dept_ID` int(11) NOT NULL,
  `org_Name` varchar(255) NOT NULL,
  `superID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`org_ID`, `dept_ID`, `org_Name`, `superID`) VALUES
(1, 1, 'Junior Philippine Association of Management Accountants', 1),
(2, 1, 'Junior Marketing Executives', 2),
(3, 1, 'College of Accountancy, Business and Economics Council', 3),
(4, 1, 'Public Administration Student Association', 4),
(5, 1, 'Association Of Operation Management Students', 5),
(6, 1, 'Young People Management Association of the Philippines', 6),
(7, 2, 'Association of College of Arts and Sciences Students', 7),
(8, 2, 'Circle of Psychology Students', 8),
(9, 2, 'Poderoso Communicador Sociedad', 9),
(10, 3, 'Alliance of Industrial Technology Students', 10),
(11, 3, 'CTRL+A', 11),
(12, 4, 'Junior Philippine Computer Society - Lipa Chapter', 12),
(13, 4, 'Tech Innovators Society', 13),
(14, 5, 'Aspiring Future Educators Guild', 14),
(15, 5, 'Language Educators Association', 15),
(16, 6, 'Junior Philippine Institute of Industrial Engineers', 16),
(17, 0, 'Red Spartan Sports Council', 17),
(18, 0, 'Supreme Student Council Lipa Campus', 18);

-- --------------------------------------------------------

--
-- Table structure for table `out_stocks`
--

CREATE TABLE `out_stocks` (
  `Product_ID` int(100) NOT NULL,
  `SoldStocks` varchar(100) NOT NULL,
  `Transaction_No` int(100) NOT NULL,
  `Date` date NOT NULL,
  `empid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Product_ID` int(100) NOT NULL,
  `Category_Name` varchar(100) NOT NULL,
  `Product_Name` varchar(100) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Price` int(50) NOT NULL,
  `image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `publisherID` int(11) NOT NULL,
  `publisherName` text DEFAULT NULL,
  `publisherAddress` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`publisherID`, `publisherName`, `publisherAddress`) VALUES
(1, 'ABC Production', 'Cuenca, Batangas'),
(2, 'Victory', 'Lipa City, Batangas'),
(3, 'Modico', 'BiÃ±an, Laguna'),
(4, 'City Publishers', '321 Maple St, City4, Country'),
(5, 'Metro Print House', '555 Pine St, City5, Country'),
(6, 'Sunny Publications', '777 Cedar St, City6, Country'),
(7, 'Valley Books', '999 Birch St, City7, Country'),
(8, 'Summit Press', '234 Spruce St, City8, Country'),
(9, 'Harbor Publishing', '876 Fir St, City9, Country'),
(10, 'Meadow Books Inc', '543 Redwood St, City10, Country');

-- --------------------------------------------------------

--
-- Table structure for table `security_lostnfound`
--

CREATE TABLE `security_lostnfound` (
  `UserId` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` enum('admin','security') DEFAULT 'security',
  `usersign` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `security_lostnfound`
--

INSERT INTO `security_lostnfound` (`UserId`, `username`, `password`, `role`, `usersign`) VALUES
(1010, 'Admin_Sd', 'adminsd', 'admin', 'Seurity Department'),
(2125, '2125', '2125', 'security', 'Security_G0');

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentinfoview`
-- (See below for the actual view)
--
CREATE TABLE `studentinfoview` (
`userID` int(11)
,`sr_code` varchar(250)
,`password` varchar(255)
,`salt` varchar(10)
,`firstName` varchar(25)
,`lastName` varchar(25)
,`courseID` int(11)
,`year` varchar(255)
,`section` varchar(250)
,`courseName` text
,`dept_ID` int(11)
,`department_Name` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `sr_code` varchar(250) NOT NULL,
  `courseID` int(11) NOT NULL,
  `year` varchar(255) NOT NULL,
  `section` varchar(250) NOT NULL,
  `stud_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`sr_code`, `courseID`, `year`, `section`, `stud_id`) VALUES
('21-33273', 6, '3rd', 'NT-3102', 1),
('21-38474', 6, '3rd', 'NT-3102', 2),
('21-32782', 6, '3rd', 'NT-3102', 3),
('21-36452', 6, '3rd', 'NT-3102', 4),
('21-35509', 6, '3rd', 'NT-3102', 5),
('21-31630', 6, '3rd', 'NT-3102', 6),
('21-30506', 6, '3rd', 'NT-3102', 7),
('21-36155', 6, '3rd', 'NT-3102', 8),
('22-35794', 6, '3rd', 'NT-3102', 9),
('21-35078', 6, '3rd', 'NT-3102', 10),
('21-30802', 6, '3rd', 'NT-3102', 11),
('21-34772', 6, '3rd', 'NT-3102', 12),
('21-36111', 6, '3rd', 'NT-3102', 13),
('21-30320', 6, '3rd', 'NT-3102', 14),
('21-36991', 6, '3rd', 'NT-3102', 15),
('21-37287', 6, '3rd', 'NT-3102', 16),
('21-32548', 6, '3rd', 'NT-3102', 17),
('21-37831', 6, '3rd', 'NT-3102', 18),
('21-37178', 6, '3rd', 'NT-3102', 19),
('21-30812', 6, '3rd', 'NT-3102', 20),
('21-34330', 6, '3rd', 'NT-3102', 21),
('21-32259', 6, '3rd', 'NT-3102', 22),
('21-33470', 6, '3rd', 'NT-3102', 23),
('21-37046', 6, '3rd', 'NT-3102', 24),
('21-36999', 6, '3rd', 'NT-3102', 25),
('21-34053', 6, '3rd', 'NT-3102', 26);

-- --------------------------------------------------------

--
-- Table structure for table `students_tbl`
--

CREATE TABLE `students_tbl` (
  `id` int(11) NOT NULL,
  `studid` int(11) NOT NULL,
  `sr_code` varchar(300) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `students_tbl`
--

INSERT INTO `students_tbl` (`id`, `studid`, `sr_code`) VALUES
(1, 1, '21-33273'),
(2, 2, '21-38474'),
(3, 3, '21-32782'),
(4, 4, '21-36452'),
(5, 5, '21-35509'),
(6, 6, '21-31630'),
(7, 7, '21-30506');

-- --------------------------------------------------------

--
-- Table structure for table `student_lostnfound`
--

CREATE TABLE `student_lostnfound` (
  `StudentId` int(11) NOT NULL,
  `Sr_code` varchar(191) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_lostnfound`
--

INSERT INTO `student_lostnfound` (`StudentId`, `Sr_code`, `password`) VALUES
(1, '21-36991', '21-36991'),
(2, '21-34551', '21-34551');

-- --------------------------------------------------------

--
-- Table structure for table `student_tbl`
--

CREATE TABLE `student_tbl` (
  `StudentID` int(11) NOT NULL,
  `studid` int(11) NOT NULL,
  `StudentQR` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `student_tbl`
--

INSERT INTO `student_tbl` (`StudentID`, `studid`, `StudentQR`) VALUES
(1, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzcmNvZGUiOiIyMS0zNjk5OSIsImZ1bGxuYW1lIjoiVkFMREVaLCBGUllBTiBBVVJJQyBMLiIsInRpbWVzdGFtcCI6IjIwMjMtMTEtMTYgMjI6MDA6MTUiLCJ0eXBlIjoiU1RVREVOVCIsInVzZXJpZCI6IjIxLTM2OTk5In0.Zvx0BjtFexJ1dKbr295nGIUDCA9vZ44yqmdoBBw7rfc'),
(2, 2, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzcmNvZGUiOiIyMS0zNjQ1MiIsImZ1bGxuYW1lIjoiQkFZQkFZLCBFTU1BTlVFTCBULiIsInRpbWVzdGFtcCI6IjIwMjMtMTEtMjQgMTY6NDE6NDAiLCJ0eXBlIjoiU1RVREVOVCIsInVzZXJpZCI6IjIxLTM2NDUyIn0.PJOlVBipbUwubXYYsoC2leHBinMpTBces1s3VkQUGNE'),
(3, 3, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzcmNvZGUiOiIyMS0zNjExMSIsImZ1bGxuYW1lIjoiTEFUT1JSRSwgSk9ITiBBRVJPTiBELiIsInRpbWVzdGFtcCI6IjIwMjMtMTEtMTYgMjE6NTA6MDQiLCJ0eXBlIjoiU1RVREVOVCIsInVzZXJpZCI6IjIxLTM2MTExIn0.qVMtyeO9V_qiWnM9lJe8fNT9NnZPaAYVDTFgdyAstYo');

-- --------------------------------------------------------

--
-- Stand-in structure for view `stud_atendees_view`
-- (See below for the actual view)
--
CREATE TABLE `stud_atendees_view` (
`userID` int(11)
,`dept_ID` int(11)
,`stud_dept` varchar(100)
,`statusID` int(11)
,`status` varchar(255)
,`stud_deptid` int(11)
,`org_ID` int(11)
,`e_date` datetime
,`attendeeID` int(11)
,`eventID` int(11)
,`DateRegistered` timestamp
,`sr_code` varchar(250)
);

-- --------------------------------------------------------

--
-- Table structure for table `stud_data`
--

CREATE TABLE `stud_data` (
  `studid` int(11) NOT NULL,
  `srCode` varchar(50) DEFAULT NULL,
  `User_Type` varchar(100) DEFAULT NULL,
  `User_Email` varchar(100) NOT NULL,
  `User_Password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `superusers`
--

CREATE TABLE `superusers` (
  `superID` int(11) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `superusers`
--

INSERT INTO `superusers` (`superID`, `userName`, `password`, `salt`) VALUES
(0, 'adminval', '95e1d817e753fe6392b68de89c337e4cbcf63d280e77245d5c7a3fc4938863d9', 'kckKVzx9k1'),
(1, 'JPAMA', '3913342ed7e247f86dc7bf83229b90a0cec7d8f7f9a6851927f7becc7fec9035', 'b79dc59cf1'),
(2, 'JME', '18d7d94a8343f46b943d963da0d1b8bb42520ba84d4329280be02e5c542a9ee4', 'fc39983032'),
(3, 'CABE Council', '423a577e2d08ee38ad7969840840efd3ebc0adde65ccce896eb93c3d2c491fc8', '02eb527701');

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
(1, 'Reyes', 'Jennifer', 'BSIT'),
(1001, 'Dela Cruz', 'Juan', 'BSIT'),
(1002, 'Santos', 'Maria', 'BSCS'),
(1003, 'Reyes', 'Pedro', 'BSIS'),
(1004, 'Doe', 'John', 'Librarian'),
(1005, 'Smith', 'Jane', 'Librarian'),
(1006, 'Johnson', 'Bob', 'Librarian'),
(1010, 'Admin_Sd', 'Admin_Sd', 'Security Department'),
(2125, '2125', 'Jose2125', 'Security Department');

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

-- --------------------------------------------------------

--
-- Table structure for table `updatelog`
--

CREATE TABLE `updatelog` (
  `updateID` int(11) NOT NULL,
  `action` text DEFAULT NULL,
  `entityType` text DEFAULT NULL,
  `entityID` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `updatelog`
--

INSERT INTO `updatelog` (`updateID`, `action`, `entityType`, `entityID`, `timestamp`) VALUES
(1, 'Delete', 'Staff', 1, '2023-11-24 13:52:26'),
(2, 'Delete', 'User', 2, '2023-11-24 13:57:34'),
(3, 'ADD', 'Staff', 3, '2023-11-24 13:57:34'),
(4, 'Delete', 'User', 4, '2023-11-24 13:57:34'),
(5, 'ADD', 'User', 5, '2023-11-24 13:57:34'),
(6, 'ADD', 'Staff', 6, '2023-11-24 13:57:34'),
(7, 'Delete', 'User', 7, '2023-11-24 13:57:34'),
(8, 'Delete', 'Staff', 8, '2023-11-24 13:57:34'),
(9, 'Add', 'Staff', 9, '2023-11-24 13:57:34'),
(10, 'Delete', 'Staff', 10, '2023-11-24 13:57:34');

-- --------------------------------------------------------

--
-- Table structure for table `usere`
--

CREATE TABLE `usere` (
  `UserEID` int(11) NOT NULL,
  `empid` int(11) NOT NULL,
  `UserE_password` varchar(25) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserSID` int(11) NOT NULL,
  `SR-Code` int(11) NOT NULL,
  `UserS_password` varchar(25) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userstudents`
--

CREATE TABLE `userstudents` (
  `userID` int(11) NOT NULL,
  `sr_code` varchar(250) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userstudents`
--

INSERT INTO `userstudents` (`userID`, `sr_code`, `password`, `salt`) VALUES
(30, '21-33273', '6b4bd75cc704efcf0a3d6887e10a411fc5a7818aa1438de4465f02d631bf1a70', 'a659f4f0d4'),
(31, '21-38474', 'bfdae3cfc2c7c2773ac293f9cb15814586705a16173606b39404b32b497d9412', '26d4dc168b'),
(32, '21-32782', '9b64a2942740cb9cd8067e1a6c8d84bff3e414976adc63a129123430c618ecec', 'e8c76eec45'),
(33, '21-36452', 'ba8d62ca622e4f3f2e68883bf68c2fd64b635f0485a87c18ac44d54a6d9eaf28', '044a38dea3'),
(34, '21-35509', '4d3fdf83d5842a266cbb3e018ae31647a2e630d3acdb9f04bb881008b42078a0', '635e641305'),
(35, '21-31630', '15efad1d5f16ab304a2af42eb78689579bef78a53e04ba06f9cf56c6181c070c', '0a98ed8fe9'),
(36, '21-30506', 'c0f4141ec4264bc7a76f53e20163c26c9761bb52fe31c0c2e4147e40756e5a61', '042539b035'),
(37, '21-36155', 'd2e35a0752a171ad48e11dd1ba36af75b411d6eae94ae1f28916e1b0a55f60d0', 'accebca5d5'),
(38, '22-35794', 'd116870cf578fbf176b3b87d705d51b44b283e7a763b43dbe54575cbd5e5e1ad', 'e56b942e78'),
(39, '21-35078', '731f2250a01087b8f1e5660b6656726bb54009824b05c461c18a04cb1c0c9f85', 'fa55bbae21'),
(40, '21-30802', '76ea1a5f2a6031ba5a4fbe0e0a5565a1e8480c56d452c1a7ae057618d027d45d', 'e93838fd30'),
(41, '21-34772', '2f45400e76cd46f975f90bfd310602cefb487b2080c4bc96814aa76537816c1a', '4d2667272b'),
(42, '21-36111', '9d4783ffd9a4ce6b6feb7d12c475df048f9d65f0aa5616267a152474d1c7b5ed', '4db457944d'),
(43, '21-30320', '00f282933a8d091e5cb737d29beb40fb49c5d7100519a82021b4cefbfea974fe', 'd22b13b908'),
(44, '21-36991', '7ba4622434e7d705fec6473b3350f1ba7a7a7e689a6b30e9b2d91f72aa013c34', '6178f70afb'),
(45, '21-37287', '8f1519dc79cbc06ef63da8ef8de2a4103a82a9740acf5df918ab042fbb29189b', '594f74acaf'),
(46, '21-32548', 'd2747f26aa58884994bbb25374d03bbbd36aa3dfc9f483254cb3e388525fc0e3', 'e65ec0644e'),
(47, '21-37831', '3e55c25d4205ac84ba4293acdafe4a19c74f7e7e8675e4afc64597a012455460', '8185b3d497'),
(48, '21-37178', '02e8cb8413c80f1305da00b678025b5d6bb9eeec0fe122514c4e4173b753ba07', 'fe40bf99a4'),
(49, '21-30812', '7896c1ba2e0ee038ee51ad6840a8e308847b3c2419ca70981c0bab1e3bf74f8a', 'c10a55ae53'),
(50, '21-34330', '65b9df5485143f41e79ade91f6e5b696db2b9b38a967b04cf58e731da4920e0c', 'e516258230'),
(51, '21-32259', '69dacba9daf6902e01d29c18cfef195e8484b4e0eda11dd0745ebe79a25b8b28', '24bd21e835'),
(52, '21-33470', 'bccf5bfbc32d89bacb2d02601b67e7f0dd699d3fd3e61cf7e5b30d8d60e1b576', 'd1d340bd60'),
(53, '21-37046', 'f5124f3a67d3e9b3b360039cdb31fab5a03d61468d81349c20fe3f61b158af14', '0b2ed73711'),
(54, '21-36999', 'ff84e76a0976bc6d3008720d48c985ac87d9533d5c9e1309bebc1520952e0b2f', '662c6c77d1'),
(55, '21-34053', 'd8c7465170ae72d87267dbb71600b65a0ffbd03c056e336e7b7d4d01cd652f4a', 'd55f02bac4');

-- --------------------------------------------------------

--
-- Structure for view `atendees_view`
--
DROP TABLE IF EXISTS `atendees_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `atendees_view`  AS SELECT `studentinfoview`.`userID` AS `userID`, `event_info`.`eventID` AS `stud_deptid`, `event_info`.`eventName` AS `eventName`, `event_info`.`eventDesc` AS `eventDesc`, `event_info`.`department_Name` AS `department_Name`, `event_info`.`dept_ID` AS `event_deptid`, `event_info`.`org_Name` AS `org_Name`, `eventattendees`.`attendeeID` AS `attendeeID`, `eventattendees`.`eventID` AS `eventID`, `eventattendees`.`DateRegistered` AS `DateRegistered` FROM ((`eventattendees` join `event_info` on(`event_info`.`eventID` = `eventattendees`.`eventID`)) join `studentinfoview` on(`studentinfoview`.`sr_code` = `eventattendees`.`sr_code`)) GROUP BY `eventattendees`.`attendeeID`, `eventattendees`.`eventID` ;

-- --------------------------------------------------------

--
-- Structure for view `event_info`
--
DROP TABLE IF EXISTS `event_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `event_info`  AS SELECT `eventstatus`.`statusID` AS `statusID`, `eventstatus`.`status` AS `status`, `events`.`eventID` AS `eventID`, `events`.`eventName` AS `eventName`, `events`.`eventDesc` AS `eventDesc`, `events`.`org_ID` AS `org_ID`, `events`.`e_date` AS `e_date`, `department`.`department_Name` AS `department_Name`, `organization`.`dept_ID` AS `dept_ID`, `organization`.`org_Name` AS `org_Name` FROM (((`eventstatus` join `events` on(`eventstatus`.`statusID` = `events`.`statusID`)) join `organization` on(`organization`.`org_ID` = `events`.`org_ID`)) join `department` on(`department`.`dept_ID` = `organization`.`dept_ID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `moderatorcookies`
--
DROP TABLE IF EXISTS `moderatorcookies`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `moderatorcookies`  AS SELECT `superusers`.`superID` AS `superID`, `superusers`.`userName` AS `userName`, `superusers`.`password` AS `password`, `superusers`.`salt` AS `salt`, `organization`.`org_ID` AS `org_ID`, `department`.`dept_ID` AS `dept_ID` FROM ((`superusers` join `organization` on(`superusers`.`superID` = `organization`.`superID`)) join `department` on(`department`.`dept_ID` = `organization`.`dept_ID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `moderators`
--
DROP TABLE IF EXISTS `moderators`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `moderators`  AS SELECT `superusers`.`superID` AS `superID`, `superusers`.`userName` AS `username`, `organization`.`org_Name` AS `org_Name` FROM (`organization` join `superusers` on(`organization`.`superID` = `superusers`.`superID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `notifications`
--
DROP TABLE IF EXISTS `notifications`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `notifications`  AS SELECT `event_info`.`statusID` AS `statusID`, `event_info`.`status` AS `status`, `event_info`.`eventID` AS `eventID`, `event_info`.`eventName` AS `eventName`, `event_info`.`eventDesc` AS `eventDesc`, `event_info`.`org_ID` AS `org_ID`, `event_info`.`e_date` AS `e_date`, `event_info`.`department_Name` AS `department_Name`, `event_info`.`dept_ID` AS `dept_ID`, `event_info`.`org_Name` AS `org_Name` FROM `event_info` WHERE cast(`event_info`.`e_date` as date) between current_timestamp() and current_timestamp() + interval 7 day AND `event_info`.`status` = 'Approved' ;

-- --------------------------------------------------------

--
-- Structure for view `studentinfoview`
--
DROP TABLE IF EXISTS `studentinfoview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentinfoview`  AS SELECT `userstudents`.`userID` AS `userID`, `students`.`sr_code` AS `sr_code`, `userstudents`.`password` AS `password`, `userstudents`.`salt` AS `salt`, `tb_studentinfo`.`firstname` AS `firstName`, `tb_studentinfo`.`lastname` AS `lastName`, `course`.`courseID` AS `courseID`, `students`.`year` AS `year`, `students`.`section` AS `section`, `course`.`courseName` AS `courseName`, `department`.`dept_ID` AS `dept_ID`, `department`.`department_Name` AS `department_Name` FROM ((((`userstudents` join `students` on(`students`.`sr_code` = `userstudents`.`sr_code`)) join `tb_studentinfo` on(`students`.`stud_id` = `tb_studentinfo`.`studid`)) join `course` on(`course`.`courseID` = `students`.`courseID`)) join `department` on(`department`.`dept_ID` = `course`.`dept_ID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `stud_atendees_view`
--
DROP TABLE IF EXISTS `stud_atendees_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stud_atendees_view`  AS SELECT `studentinfoview`.`userID` AS `userID`, `studentinfoview`.`dept_ID` AS `dept_ID`, `studentinfoview`.`department_Name` AS `stud_dept`, `event_info`.`statusID` AS `statusID`, `event_info`.`status` AS `status`, `eventattendees`.`eventID` AS `stud_deptid`, `event_info`.`org_ID` AS `org_ID`, `event_info`.`e_date` AS `e_date`, `eventattendees`.`attendeeID` AS `attendeeID`, `eventattendees`.`eventID` AS `eventID`, `eventattendees`.`DateRegistered` AS `DateRegistered`, `studentinfoview`.`sr_code` AS `sr_code` FROM ((`eventattendees` join `event_info` on(`event_info`.`eventID` = `eventattendees`.`eventID`)) join `studentinfoview` on(`studentinfoview`.`sr_code` = `eventattendees`.`sr_code`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_stocks`
--
ALTER TABLE `add_stocks`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`administratorID`),
  ADD KEY `fk_empid` (`empid`);

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance_tbl`
--
ALTER TABLE `attendance_tbl`
  ADD PRIMARY KEY (`AttendanceID`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`authorID`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`bookID`),
  ADD KEY `authorID` (`authorID`),
  ADD KEY `publisherID` (`publisherID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`courseID`),
  ADD KEY `dept_ID` (`dept_ID`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_ID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_data`
--
ALTER TABLE `emp_data`
  ADD PRIMARY KEY (`empid`);

--
-- Indexes for table `eventattendees`
--
ALTER TABLE `eventattendees`
  ADD PRIMARY KEY (`attendeeID`);

--
-- Indexes for table `eventrecords`
--
ALTER TABLE `eventrecords`
  ADD PRIMARY KEY (`recordID`),
  ADD KEY `superID` (`superID`),
  ADD KEY `statusID` (`eventID`(250)),
  ADD KEY `fk_eventID` (`eventID`(250));

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`eventID`),
  ADD KEY `org_ID` (`org_ID`),
  ADD KEY `statusID` (`statusID`);

--
-- Indexes for table `eventstatus`
--
ALTER TABLE `eventstatus`
  ADD PRIMARY KEY (`statusID`);

--
-- Indexes for table `faculty_tbl`
--
ALTER TABLE `faculty_tbl`
  ADD PRIMARY KEY (`FacultyID`);

--
-- Indexes for table `librarian`
--
ALTER TABLE `librarian`
  ADD PRIMARY KEY (`libID`),
  ADD KEY `fk_empid_librarian` (`empid`);

--
-- Indexes for table `lost_items`
--
ALTER TABLE `lost_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`Userid`),
  ADD KEY `student_id` (`StudentId`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`org_ID`),
  ADD KEY `superID` (`superID`),
  ADD KEY `dept_ID` (`dept_ID`);

--
-- Indexes for table `out_stocks`
--
ALTER TABLE `out_stocks`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`publisherID`);

--
-- Indexes for table `security_lostnfound`
--
ALTER TABLE `security_lostnfound`
  ADD PRIMARY KEY (`UserId`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`sr_code`),
  ADD KEY `courseID` (`courseID`),
  ADD KEY `stud_id` (`stud_id`);

--
-- Indexes for table `students_tbl`
--
ALTER TABLE `students_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_lostnfound`
--
ALTER TABLE `student_lostnfound`
  ADD PRIMARY KEY (`StudentId`);

--
-- Indexes for table `student_tbl`
--
ALTER TABLE `student_tbl`
  ADD PRIMARY KEY (`StudentID`);

--
-- Indexes for table `stud_data`
--
ALTER TABLE `stud_data`
  ADD PRIMARY KEY (`studid`);

--
-- Indexes for table `superusers`
--
ALTER TABLE `superusers`
  ADD PRIMARY KEY (`superID`);

--
-- Indexes for table `tbemployee`
--
ALTER TABLE `tbemployee`
  ADD PRIMARY KEY (`empid`);

--
-- Indexes for table `tb_studentinfo`
--
ALTER TABLE `tb_studentinfo`
  ADD PRIMARY KEY (`studid`);

--
-- Indexes for table `updatelog`
--
ALTER TABLE `updatelog`
  ADD PRIMARY KEY (`updateID`);

--
-- Indexes for table `usere`
--
ALTER TABLE `usere`
  ADD PRIMARY KEY (`UserEID`),
  ADD KEY `fk_empid` (`empid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserSID`),
  ADD KEY `fk_studid` (`SR-Code`);

--
-- Indexes for table `userstudents`
--
ALTER TABLE `userstudents`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `sr_code` (`sr_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_stocks`
--
ALTER TABLE `add_stocks`
  MODIFY `Product_ID` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `announcement`
--
ALTER TABLE `announcement`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attendance_tbl`
--
ALTER TABLE `attendance_tbl`
  MODIFY `AttendanceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `authorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `bookID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `courseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `dept_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emp_data`
--
ALTER TABLE `emp_data`
  MODIFY `empid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eventattendees`
--
ALTER TABLE `eventattendees`
  MODIFY `attendeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `eventrecords`
--
ALTER TABLE `eventrecords`
  MODIFY `recordID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `eventID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `eventstatus`
--
ALTER TABLE `eventstatus`
  MODIFY `statusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `faculty_tbl`
--
ALTER TABLE `faculty_tbl`
  MODIFY `FacultyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `librarian`
--
ALTER TABLE `librarian`
  MODIFY `libID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lost_items`
--
ALTER TABLE `lost_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `org_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `out_stocks`
--
ALTER TABLE `out_stocks`
  MODIFY `Product_ID` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Product_ID` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `publisherID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `security_lostnfound`
--
ALTER TABLE `security_lostnfound`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2126;

--
-- AUTO_INCREMENT for table `students_tbl`
--
ALTER TABLE `students_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `student_lostnfound`
--
ALTER TABLE `student_lostnfound`
  MODIFY `StudentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_tbl`
--
ALTER TABLE `student_tbl`
  MODIFY `StudentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stud_data`
--
ALTER TABLE `stud_data`
  MODIFY `studid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `superusers`
--
ALTER TABLE `superusers`
  MODIFY `superID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_studentinfo`
--
ALTER TABLE `tb_studentinfo`
  MODIFY `studid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `updatelog`
--
ALTER TABLE `updatelog`
  MODIFY `updateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `usere`
--
ALTER TABLE `usere`
  MODIFY `UserEID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserSID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `userstudents`
--
ALTER TABLE `userstudents`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
