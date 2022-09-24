;; Colors

(use-package beacon
  :custom
  ((beacon-color "#4ae3a1")
   (beacon-blink-when-window-scrolls nil))
  :hook
  ((after-init . beacon-mode)))

;; http://xahlee.info/emacs/emacs/emacs_CSS_colors.html
(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `http://xahlee.info/emacs/emacs/emacs_CSS_colors.html'
Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background
                      (let* (
                             (ms (match-string-no-properties 0))
                             (r (substring ms 1 2))
                             (g (substring ms 2 3))
                             (b (substring ms 3 4)))
                        (concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))

(add-hook 'prog-mode-hook 'xah-syntax-color-hex)

(use-package rainbow-delimiters
  :hook
  ((org-mode . rainbow-delimiters-mode)
   (prog-mode . rainbow-delimiters-mode)))

(use-package doom-themes
  :config
  (load-theme 'doom-nord-aurora t))

(provide 'colors)
