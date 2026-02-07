#!/usr/bin/env bash
# installClipOCR — installs clipOCR to ~/.local/bin

set -euo pipefail

TARGET_DIR="$HOME/.local/bin"
SCRIPT_NAME="clipOCR"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Creating directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Where are we right now? (assuming install script is next to clipOCR)
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_FILE="$SOURCE_DIR/$SCRIPT_NAME"

if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: $SCRIPT_NAME not found in current directory!" >&2
    echo "       Please run this installer from the same folder as $SCRIPT_NAME" >&2
    exit 1
fi

ln -s "$SOURCE_FILE" "$TARGET_DIR/$SCRIPT_NAME"

echo
echo "Installed $SCRIPT_NAME → $TARGET_DIR/$SCRIPT_NAME"
echo
echo "You can now use it like:"
echo "    clipOCR          # English (default)"
echo "    clipOCR deu      # German"
echo "    clipOCR jpn_vert # Japanese vertical"
echo
echo "Make sure these are installed:"
echo "  • tesseract-ocr"
echo "  • tesseract-ocr-eng  (and other lang packs you want)"
echo "  • xclip"
echo
