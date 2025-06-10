-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:9000
-- Waktu pembuatan: 05 Jun 2025 pada 05.05
-- Versi server: 8.0.30
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_sidangskripsi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int NOT NULL,
  `nama_dosen` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nip` int NOT NULL,
  `id_user` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nama_dosen`, `nip`, `id_user`) VALUES
(20, 'Prih Diantono Abda`u', 123456789, 44),
(21, 'Vika Nurul ', 123123123, 45);

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen_penguji`
--

CREATE TABLE `dosen_penguji` (
  `id_penguji` int NOT NULL,
  `id_sidang` int NOT NULL,
  `id_dosen` int NOT NULL,
  `peran` enum('PENGUJI 1','PENGUJI 2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `dosen_penguji`
--

INSERT INTO `dosen_penguji` (`id_penguji`, `id_sidang`, `id_dosen`, `peran`) VALUES
(27, 15, 20, 'PENGUJI 1'),
(28, 15, 21, 'PENGUJI 2'),
(29, 16, 20, 'PENGUJI 1'),
(30, 16, 21, 'PENGUJI 2');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mhs` int NOT NULL,
  `nama_mhs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nim` int NOT NULL,
  `prodi_mhs` enum('D3 TI','D4 RKS','D4 ALKS','D4 TRM','D4 RPL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `thn_akademik` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `judul_skripsi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_user` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mhs`, `nama_mhs`, `nim`, `prodi_mhs`, `thn_akademik`, `judul_skripsi`, `id_user`) VALUES
(73, 'Bikra Abna Filqiyast Dzakii', 230302005, 'D3 TI', '2025/2026', 'Pembuatan Sistem E-Farmer Analisa Cuaca dan Harga Pasar Dari Hasil Panen untuk Membantu Pertanian Pe', 43);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ruangan`
--

CREATE TABLE `ruangan` (
  `id_ruangan` int NOT NULL,
  `kode_ruangan` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_ruangan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `ruangan`
--

INSERT INTO `ruangan` (`id_ruangan`, `kode_ruangan`, `nama_ruangan`) VALUES
(20, 'I.5.1', 'Auditorium'),
(21, 'J.4.4', 'Lab Teknologi Jaringan'),
(22, 'J.5.2', 'Lab Design Grafis'),
(23, 'I.3.1', 'Ruang Teori');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sidang`
--

CREATE TABLE `sidang` (
  `id_sidang` int NOT NULL,
  `id_mhs` int NOT NULL,
  `id_ruangan` int NOT NULL,
  `tanggal_sidang` date NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `status` enum('DITUNDA','DIJADWALKAN','DIBATALKAN') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `sidang`
--

INSERT INTO `sidang` (`id_sidang`, `id_mhs`, `id_ruangan`, `tanggal_sidang`, `waktu_mulai`, `waktu_selesai`, `status`) VALUES
(15, 73, 20, '2026-01-01', '08:00:00', '09:00:00', 'DITUNDA'),
(16, 73, 20, '2026-01-01', '10:00:00', '11:00:00', 'DIJADWALKAN');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` enum('mahasiswa','dosen') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'mahasiswa',
  `isAdmin` enum('Y','N') DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `role`, `isAdmin`) VALUES
(43, 'admin', '$2y$12$O1L8NoO9N7YnVduIHFz02eJwulvWK1gEmAGkdVy5tZNzzi1S2uvdK', 'mahasiswa', 'Y'),
(44, 'Dosen 1', '$2y$12$sJ37rO5HoSp3yFhZ6a/2G.HGyZOQBdOpB6tIXbCD9YqFn6WsPeNBW', 'dosen', 'N'),
(45, 'Dosen 2', '$2y$12$5.FIhvr7lVKDUbQEYWfzYO7FMPIfhYHA7SaUPJHSSwdqsx48/7qba', 'dosen', 'N');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('unread','read') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unread',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `user_id`, `message`, `status`, `created_at`, `updated_at`) VALUES
(1, 22, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:40:23', '2025-05-15 15:40:23'),
(2, 23, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:40:23', '2025-05-15 15:40:23'),
(3, 77, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:40:23', '2025-05-15 15:40:23'),
(4, 49, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:58:03', '2025-05-15 15:58:03'),
(5, 45, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:58:03', '2025-05-15 15:58:03'),
(6, 52, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:58:03', '2025-05-15 15:58:03'),
(7, 49, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:58:59', '2025-05-15 15:58:59'),
(8, 45, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:58:59', '2025-05-15 15:58:59'),
(9, 52, 'Sidang mahasiswa dengan ID 77 telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 15:58:59', '2025-05-15 15:58:59'),
(10, 49, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:04:39', '2025-05-15 16:04:39'),
(11, 45, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:04:39', '2025-05-15 16:04:39'),
(12, 52, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:04:39', '2025-05-15 16:04:39'),
(13, 49, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:12:14', '2025-05-15 16:12:14'),
(14, 45, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:12:14', '2025-05-15 16:12:14'),
(15, 52, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:12:14', '2025-05-15 16:12:14'),
(16, 49, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:14:22', '2025-05-15 16:14:22'),
(17, 45, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:14:22', '2025-05-15 16:14:22'),
(18, 52, 'Sidang mahasiswa dengan nama SayaAdmin telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Lab Teknologi Jaringan.', 'unread', '2025-05-15 16:14:22', '2025-05-15 16:14:22'),
(19, 44, 'Sidang mahasiswa dengan nama Bikra Abna Filqiyast Dzaki telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Auditorium.', 'unread', '2025-05-15 16:18:09', '2025-05-15 16:18:09'),
(20, 49, 'Sidang mahasiswa dengan nama Bikra Abna Filqiyast Dzaki telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Auditorium.', 'unread', '2025-05-15 16:18:09', '2025-05-15 16:18:09'),
(21, 43, 'Sidang mahasiswa dengan nama Bikra Abna Filqiyast Dzaki telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Auditorium.', 'unread', '2025-05-15 16:18:09', '2025-05-15 16:18:09'),
(22, 44, 'Sidang mahasiswa dengan nama Bikra Abna Filqiyast Dzaki telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Auditorium.', 'unread', '2025-05-16 00:44:34', '2025-05-16 00:44:34'),
(23, 49, 'Sidang mahasiswa dengan nama Bikra Abna Filqiyast Dzaki telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Auditorium.', 'unread', '2025-05-16 00:44:34', '2025-05-16 00:44:34'),
(24, 43, 'Sidang mahasiswa dengan nama Bikra Abna Filqiyast Dzaki telah dijadwalkan pada 2026-01-01 pukul 08:00:00 - 09:00:00 di ruang Auditorium.', 'unread', '2025-05-16 00:44:34', '2025-05-16 00:44:34');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`) USING BTREE,
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `dosen_penguji`
--
ALTER TABLE `dosen_penguji`
  ADD PRIMARY KEY (`id_penguji`) USING BTREE,
  ADD UNIQUE KEY `unique_sidang_dosen` (`id_sidang`,`id_dosen`) USING BTREE,
  ADD KEY `fk_dosen` (`id_dosen`) USING BTREE;

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mhs`) USING BTREE,
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id_ruangan`) USING BTREE;

--
-- Indeks untuk tabel `sidang`
--
ALTER TABLE `sidang`
  ADD PRIMARY KEY (`id_sidang`) USING BTREE,
  ADD KEY `fk_mhs` (`id_mhs`) USING BTREE,
  ADD KEY `fk_ruangan` (`id_ruangan`) USING BTREE;

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeks untuk tabel `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `dosen_penguji`
--
ALTER TABLE `dosen_penguji`
  MODIFY `id_penguji` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mhs` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT untuk tabel `ruangan`
--
ALTER TABLE `ruangan`
  MODIFY `id_ruangan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `sidang`
--
ALTER TABLE `sidang`
  MODIFY `id_sidang` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `FK_dosen_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dosen_penguji`
--
ALTER TABLE `dosen_penguji`
  ADD CONSTRAINT `fk_dosen` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sidang` FOREIGN KEY (`id_sidang`) REFERENCES `sidang` (`id_sidang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `FK_mahasiswa_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sidang`
--
ALTER TABLE `sidang`
  ADD CONSTRAINT `fk_mhs` FOREIGN KEY (`id_mhs`) REFERENCES `mahasiswa` (`id_mhs`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
