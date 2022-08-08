;; input.el

(use-package evil
  :custom ((evil-move-cursor-back nil)
           (evil-move-beyond-eol t)
           (evil-ex-complete-emacs-commands nil)
           (evil-vsplit-window-right t)
           (evil-split-window-below t)
           )
  :config
  (evil-mode 1)
  :init (setq evil-want-keybinding nil)
  )

(use-package evil-collection
  :config (evil-collection-init)
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  (define-key evil-normal-state-map (kbd "gs") 'evil-surround-change))

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 1.0))
  )

(add-hook 'after-load-functions 'my-keys-have-priority)

(defun my-keys-have-priority (_file)
  "Try to ensure that my keybindings retain priority over other minor modes.

Called via the `after-load-functions' special hook."
  (unless (eq (caar minor-mode-map-alist) 'evil-dvorak-mode)
    (let ((mykeys (assq 'evil-dvorak-mode minor-mode-map-alist)))
      (assq-delete-all 'evil-dvorak-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist mykeys))))

;; Originally based on: https://github.com/jbranso/evil-dvorak/blob/master/evil-dvorak.el
(define-minor-mode evil-dvorak-mode
  "Custom minor mode for ortholinear-split ergonomic keyboard with custom programmer dvorak layout."
  :keymap (make-sparse-keymap))

(defun turn-on-evil-dvorak-mode ()
  "Enable evil-dvorak-mode in the current buffer."
  (evil-dvorak-mode 1))

(defun turn-off-evil-dvorak-mode ()
  "Disable evil-dvorak-mode in this buffer."
  (evil-dvorak-mode -1))

(define-globalized-minor-mode global-evil-dvorak-mode
  evil-dvorak-mode turn-on-evil-dvorak-mode
  "Global mode to let you use evil with dvorak friendly keybindings.")

(evil-define-key 'visual evil-dvorak-mode-map
  "h" 'evil-next-line
  "t" 'evil-previous-line
  "d" 'evil-backward-char
  "n" 'evil-forward-char
  )

(evil-define-key '(normal visual) evil-dvorak-mode-map
  (kbd "h") #'evil-next-line
  (kbd "t") #'previous-line
  (kbd "d") #'backward-char
  (kbd "n") #'forward-char
  )

(evil-define-key 'insert evil-dvorak-mode-map
  (kbd "C-z") 'evil-normal-state
  (kbd "ESC") 'evil-normal-state
  (kbd "C-d") 'delete-char
  (kbd "<backspace>") 'delete-backward-char
  (kbd "<return>") 'newline-and-indent
  ;; (kbd "C-h") 'evil-next-line
  ;; (kbd "C-t") 'evil-previous-line
  (kbd "C-n") 'backward-char
  (kbd "C-s") 'forward-char
  (kbd "M-x") 'counsel-M-x
  )

(evil-define-key '(normal visual) evil-dvorak-mode-map
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

(evil-define-key '(normal visual) corfu-map
  "C-h" 'corfu-next
  "C-t" 'corfu-previous
  )

(evil-define-key '(normal visual) org-agenda-mode-map
  "h" 'org-agenda-next-line
  "t" 'org-agenda-previous-line 
  )

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

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  )

(evil-leader/set-leader "SPC")

(evil-leader/set-key
  "." 'find-file
  "," 'switch-to-buffer
  )

(evil-leader/set-key
  "bs" 'save-buffer
  "bk" 'kill-current-buffer
  "bj" 'kill-buffer-and-window
  "bb" 'consult-buffer
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
  "sS" 'helm-rg
  "sr" 'replace-string
  )

(evil-leader/set-key
  "qq" 'save-buffers-kill-terminal
  "qs" 'kill-emacs
  "qe" 'eshell
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
  "cc" 'evilnc-comment-or-uncomment-lines
  "cp" 'evilnc-copy-and-comment-lines
  "cr" 'comment-or-uncomment-region
  )

(global-evil-dvorak-mode 1)

(provide 'input)
