;; Binds

(use-package general)

(use-package evil
  :init
  (setq evil-want-fine-undo t)
  (setq evil-want-keybinding nil)
  (setq evil-move-beyond-eol t)
  (setq evil-move-cursor-back nil)
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )

;; (general-swap-key 'normal 'org-mode-map
;;   "h" "n"
;;  )

;; (evil-mode 1)
;; (define-key key-translation-map "j" "f")
;; (define-key key-translation-map "f" "j")

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.5))
  )

(provide 'jk-binds)
