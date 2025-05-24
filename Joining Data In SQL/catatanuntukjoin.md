-- INNER JOIN: hanya customer yang punya order
SELECT c.name, o.order_date
FROM customers c INNER JOIN orders o ON c.id = o.customer_id;

-- LEFT JOIN: semua customer, termasuk yang belum pernah order
SELECT c.name, o.order_date
FROM customers c LEFT JOIN orders o ON c.id = o.customer_id;

-- RIGHT JOIN: semua order, termasuk yang customer_id-nya tidak valid
SELECT c.name, o.order_date
FROM customers c RIGHT JOIN orders o ON c.id = o.customer_id;

-- FULL JOIN: semua customer dan semua order
SELECT c.name, o.order_date
FROM customers c FULL JOIN orders o ON c.id = o.customer_id;

Setup Data :
-- Tabel customers
id | name | email
1 | Andi | andi@mail.com
2 | Budi | budi@mail.com  
3 | Citra | citra@mail.com
4 | Dian | dian@mail.com

-- Tabel orders
id | customer_id | order_date | total
101| 1 | 2024-01-15 | 150000
102| 2 | 2024-01-16 | 250000
103| 1 | 2024-01-17 | 100000
104| 5 | 2024-01-18 | 300000 -- customer_id 5 tidak ada di tabel customers

1. INNER JOIN - "Customer yang pernah order"

```bash
SELECT c.name, o.order_date, o.total
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id;
```

Hasil:

```bash
name | order_date | total
Andi | 2024-01-15 | 150000
Budi | 2024-01-16 | 250000
Andi | 2024-01-17 | 100000
```

Citra dan Dian tidak muncul karena belum pernah order. Order 104 tidak muncul karena customer_id 5 tidak ada.

2. LEFT JOIN - "Semua customer + order mereka (kalau ada)"

```bash
SELECT c.name, o.order_date, o.total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;
```

Hasil:

```bash
name  | order_date | total
Andi  | 2024-01-15 | 150000
Andi  | 2024-01-17 | 100000
Budi  | 2024-01-16 | 250000
Citra | NULL       | NULL
Dian  | NULL       | NULL
```

Semua customer muncul. Yang belum order ditampilkan dengan NULL.

3. RIGHT JOIN - "Semua order + data customer (kalau ada)"

```bash
SELECT c.name, o.order_date, o.total
FROM customers c
RIGHT JOIN orders o ON c.id = o.customer_id;
```

Hasil:

```bash
name | order_date | total
Andi | 2024-01-15 | 150000
Budi | 2024-01-16 | 250000
Andi | 2024-01-17 | 100000
NULL | 2024-01-18 | 300000
```

Semua order muncul. Order dengan customer_id tidak valid ditampilkan dengan name NULL.

4. FULL JOIN - "Semua customer + semua order"

```bash
SELECT c.name, o.order_date, o.total
FROM customers c
FULL JOIN orders o ON c.id = o.customer_id;
```

Hasil:

```bash
name  | order_date | total
Andi  | 2024-01-15 | 150000
Andi  | 2024-01-17 | 100000
Budi  | 2024-01-16 | 250000
Citra | NULL       | NULL
Dian  | NULL       | NULL
NULL  | 2024-01-18 | 300000
```

Gabungan semua: customer yang belum order + order dengan data customer tidak valid.

Kapan pakai masing-masing:

```bash
INNER JOIN: "Laporan penjualan per customer" - hanya yang relevan
LEFT JOIN: "Customer mana yang belum order bulan ini?" - untuk follow up marketing
RIGHT JOIN: "Order mana yang datanya bermasalah?" - untuk data cleaning
FULL JOIN: "Audit lengkap customer vs order" - untuk rekonsiliasi data
```

SELF JOIN
JOIN tabel dengan dirinya sendiri. Berguna untuk membandingkan baris dalam tabel yang sama.

Contoh Data - Tabel employees:

```bash
id | name    | manager_id | salary
1  | Andi    | NULL       | 10000000  -- CEO
2  | Budi    | 1          | 8000000   -- Manager
3  | Citra   | 1          | 8500000   -- Manager
4  | Dian    | 2          | 6000000   -- Staff
5  | Eko     | 2          | 5500000   -- Staff
6  | Fira    | 3          | 6500000   -- Staff
```

Contoh SELF JOIN:

```bash
-- Tampilkan employee beserta nama manager-nya
SELECT
    e.name AS employee,
    m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

Hasil:

```bash
employee | manager
Andi     | NULL
Budi     | Andi
Citra    | Andi
Dian     | Budi
Eko      | Budi
Fira     | Citra
```

Contoh lain SELF JOIN:

```bash
-- Cari employee yang gajinya lebih tinggi dari manager-nya
SELECT
    e.name AS employee,
    e.salary AS emp_salary,
    m.name AS manager,
    m.salary AS mgr_salary
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;
```

CROSS JOIN
Menghasilkan cartesian product - setiap baris dari tabel pertama dikombinasikan dengan setiap baris dari tabel kedua.

Contoh data:

```bash
-- Tabel products
id | product_name
1  | Laptop
2  | Mouse
3  | Keyboard

-- Tabel colors
id | color_name
1  | Black
2  | White
3  | Red
```

Cross Join:

```bash
SELECT
    p.product_name,
    c.color_name
FROM products p
CROSS JOIN colors c;
```

Hasil (9 kombinasi):

```bash
product_name | color_name
Laptop       | Black
Laptop       | White
Laptop       | Red
Mouse        | Black
Mouse        | White
Mouse        | Red
Keyboard     | Black
Keyboard     | White
Keyboard     | Red
```

Kasus Penggunaan Praktis:
SELF JOIN untuk:

- Struktur organisasi (employee-manager)
- Kategori produk bertingkat (parent-child categories)
- Referral system (user yang mengundang user lain)
- Membandingkan data dalam periode berbeda

```bash
-- Bandingkan sales bulan ini vs bulan lalu
SELECT
    this_month.product_id,
    this_month.sales AS current_sales,
    last_month.sales AS previous_sales
FROM monthly_sales this_month
JOIN monthly_sales last_month
ON this_month.product_id = last_month.product_id
WHERE this_month.month = '2024-02'
AND last_month.month = '2024-01';
```

CROSS JOIN untuk:

- Generate semua kombinasi produk-warna untuk katalog
- Buat time slots untuk appointment system
- Generate test data combinations
- Analisis "what-if" scenarios

```bash
-- Buat slot appointment untuk semua dokter di semua hari
SELECT
    d.doctor_name,
    t.time_slot,
    t.day_name
FROM doctors d
CROSS JOIN time_slots t;
```

Perhatian: CROSS JOIN bisa menghasilkan data sangat besar (tabel 1000 baris × tabel 1000 baris = 1 juta baris), jadi hati-hati penggunaannya!
