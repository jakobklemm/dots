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

(provide 'jk-latex)
