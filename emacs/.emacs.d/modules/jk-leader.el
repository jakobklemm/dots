;; Leader function

(general-define-key
 :keymaps '(normal emacs visual)
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
 "ss" '(swiper :which-key "search-line")
 "sr" '(ripgrep-regexp :which-key "search-rg")

 ;; Windows
 "ww" '(hrs/split-window-below-and-switch :which-key "window-below")
 "wc" '(hrs/split-window-right-and-switch :which-key "window-right")
 "wj" '(kill-buffer-and-window :which-key "buffer-and-window")
 "wo" '(ace-window :which-key "switch-window")
 "wn" '(jk/split-window-right-and-roam :which-key "switch-roam")

 ;; Emacs
 "qq" '(save-buffers-kill-emacs :which-key "kill-emacs")

 ;; Git
 "gg" 'magit-status
 "gi" 'magit-init
 "gp" 'magit-pull

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

 ;; Test: Transclusion
 "va" 'org-transclusion-add-all
 "vm" 'org-transclusion-mode
 )

(provide 'jk-leader)
