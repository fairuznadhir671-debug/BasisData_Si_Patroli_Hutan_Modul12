Praktikum Basis Data — Modul 12 (TimescaleDB & Proyek SIPATROLI HUTAN)

---

##  Tim Pengembang (Kelas 1B - TRPL)
* **Ahmad Mujadid Musyafi'i** (264311031)
* **Fairuz Nadhir Rahmad** (264311040)
* **Nila Ayunisa** (264311053)

---

Repositori ini berisi skrip SQL, diagram rencana kueri, dokumentasi laporan praktikum, serta rancangan awal migrasi basis data deret waktu (time-series) menggunakan PostgreSQL dan TimescaleDB untuk studi kasus proyek SIPATROLI HUTAN (Sistem Pelaporan Patroli Hutan Secara Real-Time di Hutan Pinus Nongko Ijo).

---

Lingkungan & Alat Kerja

Basis Data: PostgreSQL dengan ekstensi TimescaleDB pada VM Kali Linux

Klien Manajemen Basis Data: DBeaver (di Windows)

Pengelolaan Berkas: Git & struktur direktori praktikum Modul 12

---

Struktur Direktori

scripts/01_migrasi_data_latihan.sql — Pembuatan ekstensi TimescaleDB, tabel relasional (routes) dan hypertable (trips), indeks komposit, serta pengisian data uji transportasi.

scripts/02_query_transportasi.sql — Kueri gabungan dan penyaringan data perjalanan serta evaluasi rencana eksekusi menggunakan EXPLAIN (ANALYZE, BUFFERS).

scripts/03_pengujian_dcl.sql — Pengujian pembuatan peran (report_user), pemberian hak akses terbatas (GRANT), verifikasi privilege, uji eksekusi SELECT dan penolakan DELETE, pencabutan hak akses (REVOKE), serta pembersihan peran (DROP OWNED BY dan DROP ROLE).

scripts/04_rancangan_migrasi_pjbl.sql — Skema migrasi proyek SIPATROLI HUTAN (patrol_areas dan hypertable patrol_logs), kueri analitik dengan time_bucket, evaluasi EXPLAIN (ANALYZE, BUFFERS), serta konfigurasi peran forest_reporter dan patrol_operator.

diagram/query_tree.png — Diagram pohon kueri (Query Tree) hasil rendering aljabar relasional.

dokumentasi/laporan_modul12.pdf — Laporan lengkap hasil praktikum Modul 12.

---

Urutan Eksekusi Skrip

Jalankan scripts/01_migrasi_data_latihan.sql terlebih dahulu untuk menyiapkan skema latihan dan data awal.

Jalankan scripts/02_query_transportasi.sql untuk mengamati hasil kueri serta keluaran EXPLAIN (ANALYZE, BUFFERS).

Jalankan scripts/03_pengujian_dcl.sql secara bertahap sesuai kebutuhan pengujian hak akses; ganti placeholder kata sandi sebelum eksekusi dan pastikan tidak menyimpan kata sandi asli di repositori.

Jalankan scripts/04_rancangan_migrasi_pjbl.sql untuk menguji rancangan migrasi SIPATROLI HUTAN di lingkungan pengembangan.


## Struktur Direktori

```text
praktikum_modul12/
├── scripts/
│   ├── 01_migrasi_data_latihan.cypher      # Pengecekan versi DBMS, migrasi node & relasi (:Trip, :Route, [:ON_ROUTE])
│   ├── 02_query_transportasi.cypher        # Query seleksi, traversal, proyeksi, dan inspeksi rencana eksekusi (PROFILE)
│   ├── 03_pengujian_dcl.cypher             # Pembuatan role/user, GRANT, REVOKE, dan pengujian hak akses (Least Privilege)
│   └── 04_rancangan_migrasi_pjbl.cypher    # Pembuatan Range Index dan query traversal proyek SiPatroliHutan
├── dokumentasi/
│   ├── analisis_query_cost.pdf             # Analisis perbandingan rencana eksekusi & estimasi page read
│   └── laporan_modul12.pdf                 # Laporan lengkap Tahap 1–5 beserta bukti tangkapan layar
├── diagram/
│   └── query_tree.png                      # Diagram Query Tree (Rencana Standar vs Selection Pushdown)
└── README.md


