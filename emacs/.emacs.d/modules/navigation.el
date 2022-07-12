;; navigation.el

(use-package selectrum
  :config
  (selectrum-mode t)
  )

(define-key selectrum-minibuffer-map (kbd "C-h") 'selectrum-next-candidate)
(define-key selectrum-minibuffer-map (kbd "C-t") 'selectrum-previous-candidate)
(define-key selectrum-minibuffer-map (kbd "C-d") 'selectrum-submit-exact-input)

(define-key selectrum-minibuffer-map (kbd "C-n") 'selectrum-backward-kill-sexp)

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode)
  )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-styles '(orderless))
  (orderless-skip-highlighting (lambda () selectrum-is-active))
  (selectrum-highlight-candidates-function #'orderless-highlight-matches)
  (selectrum-refine-candidates-function #'orderless-filter)
  )

(use-package consult
  :bind (("C-s" . consult-line)
         ("M-s" . consult-imenu)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :config
  (consult-preview-at-point-mode)
  )

(use-package savehist
  :init
  (savehist-mode)
  )

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-h B" . embark-bindings)
   :map selectrum-minibuffer
   ("C-s" . embark-act)
   ("C-;" . embark-dwim)
   )
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  )

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(provide 'navigation)
