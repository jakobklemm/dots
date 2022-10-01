;; LSP

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3)
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  )

(use-package eglot
  :custom
  (eglot-send-changes-idle-time 0)
  )

(use-package flycheck-inline
  :config
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))
  )


(provide 'jk-lsp)
