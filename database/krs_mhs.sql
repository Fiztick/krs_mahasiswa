-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 26, 2024 at 03:50 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `krs_mhs`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_matkul_data` (IN `p_npm` INT UNSIGNED, IN `p_semester` INT)   BEGIN
    SELECT 
        mk.`nama` AS mata_kuliah_name,
        mk.`sks` AS mata_kuliah_sks
    FROM 
        `enrollment` e
    JOIN 
        `mahasiswa` m ON e.`id_mhs` = m.`id`
    JOIN 
        `mata_kuliah` mk ON e.`id_matkul` = mk.`id`
    WHERE 
        m.`npm` = p_npm AND mk.`semester` = p_semester;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_ket_matkul` (IN `p_npm` INT UNSIGNED, IN `p_kode` VARCHAR(10))   BEGIN
    -- variabel nyimpen id
    DECLARE v_id_mhs INT;
    DECLARE v_id_matkul INT;

    -- ngambil id mhs
    SELECT `id` INTO v_id_mhs
    FROM `mahasiswa`
    WHERE `npm` = p_npm;
    
    -- ngambil id matkul
    SELECT `id` INTO v_id_matkul
    FROM `mata_kuliah`
    WHERE `kode` = p_kode;
    
    -- update disini
    UPDATE `enrollment`
    SET `ket` = 'baru'
    WHERE `id_mhs` = v_id_mhs AND `id_matkul` = v_id_matkul;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_matkul_data` (`p_npm` INT UNSIGNED, `p_semester` INT) RETURNS TEXT CHARSET utf8mb4 DETERMINISTIC BEGIN
    DECLARE result TEXT DEFAULT '';

    -- Construct the result string
    SELECT 
        CONCAT(mk.`nama`, ' - ', mk.`nama`, ' - ', mk.`sks`, ' SKS - ', mk.`semester`) INTO result
    FROM 
        `enrollment` e
    JOIN 
        `mahasiswa` m ON e.`id_mhs` = m.`id`
    JOIN 
        `mata_kuliah` mk ON e.`id_matkul` = mk.`id`
    WHERE 
        m.`npm` = p_npm AND mk.`semester` = p_semester;

    RETURN result;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_matkul_sks` (`p_npm` INT UNSIGNED, `p_semester` INT) RETURNS TEXT CHARSET utf8mb4 DETERMINISTIC BEGIN
    DECLARE result TEXT DEFAULT '';

    -- buat ngegabungin data matkul
    SELECT 
        CONCAT(mk.`kode`, " - ", mk.`nama`, " - ", mk.`sks`, " SKS - ", mk.`semester`) INTO result
    FROM 
        `enrollment` e
    JOIN 
        `mahasiswa` m ON e.`id_mhs` = m.`id`
    JOIN 
        `mata_kuliah` mk ON e.`id_matkul` = mk.`id`
    WHERE 
        m.`npm` = p_npm AND e.`semester` = p_semester;

    RETURN result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `id` int NOT NULL,
  `id_mhs` int NOT NULL,
  `id_matkul` int NOT NULL,
  `nilai` int DEFAULT '0',
  `tahun_ajaran` int NOT NULL,
  `ket` enum('baru','lama') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`id`, `id_mhs`, `id_matkul`, `nilai`, `tahun_ajaran`, `ket`) VALUES
(1, 1, 1, 0, 2024, 'baru'),
(2, 1, 2, 0, 2024, 'baru'),
(3, 1, 3, 0, 2024, 'baru'),
(4, 1, 4, 0, 2024, 'baru'),
(5, 1, 5, 0, 2024, 'baru'),
(6, 1, 6, 0, 2024, 'baru'),
(7, 1, 7, 0, 2024, 'baru'),
(8, 1, 8, 0, 2024, 'baru'),
(9, 1, 9, 0, 2024, 'baru'),
(10, 1, 10, 0, 2024, 'baru'),
(11, 2, 1, 0, 2024, 'baru'),
(12, 2, 2, 0, 2024, 'baru'),
(13, 2, 3, 0, 2024, 'baru'),
(14, 2, 4, 0, 2024, 'baru'),
(15, 2, 5, 0, 2024, 'baru'),
(16, 2, 6, 0, 2024, 'baru'),
(17, 2, 7, 0, 2024, 'baru'),
(18, 2, 8, 0, 2024, 'baru'),
(19, 2, 9, 0, 2024, 'baru'),
(20, 2, 10, 0, 2024, 'baru'),
(21, 3, 1, 0, 2024, 'baru'),
(22, 3, 2, 0, 2024, 'baru'),
(23, 3, 3, 0, 2024, 'baru'),
(24, 3, 4, 0, 2024, 'baru'),
(25, 3, 5, 0, 2024, 'baru'),
(26, 3, 6, 0, 2024, 'baru'),
(27, 3, 7, 0, 2024, 'baru'),
(28, 3, 8, 0, 2024, 'baru'),
(29, 3, 9, 0, 2024, 'baru'),
(30, 3, 10, 0, 2024, 'baru'),
(31, 1, 1, 0, 2024, 'baru'),
(32, 26, 13, 90, 2024, 'baru');

