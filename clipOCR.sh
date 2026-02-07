#!/usr/bin/env bash
# clipOCR — OCR from clipboard image → text back to clipboard

set -euo pipefail

# Default language
LANG="${1:-eng}"

if ! command -v tesseract >/dev/null 2>&1; then
    echo "Error: tesseract not found. Please install tesseract-ocr" >&2
    exit 1
fi

if ! command -v xclip >/dev/null 2>&1; then
    echo "Error: xclip not found. Please install xclip" >&2
    exit 1
fi

TMPDIR="$(mktemp -d -t clipocr.XXXXXXXXXX)"
trap 'rm -rf "$TMPDIR"' EXIT

PNGFILE="$TMPDIR/clipboard.png"
TXTFILE="$TMPDIR/ocrresult"

# Save clipboard image (works with PNG, JPG, etc. that X understands)
xclip -selection clipboard -t image/png -o > "$PNGFILE" 2>/dev/null || {
    echo "Error: No image found in clipboard (or xclip failed)" >&2
    exit 2
}

# Check it's actually an image
if [[ ! -s "$PNGFILE" ]]; then
    echo "Error: Clipboard content is empty or not an image" >&2
    exit 3
fi

# Run OCR — output directly to file without extension (tesseract adds .txt)
tesseract "$PNGFILE" "$TXTFILE" -l "$LANG" --psm 6 quiet

# Remove trailing empty lines, copy to clipboard
cat "$TXTFILE.txt" | sed ':a;/^\n*$/{$d;N;ba}' | xclip -selection clipboard -i

# Optional: also print to terminal
cat "$TXTFILE.txt" | sed ':a;/^\n*$/{$d;N;ba}'

echo
echo "(language: $LANG)  →  text copied to clipboard"
