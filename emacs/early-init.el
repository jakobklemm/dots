;;; init.el --- -*- lexical-binding: t -*-
;; DeferGC
(setq gc-cons-threshold 10000000000)
;; -DeferGC

(set-window-scroll-bars (minibuffer-window) nil nil)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq package-enable-at-startup nil)

(provide 'early-init)
