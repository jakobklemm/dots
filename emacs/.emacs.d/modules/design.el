(load-file "~/.emacs.d/lisp/jeykey-dark-theme.el")

(load-theme 'jeykey-dark t)

(set-cursor-color "#4ae3a1")
(set-face-background 'hl-line "#303440")
(custom-set-faces '(org-ellipsis ((t (:foreground "#6483b5" :underline nil)))))

;; Font & Resize
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

;; Icons
(use-package all-the-icons
  :defer t
  :if (window-system))

(use-package telephone-line
  :defer t
  :hook (after-init . telephone-line-mode)
  :custom
  (
   (telephone-line-primary-left-separator 'telephone-line-gradient)
   (telephone-line-secondary-left-separator 'telephone-line-nil)
   (telephone-line-primary-right-separator 'telephone-line-gradient)
   (telephone-line-secondary-right-separator 'telephone-line-nil)
   (telephone-line-height 22)
   (telephone-line-evil-use-short-tag t)
   )
  :custom-face
  (mode-line ((t (:box nil))))
  :config
  (setq header-line-format mode-line-format)
  (setq etq-default mode-line-format nil)
  )

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
                                       ("#+latexx_class:" . "⇥")
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

(use-package writeroom-mode
  :defer t
  :hook ((org-mode . writeroom-mode))
  :custom
  (
   (writeroom-width 95)
   )
  )

;; Line numbers

(setq display-line-numbers 'relative)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
