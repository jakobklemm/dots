;; Modeline

(use-package feebleline
  :custom
  (feebleline-msg-functions
   '((feebleline-line-number         :post "" :fmt "%5s")
     (feebleline-column-number       :pre ":" :fmt "%-2s")
     (feebleline-file-directory      :face feebleline-dir-face :post "")
     (feebleline-file-or-buffer-name :face font-lock-keyword-face :post "")
     (jk/line-modified               :face font-lock-warning-face :post "" :pre " ")
     (feebleline-git-branch          :face feebleline-git-face :pre " " :align left)
     (jk/line-workspace              :align right :post "  -  " :face font-lock-type-face)
     (jk/line-time                   :align right :post "  -  " :face font-lock-constant-face)
     (jk/line-date                   :align right :post "" :face font-lock-negation-char-face)
     ))
  :config
  (feebleline-mode 1))

(defun jk/line-time ()
  "Returns the current system time for the modeline."
  (format-time-string "%H:%M:%S"))

(defun jk/line-date ()
  "Returns the current date for the modeline."
  (format-time-string "%d.%m.%Y"))

(defun jk/line-workspace ()
  "Returns the current workspace for the modeline."
  (if (string= (system-name) "voyager")
      ""
    (string-trim (shell-command-to-string "~/.local/bin/workspace"))))

(defun jk/line-modified ()
  "Modified version of feebleline star indicator."
  (if
       (and
	(buffer-file-name)
	(buffer-modified-p))
      "*"
    "-"))

(provide 'modeline)
