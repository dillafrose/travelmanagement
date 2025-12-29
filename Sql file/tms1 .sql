

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tms1`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Name` varchar(250) DEFAULT NULL,
  `EmailId` varchar(250) DEFAULT NULL,
  `MobileNumber` varchar(15) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `updationDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `UserName`, `Name`, `EmailId`, `MobileNumber`, `Password`, `updationDate`) VALUES
(1, 'admin', 'Administrator', 'test@gmail.com', 242424, 'blee101', '2024-01-10 11:18:49');

-- --------------------------------------------------------

--
-- Table structure for table `tblbooking`
--

CREATE TABLE `tblbooking` (
  `BookingId` int(11) NOT NULL,
  `PackageId` int(11) DEFAULT NULL,
  `UserEmail` varchar(100) DEFAULT NULL,
  `FromDate` varchar(100) DEFAULT NULL,
  `ToDate` varchar(100) DEFAULT NULL,
  `Comment` mediumtext DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL,
  `CancelledBy` varchar(5) DEFAULT NULL,
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblbooking`
--

INSERT INTO `tblbooking` (`BookingId`, `PackageId`, `UserEmail`, `FromDate`, `ToDate`, `Comment`, `RegDate`, `status`, `CancelledBy`, `UpdationDate`) VALUES
(7, 10, 'dill@gmail.com', '2025-12-07', '2025-12-09', 'I want this package.', '2025-12-05 18:31:31', 1, NULL, '2025-12-05 18:38:00'),
(8, 10, 'dill@gmail.com', '2025-12-07', '2025-12-09', 'For my friend.', '2025-12-05 18:32:01', 2, 'a', '2025-12-05 18:38:03');

-- --------------------------------------------------------

--
-- Table structure for table `tblcustompackages`
--

CREATE TABLE `tblcustompackages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `base_package_id` int(11) DEFAULT NULL,
  `package_type` varchar(100) DEFAULT NULL,
  `package_features` text DEFAULT NULL,
  `custom_request` text DEFAULT NULL,
  `people_count` int(11) NOT NULL DEFAULT 1,
  `transport_type` varchar(50) DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblenquiry`
--

CREATE TABLE `tblenquiry` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `MobileNumber` char(10) DEFAULT NULL,
  `Subject` varchar(100) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `Status` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblenquiry`
--

INSERT INTO `tblenquiry` (`id`, `FullName`, `EmailId`, `MobileNumber`, `Subject`, `Description`, `PostingDate`, `Status`) VALUES
(6, 'Shopnil', 'shopnil@gmail.com', '000000', 'About new tour update', 'I want to know about the new tour added for Saint Martin. Can you please explain the travel full details.', '2025-12-05 18:37:20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblissues`
--

