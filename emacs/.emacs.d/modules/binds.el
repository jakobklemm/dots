;; Binds

(use-package general)

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.5))
  )

(use-package meow
  )

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-dvorak)
  (meow-motion-overwrite-define-key
   ;; custom keybinding for motion state
   '("<escape>" . ignore))
  (meow-normal-define-key
   '("h" . meow-next)
   '("H" . forward-paragraph)
   '("t" . meow-prev)
   '("T" . backward-paragraph)
   '("d" . meow-left)
   '("D" . meow-left-expand)
   '("n" . meow-right)
   '("N" . meow-right-expand)

   '("s" . meow-open-below)
   '("S" . meow-open-below)
   '("i" . meow-insert)

   '("q" . backward-word)
   '("j" . forward-word)
   '("k" . end-of-line)
   '("'" . beginning-of-line-text)

   '("b" . backward-word)
   '("m" . forward-word)

   '("Q" . backward-page)
   '("J" . forward-page)
   '("K" . end-of-line)
   '("\"" . beginning-of-line)
   
   '("w" . meow-kill)
   '("W" . meow-kill-whole-line)

   '("x" . meow-delete)
   '("u" . meow-undo)
   '("p" . yank)

   '("C-SPC" . forward-word)
   
   ;;'("<SPC>" . forward-word)
   '("<escape>" . ignore)))

(meow-setup)
(meow-global-mode 1)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; (require 'xah-fly-keys)

;; specify a layout
;; (xah-fly-keys-set-layout "dvorak")

(general-define-key
 :keymaps 'meow-insert-state-?map
 :prefix "SPC"
 :non-normal-prefix "M-SPC"

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
