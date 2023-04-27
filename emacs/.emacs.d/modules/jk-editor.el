;; Editor

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
                                      (right-fringe . 3))))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none)
  (lsp--auto-configure t)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-modeline-code-actions-enable nil)
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless)))
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))

(use-package lsp-ui
  :config
  (lsp-ui-mode t)
  (lsp-ui-doc-mode t)
  :custom
  (
   (lsp-ui-sideline-enable nil)
   (lsp-ui-enable t)
   (lsp-ui-doc-enable t)
   (lsp-ui-doc-position 'top)
   (lsp-ui-doc-delay 1.0)
   ))

(use-package tree-sitter
  :config
  (use-package tree-sitter-langs
    )
  (global-tree-sitter-mode)
  )


(use-package format-all
  :bind
  (("C-c f" . format-all-buffer))
  )

(provide 'jk-editor)
