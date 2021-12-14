(load-file "~/.emacs.d/lisp/jeykey-dark-theme.el")

(load-theme 'jeykey-dark t)

(set-cursor-color "#4ae3a1")
(set-face-background 'hl-line "#303440")
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

;; TODO ?
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

;; Distraction free writing experience
(use-package writeroom-mode
  :defer t
  :hook ((org-mode . writeroom-mode))
  :custom
  (
   (writeroom-width 90)
   )
  )

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

;; Modeline & NANO
(require 'nano-modeline)
(nano-modeline-mode t)

(set-fringe-mode '(5 . 0))

