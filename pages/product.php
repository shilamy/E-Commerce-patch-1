<?php
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/db_functions.php';

$id = isset($_GET['id']) ? (int) $_GET['id'] : null;
$product = ($id && db_has_connection()) ? get_product_by_id($id) : null;
$cart_error = $cart_error ?? null;
$related_products = ($id && db_has_connection()) ? get_related_products($id, 3) : [];
$product_image = $product ? resolve_product_image_path($product) : '';
$thumb_images = [];
if ($product) {
  $thumb_images[] = $product_image;
  foreach ($related_products as $related_item) {
    $thumb_images[] = resolve_product_image_path($related_item);
    if (count($thumb_images) >= 3) {
      break;
    }
  }
  $thumb_images = array_values(array_unique(array_filter($thumb_images)));
  while (count($thumb_images) < 3) {
    $thumb_images[] = $product_image;
  }
}
?>

<?php if ($product): ?>
<section class="wf-product-page">
  <div class="wf-product-shell">
    <div class="wf-product-media">
      <div class="wf-product-media-top">
        <a href="index.php?page=products" class="wf-circle-btn" aria-label="Back">
          <i class="fas fa-arrow-left"></i>
        </a>
        <a href="index.php?page=cart" class="wf-circle-btn wf-share" aria-label="Share">
          <i class="fas fa-share-alt"></i>
        </a>
      </div>

      <div class="wf-main-image-wrap">
        <img
          class="wf-main-image"
          src="<?php echo htmlspecialchars($product_image); ?>"
          alt="<?php echo htmlspecialchars($product['name']); ?>"
        >
      </div>

      <div class="wf-slider-dots" aria-hidden="true">
        <span class="wf-slider-dot active"></span>
        <span class="wf-slider-dot"></span>
        <span class="wf-slider-dot"></span>
      </div>
    </div>

    <div class="wf-product-details">
      <div class="wf-detail-head">
        <div>
          <h1 class="wf-product-title"><?php echo htmlspecialchars($product['name']); ?></h1>
          <p class="wf-product-subtitle"><?php echo !empty($product['category']) ? htmlspecialchars($product['category']) : 'Men\'s Shoes'; ?></p>
        </div>
        <?php if (isset($product['sale_price']) && (float)$product['sale_price'] < (float)$product['price']): ?>
          <span class="wf-sale-pill">24% Off</span>
        <?php endif; ?>
      </div>

      <div class="wf-price-block">
        <span class="wf-main-price"><?php echo format_currency((float)($product['sale_price'] ?? $product['price'])); ?></span>
        <?php if (isset($product['sale_price']) && (float)$product['sale_price'] < (float)$product['price']): ?>
          <span class="wf-old-price"><?php echo format_currency((float)$product['price']); ?></span>
        <?php endif; ?>
      </div>

      <h4 class="wf-option-title">Color</h4>
      <div class="wf-thumb-row">
        <span class="wf-thumb active"><img src="<?php echo htmlspecialchars($thumb_images[0]); ?>" alt="Product color"></span>
        <span class="wf-thumb"><img src="<?php echo htmlspecialchars($thumb_images[1]); ?>" alt="Alternative color"></span>
        <span class="wf-thumb"><img src="<?php echo htmlspecialchars($thumb_images[2]); ?>" alt="Alternative color"></span>
      </div>

      <h4 class="wf-option-title">Select size</h4>
      <div class="wf-size-row">
        <span class="wf-size-pill">38.5</span>
        <span class="wf-size-pill inactive">39</span>
        <span class="wf-size-pill">40</span>
        <span class="wf-size-pill">41</span>
        <span class="wf-size-pill">42</span>
      </div>

      <p class="wf-product-desc"><?php echo htmlspecialchars($product['description'] ?? 'Air Max brings you style, comfort and big attitude in the Nike Air Max 270.'); ?></p>
      <div class="wf-product-meta">
        Color: Black/White/Solar Red/Anthracite<br>
        Style: AH8050-002
      </div>

      <div class="wf-review-head">
        <h5 class="wf-review-title">Review Product</h5>
        <a class="wf-review-more" href="#">See More</a>
      </div>

      <div class="wf-review-rating">
        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
        <small>4.5 (5 Review)</small>
      </div>

      <div class="wf-review-card">
        <div class="wf-review-avatar">
          <img src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=120&q=60" alt="Reviewer">
        </div>
        <div class="wf-review-text">
          <h6>James Lawson</h6>
          <p>Air max are always very comfortable fit, clean and just perfect in every way.</p>
        </div>
      </div>

      <?php if (!empty($related_products)): ?>
      <div class="wf-related-strip">
        <?php foreach ($related_products as $related): ?>
          <?php $related_image = resolve_product_image_path($related); ?>
          <a class="wf-related-card" href="index.php?page=product&id=<?php echo (int)$related['id']; ?>">
            <img src="<?php echo htmlspecialchars($related_image); ?>" alt="<?php echo htmlspecialchars($related['name']); ?>">
          </a>
        <?php endforeach; ?>
      </div>
      <?php endif; ?>

      <?php if ($cart_error): ?>
        <div class="alert alert-danger mt-3"><?php echo htmlspecialchars($cart_error); ?></div>
      <?php endif; ?>
    </div>

    <div class="wf-add-wrap">
      <form method="post" action="index.php?page=product&id=<?php echo (int)$id; ?>" class="m-0">
        <input type="hidden" name="product_id" value="<?php echo (int)$id; ?>">
        <input type="hidden" name="quantity" value="1">
        <button class="wf-add-btn" type="submit" name="add_to_cart" value="1">Add To Cart</button>
      </form>
    </div>

    <nav class="wf-bottom-nav" aria-label="Main">
      <a class="wf-bottom-link" href="index.php?page=home" aria-label="Home"><i class="fas fa-home"></i></a>
      <a class="wf-bottom-link" href="index.php?page=products" aria-label="Explore"><i class="fas fa-search"></i></a>
      <a class="wf-bottom-link active" href="index.php?page=product&id=<?php echo (int)$id; ?>" aria-label="Wishlist"><i class="far fa-heart"></i></a>
      <a class="wf-bottom-link" href="index.php?page=<?php echo isset($_SESSION['user']) ? 'checkout' : 'login'; ?>" aria-label="Account"><i class="fas fa-user"></i></a>
    </nav>
  </div>
</section>
<?php else: ?>
<section class="wf-product-page">
  <div class="wf-product-empty">
    <h2><?php echo $id ? 'Product Not Found' : 'Browse Products'; ?></h2>
    <p><?php echo $id ? 'The product you selected is unavailable.' : 'Select a product from the catalog to continue.'; ?></p>
    <a href="index.php?page=products" class="btn btn-primary">Back to Products</a>
  </div>
</section>
<?php endif; ?>
