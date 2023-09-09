;; Early init stuff

(defconst jk/original-gc gc-cons-threshold)
(defconst jk/original-percent gc-cons-percentage)

(setq gc-cons-threshold (* 1024 1024 1024))
(setq gc-cons-percentage 0.6)


(unless (display-graphic-p)
  (setq default-frame-alist '((fullscreen . maximized)
			      (menu-bar-lines . 0)
			      (tool-bar-lines . 0)
			      (vertical-scroll-bars . nil)
			      (drag-internal-border . 1)
			      (internal-border-width . 1))
	initial-frame-alist '((fullscreen . maximized)
			      (menu-bar-lines . 0)
			      (tool-bar-lines . 0)
			      (vertical-scroll-bars . nil)
			      (background-color . "#000000")
			      )))

(provide 'early-init)
