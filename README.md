# E‑Commerce (PHP)

A minimal PHP e‑commerce scaffold to get you started quickly on XAMPP/WAMP.

## Features

- Basic product listing, cart, and checkout flow
- Simple project structure with assets, pages, includes, admin, config
- Basic router via index.php?page=...
- Shared header/footer and navbar
- Starter CSS/JS and placeholder pages

## Requirements

- PHP 8.0+
- MySQL 8.0+
- XAMPP/WAMP (local server)

## Getting Started

1. Copy this folder into your server root (XAMPP htdocs).
   - Current path: c:\\xampp\\htdocs\\e-commerce (keep as-is).
2. Start Apache/MySQL from XAMPP.
3. Create a database (e.g., ecommerce_db).
4. Update config/db.php credentials if needed (XAMPP defaults: user root, password empty).
5. Visit in browser:
   - If served via Apache: <http://localhost/e-commerce/>
   - If using PHP built-in server:

## Notes

- This is a scaffold; wire up real product, cart, auth, and admin logic next.
- Replace placeholder images under assets/images with real assets.

## Docker Deployment

1. Copy Docker env template:
   - Windows (PowerShell): `Copy-Item .env.docker.example .env`
   - macOS/Linux: `cp .env.docker.example .env`
2. Build and start containers:
   - `docker compose up --build -d`
3. Open the app:
   - `http://localhost:8080`
4. MySQL is available on:
   - Host: `127.0.0.1`
   - Port: `3307`
   - Database/user/password from `.env`

Notes:
- Database bootstrap SQL is mounted from `ecommerce_db.sql`.
- Uploaded files persist via Docker volume `app_uploads`.
- DB data persists via Docker volume `db_data`.

## Structure

assets/
  css/style.css
  js/main.js
  images/
config/db.php
includes/
  header.php
  footer.php
  navbar.php
pages/
  home.php
  product.php
  cart.php
  checkout.php
  login.php
  register.php
admin/
  dashboard.php
  add_product.php
  edit_product.php
  view_orders.php
  manage_users.php
uploads/
index.php
README.md
SETUP_GUIDE.md
