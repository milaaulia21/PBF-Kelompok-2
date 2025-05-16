-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for db_sidangskripsi
CREATE DATABASE IF NOT EXISTS `db_sidangskripsi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_sidangskripsi`;

-- Dumping structure for table db_sidangskripsi.dosen
CREATE TABLE IF NOT EXISTS `dosen` (
  `id_dosen` int NOT NULL AUTO_INCREMENT,
  `nama_dosen` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nip` int NOT NULL,
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_dosen`) USING BTREE,
  KEY `id_user` (`id_user`),
  CONSTRAINT `FK_dosen_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table db_sidangskripsi.dosen: ~2 rows (approximately)
INSERT INTO `dosen` (`id_dosen`, `nama_dosen`, `nip`, `id_user`) VALUES
	(20, 'Prih Diantono Abda`u', 123456789, 44),
	(21, 'Vika Nurul ', 123123123, 45);

-- Dumping structure for table db_sidangskripsi.dosen_penguji
CREATE TABLE IF NOT EXISTS `dosen_penguji` (
  `id_penguji` int NOT NULL AUTO_INCREMENT,
  `id_sidang` int NOT NULL,
  `id_dosen` int NOT NULL,
  `peran` enum('PENGUJI 1','PENGUJI 2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_penguji`) USING BTREE,
  UNIQUE KEY `unique_sidang_dosen` (`id_sidang`,`id_dosen`) USING BTREE,
  KEY `fk_dosen` (`id_dosen`) USING BTREE,
  CONSTRAINT `fk_dosen` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sidang` FOREIGN KEY (`id_sidang`) REFERENCES `sidang` (`id_sidang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table db_sidangskripsi.dosen_penguji: ~4 rows (approximately)
INSERT INTO `dosen_penguji` (`id_penguji`, `id_sidang`, `id_dosen`, `peran`) VALUES
	(27, 15, 20, 'PENGUJI 1'),
	(28, 15, 21, 'PENGUJI 2'),
	(29, 16, 20, 'PENGUJI 1'),
	(30, 16, 21, 'PENGUJI 2');

-- Dumping structure for table db_sidangskripsi.mahasiswa
CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `id_mhs` int NOT NULL AUTO_INCREMENT,
  `nama_mhs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nim` int NOT NULL,
  `prodi_mhs` enum('D3 TI','D4 RKS','D4 ALKS','D4 TRM','D4 RPL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `thn_akademik` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `judul_skripsi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id_mhs`) USING BTREE,
  KEY `id_user` (`id_user`),
  CONSTRAINT `FK_mahasiswa_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table db_sidangskripsi.mahasiswa: ~1 rows (approximately)
INSERT INTO `mahasiswa` (`id_mhs`, `nama_mhs`, `nim`, `prodi_mhs`, `thn_akademik`, `judul_skripsi`, `id_user`) VALUES
	(73, 'Bikra Abna Filqiyast Dzakii', 230302005, 'D3 TI', '2025/2026', 'Pembuatan Sistem E-Farmer Analisa Cuaca dan Harga Pasar Dari Hasil Panen untuk Membantu Pertanian Pe', 43);

-- Dumping structure for table db_sidangskripsi.ruangan
CREATE TABLE IF NOT EXISTS `ruangan` (
  `id_ruangan` int NOT NULL AUTO_INCREMENT,
  `kode_ruangan` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_ruangan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_ruangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table db_sidangskripsi.ruangan: ~4 rows (approximately)
INSERT INTO `ruangan` (`id_ruangan`, `kode_ruangan`, `nama_ruangan`) VALUES
	(20, 'I.5.1', 'Auditorium'),
	(21, 'J.4.4', 'Lab Teknologi Jaringan'),
	(22, 'J.5.2', 'Lab Design Grafis'),
	(23, 'I.3.1', 'Ruang Teori');

-- Dumping structure for table db_sidangskripsi.sidang
CREATE TABLE IF NOT EXISTS `sidang` (
  `id_sidang` int NOT NULL AUTO_INCREMENT,
  `id_mhs` int NOT NULL,
  `id_ruangan` int NOT NULL,
  `tanggal_sidang` date NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `status` enum('DITUNDA','DIJADWALKAN','DIBATALKAN') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_sidang`) USING BTREE,
  KEY `fk_mhs` (`id_mhs`) USING BTREE,
  KEY `fk_ruangan` (`id_ruangan`) USING BTREE,
  CONSTRAINT `fk_mhs` FOREIGN KEY (`id_mhs`) REFERENCES `mahasiswa` (`id_mhs`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table db_sidangskripsi.sidang: ~2 rows (approximately)
INSERT INTO `sidang` (`id_sidang`, `id_mhs`, `id_ruangan`, `tanggal_sidang`, `waktu_mulai`, `waktu_selesai`, `status`) VALUES
	(15, 73, 20, '2026-01-01', '08:00:00', '09:00:00', 'DITUNDA'),
	(16, 73, 20, '2026-01-01', '10:00:00', '11:00:00', 'DIJADWALKAN');

-- Dumping structure for table db_sidangskripsi.user
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` enum('mahasiswa','dosen') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'mahasiswa',
  `isAdmin` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_sidangskripsi.user: ~3 rows (approximately)
INSERT INTO `user` (`id_user`, `username`, `password`, `role`, `isAdmin`) VALUES
	(43, 'admin', '$2y$12$O1L8NoO9N7YnVduIHFz02eJwulvWK1gEmAGkdVy5tZNzzi1S2uvdK', 'mahasiswa', 'Y'),
	(44, 'Dosen 1', '$2y$12$sJ37rO5HoSp3yFhZ6a/2G.HGyZOQBdOpB6tIXbCD9YqFn6WsPeNBW', 'dosen', 'N'),
	(45, 'Dosen 2', '$2y$12$5.FIhvr7lVKDUbQEYWfzYO7FMPIfhYHA7SaUPJHSSwdqsx48/7qba', 'dosen', 'N');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
