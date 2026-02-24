document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('[data-cart-root]');
  if (!root) return;

  const taxRate = Number.parseFloat(root.dataset.taxRate || '0.10') || 0.10;
  const currencyPrefix = root.dataset.currencyPrefix || 'KSh ';
  const toastStack = document.querySelector('[data-cart-toasts]');
  const itemCountEl = document.querySelector('[data-cart-item-count]');
  const subtotalEl = document.querySelector('[data-summary-subtotal]');
  const taxEl = document.querySelector('[data-summary-tax]');
  const shippingEl = document.querySelector('[data-summary-shipping]');
  const totalEl = document.querySelector('[data-summary-total]');
  const localHintEl = document.querySelector('[data-cart-local-hint]');
  const STORAGE_KEY = 'ecom_cart_snapshot_v1';

  const numberFormatter = new Intl.NumberFormat('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });

  function formatMoney(amount) {
    const value = Number.isFinite(amount) ? amount : 0;
    return `${currencyPrefix}${numberFormatter.format(value)}`;
  }

  function showToast(message, type = 'success') {
    if (!toastStack) return;
    const node = document.createElement('div');
    node.className = `cart-toast ${type}`;
    node.textContent = message;
    toastStack.appendChild(node);
    window.setTimeout(() => node.remove(), 2600);
  }

  function getItemRows() {
    return Array.from(document.querySelectorAll('[data-cart-item]'));
  }

  function updateSummary(subtotal, tax, shipping) {
    const safeSubtotal = Number.isFinite(subtotal) ? subtotal : 0;
    const safeTax = Number.isFinite(tax) ? tax : safeSubtotal * taxRate;
    const safeShipping = Number.isFinite(shipping) ? shipping : 0;
    const grand = safeSubtotal + safeTax + safeShipping;

    if (subtotalEl) {
      subtotalEl.dataset.amount = safeSubtotal.toFixed(2);
      subtotalEl.textContent = formatMoney(safeSubtotal);
    }
    if (taxEl) {
      taxEl.dataset.amount = safeTax.toFixed(2);
      taxEl.textContent = formatMoney(safeTax);
    }
    if (shippingEl) {
      shippingEl.dataset.amount = safeShipping.toFixed(2);
      shippingEl.textContent = safeShipping <= 0 ? 'Free' : formatMoney(safeShipping);
    }
    if (totalEl) {
      totalEl.dataset.amount = grand.toFixed(2);
      totalEl.textContent = formatMoney(grand);
    }
  }

  function recalcFromDom() {
    let subtotal = 0;
    let itemCount = 0;
    for (const row of getItemRows()) {
      const qty = Number.parseInt(row.dataset.quantity || '0', 10) || 0;
      const unit = Number.parseFloat(row.dataset.unitPrice || '0') || 0;
      const lineSubtotal = unit * qty;
      const lineTotalEl = row.querySelector('[data-line-total]');
      if (lineTotalEl) {
        lineTotalEl.dataset.amount = lineSubtotal.toFixed(2);
        lineTotalEl.textContent = formatMoney(lineSubtotal);
      }
      subtotal += lineSubtotal;
      itemCount += qty;
    }
    if (itemCountEl) {
      itemCountEl.textContent = String(itemCount);
    }
    updateSummary(subtotal, subtotal * taxRate, 0);
  }

  function persistSnapshot() {
    const snapshot = {
      captured_at: Date.now(),
      item_count: 0,
      subtotal: 0,
      items: [],
    };
    for (const row of getItemRows()) {
      const qty = Number.parseInt(row.dataset.quantity || '0', 10) || 0;
      const unit = Number.parseFloat(row.dataset.unitPrice || '0') || 0;
      const line = qty * unit;
      const name = row.querySelector('.cart-item-name')?.textContent?.trim() || 'Product';
      const category = row.querySelector('.cart-item-category')?.textContent?.trim() || '';
      const image = row.querySelector('.cart-item-image')?.getAttribute('src') || '';
      snapshot.items.push({
        item_id: Number.parseInt(row.dataset.itemId || '0', 10) || 0,
        name,
        category,
        qty,
        unit,
        subtotal: line,
        image,
      });
      snapshot.item_count += qty;
      snapshot.subtotal += line;
    }
    localStorage.setItem(STORAGE_KEY, JSON.stringify(snapshot));
  }

  function hydrateLocalHint() {
    if (!localHintEl) return;
    if (getItemRows().length > 0) return;
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return;
      const parsed = JSON.parse(raw);
      const count = Number.parseInt(String(parsed.item_count || 0), 10) || 0;
      if (count > 0) {
        localHintEl.textContent = `Saved locally: ${count} item${count === 1 ? '' : 's'} from your previous cart session.`;
      }
    } catch (_err) {
      // Ignore localStorage parsing errors.
    }
  }

  async function submitCartForm(form) {
    const data = new FormData(form);
    data.set('ajax', '1');
    const response = await fetch(form.action || window.location.href, {
      method: 'POST',
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
      },
      body: data,
    });
    return response.json();
  }

  function onQuantityChange(form, row) {
    const input = form.querySelector('.js-qty-input');
    if (!input) return;
    let qty = Number.parseInt(input.value || '1', 10);
    if (!Number.isFinite(qty) || qty < 1) qty = 1;
    input.value = String(qty);
    row.dataset.quantity = String(qty);

    recalcFromDom();
    row.classList.add('is-updating');

    submitCartForm(form)
      .then((json) => {
        if (!json || json.ok !== true) {
          throw new Error(json?.message || 'Failed to update quantity.');
        }
        if (typeof json.item_subtotal === 'number') {
          const lineTotalEl = row.querySelector('[data-line-total]');
          if (lineTotalEl) {
            lineTotalEl.dataset.amount = Number(json.item_subtotal).toFixed(2);
            lineTotalEl.textContent = formatMoney(Number(json.item_subtotal));
          }
        }
        if (typeof json.item_count === 'number' && itemCountEl) {
          itemCountEl.textContent = String(json.item_count);
        }
        if (typeof json.subtotal === 'number') {
          updateSummary(
            Number(json.subtotal),
            typeof json.tax === 'number' ? Number(json.tax) : Number(json.subtotal) * taxRate,
            typeof json.shipping === 'number' ? Number(json.shipping) : 0
          );
        }
        persistSnapshot();
      })
      .catch((err) => {
        console.error(err);
        showToast('Could not update quantity. Reloading cart.', 'error');
        form.submit();
      })
      .finally(() => {
        row.classList.remove('is-updating');
      });
  }

  function bindQuantityControls() {
    const rows = getItemRows();
    for (const row of rows) {
      const updateForm = row.querySelector('.js-cart-update');
      if (!updateForm) continue;
      const input = updateForm.querySelector('.js-qty-input');
      const qtyButtons = updateForm.querySelectorAll('.js-qty-step');
      if (!input) continue;

      let updateTimer = null;
      const queueUpdate = () => {
        window.clearTimeout(updateTimer);
        updateTimer = window.setTimeout(() => onQuantityChange(updateForm, row), 180);
      };

      qtyButtons.forEach((button) => {
        button.addEventListener('click', () => {
          const step = Number.parseInt(button.dataset.step || '0', 10) || 0;
          let current = Number.parseInt(input.value || '1', 10);
          if (!Number.isFinite(current) || current < 1) current = 1;
          const next = Math.max(1, current + step);
          input.value = String(next);
          updateForm.classList.remove('is-bump');
          void updateForm.offsetWidth;
          updateForm.classList.add('is-bump');
          queueUpdate();
        });
      });

      input.addEventListener('change', queueUpdate);
      input.addEventListener('blur', queueUpdate);
      updateForm.addEventListener('submit', (event) => {
        event.preventDefault();
        queueUpdate();
      });
    }
  }

  function bindRemoveControls() {
    const removeForms = document.querySelectorAll('.js-cart-remove');
    removeForms.forEach((form) => {
      form.addEventListener('submit', (event) => {
        event.preventDefault();
        const row = form.closest('[data-cart-item]');
        if (!row) return;
        row.classList.add('is-removing');

        submitCartForm(form)
          .then((json) => {
            if (!json || json.ok !== true) {
              throw new Error(json?.message || 'Failed to remove item.');
            }
            row.remove();

            if (typeof json.item_count === 'number' && itemCountEl) {
              itemCountEl.textContent = String(json.item_count);
            }
            if (typeof json.subtotal === 'number') {
              updateSummary(
                Number(json.subtotal),
                typeof json.tax === 'number' ? Number(json.tax) : Number(json.subtotal) * taxRate,
                typeof json.shipping === 'number' ? Number(json.shipping) : 0
              );
            } else {
              recalcFromDom();
            }

            persistSnapshot();
            showToast(json.message || 'Item removed from cart.', 'success');

            if (json.cart_empty === true || getItemRows().length === 0) {
              window.location.reload();
            }
          })
          .catch((err) => {
            console.error(err);
            row.classList.remove('is-removing');
            showToast('Could not remove item. Reloading cart.', 'error');
            form.submit();
          });
      });
    });
  }

  if (getItemRows().length > 0) {
    bindQuantityControls();
    bindRemoveControls();
    recalcFromDom();
    persistSnapshot();
  } else {
    hydrateLocalHint();
  }
});
