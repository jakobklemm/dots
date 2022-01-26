;; Evil dvorak mode
;; https://github.com/jbranso/evil-dvorak/blob/master/evil-dvorak.el

(require 'evil)

(define-minor-mode evil-dvorak-mode
  "Evil dvorak mode allows you to use evil using the dvorak keyboard layout."
  :lighter " ED"
  :keymap (make-sparse-keymap))

(defun turn-on-evil-dvorak-mode ()
  "Enable evil-dvorak-mode in the current buffer."
  (evil-dvorak-mode 1))

(defun turn-off-evil-dvorak-mode ()
  "Disable evil-dvorak-mode in this buffer."
  (evil-dvorak-mode -1))

(define-globalized-minor-mode global-evil-dvorak-mode
  evil-dvorak-mode turn-on-evil-dvorak-mode
  "Global mode to let you use evil with dvorak friendly keybindings.")

(evil-define-key 'visual evil-dvorak-mode-map
  "h" 'evil-next-line
  "t" 'evil-previous-line
  "d" 'evil-backward-char
  "n" 'evil-forward-char
  ;;I what to be able to use vaw (visual around word) and viw (visual inner word)
  ;; that's why in visual mode, u and a are not defined.
  ;; BUT it would be cool to say cie and mean change forward to word-end
  ;; and cio to mean change backward word-end
  ;;(evil-define-key 'visual "u" 'evil-end-of-line)
  ;;(evil-define-key 'visual "a" 'evil-first-non-blank
  ;;(evil-define-key 'visual "u" 'evil-end-of-line)
  )

(evil-define-key 'normal evil-dvorak-mode-map
  ;; Miscellancus
  (kbd "h") #'evil-next-line
  (kbd "t") #'previous-line
  (kbd "d") #'backward-char
  (kbd "n") #'forward-char

  ;;move the cursor around
  (kbd "C-l") 'recenter-top-bottom

  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
  (kbd "<return>") 'newline-and-indent)

(evil-define-key 'insert evil-dvorak-mode-map
  (kbd "C-z") 'evil-normal-state
  (kbd "ESC") 'evil-normal-state
  (kbd "C-d") 'delete-char
  (kbd "<backspace>") 'delete-backward-char
  (kbd "<return>") 'newline-and-indent
  (kbd "C-h") 'evil-next-line
  (kbd "C-t") 'evil-previous-line
  (kbd "C-n") 'backward-char
  (kbd "C-s") 'forward-char
  (kbd "M-x") 'counsel-M-x
  )

(evil-define-key 'normal evil-dvorak-mode-map
  "H" 'evil-forward-paragraph
  "T" 'evil-backward-paragraph
  "D" 'evil-first-non-blank
  "N" 'evil-last-non-blank

  "s" 'evil-open-below
  "S" 'evil-open-above

  "w" 'evil-delete
  "W" 'kill-line

  "j" 'evil-backward-word-begin
  "J" 'evil-backward-section-begin

  "k" 'evil-forward-word-end
  "K" 'evil-forward-section-end

  "'" 'evil-first-non-blank
  "c" 'evil-end-of-line  
  )

(provide 'evil-dvorak)

;;; evil-dvorak.el ends here
