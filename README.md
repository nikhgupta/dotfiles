My Dot Castle
=============

**dotfiles** - the cornetstone of *devkind* ! :)

This repository contains the dotfiles *(stolen/compiled/created)* by me.  
Major inspirations from [@holman](http://github.com/holman) and [@mathiasybnens](http://github.com/mathiasbynens).
Soon to dwelve into [dotfiles repository](http://github.com/skwp/dotfiles) by [@skwp](http://github.com/skwp)

Save dotfiles in ~/Code/\_\_dotfiles !!!
---------------------------------------

Following some conventions, I store all my code inside `~/Code` directory.
This has obvious *organizational* benefits.  
On similar grounds, I store my dotfiles inside `~/Code/__dotfiles` directory,
which is more sensible in my opinion than `~/.dotfiles`, because:
  - dotfiles are the heart of your code - obvious reason to have them stored
    right next to all your code in `~/Code`
  - dotfiles directory is in front of your eyes at all times, and hence, you
    will be intrigued to change it more often than when it was hidden.
  - more importantly, improving code in dotfiles implies improved productivity.

Installation
------------
There will be a 80% chance you will have a reason not to use
`~/Code/__dotfiles` for the installation, in which case, you can simply modify
the first line of the following bash commands to suit your taste ;)

    $INSTALL_LOCATION="~/Code/__dotfiles"
    mkdir -p $INSTALL_LOCATION && cd $INSTALL_LOCATION
    git clone git://github.com/nikhgupta/dotfiles.git .
    rake install

How my Development Environment is Setup
=======================================
Its not enough to install these dotfiles - my environment requires some more
tweaks, e.g. setting up Solarized themes, using Todo.txt-cli and so on.

So, I have included some setup instructions for myself, and for any
unfortunate soul who might be reading all this.

Following are the vague instructions on how to setup everything for my
development environment. These instructions might be outdate, might not work,
or even obsolete (none of these should be true, in general), but the idea here
is to have an understanding (and a record) of how everything is setup for
myself :)

Homebrew
--------
- install [Homebrew](http://mxcl.github.com/homebrew)
- run Brew Doctor to check if everything is as expected (this step might
  require application of your IQ)
- install some common and essential homebrew packages

Code:

    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
    brew doctor
    brew install wget ack git git-flow macvim


Everything goes inside ~/Code
-----------------------------
Everything - everything, I code - goes inside `~/Code` directory. I have setup
structure for various things and, carefully, place my code inside these
directories. This *oragnization* is still vague and *may* undergo heavy
changes.

- repositories are downloaded from github and bitbucket to `__repos` using a import script 
- repositories are downloaded from gitolite server inside `__repos/gitbox` directory using the same script
- all the snippets are stored inside `__snippets`  
  (contains a `gist` directory where all my public and private gists are downloaded via a script)
- vagrant boxes, chef recipes, etc. for vagrant are downloaded and stored inside `__vagrant` directory
- `scripts` will eventually be populated from a git repository setup for this purpose.
- `sites` directory is the real codebase for all applications/websites.

Code:

    mkdir -p ~/Code/__{files,repos,vagrant}
    mkdir -p ~/Code/{scripts,sites,snippets}
    mkdir -p ~/Code/scripts/shell

iTerm2
------
- visit here: http://code.google.com/p/iterm2/downloads/list
- download one of the zip files from there and install iTerm2
- open iTerm2 > Preferences > Profiles > Default > Colors > load presets > Solarized Dark
- open iTerm2 > Preferences
    - Inside Keys
        - Hotkeys > Check both
        - Hotkeys > (Command, tilde)
    - Inside Profiles > Hotkey Window 
        - Color > load presets > Solarized Light
        - Window > Style > Fullscreen
- add iTerm2 to run on system startup
    
Oh My Zsh
---------
    
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

Solarized
---------
All these URLs link to specific files in the Solarized repo on Github

    curl -fsSkL http://is.gd/sdMcIS > "/tmp/solarized/Solarized Dark.itermcolors"
    curl -fsSkL http://is.gd/IuUlFQ > "/tmp/solarized/Solarized Light.itermcolors"
    curl -fsSkL http://is.gd/TfM3m8 > ~/Library/Colors/
    open /tmp/solarized/iterm2-colors-solarized/*.itermcolors

RVM (Ruby Version Manager)
--------------------------
Install a stable release of Ruby Version Manager

    curl -fsSkL https://get.rvm.io | bash -s stable

RubyOnRails
-----------
- make sure RVM is installed and working properly
- install Ruby v1.9.3 (which is the latest, at the time of writing this)
- Setup this new ruby as the default ruby
- install latest available gem for `Rails`

Code:

    source ~/.rvm/bin/rvm
    type rvm | head -1    #==> "rvm is a function"
    rvm install 1.9.3
    rvm use 1.9.3@global --default
    rvm use 1.9.3@rails --create && gem install rails

Todo Manager
------------
The awesome simplistic Todo Manager which works from the CLI (which is then aliased in my dotfiles)

    mkdir -p ~/Code/scripts/shell &&
    git clone https://github.com/ginatrapani/todo.txt-cli.git ~/Code/scripts/shell

Z
----
**directory jumping** - nice little nifty shell script :)

    mkdir -p ~/Code/scripts/shell &&
    git clone https://github.com/rupa/z.git ~/Code/scripts/shell

Dotfiles
--------

    cd ~/Code/__dotfiles && 
    git clone https://github.com/nikhgupta/dotfiles.git . &&
    rake install && cd

Syntax Highlighting for ZSH
---------------------------
**on the fly** syntax highlighting for your shell - awesomeness personified :P

    mkdir -p ~/Code/scripts/shell &&
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/Code/scripts/shell

TextExpander
------------
- another little piece of software embedded in my workflow
- link to Dropbox for previous expansion snippets

SSH Keys
--------
- add your private keys to MacOSX Keychain, using: `ssh-add -K /path/to/key`

Ryan Bates' c
-------------
- *yet to add...*

