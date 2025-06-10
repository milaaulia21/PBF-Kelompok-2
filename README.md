# Pemrograman Berbasis Framework - Kelompok 2
# DevOps & Deployment Engineer

## ⚙️ Deskripsi Proyek

#### 
Proyek ini berfokus pada penerapan prinsip DevOps dalam membangun Sistem Penjadwalan Sidang Skripsi Otomatis berbasis web. DevOps (Development and Operations) adalah pendekatan kolaboratif yang menggabungkan pengembangan perangkat lunak (Dev) dan operasional sistem (Ops) untuk menciptakan proses pengembangan yang lebih cepat, stabil, dan terotomatisasi.

Dalam proyek ini, seluruh komponen sistem dikemas menggunakan Docker dan dikoordinasikan melalui Docker Compose, sehingga proses instalasi dan deployment dapat dilakukan secara otomatis dan konsisten, hanya dengan satu perintah: docker compose up.

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
```
docker --version
docker-compose --version
git --version
```
Jika versi masing-masing alat ditampilkan, maka siap lanjut ke tahap berikutnya. 


## Langkah 1 : Persiapan Lingkungan Pengembangan

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

## Langkah 3 : Konfigurasi dan Manajemen Git
### Tujuan Langkah ini 
Langkah ini bertujuan untuk mengatur struktur proyek, mengelola versi kode dengan Git, dan menyiapkan otomatisasi pengambilan kode (clone) dari GitHub ke dalam container Docker. Semua ini dilakukan agar seluruh tim bisa bekerja secara terpusat dan efisien tanpa konfigurasi manual di tiap komputer. 

### Manajemen Git 
### Struktur Repository Proyek
Dalam proyek ini, terdapat dua repository utama yang disimpan di GitHub :
#### 1. Frontend (Laravel + React + Inertia.js)
https://github.com/milaaulia21/PBF_Frontend
#### 2. Backend (CodeIgniter 4)
https://github.com/milaaulia21/PBF_Backend

Masing-masing repository berdiri sendiri, namun saling terhubung melalui file docker-compose.yml yang digunakan untuk mengatur container aplikasi.

### Konfigurasi Git & GitHub
Sebagian bagian dari manajemen proyek, setiap komponen (backend dan frontend) ditempatkan dalam repository GitHub yang terpisah, agar bisa dikelola dan dikembangkan secara modular oleh tim masing-masing.

#### File .env
File .env digunakan untuk menyimpan variabel penting secara rahasia dan terpisah dari kode. File .env di Laravel digunakan untuk menyimpan konfigurasi environment variables yang dibutuhkan oleh aplikasi agar bisa berjalan dengan benar di berbagai lingkungan (development, staging, production).

#### Dockerfile 
Dockerfile adalah kumpulan perintah yang memberi tahu Docker cara membangun sebuah image. Setelah dibuild, image itu bisa dipakai buat menjalankan container. 

##### Dockerfile.frontend
Untuk membangun container frontend (Laravel + React).
```
# Stage 1: Build React
FROM node:18 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Laravel + PHP
FROM php:8.2-fpm
WORKDIR /var/www/html

# Install system deps
RUN apt-get update && apt-get install -y \
    git curl libzip-dev zip unzip \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer + Node
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Copy Laravel + built assets
COPY . .
COPY --from=build /app/public/build /var/www/html/public/build

# Install dependencies
RUN composer install && npm install && chown -R www-data:www-data storage bootstrap/cache

# Run with concurrently (Dev)
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=9700"]


##### Dockerfile.backend
Untuk membangun container backend (CodeIgniter).

FROM php:8.2-cli

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    zip unzip git curl libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libicu-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring gd intl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --no-interaction --prefer-dist

RUN chown -R www-data:www-data /var/www/writable

EXPOSE 8080
CMD ["php", "spark", "serve", "--host=0.0.0.0", "--port=8080"]
```

#### File nginx.conf
File ini adalah konfigurasi utnuk Nginx, yaitu web server yang digunakan sebagai reverse proxy. Artinya, Nginx menerima permintaan dari browser, lalu meneruskannya ke container frontend atau backend sesuai alamat URL-nya.
```
worker_processes 1;

events {
    worker_connections 1024;
}

http {
    server {
        listen 80;

        location /api {
            proxy_pass http://backend:8080;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location / {
            proxy_pass http://frontend:9700;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```


