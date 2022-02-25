(use-package ob-elixir)
(use-package ob-rust)
(use-package ob-go)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (elixir . t)
   (latex . t)
   (rust . t)
   (plantuml . t)
   ))

(use-package plantuml-mode
  :defer t
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  )


