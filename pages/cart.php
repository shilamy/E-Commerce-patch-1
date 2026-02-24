<?php
$user = $_SESSION['user'] ?? null;
require_once __DIR__ . '/../includes/db_functions.php';

if ($user) {
    $cart = get_user_cart((int)$user['id']);
} else {
    $cart = get_session_cart();
}

$tax_rate = 0.10;
$shipping_fee = 0.00;
$line_count = 0;
$item_count = 0;
$subtotal = 0.0;

if ($cart && !empty($cart['items'])) {
    $line_count = count($cart['items']);
    foreach ($cart['items'] as $item) {
        $item_count += (int)($item['quantity'] ?? 0);
        $subtotal += (float)($item['subtotal'] ?? 0);
    }
}

$tax_total = $subtotal * $tax_rate;
$grand_total = $subtotal + $tax_total + $shipping_fee;

$currency = get_setting('currency', 'KSh');
if ($currency === 'KSh' || $currency === 'KES') {
    $currency_prefix = 'KSh ';
} elseif ($currency === 'USD') {
    $currency_prefix = '$';
} else {
    $currency_prefix = $currency . ' ';
}
?>

<section
    class="cart-shell"
    data-cart-root
    data-tax-rate="<?php echo htmlspecialchars((string)$tax_rate, ENT_QUOTES, 'UTF-8'); ?>"
    data-currency-prefix="<?php echo htmlspecialchars($currency_prefix, ENT_QUOTES, 'UTF-8'); ?>"
