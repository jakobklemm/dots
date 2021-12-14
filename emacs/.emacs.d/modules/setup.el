;; Basic settings

;; Turn off backup files
(setq-default backup-inhibited t)

;; Auto wrap text
(auto-fill-mode t)

;; selected text and start inserting your typed text.
(delete-selection-mode t)

;; If you save a file that doesn't end with a newline, automatically
;; append one.
(setq require-final-newline t)

;; Visually indicate matching pairs of parentheses.
(show-paren-mode t)
(setq show-paren-delay 0.0)

;; Disable any type of warning
(setq ring-bell-function 'ignore)
(setq visible-bell nil)

;; Don't ask `yes/no?', ask `y/n?'.
(fset 'yes-or-no-p 'y-or-n-p)

;; Ask if you're sure that you want to close Emacs.
(setq confirm-kill-emacs 'y-or-n-p)

;; When something changes a file, automatically refresh the buffer
;; containing that file so they can't get out of sync.
(global-auto-revert-mode t)

;; Move everything to trash first
(setq delete-by-moving-to-trash t)

;; Mark the current line
(setq-default global-visual-line-mode t)

;; Use tabs for everything (https://youtu.be/SsoOG6ZeyUI)
(setq indent-tabs-mode t)
(setq indent-line-function 'insert-tab)

;; Launch emacs in fullscreen mode
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Save the location within a file.
(save-place-mode t)

;; Set always to UTF-8, only display in bar if not UTF-8
(set-language-environment "UTF-8")

;; Minibuffer
(set-window-scroll-bars (minibuffer-window) nil nil)

;; Use smoth scrolling
(setq scroll-conservatively 100)

;; Highlight the current line
(global-hl-line-mode)

;; Don't warn about large files
(setq large-file-warning-threshold nil)

;; Don't warn about symlinks
(setq vc-follow-symlinks t)

;; Line wrap mode
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'gfm-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)

(setq byte-compile-warnings '(cl-functions))

;; File size limit to 100M
(setq-default large-file-warning-threshold 100000000)

;; Disable double space after sentence.
(setq-default sentence-end-double-space nil)

;; Symbol for long lines.
(setq-default truncate-lines t)

;; Disable startup screen
(setq inhibit-startup-screen t)

;; Don't confirm killing processes when emacs closes.
(setq confirm-kill-processes nil)

;; Don't put everything into the kill ring.
(setq mark-even-if-inactive nil)

;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Minibuffer-History.html
(setq history-delete-duplicates t)

;; Paste with middle mouse at the current position
(setq mouse-yank-at-point t)

;; Disable native-comp warnings
(setq comp-async-report-warnings-errors nil)

;; Add custom scripts in lisp/
(push "~/.dots/emacs/.emacs.d/lisp" load-path)

;; Esc quits everything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)
(menu-bar-mode -1)            ; Disable the menu bar

;; No message in scratch buffer
(setq initial-scratch-message nil)

;; No empty line indicators
(setq indicate-empty-lines nil)

;; Fill column at 80
(setq fill-column 80)

;; No confirmation for visiting non-existent files
(setq confirm-nonexistent-file-or-buffer nil)

;; Buffer encoding
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)
