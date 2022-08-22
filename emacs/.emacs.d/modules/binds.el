;; Binds

(use-package general)
(use-package evil
  :init
  (setq evil-want-fine-undo t)
  (setq evil-want-keybinding nil)
  (setq evil-move-beyond-eol t)
  (setq evil-want-Y-yant-to-eol t)
  :config
  (evil-mode 1)
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.5))
  )

(general-define-key
 :states '(motion visual normal)
 :keymaps 'override
 "h" 'evil-next-line
 "t" 'evil-previous-line
 "d" 'evil-backward-char
 "n" 'evil-forward-char

 "H" 'evil-forward-paragraph
 "T" 'evil-backward-paragraph
 "D" 'evil-first-non-blank
 "N" 'evil-last-non-blank

 "s" 'evil-open-below
 "S" 'evil-open-above

 "w" 'evil-delete
 "W" 'kill-line

 "q" 'evil-backward-word-begin
 "Q" 'evil-backward-section-begin

 "j" 'evil-forward-word-end
 "J" 'evil-forward-section-end

 "'" 'evil-first-non-blank
 "k" 'evil-end-of-line
 )

(add-hook 'emacs-startup-hook
          (lambda ()
	    (unbind-key "C-t")
            ))

(general-define-key
 :instert '(motion normal visual)
 :keymaps 'vertico-map

 "C-n" 'vertico-directory-up
 "C-h" 'vertico-previous
 "C-t" 'vertico-next
 "C-<return>" 'vertico-exit-input
 )

(general-define-key
 :state 'insert
 :keymaps 'corfu-map

 "C-h" 'corfu-next
 "C-t" 'corfu-previous
 )

(general-define-key
 :states '(normal motion visual)
 :keymaps 'override
 :prefix "SPC"

 "SPC" '(execute-extended-command :which-key "M-x")

 "." '(find-file :which-key "find-file")
 "," '(switch-to-buffer :which-key "switch-buffer")
 ";" '(consult-file-externally :which-key "file-external")

 ;; Buffer
 "bs" '(save-buffer :which-key "save-buffer")
 "bb" '(switch-to-buffer :which-key "switch-buffer")
 "bk" '(kill-current-buffer :which-key "kill-buffer")

 ;; Search
 "ss" '(consult-line :which-key "search-line")
 "sr" '(ripgrep-regexp :which-key "search-rg")
 "si" '(consult-imenu :which-key "search-org")

 ;; Windows
 "ww" '(hrs/split-window-below-and-switch :which-key "window-below")
 "wc" '(hrs/split-window-right-and-switch :which-key "window-right")
 "wj" '(kill-buffer-and-window :which-key "buffer-and-window")
 "wo" '(ace-window :which-key "switch-window")

 ;; Emacs
 "qq" '(save-buffers-kill-emacs :which-key "kill-emacs")

 ;; Programming
 "rs" '(lsp-ui-doc-show :which-key "doc-show")

 ;; TODO: org, roam, prod, magit
 )

;; TODO: To general.el style
(global-set-key (kbd "C-x j") 'kill-buffer-and-window)
 
(provide 'binds)
