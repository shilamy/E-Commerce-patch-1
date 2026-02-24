<?php
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/db_functions.php';

$section_blueprints = [
  ['slug' => 'home-living', 'title' => 'Home Essentials', 'search' => 'home'],
  ['slug' => 'fashion', 'title' => 'Fashion Picks', 'search' => 'fashion'],
  ['slug' => 'electronics', 'title' => 'Electronics Deals', 'search' => 'electronic'],
  ['slug' => 'accessories', 'title' => 'Accessories Spotlight', 'search' => 'accessory'],
];

$section_products = [];
$items = [];

try {
  if (db_has_connection()) {
    $seen = [];
    foreach ($section_blueprints as $section) {
      $slug = $section['slug'];
      $section_items = [];

      $category = get_category_by_slug($slug);
      if ($category && isset($category['id'])) {
        $section_items = get_products(10, (int)$category['id']);
      }

      if (empty($section_items) && !empty($section['search'])) {
        $section_items = get_products_search($section['search'], null, 10);
      }

      if (empty($section_items)) {
        $section_items = get_products(10);
      }

      $section_products[$slug] = $section_items;
      foreach ($section_items as $entry) {
        $pid = (int)($entry['id'] ?? 0);
        if ($pid > 0 && !isset($seen[$pid])) {
          $seen[$pid] = true;
          $items[] = $entry;
        }
      }
    }
  }
} catch (Exception $e) {
  error_log('Database error: ' . $e->getMessage());
}

if (empty($items) && db_has_connection()) {
  $items = get_products(12);
}
if (!is_array($items)) {
  $items = [];
}

$home_items = $section_products['home-living'] ?? [];
$hero_product = $home_items[0] ?? ($items[0] ?? null);
$hero_image = $hero_product ? resolve_product_image_path($hero_product) : '';
$hero_category = $hero_product ? guess_product_category_slug($hero_product) : 'home-living';
$hero_category_label = strtoupper(str_replace('-', ' ', $hero_category));
$showcase_items = count($items) > 1 ? array_slice($items, 1, 8) : $items;

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
  ['slug' => 'home-living', 'label' => 'HOME', 'img' => get_category_preview_image('home-living')],
  ['slug' => 'fashion', 'label' => 'FASHION', 'img' => get_category_preview_image('fashion')],
  ['slug' => 'shoes', 'label' => 'SHOES', 'img' => get_category_preview_image('shoes')],
  ['slug' => 'electronics', 'label' => 'ELECTRONICS', 'img' => get_category_preview_image('electronics')],
  ['slug' => 'accessories', 'label' => 'ACCESSORIES', 'img' => get_category_preview_image('accessories')],
  ['slug' => 'beauty', 'label' => 'BEAUTY', 'img' => get_category_preview_image('beauty')],
];
?>

