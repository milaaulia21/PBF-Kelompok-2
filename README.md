# Pemrograman Berbasis Framework - Kelompok 2
# DevOps & Deployment Engineer

## Deskripsi Proyek

#### 
Proyek ini merupakan tugas akhir gabungan dari UTS dan UAS mata kuliah Pemrograman Berbasis Framework. Tujuan utamanya adalah membangun Sistem Penjadwalan Sidang Skripsi Otomatis secara terintegrasi dengan pendekatan profesional, serta mengimplementasikan praktik modern pengembangan dan deployment aplikasi web.

Sebagai DevOps & Deployment Engineer, tugasnya adalah menyiapkan infrastruktur dan workflow agar seluruh sistem dapat berjalan dengan mudah, stabil, dan konsisten melalui containerisasi dengan Docker dan Docker Compose.

## Langkah 1 : Persiapan Lingkungan Pengembangan

####
Sebelum memulai membangun dan menjalankan sistem, hal yang paling awal yang perlu disiapkan adalah lingkungan pengembangan. 

### Apa itu Lingkungan Pengembangan?

####
Lingkungan pengembangan adalah tempat (biasanya di komputer/laptop) di mana kita menyiapkan semua alat dan konfogurasi yang dibutuhkan agar proyek bisa dijalankan dengan benar.

### Tools yang Wajib Di-install:
#### 1. Docker
Docker adalah alat untuk membuat dan menjalankan aplikasi di dalam "wadah" (container). Dengan Docker, kita bisa menjalankan backend, frontend, dan database tanpa menginstall satu per satu secara manual dan menjamin aplikasi berjalan dengan cara yang sama di semua komputer.
Download di sini : https://www.docker.com/products/docker-desktop

#### 2. Docker Compose
Docker Compose adalah alat bantu Docker untuk menjalankan banyak container sekaligus (seperti MYSQL, backend, frontend, dan NGINX) hanya dengan satu perintah. Biasanya Docker Compose sudah otomatis terinstal bersama Docker Desktop.

#### 3. Git 
Digunakan untuk mengunduh kode dari Github dan melakukan kolaborasi antar anggota tim dalam proyek. 
Download di sini : https://git-scm.com/downloads

#### Verifikasi Instalasi
Untuk memastikan semuanya sudah terpasang dengan benar, jalankan perintah ini di terminal/command prompt :
docker --version
docker-compose --version
git --version

Jika versi masing-masing alat ditampilkan, maka siap lanjut ke tahap berikutnya. 

## Langkah 2 : Menyiapkan Tools Manajemen Proyek

### Mengapa Perlu Tools Manajemen Proyek?
Dalam pengelolaan proyek pengembangan aplikasi, salah satu tugas penting dalam peran DevOps & Deployment Engineer adalah memastikan semua proses berjalan secara terstruktur dan kolaboratif. Agar setiap proses seperti integrasi, deployment, dan konfigurasi dapat dipantau dengan jelas, dibutuhkan alat bantu manajemen proyek.

### Tools yang Digunakan : Trello
Trello dipilih sebagai alat bantu utama untuk mengatur dan memantau setiap tugas tim.
Trello adalah papan kerja visual (visual task board) yang memungkinkan setiap tugas direpresentasikan sebagai "kartu" yang bisa digeser ke berbagai tahap seperti : To Do, In Progress, dan Done.

### Akses Trello Proyek
https://trello.com/b/5SqLLO5S/kelompok-2

### Fungsi Trello untuk Koordinasi Proyek 
Struktur tim dalam proyek ini terdiri dari empat peran utama : 
1. Frontend Developer
2. Backend Developer
3. Database Engineer
4. DevOps & Deployment Engineer

