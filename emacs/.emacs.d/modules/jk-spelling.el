;; Spelling

(setenv
 "DICPATH"
 "/home/jeykey/.tools/dict/")

(setq ispell-program-name "hunspell"
      ispell-local-dictionary "en_US"
      ispell-local-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
        ("de_DE" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE" "-a" "-i" "UTF-8") nil utf-8)))

(use-package langtool
  :init
  (setq langtool-http-server-host "172.16.3.15"
	langtool-http-server-port 8010)
  )

(use-package langtool-ignore-fonts
  :config
  (add-hook 'LaTeX-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'org-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'markdown-mode-hook 'langtool-ignore-fonts-minor-mode)
  (langtool-ignore-fonts-add 'markdown-mode '(markdown-code-face))
  )

(provide 'jk-spelling)
