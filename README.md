# Pemrograman Berbasis Framework - Kelompok 2
# DevOps & Deployment Engineer

## ⚙️ Deskripsi Proyek

#### 
Proyek ini berfokus pada penerapan prinsip DevOps dalam membangun Sistem Penjadwalan Sidang Skripsi Otomatis berbasis web. DevOps (Development and Operations) adalah pendekatan kolaboratif yang menggabungkan pengembangan perangkat lunak (Dev) dan operasional sistem (Ops) untuk menciptakan proses pengembangan yang lebih cepat, stabil, dan terotomatisasi.

Dalam proyek ini, seluruh komponen sistem dikemas menggunakan Docker dan dikoordinasikan melalui Docker Compose, sehingga proses instalasi dan deployment dapat dilakukan secara otomatis dan konsisten, hanya dengan satu perintah: docker compose up.

## 🔧 Langkah 1 : Persiapan Awal

### Alat yang Wajib Di-install:
Sebelum menjalankan sistem, pastikan alat-alat berikut sudah terpasang di komputer/laptop:

#### 1. Docker
Docker adalah alat untuk membuat dan menjalankan aplikasi di dalam "wadah" (container). Dengan Docker, kita bisa menjalankan backend, frontend, dan database tanpa menginstall satu per satu secara manual dan menjamin aplikasi berjalan dengan cara yang sama di semua komputer.
Download di sini : https://www.docker.com/products/docker-desktop

#### 2. Docker Compose
Docker Compose adalah alat bantu Docker untuk menjalankan banyak container sekaligus (seperti MYSQL, backend, frontend, dan NGINX) hanya dengan satu perintah. Biasanya Docker Compose sudah otomatis terinstal bersama Docker Desktop.

#### 3. Git 
Digunakan untuk mengunduh kode dari Github dan melakukan kolaborasi antar anggota tim dalam proyek. 
Download di sini : https://git-scm.com/downloads

#### 🧪 Verifikasi Instalasi
Untuk memastikan semuanya sudah terpasang dengan benar, jalankan perintah ini di terminal/command prompt :
```
docker --version
docker-compose --version
git --version
```
Jika versi masing-masing alat ditampilkan, maka siap lanjut ke tahap berikutnya. 

## 🗃️ Langkah 2: Clone Repository Proyek


### Struktur Proyek
### Clone Repositori
Clone kedua repositori proyek:
```
git clone https://github.com/milaaulia21/PBF_Backend.git
```
```
git clone https://github.com/milaaulia21/PBF_Frontend.git
```
Keterangan:

- PBF_Backend adalah proyek backend berbasis CodeIgniter 4

- PBF_Frontend adalah proyek frontend berbasis Laravel + React + Inertia.js
  
## 🐳 Langkah 3: Menjalankan Proyek dengan Docker

Semua konfigurasi telah disiapkan dalam file `docker-compose.yml`. File ini bertugas untuk mengatur dan menjalankan semua container: frontend, backend, database, dan server.

### 📁 File Penting yang Sudah Disediakan:
- '''Dockerfile''' di dalam '''frontend/''' dan '''backend/'''

- '''nginx.conf''' di dalam '''nginx/'''

- '''db_sidangskripsi.sql''' sebagai file inisialisasi database

- '''.env''' masing-masing untuk backend dan frontend 

### 🚀 Jalankan Sistem

Setelah semua file siap dan struktur proyek lengkap:

1. Buka terminal di folder root (tempat '''docker-compose.yml''' berada)

2. Jalankan perintah:
```
docker-compose up --build
```
Docker akan otomatis:

- Membangun dan menjalankan backend CodeIgniter 4

- Membangun dan menjalankan frontend Laravel + React

- Menyediakan database MySQL

- Mengarahkan semua request melalui NGINX

### 📝 Catatan:
Proses build pertama kali akan memakan waktu beberapa menit tergantung kecepatan koneksi dan komputer.

## 🌐 Langkah 4: Akses Aplikasi

Jika semua container berhasil berjalan, buka browser dan akses:

## 📌 Tips Tambahan

### 🔄 Menghentikan Aplikasi

Gunakan '''CTRL + C''' di terminal, lalu jalankan:
```
docker compose down
```

### 💾 File '''.env'''
File '''.env''' digunakan untuk menyimpan variabel penting secara rahasia dan terpisah dari kode. File .env tidak disimpan di GitHub karena berisi data sensitif (seperti kredensial database). File .env di Laravel digunakan untuk menyimpan konfigurasi environment variables yang dibutuhkan oleh aplikasi agar bisa berjalan dengan benar di berbagai lingkungan (development, staging, production).
