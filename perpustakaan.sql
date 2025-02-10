-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 10, 2025 at 02:18 PM
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
-- Database: `perpustakaan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBuku` (IN `idBuku` INT)   BEGIN
    DELETE FROM buku WHERE id_buku = idBuku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePeminjaman` (IN `p_id_peminjaman` INT)   BEGIN
    DELETE FROM peminjaman WHERE ID_Peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSiswa` (IN `idSiswa` INT)   BEGIN
    DELETE FROM siswa WHERE id_siswa = idSiswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBuku` (IN `judul_bukuBaru` VARCHAR(50), IN `penulisBaru` VARCHAR(50), IN `kategoribaru` VARCHAR(50), IN `stokBaru` INT)   BEGIN
INSERT INTO buku (judul_buku, penulis, kategori, stok) 
VALUES (judul_bukuBaru, penulisBaru, kategoriBaru, stokBaru);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPeminjaman` (IN `id_siswaBaru` INT, IN `id_bukuBaru` INT, IN `tanggal_pinjamBaru` DATE, IN `tanggal_kembaliBaru` DATE, IN `statusBaru` VARCHAR(50))   BEGIN
INSERT INTO peminjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) 
VALUES (id_siswaBaru, id_bukuBaru, tanggal_pinjamBaru,tanggal_kembaliBaru,statusBaru);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSiswa` (IN `namaBaru` VARCHAR(50), IN `kelasBaru` VARCHAR(50))   BEGIN
INSERT INTO siswa (nama, kelas) 
VALUES (namaBaru, kelasBaru);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `returnBuku` (IN `p_id_peminjaman` INT)   BEGIN
    UPDATE peminjaman 
    SET tanggal_kembali = CURRENT_DATE, 
        status = 'Dikembalikan'
    WHERE id_peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllBuku` ()   BEGIN
    SELECT b.id_buku, b.judul_buku, b.penulis, b.kategori, b.stok, 
           IFNULL(COUNT(p.id_peminjaman), 0) AS jumlah_dipinjam
    FROM buku b
    LEFT JOIN peminjaman p ON b.id_buku = p.id_buku
    GROUP BY b.id_buku, b.judul_buku, b.penulis, b.kategori, b.stok;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllSiswa` ()   BEGIN
    SELECT s.id_siswa, s.nama, s.kelas, 
           IFNULL(COUNT(p.id_peminjaman), 0) AS jumlah_peminjaman
    FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa
    GROUP BY s.id_siswa, s.nama, s.kelas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showBuku` ()   BEGIN
SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showPeminjaman` ()   BEGIN
SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showSiswa` ()   BEGIN
SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showSiswaPeminjam` ()   BEGIN
    SELECT DISTINCT s.id_siswa, s.nama, s.kelas
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBuku` (IN `idBuku` INT, IN `judulBaru` VARCHAR(50), IN `penulisBaru` VARCHAR(50), IN `kategoriBaru` VARCHAR(50), IN `stokBaru` INT)   BEGIN
    UPDATE buku 
    SET judul_buku = judulBaru, 
        penulis = penulisBaru, 
        kategori = kategoriBaru, 
        stok = stokBaru
    WHERE id_buku = idBuku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePeminjaman` (IN `p_id_peminjaman` INT, IN `p_id_siswa` INT, IN `p_id_buku` INT, IN `p_tanggal_pinjam` DATE, IN `p_tanggal_kembali` DATE, IN `p_status` VARCHAR(50))   BEGIN
    UPDATE peminjaman 
    SET ID_Siswa = p_id_siswa, id_buku = p_id_buku, 
        Tanggal_Pinjam = p_tanggal_pinjam, 
        Tanggal_Kembali = p_tanggal_kembali, 
        Status = p_status
    WHERE ID_Peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSiswa` (IN `idSiswa` INT, IN `namaBaru` VARCHAR(50), IN `kelasBaru` VARCHAR(50))   BEGIN
    UPDATE siswa 
    SET nama = namaBaru, 
        kelas = kelasBaru
    WHERE id_siswa = idSiswa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int NOT NULL,
  `judul_buku` varchar(50) DEFAULT NULL,
  `penulis` varchar(50) DEFAULT NULL,
  `kategori` varchar(30) DEFAULT NULL,
  `stok` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Makanan Tradisional', 'Ghifari', 'Kuliner', 200),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 10),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int NOT NULL,
  `id_siswa` int DEFAULT NULL,
  `id_buku` int DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-10', 'Dikembalikan'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `after_peminjaman_insert` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku 
    SET stok = stok - 1
    WHERE id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_peminjaman_update` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    -- Jika status berubah menjadi "Dikembalikan", tambahkan stok
    IF OLD.status = 'Dipinjam' AND NEW.status = 'Dikembalikan' THEN
        UPDATE buku 
        SET stok = stok + 1
        WHERE id_buku = NEW.id_buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `kelas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
