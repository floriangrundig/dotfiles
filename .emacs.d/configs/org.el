;;; org.el --- Org-mode config

;;; Commentary:
;;;

;;; Code:
(use-package org
  :defer t
  :config
  (setq org-directory "~/Dropbox/Privat/org")
  (setq org-agenda-files (list (concat org-directory "/tasks.org")))
  (setq org-default-notes-file (concat org-directory "/notes.org"))

  ;; display images
  (setq org-startup-with-inline-images (display-graphic-p))

  ;; track times
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  ;; curate this
  (setq org-hide-leading-stars t
        ;; highlight src code
        org-src-fontify-natively t
        org-startup-indented t
        org-completion-use-ido t
        org-log-done 'time
        org-email-link-description-format "Email %c (%d): %s"
        org-agenda-include-diary t
        org-enforce-todo-dependencies t
        ;; org clock
        org-clock-persist-query-save t
        org-clock-persistence-insinuate t
        org-clock-persist t
        org-clock-in-resume t
        org-clock-out-when-done t
        org-pretty-entities t
        org-clock-in-switch-to-state "STARTED"
        org-time-clocksum-format
        '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))

  ;; windmove when possible
  (add-hook 'org-shiftup-final-hook 'windmove-up)
  (add-hook 'org-shiftleft-final-hook 'windmove-left)
  (add-hook 'org-shiftdown-final-hook 'windmove-down)
  (add-hook 'org-shiftright-final-hook 'windmove-right))

;;; org.el ends here