-- --------------------------------------------------------

--
-- Stand-in structure for view `enroll_mhs`
-- (See below for the actual view)
--
CREATE TABLE `enroll_mhs` (
`mahasiswa_name` varchar(255)
,`mahasiswa_npm` varchar(10)
,`mata_kuliah_name` varchar(255)
,`mata_kuliah_sks` int
);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id` int NOT NULL,
  `npm` varchar(10) DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `prodi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id`, `npm`, `nama`, `prodi`) VALUES
(1, '2007411020', 'Hafiz', 'TI'),
(2, '2007411021', 'Kevin', 'TI'),
(3, '2007411022', 'John', 'TI'),
(26, '2024.00006', 'Juansyah', 'TI');

--
-- Triggers `mahasiswa`
--
DELIMITER $$
CREATE TRIGGER `before_insert_mahasiswa` BEFORE INSERT ON `mahasiswa` FOR EACH ROW BEGIN
    DECLARE tahun VARCHAR(4);
    DECLARE next_number INT;
    DECLARE new_npm VARCHAR(10);

    -- ambil tahun skrng
    SET tahun = YEAR(CURDATE());

    -- nyimpen data ke angka selanjutnya
    SET @next_number = (
        SELECT LPAD(COUNT(*) + 1, 5, '0')
        FROM mahasiswa
        WHERE SUBSTRING(npm, 1, 4) = tahun
    );

    -- buat npm baru
    SET new_npm = CONCAT(tahun, '.', @next_number);

    -- insert disini
    SET NEW.`npm` = new_npm;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id` int NOT NULL,
  `kode` varchar(10) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `sks` int NOT NULL,
  `semester` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id`, `kode`, `nama`, `sks`, `semester`) VALUES
(1, 'BD103', 'Pendidikan Kewarganegaraan', 2, 1),
(2, 'BD103.1', 'Pendidikan Moral Pancasila', 3, 1),
(3, 'BD105', 'Pendidikan Agama', 3, 1),
(4, 'BD106', 'Bahasa Indonesia', 3, 1),
(5, 'BD201.1', 'Anatomi Fisiologi', 3, 1),
(6, 'BD202.1', 'Biokimia dan Fisika Kesehatan', 2, 1),
(7, 'BD203.1', 'Biorep dan Mikrobiologi', 2, 1),
(8, 'BD317.1', 'Keterampilan Dasar Kebidanan 1', 3, 1),
(9, 'BD407', 'Humaniora', 2, 1),
(10, 'BD505', 'Alqur\'an Hadist', 1, 1),
(13, 'BD404', 'Programming', 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'hafiz', 'hafiz@gmail.com', NULL, '$2y$12$eIYDmY4hr.eC27fhVjhkNe3sjoQcn6oTj5GY0rhSoDjINaDLED81O', 'n1yxIfoRw8ivaUjAHt4F65MXD6PNtBvXYJo7aNOgtezZzkQBPyOK2jBlXnwK', '2024-08-25 02:41:14', '2024-08-25 02:41:14');

-- --------------------------------------------------------

--
-- Structure for view `enroll_mhs`
--
DROP TABLE IF EXISTS `enroll_mhs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `enroll_mhs`  AS SELECT `m`.`nama` AS `mahasiswa_name`, `m`.`npm` AS `mahasiswa_npm`, `mk`.`nama` AS `mata_kuliah_name`, `mk`.`sks` AS `mata_kuliah_sks` FROM ((`enrollment` `e` join `mahasiswa` `m` on((`e`.`id_mhs` = `m`.`id`))) join `mata_kuliah` `mk` on((`e`.`id_matkul` = `mk`.`id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mhs` (`id_mhs`),
  ADD KEY `id_matkul` (`id_matkul`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `npm_unique` (`npm`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_unique` (`kode`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`id_mhs`) REFERENCES `mahasiswa` (`id`),
  ADD CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`id_matkul`) REFERENCES `mata_kuliah` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
