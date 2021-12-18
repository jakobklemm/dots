;; TODO: Integrate into other binds

(global-set-key [M-l] 'downcase-word)
(global-set-key [M-u] 'upcase-word)
(global-set-key [M-c] 'capitalize-word)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c l") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
