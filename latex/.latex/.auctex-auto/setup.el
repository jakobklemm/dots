(TeX-add-style-hook
 "setup"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("tcolorbox" "most") ("background" "all" "center" "firstpage=false")))
   (TeX-run-style-hooks
    "tcolorbox"
    "background")
   (TeX-add-symbols
    "bb"
    "secret")
   (LaTeX-add-tcolorbox-newtcolorboxes
    '("defbox" "1" "" "")
    '("infobox" "1" "" "")
    '("bspbox" "1" "" "")
    '("bspboxen" "1" "" "")
    '("genbox" "2" "" "")))
 :latex)

