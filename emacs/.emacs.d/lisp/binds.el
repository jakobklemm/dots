(use-package modalka
  :defer t
  )

;; Simple helper function
(defun defkey (f g)
  (modalka-define-kbd f g)
  )

(defun insert-below ()
  (interactive)
  (move-end-of-line 1)
  (newline)
  (setq modalka-mode nil)
  )

(defun insert-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line)
  (setq modalka-mode nil)
  )

;; Navigation (visual)
(modalka-global-mode 1)
(global-set-key (kbd "<escape>") #'modalka-mode)

(defkey "h" "C-n")
(defkey "t" "C-p")
(defkey "d" "C-b")
(defkey "n" "C-f")

(defkey "T" "M-{")
(defkey "H" "M-}")

(defkey "'" "C-a")
(defkey "c" "C-e")
(defkey "j" "M-b")
(defkey "k" "M-f")

(defkey "w" "C-k")
(defkey "v" "DEL")
(defkey "m" "<deletechar>")

(defkey "u" "C-x u")
(define-key modalka-mode-map (kbd "i") #'modalka-mode)

(define-key modalka-mode-map (kbd "s") #'insert-below)
(define-key modalka-mode-map (kbd "S") #'insert-above)
(modalka-define-kbd "W" "M-w")
(modalka-define-kbd "Y" "M-y")
(modalka-define-kbd "a" "C-a")
(modalka-define-kbd "e" "C-e")
(modalka-define-kbd "g" "C-g")
(modalka-define-kbd "w" "C-w")
(modalka-define-kbd "y" "C-y")

;; Actions (commands)
(use-package hydra
  :defer t
  )

(defhydra hydra-actions (modalka-mode-map "SPC")
  "actions"
  ("ss" swiper "search")
  )
