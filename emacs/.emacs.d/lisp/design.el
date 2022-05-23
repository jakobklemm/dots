(custom-set-faces '(org-ellipsis ((t (:foreground "#6483b5" :underline nil)))))

;; https://github.com/hrs/dotfiles
(setq hrs/default-fixed-font "Fira Code")
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
  :defer t
  :if (window-system))

(use-package beacon
  :defer t
  :custom
  (
   (beacon-color "#4ae3a1")
   (beacon-blink-when-window-scrolls nil)
   )
  :hook
  ((after-init . beacon-mode))
  )

(use-package rainbow-delimiters
  :defer t
  :config
  (add-hook 'org-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(global-prettify-symbols-mode 1)

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
  :ensure t
  :config
  (perfect-margin-mode 1)
  )

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

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

(set-fringe-mode '(5 . 0))
(set-face-attribute 'fringe nil :background "#212026" :foreground "#e6e6e8")

(use-package doom-themes
  :config 
  (load-theme 'doom-ir-black t)
  )

(require 'nano-modeline)

(nano-modeline-mode t)
