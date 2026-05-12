# Aplikasi Pengelola Inventaris - Tugas PBM 2026

Aplikasi mobile berbasis Flutter untuk mengelola data inventaris barang dagangan dan mengirimkan tugas praktikum.

## 📁 Struktur Project

```
lib/
├── main.dart                              # Entry point & session checker
├── models/
│   ├── pengguna_model.dart               # Model data Pengguna
│   ├── barang_dagangan_model.dart        # Model data Barang Dagangan
│   └── hasil_autentikasi_model.dart      # Model response autentikasi
├── services/
│   ├── auth_services.dart                # Layanan autentikasi
│   ├── produk_services.dart              # Layanan produk & submit tugas
│   └── token_vault.dart                  # Penyimpanan token aman
├── screens/
│   ├── halaman_masuk.dart                # Halaman Login
│   ├── halaman_katalog.dart              # Halaman Katalog Barang
│   └── halaman_kirim_tugas.dart          # Halaman Kirim Tugas
├── widgets/
│   ├── tombol_aksi.dart                  # Widget tombol kustom
│   ├── input_teks.dart                   # Widget input teks kustom
│   └── kartu_barang.dart                 # Widget kartu barang kustom
└── config/
    └── konfigurasi_app.dart              # Konfigurasi global (warna, URL, dll)
```

## 🚀 Cara Menjalankan

### Prasyarat

- Flutter SDK (versi 3.0+)
- Dart SDK
- Android Studio / VS Code

### Instalasi

1. Clone repository:
   ```bash
   git clone <url-repository-anda>
   cd tugas1
   ```

2. Install dependensi:
   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## 🔐 Autentikasi

- **Username**: Gunakan NIM Anda
- **Password**: Gunakan NIM Anda

Contoh: NIM `232410102004`

## 📦 Fitur Utama

### 1. Autentikasi (Halaman Masuk)
- Login menggunakan NIM dan kata sandi
- Token disimpan secara aman menggunakan `flutter_secure_storage`
- Sesi otomatis tersimpan untuk kunjungan berikutnya

### 2. Manajemen Inventaris (Halaman Katalog)
- **Lihat Barang**: Menampilkan daftar inventaris dalam format list
- **Tambah Barang**: Menambahkan barang baru (nama, harga, keterangan)
- **Cari Barang**: Pencarian barang berdasarkan nama atau keterangan
- **Total Harga**: Menampilkan total nilai seluruh inventaris
- ⚠️ **Edit Barang TIDAK TERSEDIA** (sesuai ketentuan)

### 3. Kirim Tugas (Halaman Kirim Tugas)
- Memilih salah satu barang untuk dikirimkan
- Memasukkan URL repository GitHub
- Pengiriman hanya bisa dilakukan SEKALI
- Waktu pengiriman dicatat oleh sistem

## 🎨 Desain & Tema

- **Tema Warna**: Teal-Emerald
  - Primary: Teal (`#14B8A6`)
  - Secondary: Teal Dark (`#0D9488`)
  - Accent: Cyan (`#06B6D4`)
  - Error: Rose (`#F43F5E`)
  - Success: Emerald (`#059669`)
- **Layout**: ListView (bukan GridView)
- **Input Style**: UnderlineInputBorder
- **Button Style**: MaterialButton kustom
- **Login**: Card dengan gradient background

## 📚 Dependensi

- `http: ^1.1.0` - Komunikasi HTTP ke API
- `flutter_secure_storage: ^9.0.0` - Penyimpanan token aman

## 🔗 Konfigurasi API

```
Base URL: https://task.itprojects.web.id
```

### Endpoint:
1. **POST** `/api/auth/login` - Autentikasi
2. **GET** `/api/products` - Ambil daftar barang (memerlukan token)
3. **POST** `/api/products` - Tambah barang baru (memerlukan token)
4. **POST** `/api/products/submit` - Kirim tugas (memerlukan token)

## ⚠️ Ketentuan Penting

1. Tidak ada fitur Edit/Update barang
2. Pengiriman tugas hanya bisa dilakukan sekali
3. Bearer Token wajib di setiap request (kecuali login)

## 📸 Screenshot

Screenshot aplikasi terletak di folder root project.

---

**Dibuat pada**: 2026-05-11
