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
File .env digunakan untuk menyimpan variabel penting secara rahasia dan terpisah dari kode. 
```
APP_NAME=Laravel
APP_ENV=local
APP_KEY=base64:U6otiFduLH/NuSiQc2lkii/ObEXwlg3IKvEklW1osb4=
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost:9700
ASSET_URL=http://localhost:5173
VITE_DEV_SERVER=true

APP_LOCALE=en
APP_FALLBACK_LOCALE=en
APP_FAKER_LOCALE=en_US

APP_MAINTENANCE_DRIVER=file
APP_MAINTENANCE_STORE=database

PHP_CLI_SERVER_WORKERS=4

BCRYPT_ROUNDS=12

LOG_CHANNEL=stack
LOG_STACK=single
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=sqlite
DB_HOST=pbf-mysql-1
DB_PORT=3306
DB_DATABASE=db_sidangskripsi
DB_USERNAME=user
DB_PASSWORD=secret

SESSION_DRIVER=database
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=log
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=database
CACHE_PREFIX=

MEMCACHED_HOST=127.0.0.1

REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=log
MAIL_SCHEME=null
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

VITE_APP_NAME="${APP_NAME}"
VITE_APP_URL=""
```

#### Dockerfile 
Dockerfile adalah kumpulan perintah yang memberi tahu Docker cara membangun sebuah image. Setelah dibuild, image itu bisa dipakai buat menjalankan container. 

##### Dockerfile.frontend
Untuk membangun container frontend (Laravel + React).

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


#### File nginx.conf
File ini adalah konfigurasi utnuk Nginx, yaitu web server yang digunakan sebagai reverse proxy. Artinya, Nginx menerima permintaan dari browser, lalu meneruskannya ke container frontend atau backend sesuai alamat URL-nya.

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



