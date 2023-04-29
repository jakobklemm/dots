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
  :bind
  (:map company-mode-map
	("<tab>". tab-indent-or-complete)
	("TAB". tab-indent-or-complete))
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

;; (use-package lsp-mode
;; :custom
;; (lsp-completion-provider :none)
;; (lsp--auto-configure t)
;; (lsp-headerline-breadcrumb-enable t)
;; (lsp-modeline-code-actions-enable t)
;; (lsp-eldoc-render-all t)
;; (lsp-idle-delay 0.6)
;; ;; (lsp-headerline-breadcrumb-segments '(project file symbols))
;; (lsp-rust-analyzer-cargo-watch-command "clippy")
;; (lsp-rust-analyzer-server-display-inlay-hints t)
;; (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
;; (lsp-rust-analyzer-display-chaining-hints t)
;; (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
;; (lsp-rust-analyzer-display-closure-return-type-hints t)
;; (lsp-rust-analyzer-display-parameter-hints t)
;; (lsp-rust-analyzer-display-reborrow-hints t)
;;   )

(use-package lsp-mode
  :defer t
  :custom
  (
   ;; (lsp-eldoc-render-all t)
   (eldoc-mode nil)
   (lsp-idle-delay 0.6)
   (lsp-session-file "~/.emacs.d/etc/lsp/")
   (lsp-server-install-dir "~/.emacs.d/etc/server/")
   (lsp-signature-auto-activate t)
   (lsp-signature-render-documentation nil)
   (lsp-rust-analyzer-cargo-watch-command "clippy")
   (lsp-rust-analyzer-server-display-inlay-hints t)
   (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
   (lsp-rust-analyzer-display-chaining-hints t)
   (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
   (lsp-rust-analyzer-display-closure-return-type-hints t)
   (lsp-rust-analyzer-display-parameter-hints t)
   (lsp-rust-analyzer-display-reborrow-hints t)
   )
  :hook
  ((rustic-mode . lsp)
   (lua-mode . lsp)
   (lsp-mode-hook . lsp-ui-mode)
   )
  )

(use-package lsp-ui
  :defer t
  :config
  (lsp-ui-mode t)
  (lsp-ui-doc-enable t)
  (lsp-ui-sideline-mode nil)
  :custom
  (
   (lsp-ui-sideline-enable nil)

   (lsp-ui-enable t)
   (lsp-ui-doc-enable t)
   (lsp-ui-doc-position 'top)
   (lsp-ui-doc-delay 1.0)
   (lsp-ui-peek-always-show t)

   (lsp-ui-doc-max-height 48)
   (lsp-ui-doc-max-width 48)

   (lsp-ui-doc-show-with-mouse t)
   (lsp-ui-doc-show-with-cursor t)
   ))

(use-package tree-sitter
  :config
  (use-package tree-sitter-langs
    )
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  )

(use-package format-all
  )

(defun jk/do-something ()
  (interactive)
  (message "test")
  )

;; Works
(global-set-key (kbd "C-c f") 'jk/do-something)
;; Doesn't Work
(global-set-key (kbd "C-c C-f") 'jk/do-something)
;; Works
(global-set-key (kbd "C-c C-x C-f") 'jk/do-something)

(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package yasnippet-snippets
  )

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(use-package flycheck
  :config
  (global-flycheck-mode t)
  )

(electric-pair-mode t)

(provide 'jk-editor)
