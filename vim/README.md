# Vim Configuration

This directory adds the required directory structure for [`vimrc`][vimrc]
configuration specified in this repository.

Once setup, directory structure will be similar to:

    ▸ bundle/
    ▸ colors/
    ▾ data/
        bookmarks
    ▾ spell/
        autocorrect.vim
        public.utf-8.add
        public.utf-8.add.spl
        private.utf-8.add
        private.utf-8.add.spl
    ▾ tmp/
        ▸ cache/
        ▸ sessions/
        ▸ swaps/
        ▸ undo/
    README.md

Note that:

- Plugins are installed via `vundle`, which install them in the`bundle`
  directory.

- Files inside `data` directory are versioned via Git, and can be used to store
  persisting data by plugins, e.g. custom snippets, etc.

- Files inside `tmp` directory are ignored by Git, and generally, contains data
  or files that are temporary, e.g. plugin cache, undo data, sessions, etc.

- Files inside `colors` are custom vim colorschemes, that have not yet been
  ported as a VIM bundle, but soon will be.

  [vimrc]: https://github.com/nikhgupta/dotfiles/blob/master/vimrc
