Category image structure used by the storefront:

- `fashion/shoes/`
- `fashion/clothes/`
- `home-decor/`
- `office-furniture/`
- `electronics/mobile/`
- `electronics/gadgets/`
- `beauty/skin-care/`
- `accessories/bags/`
- `accessories/jewelry/`

How it works:

- The app resolver reads these folders first and maps images by category.
- Existing top-level files in `assets/images/products/` are still supported as fallback.
- You can add more images to any folder and they will be picked up automatically.
