#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""Percent-encode relative hrefs in Vimwiki-generated HTML.

Vimwiki's built-in HTML converter writes anchors with raw spaces, e.g.
``href="#Generated Tags-fzf"``. Browsers tolerate this, but it is not a valid
URL and crawlers such as the OWASP ZAP spider request bogus URLs because of it.

Only hrefs without a URL scheme are rewritten. Element ``id`` attributes are
left unchanged: browsers percent-decode the fragment before matching ids.

The transformation is idempotent (unquote, then quote), so it is safe to run
on every commit after ``vimwiki all-html``.

Usage: encode-html-anchors.py [DOCS_DIR]
DOCS_DIR defaults to ``git config ghppages.pathhtml``, then ``docs``.
"""

import html
import re
import subprocess
import sys
from pathlib import Path
from urllib.parse import quote, unquote

HREF_RE = re.compile(r'href="([^"]*)"')
SCHEME_RE = re.compile(r"^[A-Za-z][A-Za-z0-9+.-]*:")
# RFC 3986 unreserved + sub-delims (minus "&"), plus ":@/?" allowed in fragments.
FRAGMENT_SAFE = "/-._~!$'()*+,;=:@?"
PATH_SAFE = FRAGMENT_SAFE + "&"


def encode_href(href: str) -> str:
    """Return href with its path and fragment percent-encoded."""
    if not href or SCHEME_RE.match(href) or href.startswith("//"):
        return href
    raw = html.unescape(href)
    path, sep, fragment = raw.partition("#")
    path = quote(unquote(path), safe=PATH_SAFE)
    result = path.replace("&", "&amp;")
    if sep:
        result += "#" + quote(unquote(fragment), safe=FRAGMENT_SAFE)
    return result


def encode_file(path: Path) -> bool:
    """Rewrite hrefs in path; return True if the file changed."""
    text = path.read_text(encoding="utf-8")
    new = HREF_RE.sub(lambda m: f'href="{encode_href(m.group(1))}"', text)
    if new == text:
        return False
    path.write_text(new, encoding="utf-8", newline="")
    return True


def default_docs_dir() -> Path:
    result = subprocess.run(
        ["git", "config", "ghppages.pathhtml"],
        capture_output=True,
        text=True,
        check=False,
    )
    return Path(result.stdout.strip() or "docs")


def main(argv: list[str]) -> int:
    docs = Path(argv[1]) if len(argv) > 1 else default_docs_dir()
    if not docs.is_dir():
        print(f"encode-html-anchors: {docs} is not a directory", file=sys.stderr)
        return 1
    changed = [p for p in sorted(docs.rglob("*.html")) if encode_file(p)]
    for p in changed:
        print(f"encoded hrefs: {p}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
