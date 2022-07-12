;; apperance.el

;; https://github.com/hrs/dotfiles
(setq hrs/default-fixed-font jk/font)
(setq hrs/default-fixed-font-size 110)
(setq hrs/current-fixed-font-size hrs/default-fixed-font-size)
(set-face-attribute 'default nil
                    :family hrs/default-fixed-font
                    :height hrs/current-fixed-font-size)
(set-face-attribute 'fixed-pitch nil
                    :family hrs/default-fixed-font
                    :height hrs/current-fixed-font-size)
(setq hrs/font-change-increment 1.1)

(defun hrs/set-font-size ()
  "Change default, fixed-pitch, and variable-pitch font sizes to match respective variables."
  (set-face-attribute 'default nil
		              :height hrs/current-fixed-font-size)
  (set-face-attribute 'fixed-pitch nil
		              :height hrs/current-fixed-font-size)
  )

(defun hrs/reset-font-size ()
  "Revert font sizes back to defaults."
  (interactive)
  (setq hrs/current-fixed-font-size hrs/default-fixed-font-size)
  (hrs/set-font-size))

(defun hrs/increase-font-size ()
  "Increase current font sizes by a factor of `hrs/font-change-increment'."
  (interactive)
  (setq hrs/current-fixed-font-size
        (ceiling (* hrs/current-fixed-font-size hrs/font-change-increment)))
  (hrs/set-font-size))

(defun hrs/decrease-font-size ()
  "Decrease current font sizes by a factor of `hrs/font-change-increment', down to a minimum size of 1."
  (interactive)
  (setq hrs/current-fixed-font-size
        (max 1
             (floor (/ hrs/current-fixed-font-size hrs/font-change-increment))))
  (hrs/set-font-size))

(define-key global-map (kbd "C-)") 'hrs/reset-font-size)
(define-key global-map (kbd "C-+") 'hrs/increase-font-size)
(define-key global-map (kbd "C-=") 'hrs/increase-font-size)
(define-key global-map (kbd "C-_") 'hrs/decrease-font-size)
(define-key global-map (kbd "C--") 'hrs/decrease-font-size)

(hrs/reset-font-size)

(use-package all-the-icons
  :if (window-system)
  )

(use-package beacon
  :custom
  (
   (beacon-color "#4ae3a1")
   (beacon-blink-when-window-scrolls nil)
   )
  :hook
  ((after-init . beacon-mode))
  )

;; http://xahlee.info/emacs/emacs/emacs_CSS_colors.html
(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `http://xahlee.info/emacs/emacs/emacs_CSS_colors.html'
Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background
                      (let* (
                             (ms (match-string-no-properties 0))
                             (r (substring ms 1 2))
                             (g (substring ms 2 3))
                             (b (substring ms 3 4)))
                        (concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))

(add-hook 'prog-mode-hook 'xah-syntax-color-hex)

(use-package rainbow-delimiters
  :hook
  ((org-mode . rainbow-delimiters-mode)
   (prog-mode . rainbow-delimiters-mode))
  )

(use-package doom-themes
  :config
  (load-theme 'doom-palenight t)
  )

(use-package    feebleline
  :custom
  (feebleline-msg-functions
   '((feebleline-line-number         :post "" :fmt "%5s")
     (feebleline-column-number       :pre ":" :fmt "%-2s")
     (feebleline-file-directory      :face feebleline-dir-face :post "")
     (feebleline-file-or-buffer-name :face font-lock-keyword-face :post "")
     (jk/line-modified               :face font-lock-warning-face :post "" :pre " ")
     (feebleline-git-branch          :face feebleline-git-face :pre " " :align left)
     (jk/line-workspace              :align right :post "  -  " :face font-lock-type-face)
     (jk/line-time                   :align right :post "  -  " :face font-lock-constant-face)
     (jk/line-date                   :align right :post "" :face font-lock-negation-char-face)
     ))
  :config
  (feebleline-mode 1)
  )

(defun jk/feeble-workspace ()
  "Returns the current leftwm workspace setup."
  "acb"
  )

(defun jk/line-time ()
  "Returns the current system time for the modeline."
  (format-time-string "%H:%M:%S")
  )

(defun jk/line-date ()
  "Returns the current date for the modeline."
  (format-time-string "%d.%m.%Y")
  )

(defun jk/line-workspace ()
  "Returns the current workspace for the modeline."
  (string-trim (shell-command-to-string "~/.local/bin/workspace"))
  )

(defun jk/line-modified ()
  "Modified version of feebleline star indicator."
  (if
       (and
	(buffer-file-name)
	(buffer-modified-p))
      "*"
    "-"
    )
  )

(defcustom perfect-margin-ignore-regexps
  '("^minibuf" "^[*]" "Minibuf" "[*]" "magit" "mu4e" ".el" ".rs" ".toml" ".go")
  "List of strings to determine if window is ignored.
Each string is used as regular expression to match the window buffer name."
  :group 'perfect-margin)

(defcustom perfect-margin-ignore-filters
  '(window-minibuffer-p)
  "List of functions to determine if window is ignored.
Each function is called with window as its sole arguemnt, returning a non-nil value indicate to ignore the window."
  :group 'perfect-margin)

(use-package perfect-margin
  :config
  (perfect-margin-mode 1)
  )

(provide 'apperance)
