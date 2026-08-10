*.pdf
# beauty-salon-database
# 📊 پایگاه داده سالن زیبایی | Beauty Salon Database

این مخزن شامل اسکریپت SQL Server مربوط به پروژه «سیستم مدیریت سالن زیبایی» است.  
اسکریپت موجود، یک گزارش از خدمات سالن تولید می‌کند و برای هر خدمت، تعداد رزرو و درآمد تقریبی را نمایش می‌دهد.

> 📄 فایل PDF گزارش پروژه در این مخزن قرار داده نشده است.

---

## ✨ امکانات

- گزارش‌گیری از خدمات سالن زیبایی
- محاسبه تعداد رزرو هر خدمت
- محاسبه درآمد تقریبی هر خدمت
- استفاده از `LEFT JOIN` برای نمایش خدمات بدون رزرو
- استفاده از `GROUP BY` و توابع تجمیعی
- استفاده از `Cursor` برای پیمایش و نمایش سطری نتایج
- قابل اجرا در SQL Server Management Studio

---

## 📁 فایل‌های پروژه

| فایل | توضیح |
|---|---|
| `beauty salon db final.sql` | اسکریپت SQL برای اجرای گزارش خدمات با Cursor |
| `README.md` | توضیحات پروژه |

---

## 🧾 پیش‌نیازها

برای اجرای این اسکریپت به موارد زیر نیاز دارید:

- SQL Server
- SQL Server Management Studio یا Azure Data Studio
- دیتابیس `beautysalondb`
- وجود جداول زیر در دیتابیس:
  - `Service`
  - `Reservation_Service`

ساختار مورد انتظار جداول:

```text
Service
-------
id
name
price
```

```text
Reservation_Service
-------------------
reservation_id
service_id
```

---

## 🚀 نحوه اجرا

### روش ۱: اجرا در SQL Server Management Studio

1. فایل `beauty salon db final.sql` را در SQL Server Management Studio باز کنید.
2. به سرور SQL Server متصل شوید.
3. اسکریپت را اجرا کنید.

اسکریپت به‌صورت پیش‌فرض از دیتابیس زیر استفاده می‌کند:

```sql
USE beautysalondb;
```

---

### روش ۲: اجرا با sqlcmd

اگر نام فایل دارای فاصله است:

```bash
sqlcmd -S localhost -d beautysalondb -i "beauty salon db final.sql"
```

اگر فایل را به نام بدون فاصله تغییر دادید، مثلاً `beauty_salon_db_final.sql`:

```bash
sqlcmd -S localhost -d beautysalondb -i beauty_salon_db_final.sql
```

---

## 📊 خروجی گزارش

خروجی گزارش شامل ستون‌های زیر است:

| ServiceName | ReservationCount | TotalIncome |
|---|---:|---:|
| Haircut | 1 | 150000.00 |
| Makeup | 1 | 300000.00 |

توضیح ستون‌ها:

- `ServiceName`: نام خدمت
- `ReservationCount`: تعداد رزروهای ثبت‌شده برای آن خدمت
- `TotalIncome`: درآمد تقریبی آن خدمت

---

## 🧠 منطق گزارش

در این اسکریپت ابتدا با یک کوئری، تعداد رزرو هر خدمت و درآمد تقریبی آن محاسبه می‌شود:

```sql
SELECT
    s.name,
    COUNT(rs.reservation_id) AS TotalReservations,
    COUNT(rs.reservation_id) * s.price AS TotalIncome
FROM Service s
LEFT JOIN Reservation_Service rs
    ON s.id = rs.service_id
GROUP BY s.name, s.price;
```

سپس نتیجه با استفاده از `Cursor` پیمایش می‌شود و هر رکورد به‌صورت جداگانه نمایش داده می‌شود.

استفاده از `LEFT JOIN` باعث می‌شود خدماتی که هنوز هیچ رزروی ندارند نیز در گزارش نمایش داده شوند.

---

## ⚠️ نکات مهم

- اگر دیتابیس `beautysalondb` وجود نداشته باشد، اسکریپت اجرا نمی‌شود.
- اگر جداول `Service` یا `Reservation_Service` وجود نداشته باشند، اسکریپت با خطا مواجه می‌شود.
- مقدار `TotalIncome` با فرمول زیر محاسبه می‌شود:

```text
تعداد رزرو × قیمت خدمت
```

- اگر هیچ رکوردی در جداول وجود نداشته باشد، ممکن است خروجی گزارش خالی باشد.

---

## 🔒 عدم آپلود فایل PDF

فایل PDF گزارش پروژه عمداً در این مخزن قرار داده نشده است.

برای جلوگیری از آپلود تصادفی فایل‌های PDF، می‌توانید یک فایل `.gitignore` در ریشه پروژه بسازید و محتوای زیر را در آن قرار دهید:

```gitignore
*.pdf
```

---

## 🛠️ تکنولوژی‌ها و مفاهیم استفاده‌شده

- SQL Server
- T-SQL
- Cursor
- LEFT JOIN
- GROUP BY
- Aggregate Functions
- گزارش‌گیری از پایگاه داده
- طراحی پایگاه داده رابطه‌ای

---

## 📚 هدف پروژه

این پروژه برای اهداف آموزشی و تمرین طراحی پایگاه داده، گزارش‌گیری و کار با SQL Server تهیه شده است.
