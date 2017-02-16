;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives
;;             '("tromey" . "http://tromey.com/elpa/") t)
;;(add-to-list 'package-archives
  ;;           '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
   
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; project navigation
    projectile

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    ;;smex

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; auto-completion mode
    company

    ;; 
    web-mode

    ;;
    emmet-mode

    ;;
    js2-mode

    ;;
    skewer-mode

	))

;;;;
;; use-package
;;;;
; (unless (package-installed-p 'use-package)
;   (package-install 'use-package))

; (require 'use-package)
; (setq use-package-verbose t)

; (dolist (p my-packages)
;   (when (not (package-installed-p p))
;     (package-install p)))

; (use-package zenburn-theme
;   :ensure t
;   :config
;   (load-theme 'zenburn t))


;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
; (setq frame-title-format
;   '((:eval (if (buffer-file-name)
;     (abbreviate-file-name (buffer-file-name))
;       "%b"))))

(add-to-list 'load-path "~/.emacs.d/vendor")

;;;;
;; Shell
;;;;
;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;;;;
;; Navigation
;;;;
;; ido-mode allows you to more easily navigate choices. For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the the mini-buffer. As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(ido-mode t)

;; Turn this behavior off because it's annoying
(setq ido-use-filename-at-point nil)

;; Don't try to match file across all "work" directories; only match files
;; in the current directory displayed in the minibuffer
(setq ido-auto-merge-work-directories-length -1)

;; This enables ido in all contexts where it could be useful, not just
;; for selecting buffer and file names
(ido-ubiquitous-mode 1)

;; Shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; projectile everywhere!
(projectile-global-mode)

;;;;
;; ui
;;;;

;; Show line numbers
(global-linum-mode)

;; You can uncomment this to remove the graphical toolbar at the top. After
;; awhile, you won't need the toolbar.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
; (load-theme 'zenburn-theme t)
(add-hook 'after-init-hook (lambda () (load-theme 'zenburn t)))

;; increase font size for better readability
(set-face-attribute 'default nil :height 140)

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it
;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 177) (height . 53)))

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t

      ;; I'm actually not sure what this does but it's recommended?
      x-select-enable-primary t

      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t

      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      apropos-do-all t

      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

;;;;
;; editing
;;;;
;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
; (global-hl-line-mode 1)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
; (global-set-key (kbd "C-s") 'isearch-forward-regexp)
; (global-set-key (kbd "C-r") 'isearch-backward-regexp)
; (global-set-key (kbd "C-M-s") 'isearch-forward)
; (global-set-key (kbd "C-M-r") 'isearch-backward)

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
; (require 'saveplace)
; (setq-default save-place t)
; ;; keep track of saved places in ~/.emacs.d/places
; (setq save-place-file (concat user-emacs-directory "places"))

;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; yay rainbows!
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; fix weird os x kill error
(defun ns-get-pasteboard ()
  "Returns the value of the pasteboard, or nil for unsupported formats."
  (condition-case nil
      (ns-get-selection-internal 'CLIPBOARD)
    (quit nil)))

(setq electric-indent-mode nil)

;;;;
;; misc
;;;;
;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-screen t)

;;;;
;; elisp-editing
;;;;

;;;;
;; Clojure
;;;;
;; Enable paredit for Clojure
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))

;;;;
;; Cider
;;;;
;; provides minibuffer documentation for the code you're typing into the repl
; (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
; (setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
; (setq cider-show-error-buffer t)
; (setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
; (setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
; (setq cider-repl-wrap-history t)

;; enable paredit in your REPL
; (add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
; (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
; (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
; (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
; (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


;; key bindings
;; these help me out with the way I usually develop web apps
; (defun cider-start-http-server ()
;   (interactive)
;   (cider-load-current-buffer)
;   (let ((ns (cider-current-ns)))
;     (cider-repl-set-ns ns)
;     (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
;     (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


; (defun cider-refresh ()
;   (interactive)
;   (cider-interactive-eval (format "(user/reset)")))

; (defun cider-user-ns ()
;   (interactive)
;   (cider-repl-set-ns "user"))

; (eval-after-load 'cider
;   '(progn
;      (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
;      (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
;      (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
;      (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))

;;;;
;; js
;;;;
; (add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
; (add-hook 'js-mode-hook 'subword-mode)
; (add-hook 'html-mode-hook 'subword-mode)
; (setq js-indent-level 2)
; (eval-after-load "sgml-mode"
;   '(progn
;      (require 'tagedit)
;      (tagedit-add-paredit-like-keybindings)
;      (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))


; ;; coffeescript
; (add-to-list 'auto-mode-alist '("\\.coffee.erb$" . coffee-mode))
; (add-hook 'coffee-mode-hook 'subword-mode)
; (add-hook 'coffee-mode-hook 'highlight-indentation-current-column-mode)
; (add-hook 'coffee-mode-hook
;           (defun coffee-mode-newline-and-indent ()
;             (define-key coffee-mode-map "\C-j" 'coffee-newline-and-indent)
;             (setq coffee-cleanup-whitespace nil)))
; (custom-set-variables
;  '(coffee-tab-width 2))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; auto-completion
; (global-company-mode)

;; mode-specific hooks
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; To make TAB complete, without losing the ability to manually indent
; (global-set-key (kbd "TAB") #'company-indent-or-complete-common)