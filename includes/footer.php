<?php
if (!isset($base)) {
  $in_admin = isset($_SERVER['REQUEST_URI']) && strpos($_SERVER['REQUEST_URI'], '/admin/') !== false;
  $base = $in_admin ? '..' : '.';
}
$current_page = $page ?? ($_GET['page'] ?? 'home');
$wireframe_pages = ['home', 'products', 'product', 'login', 'register'];
$use_wireframe_shell = in_array($current_page, $wireframe_pages, true);
?>

<?php if (!$use_wireframe_shell): ?>
<footer class="site-footer mt-5">
  <div class="container py-5">
    <div class="row g-4">
      <div class="col-lg-5">
        <h5 class="footer-title mb-3">E-Commerce</h5>
        <p class="text-muted mb-3">Thoughtfully selected products, secure checkout, and smooth delivery from cart to doorstep.</p>
        <div class="d-flex gap-3">
          <a href="<?php echo $base; ?>/index.php?page=products&category=electronics" class="footer-chip">Electronics</a>
          <a href="<?php echo $base; ?>/index.php?page=products&category=fashion" class="footer-chip">Fashion</a>
          <a href="<?php echo $base; ?>/index.php?page=products&category=home-living" class="footer-chip">Home</a>
        </div>
      </div>
      <div class="col-sm-6 col-lg-3">
        <h6 class="mb-3">Shop</h6>
        <div class="d-grid gap-2">
          <a href="<?php echo $base; ?>/index.php?page=products" class="footer-link">All products</a>
          <a href="<?php echo $base; ?>/index.php?page=cart" class="footer-link">Cart</a>
          <a href="<?php echo $base; ?>/index.php?page=checkout" class="footer-link">Checkout</a>
        </div>
      </div>
      <div class="col-sm-6 col-lg-4">
        <h6 class="mb-3">Account</h6>
        <div class="d-grid gap-2">
          <?php if (isset($_SESSION['user'])): ?>
            <a href="<?php echo $base; ?>/index.php?page=logout" class="footer-link">Logout</a>
          <?php else: ?>
            <a href="<?php echo $base; ?>/index.php?page=login" class="footer-link">Login</a>
            <a href="<?php echo $base; ?>/index.php?page=register" class="footer-link">Create account</a>
          <?php endif; ?>
          <?php if ($current_page !== 'home'): ?>
            <a href="<?php echo $base; ?>/index.php?page=home" class="footer-link">Back to home</a>
          <?php endif; ?>
        </div>
      </div>
    </div>
    <div class="footer-bottom mt-4 pt-3">
      <small class="text-muted">&copy; <?php echo date('Y'); ?> E-Commerce. Built for fast, reliable online shopping.</small>
    </div>
  </div>
</footer>
<?php endif; ?>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<?php if ($current_page === 'home' || $current_page === 'products'): ?>
  <script src="<?php echo $base; ?>/assets/js/home.js"></script>
<?php endif; ?>
<?php if ($current_page === 'cart'): ?>
  <script src="<?php echo $base; ?>/assets/js/cart.js"></script>
<?php endif; ?>
<script src="<?php echo $base; ?>/assets/js/main.js"></script>
</body>
</html>
