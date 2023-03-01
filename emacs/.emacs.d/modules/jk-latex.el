;; Latex

(add-to-list 'org-latex-classes
             '("empty"
               "\\documentclass[a4paper,11pt]{article}
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-create-formula-image-program 'dvipng)
(setq org-latex-listings 'minted)
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))

(provide 'jk-latex)
