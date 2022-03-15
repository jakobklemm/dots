(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-f") 'yas-expand)

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x j") 'kill-buffer-and-window)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x l") 'display-line-numbers-mode)

(global-set-key (kbd "C-§") 'popper-toggle-latest)
(global-set-key (kbd "M-§") 'popper-toggle-type)

(global-set-key (kbd "C-;") 'popper-toggle-latest)
(global-set-key (kbd "M-;") 'popper-toggle-type)

(global-set-key (kbd "C-c c") 'global-evil-dvorak-mode)

(use-package evil
  :custom ((evil-move-cursor-back nil)
           (evil-move-beyond-eol t)
           (evil-ex-complete-emacs-commands nil)
           (evil-vsplit-window-right t)
           (evil-split-window-below t)
           )
  :config (evil-mode 1)
  :diminish (undo-tree-mode)
  :init (setq evil-want-keybinding nil)
  )

(use-package evil-collection
  :config (evil-collection-init)
  )

(use-package evil-commentary
  :config
  (evil-commentary-mode)
  )

(use-package evil-nerd-commenter
  :defer t
  )

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  (define-key evil-normal-state-map (kbd "gs") 'evil-surround-change))

(require 'evil-dvorak)
(global-evil-dvorak-mode 1)

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  )

(defun jk/save-all ()
  (interactive)
  (save-buffer)
  (org-save-all-org-buffers)
  )

(evil-leader/set-leader "SPC")

(evil-leader/set-key
  "," 'counsel-find-file
  "." 'ivy-switch-buffer
  )

(evil-leader/set-key
  "bs" 'jk/save-all
  "bk" 'kill-current-buffer
  "bj" 'kill-buffer-and-window
  "bb" 'counsel-switch-buffer
  "bh" 'previous-buffer
  )

(evil-leader/set-key
  "wv" 'evil-window-vsplit
  "wk" 'hrs/split-window-below-and-switch
  "wc" 'hrs/split-window-right-and-switch
  "wj" 'delete-other-windows
  "wo" 'ace-window
  )

(evil-leader/set-key
  "ss" 'consult-line
  "sS" 'consult-imenu
  "sr" 'replace-string
  "sg" 'rgrep
  )

(evil-leader/set-key
  "qq" 'save-buffers-kill-terminal
  "qs" 'kill-emacs
  "qe" 'eshell
  )

(evil-leader/set-key
  "ot" 'counsel-org-tag
  "or" 'org-refile
  "ol" 'org-insert-link
  "oo" 'org-open-at-point
  "op" 'org-link-open-as-file
  "of" 'org-agenda-file-to-front
  "oe" 'org-export-dispatch
  "oa" 'org-archive-subtree
  "os" 'org-schedule
  "od" 'org-deadline
  "oi" 'org-id-get-create
  "oc" 'org-capture
  )

(evil-leader/set-key
  "gg" 'magit-status
  "gi" 'magit-init
  "gm" 'git-messenger:popup-message
  "gp" 'magit-pull
  )

(evil-leader/set-key
 "nl" 'org-roam-buffer-toggle
 "ni" 'org-roam-node-insert
 "nf" 'org-roam-node-find
 "nc" 'org-roam-capture
 "nr" 'org-roam-node-random
 )

(evil-leader/set-key
  "mo" 'mu4e
  "mc" 'mu4e-compose-new
  "mm" 'message-send-and-exit
  "ma" 'mail-add-attachment
  "ms" 'mml-secure-message-sign-pgp
  "me" 'mml-secure-message-encrypt-pgp
  "mj" 'mu4e~headers-jump-to-maildir
  "ml" 'mu4e~view-browse-url-from-binding
  "mf" 'mu4e~view-save-attach-from-binding
  )

(evil-leader/set-key
  "cc" 'evilnc-comment-or-uncomment-lines
  "cp" 'evilnc-copy-and-comment-lines
  "cr" 'comment-or-uncomment-region
  )

;; Prod
(evil-leader/set-key
  "a" 'jk/activate
  "d" 'jk/linked-done
  "zz" 'jk/active-file
  "zp" 'jk/project-file
  "zf" 'jk/ideas-file
  "za" 'jk/store-active
  "zt" 'org-todo
  "zc" 'org-capture
  "zi" 'jk/insert-checklist
  "zs" 'jk/search-references
  "zrp" 'jk/refile-to-project
  "zri" 'jk/refile-to-ideas
  "zrr" 'jk/refile-to-reference
  )
