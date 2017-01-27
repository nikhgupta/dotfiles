# DotCastle: How do I add scripts?

DotCastle ZSH configuration can load scripts from `$DOTCASTLE/scripts`
directory. It can load binaries/executables from inside `./bin` and ZSH
completions from inside `./completions` for a script placed at the first
depth level in this path.

Therefore, if we create a new script:
`$DOTCASTLE/scripts/my-new-script/{bin,completions}`, all the scripts
from the `bin` directory will be loaded, along with completions from the
`completions` directory.

Note that, these scripts are given lower priority over scripts/bins
under `/usr/local/bin` or `/usr/bin` or any other variant, i.e. these
scripts added at the end of the `$PATH` variable.

The structure of the `scripts` folder makes it easy to create
[`subs`](https://github.com/basecamp/sub), and add them to ZSH easily.
We can, simply, create a new sub and get it working along with
completions (without adding anything to our ZSH config), like this:

    ```bash
    git clone git://github.com/37signals/sub.git $DOTCASTLE/scripts/supersub
    cd $DOTCASTLE/scripts/supersub
    ./prepare.sh supersub
    ```

For convenience, you can use `createsub supersub` for this purpose.
