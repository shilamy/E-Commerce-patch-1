<?php
$error = $auth_error ?? null;
?>

<section class="auth-wireframe">
  <div class="auth-panel">
    <div class="auth-brand">LOGO</div>
    <h1 class="auth-title">Let's Get Started</h1>
    <p class="auth-subtitle">Create an account</p>

    <?php if ($error): ?>
      <div class="auth-error"><?php echo htmlspecialchars($error); ?></div>
    <?php endif; ?>

    <form method="post" action="index.php?page=register">
      <div class="auth-field">
        <div class="auth-input-wrap">
          <i class="fas fa-user"></i>
          <input class="auth-input" type="text" name="name" placeholder="Full Name" required>
        </div>
      </div>
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
      <button class="auth-btn" type="submit">Sign In</button>
    </form>

    <div class="auth-meta mt-3">
      Have an account? <a href="index.php?page=login">Sign In</a>
    </div>
  </div>
</section>
