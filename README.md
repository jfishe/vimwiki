# Home Vimwiki Installation

[`vimfiles/vimfiles/plugin/vimwiki.vim`](https://github.com/jfishe/vimfiles/blob/e23c225af4869c0ab8c85ec223a7881d01b8ca11/vimfiles/plugin/vimwiki.vim#L80)
configuration defines Vimwiki configuration.

- Editor and shell setup:
  - Windows [vimfiles](https://github.com/jfishe/vimfiles)
  - Linux [dotfiles](https://github.com/jfishe/dotfiles)

## Tool Installation

Install [uv][], then the command-line tools:

```bash
uv tool install vimwiki-cli # https://github.com/sstallion/vimwiki-cli
uv tool install ghp-import
uv tool install prek
```

`uv` must be on `PATH`: `.pre_commit_hooks/encode-html-anchors.py` runs via
`uv run --script`.

```bash
VIMWIKI_PATH="$HOME/vimwiki_home"

git clone https://github.com/jfishe/vimwiki.git "$VIMWIKI_PATH"

pushd "$VIMWIKI_PATH"

# Install pre-commit and pre-push hooks and update to latest.
prek install --install-hooks
prek auto-update

# Count should match vimwiki configuration.
git config vimwiki.options '--count=2'
# Collect .vimwiki_tag in Topic_Index.wiki.
git config vimwiki.taglinkspage Topic_Index
# Append Generate Links to index.wiki.
git config vimwiki.linkspage index

git config vimwiki.generatelinks true
git config vimwiki.generatediarylinks true
git config vimwiki.generatetaglinks true
git config vimwiki.rebuildtags true
git config vimwiki.allhtml true

# Publish docs/ to GitHub Pages on push.
git config ghppages.pathhtml "$VIMWIKI_PATH/docs"
git config ghppages.push true
popd
```

### Zsh Completion

```bash
COMPLETION_PATH=$HOME/.oh-my-zsh/custom/vimwiki.zsh

env _VIMWIKI_COMPLETE=zsh_source vimwiki >$COMPLETION_PATH
```

## Github Pages

[prek][] runs the following hooks from `.pre-commit-config.yaml` to build and
publish [Github Pages][gh-pages]:

1. pre-commit: `vimwiki-cli` rebuilds tags, generates links, and converts the
   wiki to HTML in `docs/` (`all-html`, i.e. `:VimwikiAll2HTML`).
2. pre-commit: `encode-html-anchors` percent-encodes relative `href`s in
   `docs/**/*.html`. Vimwiki writes anchors with raw spaces, e.g.
   `href="#Generated Tags-fzf"`, which are not valid URLs and confuse crawlers
   (see [#5](https://github.com/jfishe/vimwiki/issues/5)). Element `id`s are
   unchanged.
3. pre-push: `ghp-import` publishes `docs/` to the `gh-pages` branch.

- `git config ghppages.push true` enables publishing; otherwise step 3 is
  skipped.
- `git config ghppages.pathhtml <absolute path>/docs` sets the HTML path.
  Defaults to `$GIT_WORK_TREE/docs`.
- Github page: [John D. Fisher's home wiki](https://jfishe.github.io/vimwiki/)
- `:VimwikiAll2HTML` from a Vimwiki buffer also builds `docs/`, but skips
  `encode-html-anchors`; run `.pre_commit_hooks/encode-html-anchors.py`
  afterwards to preview the published HTML.
- Commit and push to deploy.

```text
├── .github
│   └── workflows
│       └── zap-baseline.yml
├── .pre_commit_hooks
│   ├── encode-html-anchors.py
│   └── gh-pages.sh
├── .zap
│   └── rules.tsv
├── docs
│   ├── css
│   │   └── style.css
├── templates
│   ├── default.tpl
```

## Security Scan

`.github/workflows/zap-baseline.yml` runs a [ZAP baseline scan][zap] of
<https://jfishe.github.io/vimwiki/> every Monday at 06:00 UTC and opens a
"ZAP Scan Baseline Report" issue. Run it on demand with:

```bash
gh workflow run zap-baseline.yml -R jfishe/vimwiki
```

`.zap/rules.tsv` lists suppressed rules and the reason for each, e.g. response
headers GitHub Pages does not allow repositories to set.

[uv]: <https://docs.astral.sh/uv/>
[prek]: <https://github.com/j178/prek>
[gh-pages]: <https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site>
[zap]: <https://github.com/zaproxy/action-baseline>
