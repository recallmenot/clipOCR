# clipOCR

Turn an image in your X11 clipboard into text with Tesseract. The recognized
text is printed to the terminal and copied back to the clipboard.

## Requirements

- Bash
- [Tesseract OCR](https://github.com/tesseract-ocr/tesseract)
- The Tesseract language packs you want to use
- `xclip`
- Linux with X11

## Install

```bash
./install.sh
```

The installer creates a symlink at `~/.local/bin/clipOCR`. Make sure that
directory is in your `PATH` and keep the project directory in place.

## Usage

Copy an image to the clipboard, then run:

```bash
clipOCR                       # English (default)
clipOCR -l deu                # German
clipOCR --lang jpn            # Japanese
clipOCR -l eng+deu            # Multiple languages
```

Run `clipOCR --help` for all options. Temporary OCR files are removed
