<?php
$error = $auth_error ?? null;
$next = isset($_GET['next']) ? $_GET['next'] : null;
?>

<section class="auth-wireframe">
  <div class="auth-panel">
    <div class="auth-brand">LOGO</div>
    <h1 class="auth-title">Welcome to E-com</h1>
    <p class="auth-subtitle">Sign in to continue</p>

    <?php if ($error): ?>
      <div class="auth-error"><?php echo htmlspecialchars($error); ?></div>
    <?php endif; ?>

    <form method="post" action="index.php?page=login<?php echo $next ? '&next=' . urlencode($next) : ''; ?>">
      <div class="auth-field">
        <div class="auth-input-wrap">
          <i class="fas fa-envelope"></i>
          <input class="auth-input" type="email" name="email" placeholder="Your Email" required>
        </div>
      </div>
      <div class="auth-field">
        <div class="auth-input-wrap">
          <i class="fas fa-lock"></i>
          <input class="auth-input" type="password" name="password" placeholder="Password" required>
        </div>
      </div>

      <?php if ($next): ?>
        <input type="hidden" name="next" value="<?php echo htmlspecialchars($next, ENT_QUOTES, 'UTF-8'); ?>">
      <?php endif; ?>

      <button class="auth-btn" type="submit">Sign In</button>
    </form>

    <div class="auth-divider"><span>OR</span></div>

    <div class="auth-social">
      <button type="button" class="auth-social-btn"><i class="fab fa-google"></i> Login with Google</button>
      <button type="button" class="auth-social-btn"><i class="fab fa-facebook-f"></i> Login with Facebook</button>
    </div>

    <div class="auth-meta mt-3">
      <a href="#">Forgot Password?</a>
    </div>
    <div class="auth-meta">
      Don't have an account? <a href="index.php?page=register">Register</a>
    </div>
  </div>
</section>
