;; Adapted heavily from Daniel Rothenberg's setup in
;; https://github.com/darothen/dotfiles/blob/master/emacs/.emacs

;; Configuration of package managers
(require 'cl)
(require 'package)

;; Fetch list of available packages
(package-initialize)

;; Names of the package archives
(setq package-archives
  '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))

;; List the packages we want to install
(let* ((packages
        '(anaconda-mode      ; Alternative Python major mode
          auctex             ; Improved LaTeX mode
          auto-complete      ; Auto-completions based on buffer contents
          better-defaults    ; Aesthetics and other tweaks
          bind-key           ; Alias for more efficiently binding custom keys
          color-theme        ; Color/theme chooser
          flycheck           ; On the fly syntax checking
          idle-require       ; Delayed package loading
          leuven-theme       ; Nice light white/blue theme
          magit              ; Tools for controlling git from Emacs
          markdown-mode      ; Major mode for editing Markdown files
          material-theme     ; Mixed theme from Google Material
          moe-theme          ; Dark theme
          monokai-theme      ; Classic slate/dark theme
          org                ; Outline-based notes and task manager
          org-ref            ; Integrated reference manager for Org mode
          use-package))      ; Alias for loading packages
       (packages (remove-if 'package-installed-p packages)))

  (when packages
    (ignore-errors (unless package-archive-contents (package-refresh-contents))
		                    (mapcar 'package-install packages))))

;; Delayed loading - for packages which can be cumbersome and time-consuming
;; to load, this forces them to be loaded later on only when emacs is idling.
;; Helps to speed startup times
(require 'idle-require)
(setq idle-require-delay 5)
(idle-require-mode 1)

;; Loads of better default options
(require 'better-defaults)

;; Set default values
(setq auto-revert-interval 1         ; Refresh buffers fast
      default-buffer-file-coding-system 'utf-8 ; UTF-8 default file encoding
      default-tab-width 4            ; Spaces per tab
      echo-keystrokes 0.1            ; Show keystrokes ASAP
      inhibit-startup-screen t       ; Don't display the startup screen
      initial-scratch-message nil    ; Clean scratch buffer
      line-move-visual t             ; Wrap long-lines
      read-file-name-completion-ignore-case t ; Ignore case when reading file names
      ring-bell-function 'ignore     ; Quiet that damn bell
      sentence-end-double-space nil  ; Sentences should end with one space
)


;; Set defaults for buffer-local values
(setq-default fill-column 79         ; Set the fill column to 79
              indent-tabs-mode nil   ; Use spaces for indents, not tabs
                                        ; split-width-threshold 100 ; Split vertically by default
              auto-fill-function 'do-auto-fill ; Automatically break lines at fill-column
)

;; Setup UTF-8 encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

;; Turn on syntax highlighting for all buffers
(global-font-lock-mode t)

;; Require newline at end of files
(setq require-final-newline t)
