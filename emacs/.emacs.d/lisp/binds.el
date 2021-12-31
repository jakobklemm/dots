(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x j") 'kill-buffer-and-window)

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
  "actions"
  ;; Buffers
  ("bs" save-buffer "save")
  ("bk" kill-current-buffer "kill buffer")
  ("bj" kill-buffer-and-window "kill buffer and window")
  ("bf" counsel-find-file "open file")
  ("bb" counsel-switch-buffer "switch buffer")
  ("bh" previous-buffer "previous buffer")
  
  ;; Windows
  ("wo" ace-window "switch window")
  ("we" hrs/split-window-right-and-switch "split right and switch")
  ("wb" hrs/split-window-below-and-switch "split below and switch")
  ("wf" find-file-other-frame "open file in new frame")
  ("wj" kill-buffer-and-window "kill buffer and window")
  ("wc" clone-frame "same buffer in new frame")
  
  ;; Search
  ("ss" swiper "search")
  ("sg" counsel-git-log "git log")
  ("sr" rgrep "ripgrep")
  
  ;; Org
  ("oa" org-agenda "general org agenda")
  ("oc" org-capture "capture something")
  ("od" org-deadline "set deadline")
  ("os" org-schedule "set scheduled")
  ("ot" org-todo "org todo")
  ("or" org-refile "general org refile")
  ("ol" org-insert-link "create new link")
  ("ok" org-store-link "store link to current")
  ("oo" org-open-at-point "follow a link")
  ("op" org-link-open-as-file "open a link")
  ("ow" org-export-dispatch "export dialog")
  ("oy" org-archive-subtree "archive element")

  ;; Com
  ("mu" mu4e "mu4e")
  ("mx" mu4e-mark-execute-all "execute")
  ("ma" mail-add-attachment "attachment")
  ("ms" mml-secure-message-sign-pgp "sign")
  ("me" mml-secure-message-encrypt-pgp "sign")
  ("mj" mu4e~headers-jump-to-maildir "maildir")
  ("ml" mu4e~view-browse-url-from-binding "browse")
  ("mf" mu4e~view-save-attach-from-binding "save")

  ;; Git
  ("gg" magit-status "magit")
  ("gi" magit-init "create repo")
  ("gm" git-messenger:popup-message "show commit message")
  ("gp" magit-pull "pull")

  ;; Roam
  ("nt" org-roam-buffer-toggle "org roam")
  ("nf" org-roam-node-find "find node")
  ("nr" org-roam-node-random "random node")
  ("ni" org-roam-node-insert "insert node")
  ("nc" org-roam-capture "capture")
  
  ;; Extras
  ("qq" save-buffers-kill-terminal "quit")
  ("qe" eshell "emacs shell")
  )
