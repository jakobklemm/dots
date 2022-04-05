(use-package kaolin-themes
  :config
  (load-theme 'kaolin-galaxy t)
  )

(custom-set-faces '(org-ellipsis ((t (:foreground "#6483b5" :underline nil)))))

;; https://github.com/hrs/dotfiles
(setq hrs/default-fixed-font "Fira Code")
;;(setq hrs/default-fixed-font "Roboto Mono")
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

;; More font support
(use-package unicode-fonts
  :disabled
  :custom
  (unicode-fonts-skip-font-groups '(low-quality-glyphs))
  :config
  (unicode-fonts-setup)
  )

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

(use-package sublimity
  :defer t
  :config
  (require 'sublimity)
  (require 'sublimity-map)
  (sublimity-mode 1)
  )

(use-package rainbow-delimiters
  :defer t
  :config
  (add-hook 'org-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "λ")
                                       ("#+END_SRC" . "λ")
                                       ("#+begin_src" . "λ")
                                       ("#+end_src" . "λ")
                                       ("#+TITLE:" . "𝙏")
                                       ("#+title:" . "𝙏")
                                       ("#+SUBTITLE:" . "𝙩")
                                       ("#+subtitle:" . "𝙩")
                                       ("#+DATE:" . "𝘿")
                                       ("#+date:" . "𝘿")
                                       ("#+PROPERTY:" . "☸")
                                       ("#+property:" . "☸")
                                       ("#+OPTIONS:" . "⌥")
                                       ("#+options:" . "⌥")
                                       ("#+LATEX_HEADER:" . "⇾")
                                       ("#+latex_header:" . "⇾")
                                       ("#+LATEX_CLASS:" . "⇥")
                                       ("#+latex_class:" . "⇥")
                                       ("#+ATTR_LATEX:" . "🄛")
                                       ("#+attr_latex:" . "🄛")
                                       ("#+LATEX:" . "ℓ")
                                       ("#+latex:" . "ℓ")
                                       ("#+ATTR_HTML:" . "🄗")
                                       ("#+attr_html:" . "🄗")
                                       ("#+BEGIN_QUOTE:" . "❮")
                                       ("#+begin_quote:" . "❮")
                                       ("#+END_QUOTE:" . "❯")
                                       ("#+end_quote:" . "❯")
                                       ("#+CAPTION:" . "☰")
                                       ("#+caption:" . "☰")
                                       (":PROPERTIES:" . "⚙")
                                       (":properties:" . "⚙")
                                       ("#+AUTHOR:" . "A")
                                       ("#+author:" . "A")
                                       ("#+IMAGE:" . "I")
                                       ("#+image:" . "I")
                                       ("#+LANGUAGE:" . "L")
                                       ("#+language:" . "L")
                                       ))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(global-prettify-symbols-mode 1)

(use-package olivetti
  :defer t
  :custom
  ((olivetti-style 'fancy)
   (olivetti-body-width 80)
   )
  :hook
  ((org-mode . olivetti-mode)))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Colors
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

;; Modeline setup (most color config comes from customize-face)
(require 'nano-modeline)
(nano-modeline-mode t)

(setq bg0 "#212026")
(setq bg1 "#292735")
(setq accent0 "#4EB8CA")
(setq accent1 "#C74A4D")
(setq accent2 "#4FBB8A")
(setq fg0 "#EEE6D3")
(setq fg1 "#9d81ba")

(set-face-attribute 'nano-modeline-active nil :background bg1 :foreground fg0 :box nil)
(set-face-attribute 'nano-modeline-active-name nil :background bg0 :foreground accent2 :box nil)
(set-face-attribute 'nano-modeline-active-primary nil :foreground fg0 :background bg1 :box nil)
(set-face-attribute 'nano-modeline-active-secondary nil :foreground accent0 :background bg1 :box nil)
(set-face-attribute 'nano-modeline-active-status-** nil :foreground accent1 :background bg1 :box nil)
(set-face-attribute 'nano-modeline-active-status-RO nil :foreground fg0 :background bg1 :box nil)
(set-face-attribute 'nano-modeline-active-status-RW nil :foreground fg0 :background bg1 :box nil)

(set-face-attribute 'nano-modeline-inactive nil :background bg0 :foreground fg1 :box nil)
(set-face-attribute 'nano-modeline-inactive-name nil :background bg0 :foreground fg0 :box nil)
(set-face-attribute 'nano-modeline-inactive-primary nil :foreground fg1 :background bg0 :box nil)
(set-face-attribute 'nano-modeline-inactive-secondary nil :foreground fg0 :background bg0 :box nil)
(set-face-attribute 'nano-modeline-inactive-status-** nil :foreground accent1 :background bg0 :box nil)
(set-face-attribute 'nano-modeline-inactive-status-RO nil :foreground fg1 :background bg0 :box nil)
(set-face-attribute 'nano-modeline-inactive-status-RW nil :foreground fg1 :background bg0 :box nil)
