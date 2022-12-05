;; Evil movement

(evil-mode 1)

(defun jk/define-binds-dvorak ()
  (general-define-key
   :states '(motion visual normal)
   :keymaps 'override
   "h" 'evil-next-line
   "t" 'evil-previous-line
   "d" 'evil-backward-char
   "n" 'evil-forward-char

   "H" 'evil-forward-paragraph
   "T" 'evil-backward-paragraph
   "D" 'evil-first-non-blank
   "N" 'evil-last-non-blank

   "s" 'evil-open-below
   "S" 'evil-open-above

   "w" 'evil-delete
   "W" 'kill-line

   "q" 'evil-backward-word-begin
   "Q" 'evil-backward-section-begin

   "j" 'evil-forward-word-end
   "J" 'evil-forward-section-end

   "'" 'evil-first-non-blank
   "k" 'evil-end-of-line
   )

  (general-define-key
   :keymaps 'ivy-mode-map

   "M-j" 'ivy-next-line
   "M-k" 'ivy-previous-line
   )

  (general-define-key
   :keymaps 'company-mode-map

   "M-j" 'company-select-next-or-abort
   "M-k" 'company-select-previous-or-abort
   )
  )

(defun jk/define-binds-qwertz ()
  (general-define-key
   :states '(motion normal visual)
   :keymaps 'override
   "ö" 'evil-open-below
   "Ö" 'evil-open-above

   "J" 'evil-forward-paragraph
   "K" 'evil-backward-paragraph
   "H" 'evil-first-non-blank
   "L" 'evil-end-of-line

   "ä" 'evil-end-of-line
   )

  (general-define-key
   :keymaps 'ivy-mode-map

   "M-j" 'ivy-next-line
   "M-k" 'ivy-previous-line
   )

  (general-define-key
   :keymaps 'company-mode-map

   "M-j" 'company-select-next-or-abort
   "M-k" 'company-select-previous-or-abort
   )
  )

(if (string= (system-name) "voyager")
    (jk/define-binds-qwertz)
  (jk/define-binds-dvorak)
  )

(provide 'jk-evil)
