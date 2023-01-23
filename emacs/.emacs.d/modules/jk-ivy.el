;; Ivy

(defconst jk/ivy-count 15
  "number of candidates for ivy"
  )

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

(use-package prescient
  :custom
  (prescient-save-file (concat user-emacs-directory "etc/hist"))
  (prescient-sort-full-matches-first t)
  :config
  (prescient-persist-mode t)
  )

(use-package ivy-prescient
  :init (setq prescient-filter-method '(literal fuzzy regexp initialism)
              ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode t)
  )

(use-package company-prescient
  :config
  (company-prescient-mode t)
  )

(use-package swiper
  )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

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

(defun ivy-rich--switch-buffer-directory! (orig-fun &rest args)
  (cl-letf (((symbol-function 'directory-file-name) #'file-name-directory))
    (apply orig-fun args)))
(advice-add 'ivy-rich--switch-buffer-directory :around #'ivy-rich--switch-buffer-directory!)

(use-package ivy-rich
  :after ivy
  :custom
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  :config
  (ivy-rich-mode 1)
  )

(use-package company
  :diminish company-mode
  :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-idle-delay 0.1)
  (company-show-numbers t)
  (company-show-quick-access 'left)
  :config
  (global-company-mode 1)
  )

(use-package company-box
  :if (display-graphic-p)
  :defines company-box-icons-all-the-icons
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-backends-colors nil)
  (company-box-doc-delay 0.1)
  (company-box-doc-frame-parameters '((internal-border-width . 1)
                                      (left-fringe . 3)
                                      (right-fringe . 3)))
  )

(provide 'jk-ivy)
