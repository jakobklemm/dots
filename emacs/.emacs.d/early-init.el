;;; init.el --- -*- lexical-binding: t -*-

(setq gc-cons-threshold (* 1024 1024 1024))

(set-window-scroll-bars (minibuffer-window) nil nil)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq warning-suppress-types '(((package reinitialization))))

(setq package-enable-at-startup nil)

(setq site-run-file nil)

(menu-bar-mode -1)
(unless (display-graphic-p)
  (setq default-frame-alist '((fullscreen . maximized)
			      (menu-bar-lines . 0)
			      (tool-bar-lines . 0)
			      (vertical-scroll-bars . nil))
	initial-frame-alist '((fullscreen . maximized)
			      (menu-bar-lines . 0)
			      (tool-bar-lines . 0)
			      (vertical-scroll-bars . nil))))

;; Nicer symbols
(global-prettify-symbols-mode 1)

(provide 'early-init)
