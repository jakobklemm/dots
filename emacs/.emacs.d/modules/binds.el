;; Binds

(use-package general)
(use-package evil
  :init
  (setq evil-want-fine-undo t)
  (setq evil-want-keybinding nil)
  (setq evil-move-beyond-eol t)
  (setq evil-want-Y-yant-to-eol t)
  (setq evil-move-cursor-back nil)
  :config
  (evil-mode 1)
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )

(use-package evil-org
  :after org
  :config
  :hook (org-mode . (lambda () evil-org-mode))
  )

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.5))
  )

(defun jk/define-binds-dvorak ()
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

  (general-define-key
   :states '(motion normal visual)
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
  )

(defun jk/define-binds-qwertz ()
  (general-define-key
   :states '(motion normal visual)
   :keymaps 'override
   "$" 'evil-open-below
   "£" 'evil-open-above

   "J" 'evil-forward-paragraph
   "K" 'evil-backward-paragraph
   "H" 'evil-first-non-blank
   "L" 'evil-end-of-line

   "ä" 'evil-end-of-line
   "ö" 'evil-first-non-blank
   )

  (general-define-key
   :keymaps 'vertico-map
   "C-<backspace>" 'vertico-directory-up
   "C-<return>" 'vertico-exit-input
   )
  )

(if (string= (system-name) "voyager")
    (jk/define-binds-qwertz)
  (jk/define-binds-dvorak)
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
 "wn" '(jk/split-window-right-and-roam :which-key "switch-roam")

 ;; Emacs
 "qq" '(save-buffers-kill-emacs :which-key "kill-emacs")

 ;; Programming
 "ps" '(lsp-ui-doc-show :which-key "doc-show")
 "pf" '(format-all-buffer :which-key "format")

 ;; Git
 "gg" 'magit-status
 "gi" 'magit-init
 "gp" 'magit-pull

 ;; References
 "ri" '(citar-insert-citation :which-key "insert citation")
 "rr" '(citar-insert-reference :which-key "insert reference")
 "ro" '(citar-open-entry :which-key "open bibtex")
 "rl" '(citar-open :which-key "open link")

 ;; org-mode
 "or" 'org-refile
 "ol" 'org-insert-link
 "oo" 'org-open-at-point
 "op" 'org-link-open-as-file
 "oe" 'org-export-dispatch
 "oi" 'org-id-get-create
 "oc" 'org-capture
 "oa" 'org-archive-subtree
 "os" 'jk/org-search

 ;; Tasks
 "tt" 'org-todo
 "tx" 'jk/todo-done
 "td" 'org-deadline
 "ts" 'org-schedule
 "ta" 'jk/done-archive

 ;; Links
 "lo" 'org-open-at-point
 "lf" 'org-link-open-as-file

 ;; Agenda
 "ao" 'org-agenda
 "as" 'org-caldav-sync
 "af" 'org-agenda-file-to-front

 ;; org-roam
 "nn" 'org-roam-buffer-toggle
 "ni" 'org-roam-node-insert
 "nf" 'org-roam-node-find
 "nc" 'org-roam-capture
 "nr" 'org-roam-node-random
 "nt" 'org-roam-tag-add

 ;; Language
 "hc" 'langtool-check
 "hv" 'langtool-correct-buffer
 "hd" 'langtool-check-done
 "hw" 'ispell-word
 "hb" 'flyspell-buffer

 ;; Capture
 "cc" 'org-capture
 "cr" 'org-roam-capture
 )

(general-define-key
 "C-x j" 'kill-buffer-and-window
 "C-x 3" 'hrs/split-window-right-and-switch
 "C-x 2" 'hrs/split-window-below-and-switch
 "C-c C-f" 'format-all-buffer
 )

(provide 'binds)