<section class="wf-page wf-home-hybrid">
  <div class="wf-market-home">
    <div class="wf-market-shell">
      <div class="wf-market-topbar">
        <div class="wf-market-brand">
          <span class="wf-market-logo">E-COM</span>
          <span class="wf-market-sub">Home + Fashion Market</span>
        </div>
        <div class="wf-market-actions">
          <a href="index.php?page=products" aria-label="Search"><i class="fas fa-search"></i></a>
          <a href="index.php?page=cart" aria-label="Cart" class="wf-market-cart-link">
            <i class="fas fa-shopping-cart"></i>
            <?php if ($cart_count > 0): ?>
              <span class="wf-count"><?php echo (int)$cart_count; ?></span>
            <?php endif; ?>
          </a>
          <a href="index.php?page=<?php echo isset($_SESSION['user']) ? 'checkout' : 'login'; ?>" aria-label="Account"><i class="fas fa-user"></i></a>
        </div>
      </div>

      <form method="get" action="index.php" class="wf-market-search-row">
        <input type="hidden" name="page" value="products">
        <div class="wf-market-search-box">
          <i class="fas fa-search"></i>
          <input type="text" name="q" class="wf-market-search-input" placeholder="Search essentials, fashion, decor and electronics">
        </div>
        <button type="submit" class="wf-market-filter-btn" aria-label="Search">
          <i class="fas fa-sliders-h"></i>
        </button>
      </form>

      <div class="wf-market-category-row">
        <?php foreach ($category_cards as $cat): ?>
          <a class="wf-market-category-chip" href="index.php?page=products&category=<?php echo urlencode($cat['slug']); ?>">
            <span class="wf-market-category-dot">
              <img src="<?php echo htmlspecialchars($cat['img']); ?>" alt="<?php echo htmlspecialchars($cat['label']); ?>">
            </span>
            <?php echo htmlspecialchars($cat['label']); ?>
          </a>
        <?php endforeach; ?>
      </div>

      <?php if ($hero_product): ?>
        <?php
          $hero_price = (float)($hero_product['sale_price'] ?? $hero_product['price']);
          $hero_old = isset($hero_product['sale_price']) && (float)$hero_product['sale_price'] < (float)$hero_product['price']
            ? (float)$hero_product['price']
            : null;
        ?>
        <div class="wf-market-hero">
          <div class="wf-market-hero-copy">
            <span class="wf-market-hero-kicker"><?php echo htmlspecialchars($hero_category_label); ?> Spotlight</span>
            <h1><?php echo htmlspecialchars($hero_product['name']); ?></h1>
            <p>Curated essentials and lifestyle picks, styled with your blue-and-orange brand look.</p>
            <div class="wf-market-hero-price">
              <span class="wf-market-price-main"><?php echo format_currency($hero_price); ?></span>
              <?php if ($hero_old !== null): ?>
                <span class="wf-market-price-old"><?php echo format_currency($hero_old); ?></span>
              <?php endif; ?>
            </div>
            <div class="wf-market-hero-actions">
              <form method="post" action="index.php?page=home" class="m-0">
                <input type="hidden" name="product_id" value="<?php echo (int)$hero_product['id']; ?>">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" name="add_to_cart" value="1" class="wf-market-cta-primary">Add To Cart</button>
              </form>
              <a href="index.php?page=product&id=<?php echo (int)$hero_product['id']; ?>" class="wf-market-cta-secondary">View Product</a>
            </div>
          </div>
          <div class="wf-market-hero-image-wrap">
            <img class="wf-market-hero-image" src="<?php echo htmlspecialchars($hero_image); ?>" alt="<?php echo htmlspecialchars($hero_product['name']); ?>">
          </div>
        </div>
      <?php endif; ?>

      <?php foreach ($section_blueprints as $section): ?>
        <?php
          $slug = $section['slug'];
          $section_items = array_slice($section_products[$slug] ?? [], 0, 6);
        ?>
        <?php if (!empty($section_items)): ?>
          <section class="wf-market-section">
            <div class="wf-market-section-head">
              <h3><?php echo htmlspecialchars($section['title']); ?></h3>
              <a href="index.php?page=products&category=<?php echo urlencode($slug); ?>">View All</a>
            </div>
            <div class="wf-market-product-row">
              <?php foreach ($section_items as $p): ?>
                <?php
                  $product_image = resolve_product_image_path($p);
                  $new_price = (float)($p['sale_price'] ?? $p['price']);
                  $old_price = isset($p['sale_price']) && (float)$p['sale_price'] < (float)$p['price'] ? (float)$p['price'] : null;
                ?>
                <a class="wf-market-product-card" href="index.php?page=product&id=<?php echo (int)$p['id']; ?>">
                  <div class="wf-market-product-image-wrap">
                    <img class="wf-market-product-image" src="<?php echo htmlspecialchars($product_image); ?>" alt="<?php echo htmlspecialchars($p['name']); ?>">
                  </div>
                  <div class="wf-market-product-name"><?php echo htmlspecialchars($p['name']); ?></div>
                  <div class="wf-market-product-sub"><?php echo htmlspecialchars($section['title']); ?></div>
                  <div class="wf-market-price-line">
                    <span class="wf-market-price-new"><?php echo format_currency($new_price); ?></span>
                    <?php if ($old_price !== null): ?>
                      <span class="wf-market-price-cut"><?php echo format_currency($old_price); ?></span>
                    <?php endif; ?>
                  </div>
                </a>
              <?php endforeach; ?>
            </div>
          </section>
        <?php endif; ?>
      <?php endforeach; ?>
    </div>
  </div>

  <div class="wf-mobile-shell">
    <div class="wf-hero-board">
      <div class="wf-hero-topnav">
        <div class="wf-hero-brand">
          <span>E-COM</span>
          <span>MARKET</span>
        </div>

        <nav class="wf-hero-links" aria-label="Home categories">
          <a class="active" href="index.php?page=home">HOME</a>
          <a href="index.php?page=products&category=fashion">FASHION</a>
          <a href="index.php?page=products&category=home-living">HOME</a>
          <a href="index.php?page=products&category=electronics">TECH</a>
        </nav>

        <div class="wf-hero-icons">
          <a href="index.php?page=products" aria-label="Search"><i class="fas fa-search"></i></a>
          <a href="index.php?page=cart" aria-label="Cart" class="wf-hero-cart-link">
            <i class="fas fa-shopping-cart"></i>
            <?php if ($cart_count > 0): ?>
              <span class="wf-count"><?php echo (int)$cart_count; ?></span>
            <?php endif; ?>
          </a>
          <a href="index.php?page=<?php echo isset($_SESSION['user']) ? 'checkout' : 'login'; ?>" aria-label="Account"><i class="fas fa-user"></i></a>
        </div>
      </div>

      <?php if ($hero_product): ?>
        <?php
          $hero_price = (float)($hero_product['sale_price'] ?? $hero_product['price']);
          $hero_old = isset($hero_product['sale_price']) && (float)$hero_product['sale_price'] < (float)$hero_product['price']
            ? (float)$hero_product['price']
            : null;
        ?>
        <div class="wf-hero-main">
          <div class="wf-hero-copy">
            <span class="wf-hero-drop"><?php echo htmlspecialchars($hero_category_label); ?></span>
            <h1><?php echo htmlspecialchars($hero_product['name']); ?></h1>
            <p>Handpicked essentials and lifestyle favorites.</p>

            <div class="wf-hero-price">
              <span class="wf-price-main"><?php echo format_currency($hero_price); ?></span>
              <?php if ($hero_old !== null): ?>
                <span class="wf-price-cut"><?php echo format_currency($hero_old); ?></span>
              <?php endif; ?>
            </div>

            <div class="wf-hero-actions">
              <form method="post" action="index.php?page=home" class="m-0">
                <input type="hidden" name="product_id" value="<?php echo (int)$hero_product['id']; ?>">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" name="add_to_cart" value="1" class="wf-cta-primary">ADD TO CART</button>
              </form>
              <a href="index.php?page=product&id=<?php echo (int)$hero_product['id']; ?>" class="wf-cta-secondary">VIEW DETAILS</a>
            </div>
          </div>

          <div class="wf-hero-image-wrap">
            <img class="wf-hero-image" src="<?php echo htmlspecialchars($hero_image); ?>" alt="<?php echo htmlspecialchars($hero_product['name']); ?>">
          </div>
        </div>

        <div class="wf-color-chooser">
          <span>QUICK PICKS :</span>
          <div class="wf-color-products">
            <?php foreach (array_slice($items, 0, 3) as $color_item): ?>
              <?php $color_image = resolve_product_image_path($color_item); ?>
              <a href="index.php?page=product&id=<?php echo (int)$color_item['id']; ?>" class="wf-color-thumb">
                <img src="<?php echo htmlspecialchars($color_image); ?>" alt="<?php echo htmlspecialchars($color_item['name']); ?>">
              </a>
            <?php endforeach; ?>
          </div>
        </div>
      <?php else: ?>
        <div class="wf-empty">No products available yet. Seed your database and reload.</div>
      <?php endif; ?>
    </div>

    <div class="wf-home-top">
      <form method="get" action="index.php" class="wf-search-row">
        <input type="hidden" name="page" value="products">
        <div class="wf-search-box">
          <i class="fas fa-search"></i>
          <input type="text" name="q" class="wf-search-input" placeholder="Search home essentials, fashion, accessories">
        </div>
        <button type="submit" class="wf-filter-btn" aria-label="Search">
          <i class="fas fa-sliders-h"></i>
        </button>
      </form>

      <div class="wf-strip-head">
        <span>CATEGORIES</span>
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
        <span>TRENDING PICKS</span>
        <a href="index.php?page=products">VIEW ALL</a>
      </div>

      <?php if (empty($showcase_items)): ?>
        <div class="wf-empty">No products available yet. Seed your database and reload.</div>
      <?php else: ?>
        <div class="wf-grid">
          <?php foreach ($showcase_items as $p): ?>
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
              <div class="wf-product-sub"><?php echo !empty($p['categories']) ? htmlspecialchars($p['categories']) : 'Popular Item'; ?></div>
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
      <a class="wf-bottom-link active" href="index.php?page=home" aria-label="Home"><i class="fas fa-home"></i></a>
      <a class="wf-bottom-link" href="index.php?page=products" aria-label="Explore"><i class="fas fa-search"></i></a>
      <a class="wf-bottom-link" href="index.php?page=cart" aria-label="Wishlist"><i class="far fa-heart"></i></a>
      <a class="wf-bottom-link" href="index.php?page=<?php echo isset($_SESSION['user']) ? 'checkout' : 'login'; ?>" aria-label="Account"><i class="fas fa-user"></i></a>
    </nav>
  </div>
</section>
