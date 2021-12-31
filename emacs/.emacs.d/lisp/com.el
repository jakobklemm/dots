(setq mu4e-maildir (expand-file-name "~/.mail"))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'smtpmail)

(use-package emacs
  :custom
  ((mu4e-completing-read-function 'ivy-completing-read)
   (mail-user-agent 'mu4e-user-agent)
   (user-mail-address "jakob@jeykey.net")
   (user-full-name "Jakob Klemm")
   (mu4e-get-mail-command "mbsync -c ~/.tools/.mbsyncrc -a")
   (mu4e-update-interval 300)
   (mu4e-index-update-in-background t)
   (mu4e-main-buffer-hide-personal-addresses t)
   (send-mail-function 'smtpmail-sent-it)
   (starttls-use-gnutls t)
   (mu4e-send-messages-behavior 'delete)
   (mu4e-view-show-addresses t)
   (message-kill-buffer-on-exit t)
   (mu4e-attachment-dir "~/workspace")
   (mu4e-sent-folder "/global/Sent")
   (mu4e-drafts-folder "/global/Drafts")
   (mu4e-trash-folder "/global/Trash")
   (message-signature
    (concat
     "Jakob Klemm\n"
     "https://github.com/jakobklemm"
     "https://jeykey.net\n"))
   (mml-secure-openpgp-sign-with-sender t)
   (mml-secure-openpgp-encrypt-to-self t)
   (mml-secure-smime-sign-with-sender "jakob@jeykey.net")
   (mu4e-view-prefer-html t)
   (smtpmail-starttls-credentilas my-mu4e-account-alist)
   (smtpmail-default-smtp-server "mail.cyon.ch")
   (smtpmail-smtp-server "mail.cyon.ch")
   (smtpmail-smtp-service 587)
   (smtpmail-debug-info t)
   )
  )

(load-file "~/.tools/mail.el")

(use-package mu4e-alert
  :defer t
  :config
  (mu4e-alert-set-default-style 'libnotify)
  (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
  )

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
