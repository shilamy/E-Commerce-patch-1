<?php
// Shared header and conditional app-shell rendering
?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>E-Commerce</title>
    <?php
      $in_admin = isset($_SERVER['REQUEST_URI']) && strpos($_SERVER['REQUEST_URI'], '/admin/') !== false;
      $base = $in_admin ? '..' : '.';
      $current_page = $page ?? ($_GET['page'] ?? 'home');
      $wireframe_pages = ['home', 'products', 'product', 'login', 'register'];
      $use_wireframe_shell = in_array($current_page, $wireframe_pages, true);
      $logo_exists = file_exists(__DIR__ . '/../assets/images/logo.png');
    ?>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/vendor.css">
    <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/style.css">
    <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/theme-light.css">

    <?php if ($current_page === 'home' || $current_page === 'products'): ?>
      <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/home.css">
    <?php endif; ?>
    <?php if ($current_page === 'product'): ?>
      <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/product.css">
    <?php endif; ?>
    <?php if ($current_page === 'checkout'): ?>
      <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/checkout.css">
    <?php endif; ?>
    <?php if ($current_page === 'cart'): ?>
      <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/cart.css">
    <?php endif; ?>
    <?php if ($current_page === 'login' || $current_page === 'register'): ?>
      <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/auth.css">
    <?php endif; ?>
    <?php if ($in_admin): ?>
      <link rel="stylesheet" href="<?php echo $base; ?>/assets/css/admin.css">
    <?php endif; ?>
  </head>
  <body class="page-<?php echo htmlspecialchars($current_page, ENT_QUOTES, 'UTF-8'); ?><?php echo $use_wireframe_shell ? ' wireframe-page' : ''; ?>">

    <?php if (!$use_wireframe_shell): ?>
      <header class="header-area">
        <div class="container-fluid header-shell">
          <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <a href="<?php echo $base; ?>/index.php?page=home" class="brand-link text-decoration-none">
              <?php if ($logo_exists): ?>
                <img src="<?php echo $base; ?>/assets/images/logo.png" alt="Logo" class="brand-logo">
              <?php endif; ?>
              <span class="brand-wordmark">E-Commerce</span>
            </a>

            <form id="search-form" class="input-group search-group" method="get" action="<?php echo $base; ?>/index.php">
              <input type="hidden" name="page" value="products">
              <span class="input-group-text">Browse</span>
              <input type="text" name="q" class="form-control" placeholder="Search products, brands, categories" value="<?php echo isset($_GET['q']) ? htmlspecialchars($_GET['q']) : ''; ?>">
              <button class="btn btn-primary" type="submit">Search</button>
            </form>

            <button class="btn btn-outline-dark d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav" aria-controls="mainNav" aria-expanded="false" aria-label="Toggle navigation">
              <i class="fa fa-bars"></i>
            </button>
          </div>

          <div class="collapse d-lg-block" id="mainNav">
            <?php include __DIR__ . '/navbar.php'; ?>
          </div>
        </div>
      </header>
    <?php endif; ?>

    <?php if (!empty($_SESSION['flash'])): ?>
      <div class="<?php echo $use_wireframe_shell ? 'wf-mobile-shell px-2 pt-2' : 'container mt-3'; ?>">
        <div class="alert alert-primary mb-0">
          <?php echo htmlspecialchars($_SESSION['flash']); unset($_SESSION['flash']); ?>
        </div>
      </div>
    <?php endif; ?>
