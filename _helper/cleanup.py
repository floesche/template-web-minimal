"""Remove intermediate build files (.aux, .log, .tex, .out, .typ).

Called by Quarto as a pre-render script (see _quarto.yml).
Skips .pixi, .git, and _helper directories.
"""

import pathlib

for p in pathlib.Path(".").rglob("*"):
    if (
        p.suffix in {".aux", ".log", ".tex", ".out", ".typ"}
        and ".pixi" not in p.parts
        and ".git" not in p.parts
        and "_helper" not in p.parts
    ):
        p.unlink()
