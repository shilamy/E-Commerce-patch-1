-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2025 at 09:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `label` varchar(50) DEFAULT 'home',
  `line1` varchar(255) NOT NULL,
  `line2` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(30) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `label`, `line1`, `line2`, `city`, `state`, `postal_code`, `country`, `is_default`, `created_at`) VALUES
(1, 6, 'juja', 'juja', 'juja', 'jujajuja', 'juja', '00200', 'Kenya', 0, '2025-11-27 16:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `token` varchar(191) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `token`, `created_at`, `updated_at`) VALUES
(1, NULL, '00ba53366b7fbdeb5482e4700e06f6d1', '2025-11-23 10:41:31', NULL),
(2, 6, NULL, '2025-11-27 16:50:41', '2025-11-27 16:58:31'),
(3, NULL, '74cabd756f61b1a8619329231e313d44', '2025-11-27 17:15:34', NULL),
(4, 7, NULL, '2025-11-27 17:16:31', NULL),
(5, NULL, 'eb8b67fc7c0a38b46267803a68e0258a', '2025-11-27 17:19:10', NULL),
(6, 8, NULL, '2025-11-27 17:20:26', NULL),
(7, NULL, '195316abda8c426e385220492ae72038', '2025-11-27 17:20:33', NULL),
(8, 9, NULL, '2025-11-27 17:21:11', NULL),
(9, NULL, 'ab28a6e36647748c48afd9d1cf4efcfe', '2025-11-27 17:24:51', NULL),
(10, NULL, '7b361d825ec6d14e08e321ab2dedef47', '2025-11-27 17:31:08', NULL),
(11, NULL, '5da9b9614d705b4ddd936173212fcac9', '2025-11-28 10:27:04', NULL),
(12, NULL, '70d5234a706b74141823f3debf895b03', '2025-11-28 10:42:49', NULL),
(13, NULL, '4ae48157ebeb622bba253658376cf62f', '2025-11-29 17:40:57', NULL),
(14, NULL, '61b79aa66f77ca1ad167b7cb1832a1ac', '2025-12-04 17:46:25', NULL),
(15, NULL, '47ad5d2e5e50c7aa9cb24bc8d52d9ed3', '2025-12-04 18:27:00', NULL),
(16, NULL, 'a84544553223bab65b01acdf9176397d', '2025-12-04 18:33:58', NULL),
(17, 1, NULL, '2025-12-04 18:34:37', NULL),
(18, NULL, '66a37c837efc4b69eb33814fc6c8e4dd', '2025-12-04 19:12:47', NULL),
(19, NULL, '4c8dce440c3cba877aad2e9900f368c5', '2025-12-04 19:52:24', NULL),
(20, NULL, 'cca3590aed936a772f15658793847c6f', '2025-12-04 19:53:09', NULL),
(21, NULL, '42ea15e085903870233f0bdfe57e7225', '2025-12-04 20:19:01', NULL),
(22, NULL, 'f2a11eae0ac08d6fa138b8b17f7d379b', '2025-12-04 20:47:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `cart_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `product_id`, `quantity`, `price`, `created_at`) VALUES
(1, 1, 20, 1, 199.99, '2025-11-23 10:41:31'),
(2, 1, 18, 1, 999.00, '2025-11-23 11:01:39'),
(3, 1, 21, 1, 49.99, '2025-11-23 11:01:40'),
(4, 2, 19, 1, 849.00, '2025-11-27 16:50:48'),
(5, 2, 20, 1, 199.99, '2025-11-27 16:50:48'),
(6, 2, 21, 1, 49.99, '2025-11-27 16:50:49'),
(7, 8, 19, 2, 849.00, '2025-11-27 17:43:34'),
(8, 8, 24, 1, 89.00, '2025-11-27 17:43:35'),
(9, 8, 10, 1, 29.99, '2025-11-27 17:43:36'),
(10, 8, 21, 1, 49.99, '2025-11-27 17:43:40'),
(11, 11, 19, 1, 849.00, '2025-11-28 10:41:48'),
(12, 13, 19, 1, 849.00, '2025-12-04 17:27:08'),
(13, 13, 20, 1, 199.99, '2025-12-04 17:27:09'),
(14, 13, 21, 1, 49.99, '2025-12-04 17:27:11'),
(15, 17, 28, 1, 549.00, '2025-12-04 18:56:55');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `parent_id`, `created_at`) VALUES
(1, 'Default', 'default', 'Default category', NULL, '2025-10-31 07:48:26'),
(2, 'Electronics', 'electronics', 'Electronic devices and gadgets', NULL, '2025-11-03 12:34:32'),
(3, 'Clothing', 'clothing', 'Apparel and fashion items', NULL, '2025-11-03 12:34:32'),
(4, 'Books', 'books', 'Books and educational materials', NULL, '2025-11-03 12:34:32'),
(5, 'Home & Garden', 'home-garden', 'Home improvement and garden supplies', NULL, '2025-11-03 12:34:32'),
(6, 'Sports', 'sports', 'Sports equipment and accessories', NULL, '2025-11-03 12:34:32'),
(8, 'Home & Living', 'home-living', 'Elevate your space', NULL, '2025-12-04 17:43:55'),
(9, 'Fashion', 'fashion', 'Timeless style', NULL, '2025-12-04 17:43:55'),
(10, 'Beauty', 'beauty', 'Care and cosmetics', NULL, '2025-12-04 17:43:55'),
(11, 'Accessories', 'accessories', 'Complete your look', NULL, '2025-12-04 17:43:55'),
(12, 'Shoes', 'shoes', 'Footwear for every occasion', NULL, '2025-12-04 17:43:55'),
(13, 'Gaming', 'gaming', 'Gaming equipment and accessories', NULL, '2025-12-04 17:53:43'),
(14, 'Computers', 'computers', 'Laptops, desktops, and accessories', 2, '2025-12-04 17:53:43'),
(15, 'Audio', 'audio', 'Headphones, speakers, and audio equipment', 2, '2025-12-04 17:53:43'),
(16, 'Mobile Devices', 'mobile-devices', 'Smartphones and tablets', 2, '2025-12-04 17:53:43'),
(17, 'Furniture', 'furniture', 'Furniture', 8, '2025-12-04 17:53:43'),
(18, 'Lighting', 'lighting', 'Lighting', 8, '2025-12-04 17:53:43'),
(19, 'Decor', 'decor', 'Decor', 8, '2025-12-04 17:53:43'),
(20, 'Men Clothing', 'men-clothing', 'Men clothing', 9, '2025-12-04 17:53:43'),
(21, 'Women Clothing', 'women-clothing', 'Women clothing', 9, '2025-12-04 17:53:43'),
(22, 'Dresses', 'dresses', 'Dresses', 9, '2025-12-04 17:53:43'),
(23, 'Skincare', 'skincare', 'Skincare', 10, '2025-12-04 17:53:43'),
(24, 'Haircare', 'haircare', 'Haircare', 10, '2025-12-04 17:53:43'),
(25, 'Fragrance', 'fragrance', 'Perfume and fragrance', 10, '2025-12-04 17:53:43'),
(26, 'Bags', 'bags', 'Bags', 11, '2025-12-04 17:53:43'),
(27, 'Belts', 'belts', 'Belts', 11, '2025-12-04 17:53:43'),
(28, 'Sunglasses', 'sunglasses', 'Sunglasses', 11, '2025-12-04 17:53:43'),
(29, 'Watches', 'watches', 'Watches', 11, '2025-12-04 17:53:43'),
(30, 'Men Shoes', 'men-shoes', 'Men shoes', 12, '2025-12-04 17:53:43'),
(31, 'Women Shoes', 'women-shoes', 'Women shoes', 12, '2025-12-04 17:53:43'),
(32, 'Kids Shoes', 'kids-shoes', 'Kids shoes', 12, '2025-12-04 17:53:43');

-- --------------------------------------------------------

--
-- Table structure for table `email_verifications`
--

CREATE TABLE `email_verifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token` varchar(191) NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_verifications`
--

INSERT INTO `email_verifications` (`id`, `user_id`, `token`, `expires_at`, `verified_at`, `created_at`) VALUES
(1, 9, '581e1b4d6bcf0760c7573afcbe2fac64', '2025-11-28 15:25:10', '2025-11-27 17:29:32', '2025-11-27 17:25:10'),
(2, 1, '36cfd2c49db9c6d96be362a5c66a6f8b', '2025-12-05 16:33:43', NULL, '2025-12-04 18:33:43');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `order_number` varchar(100) NOT NULL,
  `billing_address_id` int(10) UNSIGNED DEFAULT NULL,
  `shipping_address_id` int(10) UNSIGNED DEFAULT NULL,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(12,2) DEFAULT 0.00,
  `shipping` decimal(12,2) DEFAULT 0.00,
  `status` enum('pending','processing','shipped','completed','cancelled','refunded') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_number`, `billing_address_id`, `shipping_address_id`, `total`, `tax`, `shipping`, `status`, `created_at`, `updated_at`) VALUES
