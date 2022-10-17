;; Ivy

(defconst jk/ivy-count 15
  "number of candidates for ivy"
  )

(use-package counsel
  :diminish ivy-mode counsel-mode
  :defines
  (projectile-completion-system magit-completing-read-function)
  :hook
  (after-init . ivy-mode)
  (ivy-mode . counsel-mode)
  :custom
  (counsel-yank-pop-height 15)
  (enable-recursive-minibuffers t)
  (swiper-action-recenter t)
  (counsel-grep-base-command "ag -S --noheading --nocolor --nofilename --numbers '%s' %s")
  )

(use-package swiper)
(use-package orderless)
(use-package flx)

(use-package ivy
  :custom
  ((ivy-use-selectable-prompt t)
   (ivy-use-virtual-buffers t)
   (ivy-on-del-error-function nil)
   (search-default-mode #'char-fold-to-regexp)
   (ivy-wrap t)
   (ivy-height jk/ivy-count)
   (swiper-action-recenter t)
   )
  )

(use-package prescient
  :custom
  (prescient-save-file (concat user-emacs-directory "etc/hist"))
  (prescient-sort-full-matches-first t)
  :config
  (prescient-persist-mode t)
  )

(use-package ivy-prescient
  :init (setq prescient-filter-method '(literal fuzzy regexp initialism)
              ;https://github.com/raxod502/prescient.el#ivy-specific
              ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode t)
  )
(use-package company-prescient
  :config
  (company-prescient-mode t)
  )

(use-package amx
  :after ivy
  :custom
  (amx-backend 'auto)
  (amx-save-file "~/.emacs.d/etc/amx-items")
  (amx-history-length 50)
  (amx-show-key-bindings nil)
  :config (amx-mode 1))

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :custom
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  :config
  (ivy-rich-mode 1))

(use-package ivy-posframe
  :after ivy
  :init
  :custom
  (ivy-posframe-parameters
   '((left-fringe . 4)
	 (right-fringe . 4)))
  (ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
  (ivy-posframe-width 160)
  (ivy-posframe-height jk/ivy-count)
  (ivy-posframe-border-width 4)
  :config
  (ivy-posframe-mode 1)
  :custom-face
  (ivy-posframe-border ((t (:background "#242732"))))
  (ivy-posframe-cursor ((t (:background "#95a3b0"))))
  )

(provide 'jk-ivy)
