#!/usr/bin/env bash
set -euo pipefail

VENDOR_DIR="vendor"
FONTS_DIR="$VENDOR_DIR/fonts"

echo "==> Creating vendor directories..."
mkdir -p "$VENDOR_DIR" "$FONTS_DIR"

# --- Bootstrap CSS ---
echo "==> Downloading Bootstrap 4.0.0-beta.2..."
curl -sL "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" \
  -o "$VENDOR_DIR/bootstrap.min.css"

# --- Font Awesome JS ---
echo "==> Downloading Font Awesome 5.0.2..."
curl -sL "https://use.fontawesome.com/releases/v5.0.2/js/all.js" \
  -o "$VENDOR_DIR/fontawesome.min.js"

# --- Google Fonts (Lato) ---
echo "==> Downloading Lato font CSS..."
# Request with woff2-capable user-agent to get woff2 format
curl -sL "https://fonts.googleapis.com/css?family=Lato" \
  -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36" \
  -o "$VENDOR_DIR/lato.css"

echo "==> Downloading Lato font files..."
# Extract font URLs from the CSS and download them
grep -oP 'url\(\K[^)]+' "$VENDOR_DIR/lato.css" | while read -r url; do
  filename=$(basename "$url" | sed 's/\?.*//') # strip query params
  echo "    Fetching $filename..."
  curl -sL "$url" -o "$FONTS_DIR/$filename"
  # Rewrite the CSS to use local path
  escaped_url=$(printf '%s' "$url" | sed 's/[&/\]/\\&/g')
  sed -i "s|$escaped_url|fonts/$filename|g" "$VENDOR_DIR/lato.css"
done

# --- Update index.html ---
echo "==> Updating index.html to use local assets..."
sed -i \
  -e 's|https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css|vendor/bootstrap.min.css|' \
  -e 's|https://use.fontawesome.com/releases/v5.0.2/js/all.js|vendor/fontawesome.min.js|' \
  -e "s|@import url('https://fonts.googleapis.com/css?family=Lato');|@import url('vendor/lato.css');|" \
  index.html

# Remove integrity/crossorigin attrs since we're serving locally
sed -i \
  -e 's/ integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb"//' \
  -e 's/ crossorigin="anonymous"//' \
  index.html

echo "==> Done! All dependencies bundled in $VENDOR_DIR/"
echo "    Files:"
find "$VENDOR_DIR" -type f | sort | sed 's/^/      /'
