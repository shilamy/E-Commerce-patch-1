<?php
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/db_functions.php';

$category_slug = isset($_GET['category']) ? trim($_GET['category']) : null;
$search_q = isset($_GET['q']) ? trim($_GET['q']) : null;
$category = ($category_slug && db_has_connection()) ? get_category_by_slug($category_slug) : null;
$category_id = $category ? (int)$category['id'] : null;

try {
  if (db_has_connection()) {
    if ($search_q !== null && $search_q !== '') {
      $items = get_products_search($search_q, $category_id);
    } else {
      $items = get_products(null, $category_id);
    }
  } else {
    $items = [];
  }
} catch (Exception $e) {
  error_log('Error loading products: ' . $e->getMessage());
  $items = [];
}

$cart_count = 0;
try {
  if (isset($_SESSION['user'])) {
    $cart = get_user_cart((int)$_SESSION['user']['id']);
  } else {
    $cart = get_session_cart();
  }
  if (!empty($cart['items'])) {
    foreach ($cart['items'] as $item) {
      $cart_count += (int)$item['quantity'];
    }
  }
} catch (Exception $e) {
  error_log('Cart count error: ' . $e->getMessage());
}

$category_cards = [
  ['slug' => 'electronics', 'label' => 'ELECTRONICS', 'img' => get_category_preview_image('electronics')],
  ['slug' => 'fashion', 'label' => 'FASHION', 'img' => get_category_preview_image('fashion')],
  ['slug' => 'beauty', 'label' => 'BEAUTY', 'img' => get_category_preview_image('beauty')],
  ['slug' => 'home-living', 'label' => 'HOME', 'img' => get_category_preview_image('home-living')],
  ['slug' => 'accessories', 'label' => 'ACCESSORIES', 'img' => get_category_preview_image('accessories')],
  ['slug' => 'shoes', 'label' => 'SHOES', 'img' => get_category_preview_image('shoes')]
];
?>

<section class="wf-page">
  <div class="wf-mobile-shell">
    <div class="wf-products-top">
      <div class="wf-topbar">
        <a href="index.php?page=home" class="wf-icon-link" aria-label="Back">
          <i class="fas fa-arrow-left"></i>
        </a>
        <div class="wf-top-right">
          <a href="index.php?page=cart" class="wf-icon-link" aria-label="Cart">
            <i class="fas fa-shopping-bag"></i>
            <?php if ($cart_count > 0): ?>
              <span class="wf-count"><?php echo (int)$cart_count; ?></span>
            <?php endif; ?>
          </a>
          <a href="index.php?page=<?php echo isset($_SESSION['user']) ? 'checkout' : 'login'; ?>" class="wf-icon-link" aria-label="Account">
            <i class="fas fa-user"></i>
          </a>
        </div>
      </div>

      <form method="get" action="index.php" class="wf-search-row">
        <input type="hidden" name="page" value="products">
        <div class="wf-search-box">
          <i class="fas fa-search"></i>
          <input type="text" name="q" class="wf-search-input" placeholder="Search products" value="<?php echo htmlspecialchars((string)$search_q); ?>">
        </div>
        <button type="submit" class="wf-filter-btn" aria-label="Search">
          <i class="fas fa-sliders-h"></i>
        </button>
      </form>

      <div class="wf-strip-head">
        <span><?php echo $category ? htmlspecialchars(strtoupper($category['name'])) : 'CATEGORIES'; ?></span>
        <a href="index.php?page=products">VIEW ALL</a>
      </div>

      <div class="wf-category-row">
        <?php foreach ($category_cards as $cat): ?>
          <a class="wf-category-chip" href="index.php?page=products&category=<?php echo urlencode($cat['slug']); ?>">
            <span class="wf-category-dot"><img src="<?php echo htmlspecialchars($cat['img']); ?>" alt="<?php echo htmlspecialchars($cat['label']); ?>"></span>
            <?php echo htmlspecialchars($cat['label']); ?>
          </a>
        <?php endforeach; ?>
      </div>
    </div>

    <div class="wf-card-zone">
      <div class="wf-strip-head">
        <span>
          <?php if ($search_q): ?>
            RESULTS FOR "<?php echo htmlspecialchars(strtoupper($search_q)); ?>"
          <?php elseif ($category): ?>
            <?php echo htmlspecialchars(strtoupper($category['name'])); ?>
          <?php else: ?>
            FEATURED PICKS
          <?php endif; ?>
        </span>
        <a href="index.php?page=products">VIEW ALL</a>
      </div>

      <?php if (empty($items)): ?>
        <div class="wf-empty">No products found for your filters.</div>
      <?php else: ?>
        <div class="wf-grid">
          <?php foreach ($items as $p): ?>
            <?php
              $new_price = (float)($p['sale_price'] ?? $p['price']);
              $old_price = isset($p['sale_price']) && (float)$p['sale_price'] < (float)$p['price'] ? (float)$p['price'] : null;
              $product_image = resolve_product_image_path($p);
            ?>
            <a href="index.php?page=product&id=<?php echo (int)$p['id']; ?>" class="wf-product-card">
              <div class="wf-product-image-wrap">
                <img class="wf-product-image" src="<?php echo htmlspecialchars($product_image); ?>" alt="<?php echo htmlspecialchars($p['name']); ?>">
              </div>
              <div class="wf-product-name"><?php echo htmlspecialchars($p['name']); ?></div>
              <div class="wf-product-sub"><?php echo !empty($p['category']) ? htmlspecialchars($p['category']) : 'Popular Item'; ?></div>
              <div class="wf-price-line">
                <span class="wf-price-new"><?php echo format_currency($new_price); ?></span>
                <?php if ($old_price !== null): ?>
                  <span class="wf-price-old"><?php echo format_currency($old_price); ?></span>
                  <span class="wf-off">24% Off</span>
                <?php endif; ?>
              </div>
            </a>
          <?php endforeach; ?>
        </div>
      <?php endif; ?>
    </div>

    <nav class="wf-bottom-nav" aria-label="Main">
      <a class="wf-bottom-link" href="index.php?page=home" aria-label="Home"><i class="fas fa-home"></i></a>
      <a class="wf-bottom-link active" href="index.php?page=products" aria-label="Explore"><i class="fas fa-search"></i></a>
      <a class="wf-bottom-link" href="index.php?page=cart" aria-label="Wishlist"><i class="far fa-heart"></i></a>
      <a class="wf-bottom-link" href="index.php?page=<?php echo isset($_SESSION['user']) ? 'checkout' : 'login'; ?>" aria-label="Account"><i class="fas fa-user"></i></a>
    </nav>
  </div>
</section>
