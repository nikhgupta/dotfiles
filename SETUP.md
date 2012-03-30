How my Development Environment is Setup
=======================================

Homebrew
--------

    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
    brew doctor
    brew install wget ack git git-flow macvim


Everything goes inside ~/Code
-----------------------------

    mkdir -p ~/Code/__{files,repos,vagrant}
    mkdir -p ~/Code/{scripts,sites,snippets}
    mkdir -p ~/Code/scripts/shell
    # populate __repos using repo_import script
    # populate __snippets using snippet_import script
    # populate __vagrant  using wget call
    # populate scripts in other ways
    # populate sites via backup?

Solarized
---------
    # all these URLs link to specific files in the Solarized repo on Github
    curl -fsSkL http://is.gd/sdMcIS > "/tmp/solarized/Solarized Dark.itermcolors"
    curl -fsSkL http://is.gd/IuUlFQ > "/tmp/solarized/Solarized Light.itermcolors"
    curl -fsSkL http://is.gd/TfM3m8 > ~/Library/Colors/
    open /tmp/solarized/iterm2-colors-solarized/*.itermcolors

iTerm2
------
- visit here: http://code.google.com/p/iterm2/downloads/list
- download one of the zip files from there and install iTerm2
- open iTerm2 > Preferences > Profiles > Default > Colors > load presets > Solarized Dark
- open iTerm2 > Preferences
    - > Keys
        - > Hotkeys > Check both
        - > Hotkeys > (Command, tilde)
    - > Profiles > Hotkey Window 
        - > Color > load presets > Solarized Light
        - > Window > Style > Fullscreen
- add iTerm2 to run on system startup
    
Oh My Zsh
---------
    
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

RVM (Ruby Version Manager)
--------------------------
    curl -fsSkL https://get.rvm.io | bash -s stable

RubyOnRails
-----------
    source ~/.rvm/bin/rvm
    type rvm | head -1    #==> "rvm is a function"
    rvm install 1.9.3
    rvm use 1.9.3@global --default
    rvm use 1.9.3@rails --create && gem install rails

Todo Manager
------------
    mkdir -p ~/Code/scripts/shell &&
    git clone https://github.com/ginatrapani/todo.txt-cli.git ~/Code/scripts/shell

Z
----
    mkdir -p ~/Code/scripts/shell &&
    git clone https://github.com/rupa/z.git ~/Code/scripts/shell

Dotfiles
--------
    cd ~/Code/__dotfiles && 
    git clone https://github.com/nikhgupta/dotfiles.git . &&
    rake install &&
    cd

Syntax Highlighting for Shell
-----------------------------
    mkdir -p ~/Code/scripts/shell &&
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/Code/scripts/shell

Ryan Bates' c
-------------

TextExpander
------------
- link to Dropbox for previous expansion snippets
