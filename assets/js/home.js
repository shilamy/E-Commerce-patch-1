document.addEventListener('DOMContentLoaded', () => {
  // Keep icon-only menu button from submitting forms when embedded.
  document.querySelectorAll('.wf-icon-link[aria-label="Menu"]').forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
    });
  });
});
