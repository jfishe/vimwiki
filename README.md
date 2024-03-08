# Home Vimwiki Installation

[`vimfiles/vimfiles/plugin/vimwiki.vim`](https://github.com/jfishe/vimfiles/blob/ebeb257cb1af6a5489ba5608d737d174dc74a878/vimfiles/plugin/vimwiki.vim#L46)
configuration defines Vimwiki configuration.

- Conda environment configuration:
  - Windows [vimfiles](https://github.com/jfishe/vimfiles)
  - Linux [dotfiles](https://github.com/jfishe/dotfiles)

## Vimwiki-cli Installation

- Install
  [sstallion / vimwiki-cli](https://github.com/sstallion/vimwiki-cli)
- Install [pre-commit][].
- Install `python -m pip install ghp-import`

```bash
VIMWIKI_PATH="$HOME/vimwiki_home"

git clone https://github.com/jfishe/vimwiki.git "$VIMWIKI_PATH"

pushd "$VIMWIKI_PATH"

# Install pre-commit hooks and update to latest.
pre-commit install --install-hooks
pre-commit autoupdate

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
popd
```

### Zsh Completion

```bash
COMPLETION_PATH=$HOME/.oh-my-zsh/custom/vimwiki.zsh

# pip install vimwiki-cli
env _VIMWIKI_COMPLETE=zsh_source vimwiki >$COMPLETION_PATH
```

## Github Pages

- `.pre-commit-config.yaml` includes a pre-push hook to publish to
  [Github Pages][gh-pages].
- To enable the hook, `git config ghppages.push true`.
- To set the HTML path, `git config ghppages.pathhtml <absolute path>/docs`.
  Defaults to `$GIT_WORK_TREE/docs`.
- Github page: [John D. Fisher's home wiki](https://jfishe.github.io/vimwiki/)
- Run `:VimwikiAll2HTML` from a Vimwiki buffer or the `vimwiki-cli` pre-commit
  hook.
- Commit and push to deploy.

```text
├── docs
│   ├── css
│   │   └── style.css
├── templates
│   ├── default.tpl
```

[pre-commit]: <https://pre-commit.com/index.html>
[gh-pages]: <https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site>
