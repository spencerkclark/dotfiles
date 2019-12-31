;; Taken from Harry Schwartz's dotfiles

;; A couple lines to accelerate startup; see
;; https://github.com/MatthewZMD/.emacs.d for more details.
(setq gc-cons-threshold 67108864)
(setq package-enable-at-startup nil)

(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(org-babel-load-file "~/.emacs.d/configuration.org")

;; Allow for an optional local configuration file to
;; add or override my universal settings.
(if (file-exists-p "~/.emacs_local.org")
    (org-babel-load-file "~/.emacs_local.org"))
