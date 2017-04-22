Personal dotfiles
-----------------

The purpose of this repository is to keep track of the shell and text editor
settings that I would like to have in common across all machines that I work on.

- The structure of this repository, as well as the `zsh` settings are based
heavily
on
[Armin Ronacher's public dotfiles repository](https://github.com/mitsuhiko/dotfiles).
- My global `emacs` and `org-mode` settings are based substantially
 on
 [Daniel Rothenberg's](https://github.com/darothen/dotfiles/tree/master/emacs).
- I ended up modularizing my file-type-specific settings into separate `.el` files
based on
this
[StackOverflow answer](http://stackoverflow.com/questions/2079095/how-to-modularize-an-emacs-configuration).

Installation
------------

To install these dotfiles on a machine, I first clone the repository,
navigate into it, and call `make install`.
```
$ git clone https://github.com/spencerkclark/dotfiles.git
$ cd dotfiles
$ make install
```
Note that my `emacs` configuration relies on the [`package.el` library](http://wikemacs.org/wiki/Package.el), which
comes installed with versions of `emacs` 24 and above.  One can do a local
install of the latest version of `emacs` using `conda` if the root install of
`emacs` is too old:
```
$ conda install -c conda-forge emacs
```
