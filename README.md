My Dot Castle
=============

![DotCastle](http://cdn.obsidianportal.com/assets/38992/AldredsCastle.jpg)

**castle for my dotfiles** - the cornetstone of *dev-kind* ! :)

This repository contains the dotfiles *(stolen/compiled/created)* by me.
Major inspirations from [@holman](http://github.com/holman) and
[@mathiasybnens](http://github.com/mathiasbynens). More inspirations
from [dotfiles repository](http://github.com/skwp/dotfiles) by
[@skwp](http://github.com/skwp). Credit has been given where I could. :)

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
`~/Code/__dotfiles` for the installation, in which case, you can simply
modify the first line of the following bash commands to suit your taste
;) Note that, `DotCastle` requires `homebrew` (or `linuxbrew`) and
`ohmyzsh`, and the same can be installed manually, or via the installer
script at `./scripts/dep-installer.sh`.

    ```bash
    export DOTCASTLE=$HOME/Code/__dotfiles
    git clone git://github.com/nikhgupta/dotfiles.git $DOTCASTLE
    # run the installer script
    $DOTCASTLE/scripts/dep-installer.sh
    $DOTCASTLE/scripts/bootstrap.sh
    ```

How my Development Environment is Setup
=======================================

A lot of this information can be found on my [blog](http://nikhgupta.com).

Primarily, I use a lot of tools to setup my development environment, and
thanks to the *nix goodness, all fo these tools have a way to specify
their configurations. Most of the times, I will include such
configurations within this repository to keep them versioned.

The minimal setup that I would like to work with includes these
dotfiles, as well as `base16-eighties` and `solarized` themes for both
iTerm2 and MacVim, along with Homebrew on my MacOSX.

Everything goes inside ~/Code
-----------------------------

All my code resides in the `~/Code` directory. Typically:

- repositories are downloaded to the `repos` directory.
- these dotfiles are present at `__dotfiles` directory.
- scripts are saved to `__dotfiles/scripts` directory, and include [`subs`](https://github.com/basecamp/sub) created.
- websites that I develop upon locally are present at `sites` directory.
- work related code is located in `work` directory.
- other personal/miscelleneous code is present in topic-wise directories
  under `personal` directory.

iTerm2
------

I prefer iTerm2 over Terminal app in MacOSX, and have installed the
`base16-eighties` theme for it. Note that, this requires `base16-shell`
to be loaded in my ZSH configuration.
    
OhMyZsh!
--------
    
I like OhMyZSH! project, which provides me with a ready-to-use ZSH
configuration. I customize upon that heavily, but OMZ! is a major
ingredient.

HomeBrew and packages
---------------------

[HomeBrew](http://brew.sh) is a necessity for development on OSX, and is
a really awesome package manager. I use it to install various
dependencies and packages, like `macvim,` `rbenv,` `autoenv,`
`zsh-syntax-highlighting` etc. If there is a formula available for
a particular program in Homebrew, I would prefer it over other sources.
Also, note that brew installs `zsh` completions to
`/usr/local/share/zsh/site-functions` file, which helps me add custom
completions, easily. On Ubuntu, I install the Linux version of Homebrew,
namely `Linuxbrew`.
