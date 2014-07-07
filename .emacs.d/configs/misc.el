;;; misc.el --- Personal configuration on top of prelude

;;; Commentary:
;;;

;;; Code:

;; el-get initialization
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

;; default settings
(setq-default
 tab-width 2
 icomplete-mode t
 ;; Disable guru mode (comes with prelude)
 prelude-guru nil
 ;; Disable backup
 ;; backup-inhibited t
 ;; Disable auto-save
 ;; auto-save-default nil
 ;; Enable hungry delete
 c-hungry-delete-key t
 ;; Allow pasting selection outside of Emacs
 x-select-enable-clipboard t
 auto-revert-verbose nil
 )

;; ispell
;; find aspell and hunspell automatically
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args
        '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=5" "--run-together-min=2")))
 ;; ((executable-find "hunspell")
 ;;  (setq ispell-program-name "hunspell")
 ;;  (setq ispell-extra-args '("-d en_US")))
 )
(setq-default ispell-list-command "list")
;; (setq-default ispell-dictionary "romanian")

;; move through camel case words
(global-subword-mode 1)

;; Turn off the scroll-bar
(scroll-bar-mode -1)
;; ;; Linum (line numbering)
;; (require 'linum)
;; (global-linum-mode)
;; Push the mouse out of the way on cursor approach
(mouse-avoidance-mode 'cat-and-mouse)
;; Enable electric indent mode
;; (electric-indent-mode +1)
;; Set font for current winbdow
;; set font size 100 = 10pt (1/10)
;; set font for all windows
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10"))
(cond
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono-10"))
 ((find-font (font-spec :name "inconsolata"))
  (set-frame-font "inconsolata-10"))
 ((find-font (font-spec :name "Consolas"))
  (set-frame-font "Consolas-10"))
 ((find-font (font-spec :name "Lucida Console"))
  (set-frame-font "Lucida Console-10"))
 ((find-font (font-spec :name "courier"))
  (set-frame-font "courier-10")))

;; (set-face-attribute 'mode-line nil :height 60)
;; (set-face-attribute 'default nil :height 100)

;; Key bindings
;; Unset C-z suspend
(global-unset-key "\C-z")

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-z m l") 'mc/edit-lines)
(global-set-key (kbd "C-z m n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-z m p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-z m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)

;; Comment or uncomment region or line
(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    )
  )
(global-set-key (kbd "C-c c") 'comment-or-uncomment-line-or-region)

;; Use control-arrow keys for window resizing
(global-set-key (kbd "<M-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "<M-left>") 'shrink-window-horizontally)

;; recompile with f5
;; (global-set-key (kbd "<f5>") 'recompile)

;; A saner ediff
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Set file registers
(set-register ?m '(file . "~/projects/dotfiles/.emacs.d/configs/misc.el"))

;; nxml tab width
(setq nxml-child-indent 2)
(setq nxml-attribute-indent 2)

;; Set backup/auto-save di1rectory
;; (setq backup-directory-alist
;;       `((".*" . ,"~/temp/emacs-bak")))
;; (setq auto-save-file-name-transforms
;; `((".*" ,"~/temp/emacs-bak" t)))

;; enable zone after a minute
;; (require 'zone)
;; (zone-when-idle 120)


(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Dired" (mode . dired-mode))
               ("Erc" (mode . erc-mode))
               ("C++" (mode . cpp-mode))
               ("Java" (mode . java-mode))
               ("Org" (mode . org-mode))
               ("SQL" (mode . sql-mode))
               ("Xml" (mode . nxml-mode))
               ("Python" (mode . elpy-mode))
               ("Web" (mode . web-mode))
               ("Web" (mode . html-mode))
               ("Web" (mode . css-mode))
               ))
             ))

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")
            )) ;; to show only dired and files buffers

;; yasnippet
(yas-global-mode 1)
;; (yas/load-directory "~/.emacs.d/snippets")
(define-key yas-minor-mode-map (kbd "C-c C-s") 'yas-insert-snippet)

;; web-mode
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)
  )
(add-hook 'web-mode-hook  'web-mode-hook)

;; (require 'reftex)

;; make shell colorful
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; icicles
;; (require 'icicles)
;; (setq-default icicle-show-Completions-initially-flag t)

;; (defun quit-window ()
;;   "modified quit window"
;;   (interactive)
;;   (kill-buffer-and-window)
;;   )

;; setup elpy-mode
;; (package-initialize)
;; (require 'package)
;; (add-to-list 'package-archives
;;             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

;; (elpy-enable)
;; (elpy-use-ipython)
;; (autoload 'python-mode "python" "Python Mode." t)
;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;  "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;  "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; configure ergoemacs
;; (require 'ergoemacs-mode)
;; (ergoemacs-ignore-prev-global)
;; (setq ergoemacs-theme nil)
;; (setq ergoemacs-keyboard-layout "us")
;; (ergoemacs-key "M-m" 'ergoemacs-end-of-line-or-what "End of line")
;; (ergoemacs-mode 1)

;;; Code:

;; set bookmarks files
(defvar emacsd-bookmarks-dir (expand-file-name "bookmarks" emacsd-dir)
  "Emacs.d bookmarks directory path.")
(setq-default bookmark-save-flag t)

;; platform specific settings
(cond
 ((string-equal system-type "windows-nt")
  (progn
    (message "You're screwed")
    ;; set bookmarks file
    (setq-default bookmark-default-file (expand-file-name "win-bookmarks.gpg"
                                                          emacsd-bookmarks-dir))
    )
  )
 ((string-equal system-type "gnu/linux")
  (progn
    ;; set path from shell
    (defun set-exec-path-from-shell-PATH ()
      (let ((path-from-shell (shell-command-to-string "$SHELL -c 'echo $PATH'")))
        (setenv "PATH" path-from-shell)
        (setq exec-path (split-string path-from-shell path-separator))))
    (when window-system (set-exec-path-from-shell-PATH))

    ;; set bookmarks file
    (setq-default bookmark-default-file (expand-file-name "gnu-bookmarks.gpg"
                                                          emacsd-bookmarks-dir))
    ;; visual-regexp
    (require 'visual-regexp-steroids)
    (global-set-key (kbd "C-z r r") 'vr/replace)
    (global-set-key (kbd "C-z r q") 'vr/query-replace)
    ;; if you use multiple-cursors, this is for you:
    (global-set-key (kbd "C-z r m") 'vr/mc-mark)
    ;; to use visual-regexp-steroids's isearch instead of the built-in
    ;; regexp isearch, also include the following lines:
    ;; (global-set-key (kbd "C-r") 'vr/isearch-backward)
    ;; (global-set-key (kbd "C-s") 'vr/isearch-forward)
    )
  )
 )

;; modeline
;; (progn
;;   (setq-default
;;    mode-line-format
;;    '("%e"
;;      mode-line-front-space
;;      mode-line-mule-info
;;      mode-line-client
;;      mode-line-modified
;;      mode-line-remote
;;      mode-line-frame-identification
;;      mode-line-buffer-identification
;;      "   "
;;      mode-line-position
;;      (vc-mode vc-mode)
;;      "  "
;;      mode-line-modes
;;      mode-line-misc-info
;;      mode-line-end-spaces)))

;; powerline
(require 'powerline)
(powerline-default-theme)


;; helm
;; (setq-default ido-mode nil)
;; (helm-mode 1)
;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
;; (define-key global-map (kbd "M-x") 'helm-M-x)

;; (progn
;; (require 'helm-config)
;; (setq helm-candidate-number-limit 10)
;; From https://gist.github.com/antifuchs/9238468
;; (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
;;       helm-input-idle-delay 0.01  ; this actually updates things
;;                                       ; reeeelatively quickly.
;;       helm-quick-update t
;;       helm-M-x-requires-pattern nil
;;       helm-ff-skip-boring-files t)
;; (helm-mode))

;; undo-tree
;; (setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)

;; anzu stuff
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

;; regex tool
(setq-default regex-tool-backend 'perl)

;;; misc.el ends here