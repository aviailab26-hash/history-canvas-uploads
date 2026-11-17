# Hindi kit for The History Canvas Shorts

Makes a Hindi version of a finished English paper-atlas Short.

1. Copy the finished English project folder to `<name>-hindi`.
2. `bash hindi-kit/apply.sh <name>-hindi` (copies Devanagari fonts, Hindi voice + word-timing tools, unicode word matching).
3. Rewrite `script.json` in natural spoken Hindi: same story, same facts, same loop. Voice `hf_alpha` (or `hf_beta`), speed about 1.1. End sentences with `.` `?` or `।`. Write `caps` in Hindi; each chunk must match the spoken words exactly.
4. In `src/shots.js`, translate every on-screen text (slips, ribbons, bigText) to Hindi and change every `Wd('english', i)` key to a Hindi word that is actually in line i.
5. Narration: `<venv python> hi-tools/voice.py .` then `<venv python> hi-tools/words.py .` (venv python = `~/.faceless-shorts/venv/bin/python`).
6. Then the normal steps: `node tools/capture.mjs check`, `cues`, `mix.py`, contact sheet, look at every frame, `video`.

Fonts: Tiro Devanagari Hindi and Khand, SIL Open Font License (from github.com/google/fonts).
