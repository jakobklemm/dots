;; programming.el

(use-package lsp-mode
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex))) ;; Configure flex
  :custom
  (
   (lsp-eldoc-render-all t)
   (lsp-eldoc-enable-hover t)
   (lsp-idle-delay 0.6)
   (lsp-rust-analyzer-server-display-inlay-hints t)
   (lsp-session-file "~/.emacs.d/etc/lsp")
   (lsp-server-install-dir "~/.emacs.d/etc/lsp-server/")
   (lsp-signature-auto-activate t)
   (lsp-rust-analyzer-display-closure-return-type-hints t)
   (lsp-rust-analyzer-display-parameter-hints t)
   (lsp-completion-provider :none)
   )
  :hook
  (
   ;; (lsp-mode-hook . lsp-ui-mode)
   (lsp-completion-mode . my/lsp-mode-setup-completion)
   )
  :bind
  (:map lsp-mode-map
	("C-c C-f" . lsp-find-definition)))

;; (use-package lsp-ui
;;   :config
;;   (lsp-ui-mode t)
;;   (lsp-ui-doc-mode t)
;;   :custom
;;   (
;;    (lsp-ui-peek-always-show t)
;;    (lsp-ui-peek-enable t)
;;    (lsp-ui-sideline-show-hover t)
;;    (lsp-ui-enable t)
;;    (lsp-ui-doc-enable t)
;;    (lsp-ui-doc-position 'at-point)
;;    (lsp-ui-doc-delay 3.0)
;;    (lsp-ui-doc-show-wit-cursor t)
;;    (lsp-ui-doc-max-width 64)
;;    (lsp-ui-doc-max-height 52)
;;    ))
;; 
;; (use-package company
;;   :bind
;;   (:map company-active-map
;; 	("C-n". company-select-next)
;; 	("C-p". company-select-previous)
;; 	("M-<". company-select-first)
;; 	("M->". company-select-last))
;;   :custom
;;   ((company-tooltip-maximum-width 60)
;;    (company-tooltip-width-grow-only t)
;;    (company-idle-delay 0)
;;    (company-tooltip-idle-delay 0))
;;   :hook
;;   ((emacs-lisp-mode . company-mode)
;;    (prog-mode . company-mode)))

;; (use-package company-box
;;   :hook
;;   (company-mode . company-box-mode)
;;   :config
;;   (define-key company-active-map (kbd "C-h") 'company-select-next)
;;   (define-key company-active-map (kbd "C-t") 'company-select-previous)
;;   )

(use-package smartparens
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap))
  )

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x p") 'magit-init)
  (global-set-key (kbd "C-v") 'magit-commit)
  )

(use-package magit-todos
  :config
  (magit-todos-mode t)
  )

(use-package git-messenger
  :config
  (global-set-key (kbd "C-x m") 'git-messenger)
  )

(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

(use-package yasnippet
  :after yasnippet-snippets
  :custom
  ((yas-indent-line 'auto))
  :config
  (yasnippet-snippets-initialize)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  )

(use-package smooth-scrolling
  :custom 
  (
   (smooth-scroll-margin 12)
   )
  :config
  (smooth-scrolling-mode t)
  )

(provide 'programming)
