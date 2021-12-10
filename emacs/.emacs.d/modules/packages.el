;; Tools & settings for installing packages. Has to be loaded before
;; any file that installs any packages.

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(add-to-list 'load-path "~/.emacs.d/lisp/use-package")
(require 'use-package)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
(load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; TODO: Test
(setq use-package-always-ensure t)

(use-package quelpa
:ensure t
:config
(setq quelpa-upgrade-interval 7);; upgrade all packages once a week according to https://github.com/quelpa/quelpa
(add-hook #'after-init-hook #'quelpa-upgrade-all-maybe)
)

(use-package quelpa-use-package
  :ensure t
)
