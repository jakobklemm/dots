;; Active / daily productivity system

(setq org-capture-templates
      '(("t" "Todo" entry (file "~/supervisor/inbox.org")
         "* TODO %?\n%T\n%a")
        ))

(add-hook 'org-capture-mode-hook 'jk/toggle-mode)

(defun jk/toggle-mode ()
  (interactive)
  (setq modalka-mode nil)
  )
