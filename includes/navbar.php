<?php
$is_logged_in = isset($_SESSION['user']);
$user_name = $is_logged_in ? ($_SESSION['user']['name'] ?? 'Account') : null;
$roles = $is_logged_in ? ($_SESSION['user']['roles'] ?? []) : [];
$is_admin = is_array($roles) && in_array('admin', $roles, true);
if (!isset($base)) {
  $in_admin = isset($_SERVER['REQUEST_URI']) && strpos($_SERVER['REQUEST_URI'], '/admin/') !== false;
  $base = $in_admin ? '..' : '.';
}
$current_page = $_GET['page'] ?? 'home';
?>
<nav class="nav flex-column flex-lg-row align-items-lg-center gap-2 gap-lg-3 mt-3 mt-lg-2 nav-wrap">
  <a class="nav-link nav-link-custom <?php echo $current_page === 'home' ? 'active' : ''; ?>" href="<?php echo $base; ?>/index.php?page=home">Home</a>
  <a class="nav-link nav-link-custom <?php echo $current_page === 'products' ? 'active' : ''; ?>" href="<?php echo $base; ?>/index.php?page=products">Products</a>

  <div class="dropdown">
    <a class="nav-link nav-link-custom dropdown-toggle" href="#" id="navCategories" role="button" data-bs-toggle="dropdown" aria-expanded="false">
      Categories
    </a>
    <ul class="dropdown-menu" aria-labelledby="navCategories">
      <li><a class="dropdown-item" href="<?php echo $base; ?>/index.php?page=products&category=electronics">Electronics</a></li>
      <li><a class="dropdown-item" href="<?php echo $base; ?>/index.php?page=products&category=fashion">Fashion</a></li>
      <li><a class="dropdown-item" href="<?php echo $base; ?>/index.php?page=products&category=beauty">Beauty</a></li>
      <li><a class="dropdown-item" href="<?php echo $base; ?>/index.php?page=products&category=home-living">Home & Living</a></li>
      <li><a class="dropdown-item" href="<?php echo $base; ?>/index.php?page=products&category=accessories">Accessories</a></li>
      <li><a class="dropdown-item" href="<?php echo $base; ?>/index.php?page=products&category=shoes">Shoes</a></li>
    </ul>
  </div>

  <a class="nav-link nav-link-custom <?php echo $current_page === 'cart' ? 'active' : ''; ?> ms-lg-auto" href="<?php echo $base; ?>/index.php?page=cart">Cart</a>
  <a class="nav-link nav-link-custom <?php echo $current_page === 'checkout' ? 'active' : ''; ?>" href="<?php echo $base; ?>/index.php?page=checkout">Checkout</a>

  <?php if ($is_admin): ?>
    <a class="nav-link nav-link-custom" href="<?php echo $base; ?>/admin/dashboard.php">Admin</a>
  <?php endif; ?>

  <?php if ($is_logged_in): ?>
    <span class="text-muted small">Hi, <?php echo htmlspecialchars($user_name); ?></span>
    <a class="btn btn-outline-primary btn-sm" href="<?php echo $base; ?>/index.php?page=logout">Logout</a>
  <?php else: ?>
    <a class="btn btn-primary btn-sm" href="<?php echo $base; ?>/index.php?page=login">Login</a>
    <a class="btn btn-outline-primary btn-sm" href="<?php echo $base; ?>/index.php?page=register">Register</a>
  <?php endif; ?>
</nav>
