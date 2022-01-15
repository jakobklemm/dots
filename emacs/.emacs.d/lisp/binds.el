(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x j") 'kill-buffer-and-window)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(defun jk/disable-modalka ()
  (setq modalka-mode nil)
  )

(defun defkey (f g)
  (modalka-define-kbd f g)
  )

(defun insert-below ()
  (interactive)
  (move-end-of-line 1)
  (newline)
  (setq modalka-mode nil)
  (indent-for-tab-command)
  )

(defun insert-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line)
  (setq modalka-mode nil)
  (indent-for-tab-command)
  )

(defun yank-below ()
  (interactive)
  (move-end-of-line 1)
  (newline)
  (yank)
  )

(require 'modalka)
;; Navigation (visual)
(modalka-global-mode 1)
(global-set-key (kbd "<escape>") #'modalka-mode)

(defkey "h" "C-n")
(defkey "t" "C-p")
(defkey "d" "C-b")
(defkey "n" "C-f")

(defkey "T" "M-{")
(defkey "H" "M-}")

(defkey "'" "C-a")
(defkey "c" "C-e")
(defkey "j" "M-b")
(defkey "k" "M-f")

(defkey "b" "M-b")

(defkey "w" "C-k")
(defkey "v" "DEL")
(defkey "m" "<deletechar>")
(defkey "x" "<deletechar>")

(defkey "u" "C-x u")
(define-key modalka-mode-map (kbd "i") #'modalka-mode)

(define-key modalka-mode-map (kbd "s") #'insert-below)
(define-key modalka-mode-map (kbd "S") #'insert-above)
(define-key modalka-mode-map (kbd "o") #'insert-below)
(define-key modalka-mode-map (kbd "P") #'yank-below)

(modalka-define-kbd "a" "C-a")
(modalka-define-kbd "e" "C-e")
(modalka-define-kbd "$" "C-e")
(modalka-define-kbd "g" "C-g")
(modalka-define-kbd "y" "C-y")
(modalka-define-kbd "p" "C-y")

;; Actions (commands)
(use-package hydra
  :defer t
  )

(defhydra hydra-actions (modalka-mode-map "SPC")
  ;; Quick access
  ("," counsel-find-file)
  ("." counsel-switch-buffer)
  ("g" keyboard-quit)
  
  ;; Buffers
  ("bs" save-buffer)
  ("bk" kill-current-buffer)
  ("bj" kill-buffer-and-window)
  ("bf" counsel-find-file)
  ("bb" counsel-switch-buffer)
  ("bh" previous-buffer)
  
  ;; Windows
  ("wo" ace-window)
  ("we" hrs/split-window-right-and-switch)
  ("wb" hrs/split-window-below-and-switch)
  ("wf" find-file-other-frame)
  ("wj" kill-buffer-and-window)
  ("wc" clone-frame)
  
  ;; Search
  ("ss" swiper)
  ("sg" counsel-git-log)
  ("sr" rgrep)
  
  ;; Org
  ("oa" org-agenda)
  ("oc" org-capture)
  ("od" org-deadline)
  ("os" org-schedule)
  ("ot" org-todo)
  ("or" org-refile)
  ("ol" org-insert-link)
  ("ok" org-store-link)
  ("oo" org-open-at-point)
  ("op" org-link-open-as-file)
  ("ow" org-export-dispatch)
  ("oy" org-archive-subtree)

  ;; Com
  ("mu" mu4e)
  ("mx" mu4e-mark-execute-all)
  ("ma" mail-add-attachment)
  ("ms" mml-secure-message-sign-pgp)
  ("me" mml-secure-message-encrypt-pgp)
  ("mj" mu4e~headers-jump-to-maildir)
  ("ml" mu4e~view-browse-url-from-binding)
  ("mf" mu4e~view-save-attach-from-binding)

  ;; Git
  ("hg" magit-status)
  ("hi" magit-init)
  ("hm" git-messenger:popup-message)
  ("hp" magit-pull)

  ;; Roam
  ("nt" org-roam-buffer-toggle)
  ("nf" org-roam-node-find)
  ("nr" org-roam-node-random)
  ("ni" org-roam-node-insert)
  ("nc" org-roam-capture)
  
  ;; Extras
  ("qq" save-buffers-kill-terminal)
  ("qe" eshell)
  )
