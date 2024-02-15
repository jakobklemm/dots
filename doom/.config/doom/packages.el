;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

(package! info-colors)
(package! org-modern)
(package! svg-tag-mode)
(package! org-appear)
(package! org-fragtog)
(package! org-incoming)
(package! popper)
(package! langtool)
(package! langtool-ignore-fonts)
(package! org-roam)
(package! org-roam-ui)
(package! org-roam-timestamps)
(package! citar-org-roam)
(package! vertico-posframe)

(package! engrave-faces :recipe (:local-repo "lisp/engrave-faces"))

(package! org-special-block-extras)