CREATE TABLE `tblissues` (
  `id` int(11) NOT NULL,
  `UserEmail` varchar(100) DEFAULT NULL,
  `Issue` varchar(100) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `AdminRemark` mediumtext DEFAULT NULL,
  `AdminremarkDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblissues`
--

INSERT INTO `tblissues` (`id`, `UserEmail`, `Issue`, `Description`, `PostingDate`, `AdminRemark`, `AdminremarkDate`) VALUES
(15, NULL, NULL, NULL, '2025-12-05 18:30:00', NULL, NULL),
(16, NULL, NULL, NULL, '2025-12-05 18:30:43', NULL, NULL),
(17, 'dill@gmail.com', 'Refund', 'I want refund for the second booking I make.', '2025-12-05 18:33:11', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblissuess`
--

CREATE TABLE `tblissuess` (
  `ID` int(11) NOT NULL,
  `UserEmail` varchar(100) NOT NULL,
  `PackageName` varchar(255) NOT NULL,
  `BookingType` varchar(50) NOT NULL,
  `Transport` varchar(50) NOT NULL,
  `Features` text NOT NULL,
  `Members` varchar(50) NOT NULL,
  `SubmittedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `AdminRemark` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblissuess`
--

INSERT INTO `tblissuess` (`ID`, `UserEmail`, `PackageName`, `BookingType`, `Transport`, `Features`, `Members`, `SubmittedAt`, `AdminRemark`) VALUES
(7, 'abeer@gmail.com', 'Tangail', 'Family', 'Train', 'dsf', '3', '2025-12-12 04:41:14', 'got it.'),
(8, 'dill@gmail.com', 'Sherpur', 'Family', 'Bus', 'hotel', '3', '2025-12-12 08:35:59', NULL),
(9, 'dill@gmail.com', 'dhaka', 'Group', 'Train', 'hotel', '8', '2025-12-13 04:41:27', 'possible');

-- --------------------------------------------------------

--
-- Table structure for table `tblpackagecomponents`
--

CREATE TABLE `tblpackagecomponents` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblpackage_items`
--

CREATE TABLE `tblpackage_items` (
  `id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `component_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblpages`
--

CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT '',
  `detail` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblpages`
--

INSERT INTO `tblpages` (`id`, `type`, `detail`) VALUES
(1, 'terms', '																																																																						<p align=\"justify\"><span id=\"docs-internal-guid-ecf1443e-7fff-b53a-def6-448707a8e9ec\"><span style=\"font-family: Arial, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-variant-position: normal; font-variant-emoji: normal; vertical-align: baseline; white-space-collapse: preserve; font-size: x-large;\">By accessing or using GOPlan Tours, you agree to comply with these Terms &amp; Conditions, which govern bookings, payments, cancellations, and user responsibilities. All bookings are subject to availability, and cancellations may incur fees as per the specified policy. Users must provide accurate information, safeguard their accounts, and adhere to travel regulations. The system’s content is protected by intellectual property laws, and unauthorized use is prohibited. GOPlan Tours is not liable for third-party services, travel disruptions, or user errors. We may update these terms at any time, and continued use constitutes acceptance. For details on data handling, please review our Privacy Policy.</span></span></p>\r\n										\r\n										\r\n										\r\n										\r\n										\r\n										\r\n										'),
(2, 'privacy', '										<span id=\"docs-internal-guid-7cce6a09-7fff-692a-5ecd-aaa59b972817\"><span style=\"font-family: &quot;Courier New&quot;, monospace; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-variant-position: normal; font-variant-emoji: normal; vertical-align: baseline; white-space-collapse: preserve; font-size: x-large;\">At GoPlan Tours, we value your privacy and are committed to protecting your personal information. When you use our tour management services, we may collect data such as your name, email, contact number, travel preferences, and payment details (processed securely through third-party providers). This information helps us manage bookings, personalize your experience, and improve our services. We do not sell your data, and we only share it with trusted partners involved in fulfilling your travel arrangements or as required by law. We use secure technologies like SSL encryption to safeguard your data. Our website may also use cookies to enhance user experience and monitor usage trends, which you can manage via your browser settings. By using our services, you agree to our data practices. If you have any concerns or wish to access, update, or delete your information, please contact us at goplantours@gmail.com</span></span>\r\n										'),
(3, 'aboutus', '																														<div><span style=\"color: rgb(0, 0, 0); font-family: Georgia; text-align: justify; font-weight: bold; font-size: x-large;\">Welcome to Go Plan Tours!!!</span></div><span id=\"docs-internal-guid-a33d80d5-7fff-0a75-86be-d62e42ba31ec\"><span style=\"font-size: x-large;\"><br></span><p dir=\"ltr\" style=\"line-height:1.3800000000000001;margin-top:12pt;margin-bottom:12pt;\"><span style=\"font-family: &quot;Courier New&quot;, monospace; color: rgb(0, 0, 0); font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-variant-position: normal; font-variant-emoji: normal; vertical-align: baseline; white-space-collapse: preserve; font-size: x-large;\">Your reliable partner in organizing memorable travel experiences. Our website is designed to simplify the process of discovering, selecting, and booking tour packages that suit your preferences and budget. Whether you\'re looking for adventure, relaxation, or cultural exploration, we offer a variety of curated travel options to help you plan the perfect trip. With a focus on user-friendly features, secure booking, and up-to-date information, our goal is to make travel planning easy, efficient, and enjoyable. Let us help you turn your travel dreams into reality.</span></p></span>\r\n										'),
(11, 'contact', '																				<span id=\"docs-internal-guid-1d0e50e4-7fff-d0e9-5fe6-76d6b040aae1\"><p dir=\"ltr\" style=\"line-height:1.3800000000000001;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: &quot;Courier New&quot;, monospace; color: rgb(0, 0, 0); font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-variant-position: normal; font-variant-emoji: normal; vertical-align: baseline; white-space-collapse: preserve; font-size: x-large;\">Address: Namapara, Khilkhet, Dhaka 1216 \r\nEmail: goplantours@gmail.com</span></p><div><span style=\"font-size: 10.5pt; font-family: &quot;Courier New&quot;, monospace; color: rgb(0, 0, 0); font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-variant-position: normal; font-variant-emoji: normal; vertical-align: baseline; white-space-collapse: preserve;\"><br></span></div></span>\r\n										\r\n										');

-- --------------------------------------------------------

--
-- Table structure for table `tbltourpackages`
--

CREATE TABLE `tbltourpackages` (
  `PackageId` int(11) NOT NULL,
  `PackageName` varchar(200) DEFAULT NULL,
  `PackageType` varchar(150) DEFAULT NULL,
  `PackageLocation` varchar(100) DEFAULT NULL,
  `PackagePrice` int(11) DEFAULT NULL,
  `PackageFetures` varchar(255) DEFAULT NULL,
  `PackageDetails` mediumtext DEFAULT NULL,
  `PackageImage` varchar(100) DEFAULT NULL,
  `Creationdate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbltourpackages`
--

INSERT INTO `tbltourpackages` (`PackageId`, `PackageName`, `PackageType`, `PackageLocation`, `PackagePrice`, `PackageFetures`, `PackageDetails`, `PackageImage`, `Creationdate`, `UpdationDate`) VALUES
(10, 'Sitakunda Tour', 'Group Package', 'Sitakunda , Chattagram', 1000, 'One night, two days group tour includes breakfast, lunch, and bus travel.', 'Pick this holiday for a relaxing vacation in Paris and Switzerland. Your tour embarks from Paris. Enjoy an excursion to popular attractions like the iconic Eiffel Tower. After experiencing the beautiful city, you will drive past mustard fields through Burgundy to reach Switzerland. While there, you can opt for a tour to Interlaken and then to the Trummelbach Falls. Photostop at Zurich Lake and a cable car ride to Mt. Titlis are the main highlights of the holiday.', 'blogOiW-acszVvd-5gK5vw4bSj284bghdic8.jpg', '2024-07-14 23:21:58', '2025-04-21 09:35:11'),
(11, 'Cox’s Bazar Beach', 'Group Package', 'Cox’s Bazar ', 2999, 'Cox’s Bazar Sea Beach --Laboni & Sugandha Point -- Evening Beach Walk -- Optional Himchari/Inani Trip', 'Escape to the world\'s longest beach! Feel the sand beneath your feet, enjoy the ocean breeze, and take in unforgettable sunsets. A perfect weekend getaway for sea lovers and peace seekers.\r\n???? Tour Highlights:\r\n•	Cox’s Bazar Sea Beach\r\n•	Laboni & Sugandha Point\r\n•	Evening Beach Walk\r\n•	Optional Himchari/Inani Trip\r\n???? Package Includes:\r\n•	AC/Non-AC Bus (Round Trip Dhaka–Cox’s Bazar)\r\n•	1 Night Stay at Hotel Sea Crown\r\n•	Complimentary Breakfast & Dinner\r\n•	Group Fun & Tour Guide Support\r\n? Excludes:\r\n•	Personal Expenses\r\n•	Lunch & Beach Rides\r\n•	Entry Fees (if applicable)\r\n???? Booking Hotline: +880 1777 620 229\r\n\r\n', 'cox.jpeg', '2025-04-21 12:06:56', NULL),
(12, 'Sajek Valley Adventure ', 'Group Package', 'Sajek', 4999, 'Sajek Valley & Konglak Para -- >Helipad Sunset/Sunrise Views --->  Adventure Ride on Chander Gari', 'Take a breath above the clouds in the magical hills of Sajek. Known for its dreamlike beauty and tribal hospitality, this trip is your escape into nature’s peaceful embrace and starry skies.\r\n???? Package Includes:\r\n•	Dhaka–Khagrachari Bus (AC/Non-AC)\r\n•	Chander Gari to Sajek\r\n•	1 Night at Meghpunji Resort\r\n•	3 Meals: Lunch, Dinner, Breakfast\r\n•	Campfire, Group Activities, Tour Guide\r\n? Excludes:\r\n•	Personal Purchases\r\n•	Entry Fees\r\n•	Optional Photography or Snacks\r\n???? Book Now: +880 1777 620 229\r\n', 'sajek.jpeg', '2025-04-21 12:18:07', NULL),
(13, 'Bandarban Tour Package', 'Group Package', 'Bandarban', 5000, 'Three night, two days group tour includes breakfast, lunch, and bus travel.', 'Bandarban  is a district in South-Eastern Bangladesh, and a part of the Chittagong Division. It is one of the three hill districts of Bangladesh and a part of the Chittagong Hill Tracts, the others being Rangamati District and Khagrachhari District. Bandarban district (4,479 km2) is not only the most remote district of the country, but also the least populous (population 388,000). There is an army contingent at Bandarban Cantonment.\r\n\r\nBandarban town is the hometown of the Bohmong Chief (Raja) U Cho Prue  who is the head of the Bohmong Circle. Of the other hill districts, Rangamati is the Chakma Circle, headed by Raja Devasish Roy and Khagrachari is the Mong Circle, headed by Raja Sachingprue Marma . Bandarban is regarded as one of the most attractive travel destinations in Bangladesh. It also is the administrative headquarters of Bandarban district, which has turned into one of the most exotic tourist attractions in Bangladesh.\r\n\r\n[ Enjoy the gentle breeze passing through the hills of Nilgiri\r\nExperience the naturally purified Shoilo Propat Waterfall.\r\nGet the thrill of Zigzag roads of Chimbuk going on the Chander Gari or CNG\r\nDiscover the exquisite and delicate beauty of the Meghla.\r\nWitness the golden sunset of Nilachal. ]', 'bandarban.webp', '2025-05-05 08:19:21', '2025-05-05 08:26:16'),
(14, 'Saint Martin Island', 'Group Package', 'Saint Martin', 7000, 'Three night, two days group tour includes breakfast, lunch, and bus travel. ', 'Nestled in the blue waters of the Bay of Bengal, Saint Martin Island is the only coral island in Bangladesh, and it offers a stunning mix of natural beauty and marine adventure. Located about 9 kilometers south of the Cox’s Bazar-Teknaf peninsula, this small island is only about 8 square kilometers in size, but its pristine beaches, crystal-clear waters, and unique biodiversity make it a popular tourist spot for locals and foreigners alike.', 'stmartine1.png', '2025-05-05 08:31:01', NULL);

-- --------------------------------------------------------



CREATE TABLE `tblusers` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `MobileNumber` char(10) DEFAULT NULL,
  `EmailId` varchar(70) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`id`, `FullName`, `MobileNumber`, `EmailId`, `Password`, `RegDate`, `UpdationDate`) VALUES
(12, 'Jakia', '00000', 'jakia@gmail.com', '0001pass', '2025-12-05 17:37:45', NULL),
(13, 'Ifterkhar Ahmed', '111111', 'Iftekhar@gmail.com', '0002pass', '2025-12-05 18:30:00', NULL),
(14, 'Dill Afrose', '22222', 'dill@gmail.com', '0003pass', '2025-12-05 18:30:43', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbooking`
--
ALTER TABLE `tblbooking`
  ADD PRIMARY KEY (`BookingId`);

--
-- Indexes for table `tblcustompackages`
--
ALTER TABLE `tblcustompackages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_base_package` (`base_package_id`);

--
-- Indexes for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblissues`
--
ALTER TABLE `tblissues`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblissuess`
--
ALTER TABLE `tblissuess`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblpackagecomponents`
--
ALTER TABLE `tblpackagecomponents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblpackage_items`
--
ALTER TABLE `tblpackage_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `package_id` (`package_id`),
  ADD KEY `component_id` (`component_id`);

--
-- Indexes for table `tblpages`
--
ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbltourpackages`
--
ALTER TABLE `tbltourpackages`
  ADD PRIMARY KEY (`PackageId`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EmailId` (`EmailId`),
  ADD KEY `EmailId_2` (`EmailId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblbooking`
--
ALTER TABLE `tblbooking`
  MODIFY `BookingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tblcustompackages`
--
ALTER TABLE `tblcustompackages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tblissues`
--
ALTER TABLE `tblissues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tblissuess`
--
ALTER TABLE `tblissuess`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tblpackagecomponents`
--
ALTER TABLE `tblpackagecomponents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblpackage_items`
--
ALTER TABLE `tblpackage_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblpages`
--
ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tbltourpackages`
--
ALTER TABLE `tbltourpackages`
  MODIFY `PackageId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblcustompackages`
--
ALTER TABLE `tblcustompackages`
  ADD CONSTRAINT `fk_base_package` FOREIGN KEY (`base_package_id`) REFERENCES `tbltourpackages` (`PackageId`),
  ADD CONSTRAINT `tblcustompackages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tblusers` (`id`);

--
-- Constraints for table `tblpackage_items`
--
ALTER TABLE `tblpackage_items`
  ADD CONSTRAINT `tblpackage_items_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `tblcustompackages` (`id`),
  ADD CONSTRAINT `tblpackage_items_ibfk_2` FOREIGN KEY (`component_id`) REFERENCES `tblpackagecomponents` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
