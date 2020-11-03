# My Dot Castle

![DotCastle](https://github.com/nikhgupta/dotfiles/raw/master/screenshots/dotcastle.png)

**castle for my dotfiles** - the cornetstone of _dev-kind_ ! :)

This repository contains the dotfiles _(stolen/compiled/created)_ by me.
Major inspirations from [@holman](http://github.com/holman) and
[@mathiasybnens](http://github.com/mathiasbynens). More inspirations
from [dotfiles repository](http://github.com/skwp/dotfiles) by
[@skwp](http://github.com/skwp). Credit has been given where I could. :)

To install, run:

    git clone https://github.com/nikhgupta/dotfiles ~/.dotfiles
    ~/.dotfiles/install.sh

## Version 5 - Back to OSX

### Pre Setup

I had to buy a Macbook Pro due to work requirements. Although, I loved using my Legion Y530
running ArchLinux OS with `bspwm` as tiling window manager, Macbooks have their own USPs.
Primarily, ease of development and longer battery backup over the Legion Y530.

I am using the Macbook Pro as a primary machine now (as mentioned - due to work requirements).
These dotfiles target setup of my Macbook Pro along with (upcoming) `BetterTouchTool` automation
and TouchBar customizations.

My Macbook has a physical Escape key unlike the most unfortunate previous generation Macbooks with 
an Escape key on the TouchBar!!!

I have further remapped by CapsLock key to function as a Hyper key which I know I use sparingly. 
Hyper key only functions really well when it is used to open a keyboard shortcuts modal (aka 
hammerspoon). However, I am not using hammerspoon at the moment - as I wanted to minimize 
dependencies on multiple tools - which brings me to BetterTouchTool.

I use BetterTouchTool for almost everything - from keyboard shortcuts to hyper chords to touch bar 
customization, etc. If hammerspoon ever allows touchbar customization, and keyboard shortcuts with 
`fn` key (a better Hyper key), I would instantly switch to it.

Most of my global shortcuts are triggerd via `fn` key, while some system-level global toggles use 
Hyper key (Caps Lock). Most shortcuts follow vim style `hjkl` movements.

### Remaining

> Choice of tools is influenced by whether the rules/config can be setup using a simple text file.
> If so, we can add that config to version control for easier setups later.

- [ ] Setup Alfred?
- [ ] `maid` rules setup (hazel)
- [ ] TouchBar customizations - Setup BetterTouchTool rules or MTMR rules
- [ ] Tiling features? Archlinux like Terminals? Maybe yabai?
- [ ] all passwords use TouchBar Fingerprint sensor incl. sudo, ssh, gpg, chrome, safari, etc.
- [ ] Setup: hammerspoon/mjolnir, maid, alfred, bettertouchtool/mtmr, yabai/amethyst, etc.

## Version 4 - Archlinux/Manjaro

### Pre-setup

These dotfiles used to target osx (`v1`), ubuntu/archlinux (`v2`), WSL
(`v3`), etc., but with `v4` - I have exclusively settled on using
Archlinux base now. For a quick setup, I do employ Manjaro Architect at
times, which sets up a base Archlinux install for me with a minimal
Gnome shell.

At the moment, I am using a Lenovo Legion Y530 laptop, which I have
really started liking as opposed to my earlier Macbook Airs. The Legion
Y530 laptop has 2 graphic cards, which makes me favor Manjaro vs Arch,
due to automatic hardware detection and drivers setup.

These dotfiles expect a minimal Gnome setup with either Archlinux or
Manjaro, but do allow setting up a tiling window manager - which I use
primarily. The Gnome session is serves as a backup, if needed.

### Screenshots

#### Home (with default wallpaper)

![desktop](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/desktop.png)

#### This system is currently busy

![Busy](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/busy-sys.png)

#### a nice app launcher

![launcher](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/launcher.png)

#### my favorite alfred alternative

![run menu](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/rofi-run.png)

#### a scratch terminal

![scratch terminal](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/scratch-term.png)

#### rofi menu for all configured keybindings

![keybindings](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/rofi-custom.png)

#### more directory colors

![dircolors](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/dircolors.png)

#### and notifications

![notifications](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/notifications-v2-1.png)

#### and a nice screen lock

![screen lock](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/screen-lock.png)

#### Other goodies

##### icons hardcoded and also, autoguessed via font-awesome

![window icons](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/window-icons.png)

##### screencasts, screenshots, wallpaper changer and a real tray

![notifications](https://github.com/nikhgupta/dotfiles/raw/v4.0/screenshots/notification-area.png)
