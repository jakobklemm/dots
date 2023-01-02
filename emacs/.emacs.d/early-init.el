;; early-init.el

(setq jk/original-gc gc-cons-threshold)

(setq gc-cons-threshold (* 1024 1024 1024))

(set-window-scroll-bars (minibuffer-window) nil nil)

;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq warning-suppress-types '(((package reinitialization))))

(setq package-enable-at-startup nil)

(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

(setq site-run-file nil)




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
			      (vertical-scroll-bars . nil))))

(provide 'early-init)