(1, 6, 'ORD-20251127175831-2653', 1, 1, 1098.98, 0.00, 0.00, 'pending', '2025-11-27 16:58:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `sku`, `name`, `quantity`, `price`, `total`, `created_at`) VALUES
(1, 1, 19, NULL, 'Samsung Galaxy S23', 1, 849.00, 849.00, '2025-11-27 16:58:31'),
(2, 1, 20, NULL, 'Noise-Cancelling Headphones', 1, 199.99, 199.99, '2025-11-27 16:58:31'),
(3, 1, 21, NULL, 'Men\'s Hoodie', 1, 49.99, 49.99, '2025-11-27 16:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token` varchar(191) NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `method` varchar(100) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` varchar(10) DEFAULT 'USD',
  `status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `method`, `amount`, `currency`, `status`, `transaction_id`, `created_at`) VALUES
(1, 1, 'mpesa', 1098.98, 'KES', 'pending', NULL, '2025-11-27 16:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `image_path` varchar(255) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `name`, `slug`, `description`, `category_id`, `tags`, `price`, `image_path`, `sale_price`, `stock`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'SKU-001', 'Sample Product', 'sample-product', 'This is a sample product.', NULL, NULL, 2800.00, NULL, NULL, 100, 1, '2025-10-31 07:48:26', '2025-12-04 19:12:37'),
(10, NULL, 'Sample Product A', 'sample-product-a', 'A great demo product.', NULL, NULL, 4200.00, NULL, NULL, 25, 1, '2025-11-04 08:23:29', '2025-12-04 19:12:37'),
(11, NULL, 'Sample Product B', 'sample-product-b', 'Another awesome demo product.', NULL, NULL, 7000.00, NULL, NULL, 15, 1, '2025-11-04 08:23:29', '2025-12-04 19:12:37'),
(12, NULL, 'Sample Product C', 'sample-product-c', 'Budget-friendly demo product.', NULL, NULL, 2800.00, NULL, NULL, 40, 1, '2025-11-04 08:23:29', '2025-12-04 19:12:37'),
(13, NULL, 'Sample Product D', 'sample-product-d', 'Premium demo product.', NULL, NULL, 13850.00, NULL, NULL, 10, 1, '2025-11-04 08:23:29', '2025-12-04 19:12:37'),
(18, NULL, 'iPhone 14 Pro', 'iphone-14-pro', 'Apple smartphone with ProMotion and triple camera.', 2, 'smartphone, ios, apple, phone', 139850.00, 'https://images.unsplash.com/photo-1661961112951-212f75b469c5?w=800&q=80', NULL, 12, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(19, NULL, 'Samsung Galaxy S23', 'galaxy-s23', 'Flagship Android phone with excellent display.', 2, 'smartphone, android, samsung', 118850.00, 'https://images.unsplash.com/photo-1616348439968-6a0e7b94f7d0?w=800&q=80', NULL, 19, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(20, NULL, 'Noise-Cancelling Headphones', 'anc-headphones', 'Over-ear headphones with active noise cancellation.', 2, 'headphones, audio, anc', 28000.00, 'https://images.unsplash.com/photo-1518449032403-1f5b1e69aa1f?w=800&q=80', NULL, 34, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(21, NULL, 'Men\'s Hoodie', 'mens-hoodie', 'Comfortable cotton hoodie for everyday wear.', 3, 'hoodie, apparel, men', 7000.00, 'https://images.unsplash.com/photo-1520975954732-3510801df756?w=800&q=80', NULL, 49, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(22, NULL, 'Women\'s Sneakers', 'womens-sneakers', 'Lightweight sneakers suitable for daily walking.', 3, 'sneakers, shoes, women', 11200.00, 'https://images.unsplash.com/photo-1528701800484-3a1bd0e6f336?w=800&q=80', NULL, 28, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(23, NULL, 'Succulent Plant', 'succulent-plant', 'Low-maintenance succulent for home decor.', 5, 'plant, decor, succulent', 2100.00, 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=800&q=80', NULL, 80, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(24, NULL, 'Cordless Drill', 'cordless-drill', 'Handy cordless drill for DIY projects.', 5, 'tools, diy, drill', 12450.00, 'https://images.unsplash.com/photo-1581092923532-cc1b5fd11849?w=800&q=80', NULL, 25, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(25, NULL, 'Fitness Tracker', 'fitness-tracker', 'Track steps, heart rate, and sleep.', 6, 'wearable, fitness, tracker', 18050.00, 'https://images.unsplash.com/photo-1517433456452-f9633a875f6f?w=800&q=80', NULL, 40, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(26, NULL, 'Yoga Mat', 'yoga-mat', 'Non-slip yoga mat for comfortable workouts.', 6, 'yoga, mat, workout', 4200.00, 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&q=80', NULL, 60, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(27, NULL, 'Bestselling Novel', 'bestselling-novel', 'Engaging story from a bestselling author.', 4, 'book, fiction, novel', 2500.00, 'https://images.unsplash.com/photo-1519682330486-97fcf0be22d3?w=800&q=80', NULL, 100, 1, '2025-11-04 08:24:03', '2025-12-04 19:12:37'),
(28, 'TV-55-4K', 'Smart TV 55\" 4K', 'smart-tv-55-4k', 'Ultra HD smart TV with HDR', NULL, NULL, 83850.00, NULL, 76850.00, 40, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(29, 'PHONE-Z', 'Smartphone Z', 'smartphone-z', '128GB 5G smartphone', NULL, NULL, 55850.00, NULL, 51650.00, 60, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(30, 'SPEAKER-BT', 'Bluetooth Speaker', 'bluetooth-speaker', 'Portable speaker with deep bass', NULL, NULL, 12450.00, NULL, 11050.00, 120, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(31, 'LAPTOP-AIR', 'Ultrabook Air 13', 'ultrabook-air-13', 'Lightweight laptop 8GB/256GB', NULL, NULL, 111850.00, NULL, 104850.00, 77, 1, '2025-12-04 17:46:25', '2025-12-04 19:36:57'),
(32, 'SOFA-MOD', 'Sofa Modern 3-Seater', 'sofa-modern-3-seater', 'Minimal fabric sofa', NULL, NULL, 69850.00, NULL, 65650.00, 15, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(33, 'TABLE-COFFEE', 'Coffee Table Minimal', 'coffee-table-minimal', 'Oak veneer coffee table', NULL, NULL, 27850.00, NULL, 25050.00, 40, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(34, 'LAMP-ARC', 'Arc Floor Lamp', 'arc-floor-lamp', 'Steel arc lamp, warm LED', NULL, NULL, 22250.00, NULL, 19450.00, 50, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(35, 'SHELVES-WALL', 'Wall Shelves Set', 'wall-shelves-set', 'Set of 3 floating shelves', NULL, NULL, 12450.00, NULL, NULL, 70, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(36, 'JACKET-MONO', 'Men’s Jacket Mono', 'mens-jacket-mono', 'Water-resistant monochrome jacket', NULL, NULL, 18050.00, NULL, 16650.00, 80, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(37, 'HOODIE-URBAN', 'Men’s Urban Hoodie', 'mens-urban-hoodie', 'Heavyweight fleece hoodie', NULL, NULL, 11050.00, NULL, 9650.00, 100, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(38, 'DRESS-MIDI', 'Women’s Midi Dress', 'womens-midi-dress', 'Tailored midi dress', NULL, NULL, 19450.00, NULL, 18050.00, 70, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(39, 'BAG-TOTE', 'Women’s Tote Bag', 'womens-tote-bag', 'Leather tote with inner pocket', NULL, NULL, 20850.00, NULL, 18050.00, 90, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(40, 'BELT-CLASSIC', 'Leather Belt Classic', 'leather-belt-classic', 'Full-grain leather belt', NULL, NULL, 6850.00, NULL, 5450.00, 200, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(41, 'SUNGLASSES-AVI', 'Sunglasses Aviator', 'sunglasses-aviator', 'Polarized lenses', NULL, NULL, 12450.00, NULL, 11050.00, 120, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(42, 'WATCH-CHRONO', 'Watch Chrono Steel', 'watch-chrono-steel', 'Chronograph quartz watch', NULL, NULL, 27850.00, NULL, 25050.00, 50, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(43, 'SKINCARE-SET', 'Skin Care Essentials', 'skin-care-essentials', 'Cleanser, serum, moisturizer', NULL, NULL, 9650.00, NULL, 8250.00, 150, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(44, 'HAIRDRYER-PRO', 'Hair Dryer Pro', 'hair-dryer-pro', '2000W ionic dryer', NULL, NULL, 11050.00, NULL, 9650.00, 110, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(45, 'PERFUME-NOIR', 'Perfume Noir', 'perfume-noir', 'Eau de parfum 50ml', NULL, NULL, 13850.00, NULL, 12450.00, 90, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(46, 'SNEAKERS-PRO', 'Running Shoes Pro', 'running-shoes-pro', 'Breathable mesh upper', NULL, NULL, 16650.00, NULL, 15250.00, 120, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(47, 'HEELS-LX', 'Stiletto Heels Luxe', 'stiletto-heels-luxe', 'Pointed toe leather heels', NULL, NULL, 20850.00, NULL, 19450.00, 60, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(48, 'BOOTS-RUGGED', 'Rugged Leather Boots', 'rugged-leather-boots', 'All-weather outsole', NULL, NULL, 22250.00, NULL, 20850.00, 80, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(49, 'SANDALS-COMF', 'Comfort Sandals', 'comfort-sandals', 'Cushioned footbed', NULL, NULL, 9650.00, NULL, 8250.00, 140, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(50, 'KIDS-SNEAK', 'Kids Sneakers Sprint', 'kids-sneakers-sprint', 'Light EVA sole', NULL, NULL, 8250.00, NULL, 6850.00, 160, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37'),
(51, 'BACKPACK-URB', 'Backpack Urban', 'backpack-urban', 'Water-resistant nylon', NULL, NULL, 12450.00, NULL, 11050.00, 130, 1, '2025-12-04 17:46:25', '2025-12-04 19:12:37');

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`product_id`, `category_id`) VALUES
(1, 1),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 8),
(33, 8),
(34, 8),
(35, 8),
(36, 9),
(37, 9),
(38, 9),
(39, 11),
(40, 11),
(41, 11),
(42, 11),
(43, 10),
(44, 10),
(45, 10),
(46, 12),
(47, 12),
(48, 12),
(49, 12),
(50, 12),
(51, 9),
(51, 11);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `file_path`, `alt_text`, `order`, `created_at`) VALUES
(1, 28, 'assets/images/products/peter-albanese-7fegck-1hkw-unsplash-2-1762258249-0-8752a513.jpg', 'Smart TV 55\" 4K', 0, '2025-12-04 17:46:25'),
(2, 29, 'assets/images/products/nik-ads33nl7v4k-unsplash-11-1762331865-0-dba2f188.jpg', 'Smartphone Z', 0, '2025-12-04 17:46:25'),
(3, 30, 'assets/images/products/patrick-langwallner-gahmbqnh5q8-unsplash-3-1762259201-0-687a1acd.jpg', 'Bluetooth Speaker', 0, '2025-12-04 17:46:25'),
(4, 31, 'assets/images/products/kam-idris-3-gxeue_scc-unsplash-4-1762328579-0-91685270.jpg', 'Ultrabook Air 13', 0, '2025-12-04 17:46:25'),
(5, 32, 'assets/images/products/spacejoy-9m66c_w_tom-unsplash-10-1762329977-0-270f9018.jpg', 'Sofa Modern 3-Seater', 0, '2025-12-04 17:46:25'),
(6, 33, 'assets/images/products/anomaly-wwesmhegxds-unsplash-13-1762345651-0-0c496998.jpg', 'Coffee Table Minimal', 0, '2025-12-04 17:46:25'),
(7, 34, 'assets/images/products/filip-mroz-gma1zfs3_6e-unsplash-18-1762353746-0-dd05ade3.jpg', 'Arc Floor Lamp', 0, '2025-12-04 17:46:25'),
(8, 35, 'assets/images/products/joan-tran-reeysfadyjq-unsplash-17-1762353552-0-c5ef8604.jpg', 'Wall Shelves Set', 0, '2025-12-04 17:46:25'),
(9, 36, 'assets/images/products/luke-peterson-lumj2zv5hue-unsplash-16-1762353291-0-49241f6a.jpg', 'Men’s Jacket Mono', 0, '2025-12-04 17:46:25'),
(10, 37, 'assets/images/products/clem-onojeghuo-c317wf_dydg-unsplash-12-1762345407-0-368dd1d7.jpg', 'Men’s Urban Hoodie', 0, '2025-12-04 17:46:25'),
(11, 38, 'assets/images/products/valeriia-miller-_42nkyrog7g-unsplash-15-1762348596-0-9adcf3c5.jpg', 'Women’s Midi Dress', 0, '2025-12-04 17:46:25'),
(12, 39, 'assets/images/products/fashion-needles-bxueghzjars-unsplash-14-1762346017-0-d71a5c15.jpg', 'Women’s Tote Bag', 1, '2025-12-04 17:46:25'),
(13, 40, 'assets/images/products/pantalon----chevilles-uni-bleu-marine-authentique-des-ann--es-1950-pour-homme-40x35_-22-1762355562-0-9d558126.jpg', 'Leather Belt Classic', 0, '2025-12-04 17:46:25'),
(14, 41, 'assets/images/products/peter-albanese-7fegck-1hkw-unsplash-2-1762258249-0-8752a513.jpg', 'Sunglasses Aviator', 0, '2025-12-04 17:46:25'),
(15, 42, 'assets/images/products/patrick-langwallner-gahmbqnh5q8-unsplash-3-1762259201-0-687a1acd.jpg', 'Watch Chrono Steel', 0, '2025-12-04 17:46:25'),
(16, 43, 'assets/images/products/download-19-1762354472-0-ff9df2ca.jpg', 'Skin Care Essentials', 0, '2025-12-04 17:46:25'),
(17, 44, 'assets/images/products/download--1--20-1762355146-0-d88f7adc.jpg', 'Hair Dryer Pro', 0, '2025-12-04 17:46:25'),
(18, 45, 'assets/images/products/download--2--21-1762355326-0-e9712aab.jpg', 'Perfume Noir', 0, '2025-12-04 17:46:25'),
(19, 46, 'assets/images/products/nik-ads33nl7v4k-unsplash-11-1762331865-0-dba2f188.jpg', 'Running Shoes Pro', 0, '2025-12-04 17:46:25'),
(20, 47, 'assets/images/products/valeriia-miller-_42nkyrog7g-unsplash-15-1762348596-0-9adcf3c5.jpg', 'Stiletto Heels Luxe', 0, '2025-12-04 17:46:25'),
(21, 48, 'assets/images/products/joan-tran-reeysfadyjq-unsplash-17-1762353552-0-c5ef8604.jpg', 'Rugged Leather Boots', 0, '2025-12-04 17:46:25'),
(22, 49, 'assets/images/products/luke-peterson-lumj2zv5hue-unsplash-16-1762353291-0-49241f6a.jpg', 'Comfort Sandals', 0, '2025-12-04 17:46:25'),
(23, 50, 'assets/images/products/valeriia-miller-_42nkyrog7g-unsplash-15-1762348596-0-9adcf3c5.jpg', 'Kids Sneakers Sprint', 0, '2025-12-04 17:46:25'),
(24, 51, 'assets/images/products/anomaly-wwesmhegxds-unsplash-13-1762345651-0-0c496998.jpg', 'Backpack Urban', 0, '2025-12-04 17:46:25'),
(25, 39, 'assets/images/products/tote-39-1764877913-0-1b9e362c.webp', 'Women’s Tote Bag', 0, '2025-12-04 19:51:53');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL CHECK (`rating` between 1 and 5),
  `title` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'admin', 'Administrator with full access', '2025-10-31 07:48:22'),
(2, 'customer', 'Regular customer', '2025-10-31 07:48:22');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `key` varchar(191) NOT NULL,
  `value` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`key`, `value`, `updated_at`) VALUES
('bootstrap_done', '1', '2025-12-04 17:43:55'),
('currency', 'KSh', '2025-12-04 17:43:55'),
('delivery_base_fee', '150', '2025-12-04 17:43:55'),
('delivery_per_km', '50', '2025-12-04 17:43:55'),
('free_delivery_threshold', '0', '2025-12-04 17:43:55'),
('prices_converted_to_ksh', '1', '2025-12-04 19:12:37'),
('site_description', 'Your one-stop shop for curated products', '2025-12-04 17:43:55'),
('site_name', 'E-Commerce Store', '2025-12-04 17:43:55'),
('tax_rate', '0.08', '2025-12-04 17:43:55');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('customer','admin') NOT NULL DEFAULT 'customer',
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `password_hash`, `role`, `first_name`, `last_name`, `phone`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'System Admin', 'admin@example.com', '$2b$12$v8F42ntQ4vnAEnxcINyPJ.HhLCT9/jo29fR4IjsJCI/EaOKZK/m.i', '$2y$10$XXaLWoxyKIwWDWMu4u.hp.Ga.eLhSW4stqGxpJNb4R4T4KboLVtfi', 'admin', 'System', 'Admin', NULL, 1, '2025-10-31 07:48:25', '2025-12-04 18:32:45'),
(2, 'Jane Customer', 'customer@example.com', '$2y$10$fWNAj.gQHJwNqEsCjZmvYeAY4j1cqk5bixWU8GiBakVATntKlX.MK', '$2y$10$ec32f7ae2f8bfb476af2b5e53ac2fcd711a9eee31966d26b363d55eb5f81430d', 'customer', 'Jane', 'Customer', NULL, 1, '2025-10-31 07:48:25', '2025-12-04 17:43:55'),
(6, '', 'michelleallias1738@gmail.com', '$2y$10$8Trq2Cz12eBOQOaSvDrbvuQPjuLtgS8FNxO7LQbALOxXkXy7KbDe2', NULL, 'customer', 'Michelle', 'Kabura', NULL, 1, '2025-11-27 16:50:08', NULL),
(7, '', 'jack.iso012@gmail.com', '$2y$10$iEvfQTk6Sc674t7GJpJW.u97Z.uJ1JVYcON6sxJ981TKox08MUc7y', NULL, 'customer', 'jackson', NULL, NULL, 1, '2025-11-27 17:16:30', NULL),
(8, '', 'jacksonkabiru9@gmail.com', '$2y$10$pK7zEiXLAQnxJcg70k14pepdxUA2zKs83aSWhLRuXgba6tg4FgnZW', NULL, 'customer', 'jackson', NULL, NULL, 1, '2025-11-27 17:20:26', NULL),
(9, '', 'michelle.ndibuik@gmail.com', '$2y$10$I0Nsf6kkqwB4/2QgQOnLYey8.ENGTxR4QcgJ6ytecH.lm3uilzTVa', NULL, 'customer', 'Michelle', 'Kabura', NULL, 1, '2025-11-27 17:21:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1, 1),
(2, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `idx_categories_slug` (`slug`);

--
-- Indexes for table `email_verifications`
--
ALTER TABLE `email_verifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `billing_address_id` (`billing_address_id`),
  ADD KEY `shipping_address_id` (`shipping_address_id`),
  ADD KEY `idx_orders_user` (`user_id`),
  ADD KEY `idx_orders_number` (`order_number`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `idx_products_name` (`name`),
  ADD KEY `idx_products_slug` (`slug`),
  ADD KEY `fk_products_category` (`category_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `email_verifications`
--
ALTER TABLE `email_verifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `email_verifications`
--
ALTER TABLE `email_verifications`
  ADD CONSTRAINT `email_verifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`billing_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`shipping_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
