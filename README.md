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
- My `emacs` configuration file setup is based on [Harry Schwartz's](https://github.com/hrs/dotfiles/blob/master/emacs/.emacs.d/configuration.org).

Installation
------------

To install these dotfiles on a machine, I first clone the repository,
navigate into it, and call `make install`.
```
$ git clone https://github.com/spencerkclark/dotfiles.git
$ cd dotfiles
$ make install
```
