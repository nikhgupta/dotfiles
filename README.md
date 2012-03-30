My Dot Castle
=============

    git clone git@github.com:nikhgupta/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    export DISPLAY_LOAD_ORDER_REAL=NON_EMPTY
    rake install && rake reload

The above commands loads the dotfiles into the current machine while it displays the name of the files as they are sourced into the Shell. This is specially useful at the time of debugging for some issue.

Notes
-----
* You can simply set the environment variable `DISPLAY_LOAD_ORDER_REAL` to some `non_empty` value to view which files have been sourced into the current Shell.
* You can also set the environment variable `DISPLAY_LOAD_ORDER_ALL` to some `non_empty` value to view all the files that will be loaded, if they exist.
* You are also able to view the load order in the exact order it took place and hence, this will really help with any troubleshooting or while debugging.
