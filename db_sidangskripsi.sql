/*
 Navicat Premium Dump SQL

 Source Server         : punyaku
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:9000
 Source Schema         : db_sidangskripsi

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 25/02/2025 21:14:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dosen
-- ----------------------------
DROP TABLE IF EXISTS `dosen`;
CREATE TABLE `dosen`  (
  `id_dosen` int NOT NULL AUTO_INCREMENT,
  `nama_dosen` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nip` int NOT NULL,
  PRIMARY KEY (`id_dosen`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dosen
-- ----------------------------
INSERT INTO `dosen` VALUES (2, 'novi', 56362);
INSERT INTO `dosen` VALUES (3, 'wahyu', 812345);

-- ----------------------------
-- Table structure for dosen_penguji
-- ----------------------------
DROP TABLE IF EXISTS `dosen_penguji`;
CREATE TABLE `dosen_penguji`  (
  `id_penguji` int NOT NULL AUTO_INCREMENT,
  `id_sidang` int NOT NULL,
  `id_dosen` int NOT NULL,
  `peran` enum('PENGUJI 1','PENGUJI 2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_penguji`) USING BTREE,
  UNIQUE INDEX `unique_sidang_dosen`(`id_sidang` ASC, `id_dosen` ASC) USING BTREE,
  INDEX `fk_dosen`(`id_dosen` ASC) USING BTREE,
  CONSTRAINT `fk_dosen` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sidang` FOREIGN KEY (`id_sidang`) REFERENCES `sidang` (`id_sidang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dosen_penguji
-- ----------------------------

-- ----------------------------
-- Table structure for mahasiswa
-- ----------------------------
DROP TABLE IF EXISTS `mahasiswa`;
CREATE TABLE `mahasiswa`  (
  `id_mhs` int NOT NULL AUTO_INCREMENT,
  `nama_mhs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nim` int NOT NULL,
  `prodi_mhs` enum('D3 TI','D4 RKS','D4 ALKS','D4 TRM','D4 RPL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `thn_akademik` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `judul_skripsi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_mhs`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mahasiswa
-- ----------------------------
INSERT INTO `mahasiswa` VALUES (1, 'esna', 1234, 'D3 TI', '2024/2025', 'lkgskuhgui');
INSERT INTO `mahasiswa` VALUES (3, 'wahyu', 812345, 'D3 TI', '2024/2025', 'jhjwyfy');

-- ----------------------------
-- Table structure for ruangan
-- ----------------------------
DROP TABLE IF EXISTS `ruangan`;
CREATE TABLE `ruangan`  (
  `id_ruangan` int NOT NULL AUTO_INCREMENT,
  `kode_ruangan` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_ruangan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_ruangan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ruangan
-- ----------------------------
INSERT INTO `ruangan` VALUES (1, 'J.5.4', 'Lab Sistem Informasi');
INSERT INTO `ruangan` VALUES (2, 'J.4.5', 'Lab Jaringan');

-- ----------------------------
-- Table structure for sidang
-- ----------------------------
DROP TABLE IF EXISTS `sidang`;
CREATE TABLE `sidang`  (
  `id_sidang` int NOT NULL AUTO_INCREMENT,
  `id_mhs` int NOT NULL,
  `id_ruangan` int NOT NULL,
  `tanggal_sidang` date NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `status` enum('DITUNDA','DIJADWALKAN','DIBATALKAN') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_sidang`) USING BTREE,
  INDEX `fk_mhs`(`id_mhs` ASC) USING BTREE,
  INDEX `fk_ruangan`(`id_ruangan` ASC) USING BTREE,
  CONSTRAINT `fk_mhs` FOREIGN KEY (`id_mhs`) REFERENCES `mahasiswa` (`id_mhs`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sidang
-- ----------------------------
INSERT INTO `sidang` VALUES (6, 1, 2, '2025-02-25', '14:23:20', '14:23:23', 'DIJADWALKAN');
INSERT INTO `sidang` VALUES (7, 3, 2, '2025-02-27', '14:23:52', '14:23:58', 'DIJADWALKAN');

SET FOREIGN_KEY_CHECKS = 1;
