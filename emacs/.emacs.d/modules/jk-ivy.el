;; Ivy

(use-package counsel
  :ensure t
  :diminish ivy-mode counsel-mode
  :defines
  (projectile-completion-system magit-completing-read-function)
  :preface
    (defun ivy-format-function-pretty (cands)
      "Transform CANDS into a string for minibuffer."
      (ivy--format-function-generic
       (lambda (str)
         (concat
             (all-the-icons-faicon "hand-o-right" :height .85 :v-adjust .05 :face 'font-lock-constant-face)
             (ivy--add-face str 'ivy-current-match)))
       (lambda (str)
         (concat "  " str))
       cands
       "\n"))
    :hook
    (after-init . ivy-mode)
    (ivy-mode . counsel-mode)
    :custom
    (counsel-yank-pop-height 15)
    (enable-recursive-minibuffers t)
    (ivy-use-selectable-prompt t)
    (ivy-use-virtual-buffers t)
    (ivy-on-del-error-function nil)
    (swiper-action-recenter t)
    (counsel-grep-base-command "ag -S --noheading --nocolor --nofilename --numbers '%s' %s")
  :config
  (use-package swiper
    :ensure t
    )
  (use-package ivy
    :ensure t
    :config
    (setq ivy-re-builders-alist '((t . orderless-ivy-re-builder)))
    )
  (ivy-mode 1)

  (setq enable-recursive-minibuffers t
	search-default-mode #'char-fold-to-regexp
	ivy-posframe-height-alist '((swiper . 20)
				    (t      . 15)))

  (use-package amx
    :ensure t
    :after ivy
    :custom
    (amx-backend 'auto)
    (amx-save-file "~/.emacs.d/etc/amx-items")
    (amx-history-length 50)
    (amx-show-key-bindings nil)
    :config (amx-mode 1))

  (use-package all-the-icons-ivy-rich
    :ensure t
    :init (all-the-icons-ivy-rich-mode 1))

  (use-package ivy-rich
    :ensure t
    :after ivy
    :custom (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
    :config
    (ivy-rich-mode 1))

  (use-package flx
    :ensure t
    )

  (use-package ivy-posframe
    :ensure t
    :after ivy
    :init
    (ivy-posframe-mode 1)
    (setq ivy-posframe-parameters
	  '((left-fringe . 4)
	    (right-fringe . 4)))
    :config (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))
		  ivy-posframe-border-width 4)
    :custom-face
    (ivy-posframe-border ((t (:background "#242732"))))
    (ivy-posframe-cursor ((t (:background "#95a3b0"))))
    :hook
    (ivy-mode . ivy-posframe-enable)
    )
  )

(use-package orderless)

(provide 'jk-ivy)
