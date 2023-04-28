;; Selection & Completion

;; https://kristofferbalintona.me/posts/202202211546/
(use-package vertico
  ;; Special recipe to load extensions conveniently
  ;; :straight (vertico :files (:defaults "extensions/*")
  ;;                    :includes (
  ;;                               vertico-mouse
  ;;                               vertico-quick
  ;;                               vertico-repeat
  ;;                               vertico-directory
  ;;                               vertico-multiform
  ;;                               ))
  :custom-face
  (vertico-current ((t (:background "#282A36"))))
  :hook ((minibuffer-setup . vertico-repeat-save)
	 (rfn-eshadow-update-overlay . vertico-directory-tidy))
  :bind
  ("M-." . vertico-repeat)
  (:map vertico-map
	("<tab>" . vertico-insert)
	("<backspace>" . vertico-directory-delete-char)
	("C-i" . vertico-quick-insert)
	("C-o" . vertico-quick-exit)
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous)
        ("C-f" . vertico-exit)
	("C-s" . vertico-exit-input)
        :map minibuffer-local-map
        ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  (vertico-count 13)
  (vertico-resize t)  :init
  (vertico-mode)
  :config
  ;; Prefix the current candidate with “» ”. From
  ;; https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "» " 'face 'vertico-current)
                   "  ")
                 cand)))
  )

(use-package marginalia
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'left)
  :init
  (marginalia-mode)
  )
	
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion 
                   )
	   )
     )
   )
  )

(use-package savehist
  :config
  (savehist-mode t)
  )

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  )

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package consult
  :bind
  (("C-s" . consult-line))
  )

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package mini-frame
  :custom
  (mini-frame-show-parameters
   '((top . 0.2)
     (width . 0.5)
     (left . 0.5)
     ))
  :init
  (mini-frame-mode)
  )

(provide 'jk-selection)
