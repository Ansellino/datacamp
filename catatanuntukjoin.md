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
