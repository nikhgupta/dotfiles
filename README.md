My Dot Castle
=============

    $INSTALL_LOCATION="~/.dotfiles"
    mkdir -p $INSTALL_LOCATION && cd $INSTALL_LOCATION
    git clone git://github.com/nikhgupta/dotfiles.git .
    rake install

The above commands loads the dotfiles into the current machine. Although, in
my opinion, its wiser to install at a location such as: ~/Code/__dotfiles,
because:
  - all your code-related data can be stored in a single directory: ~/Code
  - More importantly, since the folder isn't hidden anymore, you will be
  	intrigued to make changes to the contents of this folder.

Notes
-----
To make real use of this dotfiles repository, please read the included
SETUP file, since it contains some very important instructions on how to set
everything up.
