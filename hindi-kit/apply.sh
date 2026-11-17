#!/usr/bin/env bash
# Turn a copied faceless-shorts paper-atlas project into a Hindi-ready project.
# usage: bash apply.sh <project-dir>
set -euo pipefail
P="$1"; K="$(cd "$(dirname "$0")" && pwd)"
cp "$K/fonts/"*.ttf "$P/fonts/"
mkdir -p "$P/hi-tools" && cp "$K/voice_hi.py" "$P/hi-tools/voice.py" && cp "$K/words_hi.py" "$P/hi-tools/words.py"
python3 - "$P" <<'PY'
import sys, pathlib
P = pathlib.Path(sys.argv[1])
def sub(f, a, b, need=True):
    p = P / f; s = p.read_text()
    if a in s: p.write_text(s.replace(a, b)); return
    if need and b not in s: sys.exit(f'apply.sh: pattern not found in {f}: {a[:60]}')
# unicode-aware word matching (Devanagari words were being stripped)
sub('src/core/timing.js', "replace(/[^a-z0-9']+/g, '')", "replace(/[^\\p{L}\\p{M}\\p{N}']+/gu, '')")
sub('src/core/captions.js', "replace(/[^a-z0-9']+/g, '')", "replace(/[^\\p{L}\\p{M}\\p{N}']+/gu, '')")
# Devanagari fonts
sub('index.html', "@font-face { font-family: 'Caladea'; font-weight: 700; src: url('fonts/Caladea-Bold.ttf'); }",
    "@font-face { font-family: 'Caladea'; font-weight: 700; src: url('fonts/Caladea-Bold.ttf'); }\n@font-face { font-family: 'Tiro Devanagari Hindi'; font-weight: 400 700; src: url('fonts/TiroDevanagariHindi-Regular.ttf'); }\n@font-face { font-family: 'Khand'; font-weight: 700; src: url('fonts/Khand-Bold.ttf'); }")
sub('src/main.js', "await document.fonts.load('700 100px Caladea');",
    "await document.fonts.load('700 100px Caladea'); await document.fonts.load(\"700 100px 'Tiro Devanagari Hindi'\", 'छठ पूजा'); await document.fonts.load('700 100px Khand', 'छठ');")
sub('src/core/kit.js', "const SERIF = 'Caladea';", "const SERIF = \"'Tiro Devanagari Hindi', Caladea\";")
# any hard-coded Caladea in the project's own shots.js
p = P / 'src/shots.js'; s = p.read_text(); p.write_text(s.replace("px Caladea`", "px 'Tiro Devanagari Hindi', Caladea`"))
print('Hindi kit applied to', P)
PY
