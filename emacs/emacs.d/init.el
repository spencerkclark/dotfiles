;; Taken from Harry Schwartz's dotfiles
;; (package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(org-babel-load-file "~/.emacs.d/configuration.org")

;; Allow for an optional local configuration file to
;; add or override my universal settings.
(if (file-exists-p "~/.emacs_local.org")
    (org-babel-load-file "~/.emacs_local.org"))
