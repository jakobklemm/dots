(use-package highlight-indent-guides
  :if (display-graphic-p)
  :defer t
  :diminish
  ;; Enable manually if needed, it a severe bug which potentially core-dumps Emacs
  ;; https://github.com/DarthFennec/highlight-indent-guides/issues/76
  :commands (highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-responsive 'top)
  (highlight-indent-guides-delay 0)
  (highlight-indent-guides-auto-character-face-perc 7))

;;(add-hook 'rustic-mode-hook 'highlight-indent-guides-mode)

(setq-default indent-tabs-mode nil)
(setq-default indent-line-function 'insert-tab)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default js-switch-indent-offset 4)
(c-set-offset 'comment-intro 0)
(c-set-offset 'innamespace 0)
(c-set-offset 'case-label '+)
(c-set-offset 'access-label 0)
(c-set-offset (quote cpp-macro) 0 nil)

(use-package company
  :after lsp
  :diminish company-mode
  :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  ;; Trigger completion immediately.
  (company-idle-delay 0.1)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
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
  :config
  (when (require 'all-the-icons nil t)
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
          `((Unknown . ,(all-the-icons-material "find_in_page" :height 1.0 :v-adjust -0.2))
            (Text . ,(all-the-icons-faicon "text-width" :height 1.0 :v-adjust -0.02))
            (Method . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Function . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Constructor . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Field . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
            (Variable . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
            (Class . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
            (Interface . ,(all-the-icons-material "share" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
            (Module . ,(all-the-icons-material "view_module" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
            (Property . ,(all-the-icons-faicon "wrench" :height 1.0 :v-adjust -0.02))
            (Unit . ,(all-the-icons-material "settings_system_daydream" :height 1.0 :v-adjust -0.2))
            (Value . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
            (Enum . ,(all-the-icons-material "storage" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
            (Keyword . ,(all-the-icons-material "filter_center_focus" :height 1.0 :v-adjust -0.2))
            (Snippet . ,(all-the-icons-material "format_align_center" :height 1.0 :v-adjust -0.2))
            (Color . ,(all-the-icons-material "palette" :height 1.0 :v-adjust -0.2))
            (File . ,(all-the-icons-faicon "file-o" :height 1.0 :v-adjust -0.02))
            (Reference . ,(all-the-icons-material "collections_bookmark" :height 1.0 :v-adjust -0.2))
            (Folder . ,(all-the-icons-faicon "folder-open" :height 1.0 :v-adjust -0.02))
            (EnumMember . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2))
            (Constant . ,(all-the-icons-faicon "square-o" :height 1.0 :v-adjust -0.1))
            (Struct . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
            (Event . ,(all-the-icons-octicon "zap" :height 1.0 :v-adjust 0 :face 'all-the-icons-orange))
            (Operator . ,(all-the-icons-material "control_point" :height 1.0 :v-adjust -0.2))
            (TypeParameter . ,(all-the-icons-faicon "arrows" :height 1.0 :v-adjust -0.02))
            (Template . ,(all-the-icons-material "format_align_left" :height 1.0 :v-adjust -0.2)))
          company-box-icons-alist 'company-box-icons-all-the-icons)))

(use-package flycheck
  :defer t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

(use-package flycheck-rust
  :defer t
  :config
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  )

(use-package flycheck-inline
  :defer t
  :config
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))
  )

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-idle-delay 0.6)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-analyzer-inlay-hints-mode t)
  :hook
  (elixir-mode . lsp)
  (rustic-mode . lsp)
  :config
  (lsp-enable-which-key-integration t)
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (lsp-ui-doc-enable t)
  (lsp-ui-mode)
  (setq lsp-ui-doc-max-height 256
        lsp-ui-doc-max-width 64
        lsp-ui-doc-position 'bottom-and-right
        lsp-ui-doc-show-with-mouse t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-delay 1
        )
  )

(use-package smartparens
  :defer t
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap))
  )

(use-package yasnippet
  :defer t
  )

(use-package yasnippet-snippets
  :defer t
  )

(yas-global-mode t)

(use-package format-all
  :defer 2
  :bind ("C-c C-f" . format-all-buffer)
  )

(use-package magit
  :defer t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x p") 'magit-init)
  (global-set-key (kbd "C-v") 'magit-commit)
  )

(use-package magit-todos
  :defer t
  :config
  (magit-todos-mode t)
  )

(use-package git-messenger
  :config
  (global-set-key (kbd "C-x m") 'git-messenger:popup-message)
  )

(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  )

;; Edit comments in dedicated buffers
(use-package separedit
  :defer t
  :config
  (define-key prog-mode-map        (kbd "C-c '") #'separedit)
  (define-key minibuffer-local-map (kbd "C-c '") #'separedit)
  (define-key help-mode-map        (kbd "C-c '") #'separedit)
  )
