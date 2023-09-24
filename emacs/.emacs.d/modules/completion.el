;; Completion

;; (use-package company
;;   :diminish company-mode
;;   :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
;;   :custom
;;   (company-minimum-prefix-length 1)
;;   (company-tooltip-align-annotations t)

;;   (company-idle-delay 0.1)

;;   (company-show-numbers t)
;;   :config
;;   (global-company-mode 1)
;;   (setq company-format-margin-function    #'company-vscode-dark-icons-margin)
;;   )

(use-package company
    :ensure t
    :defer 0.1
    :init
    (defun my-sort-uppercase (candidates)
      (let (case-fold-search
            (re "\\`[[:upper:]]*\\'"))
        (sort candidates
              (lambda (s1 s2)
                (and (string-match-p re s2)
                     (not (string-match-p re s1)))))))
    (defun my-change-company-backends (backend)
      (unless (member backend (car company-backends))
        (setq comp-back (car company-backends))
        (push backend comp-back)
        (setq company-backends (list comp-back)))
      )
    :config
    (push 'my-sort-uppercase company-transformers)
    (global-company-mode t)
    (bind-chord "ew" 'company-abort 'company-active-map)
    :custom
    (company-auto-commit-chars         '(32 40 41 119 46 34 36 47 124 33))
    (company-dabbrev-downcase          nil)
    (company-dabbrev-ignore-case       nil)
    (company-dabbrev-other-buffers     t)
    (company-echo-delay                0.1)
    ;; (company-format-margin-function    #'company-vscode-dark-icons-margin)
    (company-idle-delay                0.1)
    (company-minimum-prefix-length     1)
    (company-selection-wrap-around     t)
    (company-show-numbers              nil)
    (company-tooltip-align-annotations t)
    (delete-selection-mode             t)
    (selection-coding-system           'utf-8)
    (company-backends '(
                         (company-capf
                         :with company-yasnippet
                         company-dabbrev-code)
                         company-files
                         company-dabbrev
                         company-keywords
                        )
                        )
    :bind(
      :map company-active-map
      ("<tab>" . company-complete-common-or-cycle)
      ("<backtab>" . (lambda() (interactive) (company-complete-common-or-cycle -1)))
      ("C-j" . company-select-next-or-abort)
      ("C-k" . company-select-previous-or-abort)
      ("C-l" . company-other-backend)
      ("C-h" . nil)
      :map company-mode-map
      ("C-h" . nil)
    )
)

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package eldoc-box
  :hook
  ((rust-ts-mode . eldoc-box-hover-mode))
  )

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

;; LSP Mode
(use-package lspce
  :quelpa (lspce :fetcher github :repo "zbelial/lspce" :files ("*"))
  :init
  (let ((default-directory (file-name-directory (locate-library "lspce"))))
    (message "Entering %s" (pwd))
    (unless (or (file-exists-p "lspce-module.so")
                (file-exists-p "lspce-module.d")
                (file-exists-p "lspce-module.dll"))
      (shell-command "cargo build --release")
      (cond ((eq system-type 'gnu/linux)
             (progn (copy-file "target/release/liblspce_module.so"
                               "lspce-module.so" t)
                    (copy-file "target/release/liblspce_module.d"
                               "lspce-module.d" t)))
            ((eq system-type 'windows-nt)
             (progn (copy-file "target/release/lspce_module.dll"
                               "lspce-module.dll" t)
                    (copy-file "target/release/lspce_module.d"
                               "lspce-module.d" t))))
      (message "Done.")))
  (require 'lspce)
  :hook
  ((rust-ts-mode . lspce-mode))
  )

(use-package yasnippet
  :config
  (yas-global-mode t)
  )

(use-package yasnippet-snippets
  )

(provide 'completion)
