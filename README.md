# Home Vimwiki Installation

[`vimfiles/vimfiles/plugin/vimwiki.vim`](https://github.com/jfishe/vimfiles/blob/ebeb257cb1af6a5489ba5608d737d174dc74a878/vimfiles/plugin/vimwiki.vim#L46)
configuration defines Vimwiki configuration.

- Conda environment configuration:
  - Windows [vimfiles](https://github.com/jfishe/vimfiles)
  - Linux [dotfiles](https://github.com/jfishe/dotfiles)

## Vimwiki-cli Installation

- Installation instructions:
  [sstallion / vimwiki-cli](https://github.com/sstallion/vimwiki-cli)
- Pre-commit hook to maintain tags:
  [vimwiki-cli/scripts/pre-commit.sh](https://github.com/sstallion/vimwiki-cli/blob/master/scripts/pre-commit.sh)

```bash
VIMWIKI_PATH=$HOME/vimwiki_home

git clone https://github.com/jfishe/vimwiki.git $VIMWIKI_PATH

curl \
https://raw.githubusercontent.com/sstallion/vimwiki-cli/master/scripts/pre-commit.sh \
> $VIMWIKI_PATH/.git/hooks/pre-commit

pushd $VIMWIKI_PATH
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
popd
```

### Zsh Completion

```bash
COMPLETION_PATH=$HOME/.oh-my-zsh/custom/vimwiki.zsh

# pip install vimwiki-cli
env _VIMWIKI_COMPLETE=zsh_source vimwiki >$COMPLETION_PATH
```

## Github Pages

- Add gh-pages to `$VIMWIKI_PATH/.git/hooks/pre-commit`:

  ```bash
  # Update gh-pages
  if test "$(git config --bool ghppages.push || echo false)" = true
  then
    pathhtml=$(git config ghppages.pathhtml || echo "$GIT_WORK_TREE/docs")
    say 'Pushing html to gh-pages...'
    ghp-import -n -o -p -f "$pathhtml"
    say_done
  fi
  ```

- `python -m pip install ghp-import`
- Github page: [John D. Fisher's home wiki](https://jfishe.github.io/vimwiki/)
- Run `:VimwikiAll2HTML` from a Vimwiki buffer.
- Commit and push to deploy.

```text
├── docs
│   ├── css
│   │   └── style.css
├── templates
│   ├── default.tpl
```
