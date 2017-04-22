;; Personal org-mode setup
;; Heavily borrowed from Daniel Rothenberg's: https://github.com/darothen/dotfiles/blob/master/emacs/.emacs.d/darothen.org

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)

(setq org-agenda-files
      (append '("~/org/main.org"
                "~/org/phd.org"
                "~/org/personal.org")
              (file-expand-wildcards "~/org/cals/*.org")))


;; Keyboard Shortcuts
(bind-key "C-c c" 'org-capture)
(bind-key "C-c a" 'org-agenda)
(bind-key "C-c l" 'org-store-link)
(bind-key "C-c L" 'org-insert-link-global)
(bind-key "C-c O" 'org-open-at-point-global)
(bind-key "C-c j" 'org-clock-goto)
(bind-key "C-c C-w" 'org-refile)
(bind-key "<f9> h" 'bh/hide-other)
(bind-key "<f9> <f9>" 'org-agenda-list)
(bind-key "<f9> <f8>" (lambda () (interactive) (org-capture nil "r")))

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
        (org-cycle)))

;; Logging and clocking
(setq org-clock-into-drawer t)
(setq org-drawers '("PROPERTIES" "LOGBOOK"))
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-in-resume t)

;; Custom status keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "INPROGRESS(i)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "SHELF(s@/!)")))
(setq org-todo-keyword-faces
      '(("TODO" :foreground "blue" :weight bold)
        ("NEXT" :foreground "orange" :weight bold)
        ("INPROGRESS" :foreground "lightgreen" :weight bold)
        ("DONE" :foreground "forestgreen" :weight bold)
        ("WAITING" :foreground "gold" :weight bold)
        ("HOLD" :foreground "red" :weight bold)
        ("SHELF" :foreground "purple" :weight bold)))