>
    <div class="container py-4 py-lg-5">
        <a href="index.php?page=home" class="cart-back-link">
            <i class="fas fa-arrow-left"></i>
            Continue Shopping
        </a>

        <header class="cart-header">
            <div>
                <h1><i class="fas fa-shopping-cart"></i> Your Shopping Cart</h1>
                <p>Review your items, adjust quantities, and proceed to checkout.</p>
            </div>
            <div class="cart-header-stat">
                <span data-cart-item-count><?php echo (int)$item_count; ?></span>
                <small>items</small>
            </div>
        </header>

        <?php if (!$cart || empty($cart['items'])): ?>
            <div class="cart-empty-state" data-cart-empty>
                <div class="cart-empty-icon">
                    <i class="fas fa-shopping-basket"></i>
                </div>
                <h3>Your Cart Is Empty</h3>
                <p>Start exploring and add products to build your order.</p>
                <p class="cart-local-hint" data-cart-local-hint></p>
                <a href="index.php?page=products" class="btn btn-primary btn-lg">
                    <i class="fas fa-bag-shopping me-2"></i>Browse Products
                </a>
            </div>
        <?php else: ?>
            <div class="cart-layout">
                <div class="cart-lines" data-cart-list>
                    <?php foreach ($cart['items'] as $item): ?>
                        <?php
                            $item_id = (int)($item['id'] ?? 0);
                            $qty = (int)($item['quantity'] ?? 1);
                            $unit_price = (float)($item['unit_price'] ?? 0);
                            $line_total = (float)($item['subtotal'] ?? 0);
                            $item_image = resolve_product_image_path($item);
                            $item_category = trim((string)($item['categories'] ?? ''));
                            if ($item_category === '') {
                                $item_category = ucwords(str_replace('-', ' ', guess_product_category_slug($item)));
                            }
                        ?>
                        <article
                            class="cart-line-item"
                            data-cart-item
                            data-item-id="<?php echo $item_id; ?>"
                            data-quantity="<?php echo $qty; ?>"
                            data-unit-price="<?php echo htmlspecialchars(number_format($unit_price, 2, '.', ''), ENT_QUOTES, 'UTF-8'); ?>"
                        >
                            <a
                                class="cart-item-image-wrap"
                                href="index.php?page=product&id=<?php echo (int)($item['product_id'] ?? 0); ?>"
                                aria-label="<?php echo htmlspecialchars($item['product_name'] ?? 'Product'); ?>"
                            >
                                <img
                                    src="<?php echo htmlspecialchars($item_image); ?>"
                                    alt="<?php echo htmlspecialchars($item['product_name'] ?? 'Product'); ?>"
                                    class="cart-item-image"
                                >
                            </a>

                            <div class="cart-item-content">
                                <div class="cart-item-title-row">
                                    <div>
                                        <div class="cart-item-category"><?php echo htmlspecialchars($item_category); ?></div>
                                        <h3 class="cart-item-name"><?php echo htmlspecialchars($item['product_name'] ?? 'Product'); ?></h3>
                                    </div>
                                    <form method="POST" action="index.php?page=cart" class="js-cart-form js-cart-remove">
                                        <input type="hidden" name="action" value="remove_item">
                                        <input type="hidden" name="item_id" value="<?php echo $item_id; ?>">
                                        <button type="submit" class="cart-remove-btn" aria-label="Remove item">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>

                                <div class="cart-item-bottom">
                                    <form method="POST" action="index.php?page=cart" class="cart-qty-form js-cart-form js-cart-update">
                                        <input type="hidden" name="action" value="update_quantity">
                                        <input type="hidden" name="item_id" value="<?php echo $item_id; ?>">
                                        <button type="button" class="cart-qty-btn js-qty-step" data-step="-1" aria-label="Decrease quantity">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <input
                                            type="number"
                                            name="quantity"
                                            class="cart-qty-input js-qty-input"
                                            value="<?php echo $qty; ?>"
                                            min="1"
                                            inputmode="numeric"
                                            aria-label="Quantity"
                                        >
                                        <button type="button" class="cart-qty-btn js-qty-step" data-step="1" aria-label="Increase quantity">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </form>

                                    <div class="cart-item-price">
                                        <strong class="cart-line-total" data-line-total data-amount="<?php echo htmlspecialchars(number_format($line_total, 2, '.', ''), ENT_QUOTES, 'UTF-8'); ?>">
                                            <?php echo format_currency($line_total); ?>
                                        </strong>
                                        <span class="cart-unit-price">
                                            <?php echo format_currency($unit_price); ?> each
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </article>
                    <?php endforeach; ?>
                </div>

                <aside class="cart-summary summary-card" data-cart-summary>
                    <h4>Order Summary</h4>
                    <div class="cart-summary-row">
                        <span>Subtotal</span>
                        <span data-summary-subtotal data-amount="<?php echo htmlspecialchars(number_format($subtotal, 2, '.', ''), ENT_QUOTES, 'UTF-8'); ?>">
                            <?php echo format_currency($subtotal); ?>
                        </span>
                    </div>
                    <div class="cart-summary-row">
                        <span>Tax (16%)</span>
                        <span data-summary-tax data-amount="<?php echo htmlspecialchars(number_format($tax_total, 2, '.', ''), ENT_QUOTES, 'UTF-8'); ?>">
                            <?php echo format_currency($tax_total); ?>
                        </span>
                    </div>
                    <div class="cart-summary-row">
                        <span>Shipping</span>
                        <span class="text-success" data-summary-shipping data-amount="<?php echo htmlspecialchars(number_format($shipping_fee, 2, '.', ''), ENT_QUOTES, 'UTF-8'); ?>">
                            Free
                        </span>
                    </div>
                    <div class="cart-summary-row cart-summary-total">
                        <span>Total</span>
                        <span data-summary-total data-amount="<?php echo htmlspecialchars(number_format($grand_total, 2, '.', ''), ENT_QUOTES, 'UTF-8'); ?>">
                            <?php echo format_currency($grand_total); ?>
                        </span>
                    </div>

                    <div class="cart-summary-actions">
                        <a href="index.php?page=checkout" class="btn btn-primary btn-lg w-100">
                            <i class="fas fa-lock me-2"></i>Proceed to Checkout
                        </a>
                        <a href="index.php?page=products" class="btn btn-outline-primary w-100">
                            Continue Shopping
                        </a>
                    </div>

                    <ul class="cart-trust-list">
                        <li><i class="fas fa-shield-alt"></i> Secure Checkout</li>
                        <li><i class="fas fa-truck-fast"></i> Free Shipping</li>
                        <li><i class="fas fa-rotate-left"></i> Easy Returns</li>
                    </ul>
                </aside>
            </div>
        <?php endif; ?>
    </div>

    <div class="cart-toast-stack" data-cart-toasts aria-live="polite" aria-atomic="true"></div>
</section>
