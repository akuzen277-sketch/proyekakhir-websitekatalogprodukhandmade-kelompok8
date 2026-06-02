USE handmade;

drop table users;
drop table pesanan;
drop table detail_pesanan;
drop table kategori;
drop table produk;
CREATE TABLE users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','user') DEFAULT 'user',
    no_hp VARCHAR(20),
    alamat TEXT,
    bio TEXT,
    foto VARCHAR(255) DEFAULT 'default.png'
);

CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);

CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT,
    nama_produk VARCHAR(100) NOT NULL,
    harga INT NOT NULL,
    stok INT NOT NULL,
    gambar VARCHAR(100),
    deskripsi TEXT,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);

CREATE TABLE pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    nama_penerima VARCHAR(100),
    no_hp VARCHAR(20),
    alamat TEXT,
    total INT,
    status ENUM('menunggu','diproses','selesai') DEFAULT 'menunggu',
    tanggal DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE detail_pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT,
    id_produk INT,
    jumlah INT,
    subtotal INT
);

CREATE TABLE kupon (
    id_kupon INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    kode_kupon VARCHAR(50) NOT NULL,
    nominal_diskon INT DEFAULT 10000,
    status ENUM('belum_dipakai','sudah_dipakai') DEFAULT 'belum_dipakai',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users
(
    nama,
    username,
    password,
    role
)

VALUES
(
    'Admin',
    'admin',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'admin'
);

INSERT INTO users 
(nama, username, password, role, no_hp, alamat, bio, foto)
VALUES
('Admin', 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', '', '', '', 'default.png');

INSERT INTO kategori VALUES
(NULL, 'Rajutan'),
(NULL, 'Aksesoris'),
(NULL, 'Dekorasi'),
(NULL, 'Tas'),
(NULL, 'Pakaian'),
(NULL, 'Peralatan Makan&Minum');

INSERT INTO produk VALUES
(NULL, 1, 'Tas Rajut Premium', 85000, 12, 'tas.jpg', 'Tas rajut handmade dengan desain elegan.'),
(NULL, 2, 'Gelang Manik Pastel', 25000, 25, 'gelang.jpg', 'Gelang manik handmade warna kalem.'),
(NULL, 3, 'Lilin Aromaterapi', 45000, 15, 'lilin.jpg', 'Lilin dekorasi dengan aroma lembut.'),
(NULL, 4, 'Dompet Kain Handmade', 35000, 20, 'dompet.jpg', 'Dompet kain simple dan estetik.'),

ALTER TABLE pesanan 
MODIFY status ENUM('menunggu','diproses','dikirim','selesai','dibatalkan') 
DEFAULT 'menunggu';

update users set role='admin' where username='ferdi';

ALTER TABLE users
ADD email VARCHAR(100) UNIQUE AFTER username;

ALTER TABLE users
ADD otp VARCHAR(10) NULL,
ADD otp_expired DATETIME NULL;

ALTER TABLE pesanan
    ADD COLUMN provinsi VARCHAR(100) NULL AFTER alamat,
    ADD COLUMN kabupaten VARCHAR(100) NULL AFTER provinsi,
    ADD COLUMN kecamatan VARCHAR(100) NULL AFTER kabupaten,
    ADD COLUMN desa VARCHAR(100) NULL AFTER kecamatan,
    ADD COLUMN estimasi_pengiriman DATE NULL AFTER desa;

ALTER TABLE kategori
ADD CONSTRAINT unik_nama_kategori
UNIQUE (nama_kategori);

ALTER TABLE pesanan 
ADD COLUMN kode_kupon VARCHAR(50) NULL,
ADD COLUMN diskon INT DEFAULT 0;

select * from produk;