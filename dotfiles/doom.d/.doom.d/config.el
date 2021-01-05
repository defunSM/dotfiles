;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Salman Hossain"
      user-mail-address "salmanhossain500@gmail.com")

(setenv "LANG" "en_US.UTF-8")
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; Try "Fira Mono for Powerline" font

(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 16))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-palenight)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! solaire-mode (solaire-global-mode -1))
(define-key global-map (kbd "C-,") 'previous-buffer)
(define-key global-map (kbd "C-.") 'next-buffer)
;;(setq dired-guess-shell-alist-user '(("\\.pdf\\'" "evince")))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; (add-hook 'after-init-hook #'global-emojify-mode)
;; (add-hook 'after-init-hook #'golden-ratio-mode)
(setq load-prefer-newer t)

(add-hook 'python-mode-hook
          (lambda ()
            (blacken-mode)
            ;;(anaconda-mode)
            (anaconda-eldoc-mode)
            ;;(importmagic-mode)
            (local-set-key (kbd "C-x C-d") 'anaconda-mode-show-doc)
            (local-set-key (kbd "C-x C-w") 'anaconda-mode-find-definitions)
            (add-hook 'before-save-hook 'pyimport-remove-unused)
            (add-hook 'before-save-hook 'importmagic-fix-imports)
            (add-hook 'before-save-hook 'pyimpsort-buffer)
            ))
;; (use-package! company-jedi
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'company-jedi))

;; (use-package! pyvenv
;;   :ensure t
;;   :hook ((python-mode . pyvenv-mode)))

;; (elpy-enable)
;; (dap-python-debugger 'debugpy)

(setq doom-themes-treemacs-theme "doom-colors")

;; postframe https://github.com/tumashu/posframe#orgaff395c
(defvar my-posframe-buffer " *my-posframe-buffer*")

;; (with-current-buffer (get-buffer-create my-posframe-buffer)
;;   (erase-buffer)
;;   (insert "Welcome to Doom Emacs, are you ready?"))

;; (when (posframe-workable-p)
;;   (posframe-show my-posframe-buffer
;;                  :position (point)))


;(company-posframe-mode 1)

;;(setq fancy-splash-image (concat doom-private-dir "splash/doom-emacs-bw-light.svg"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; (defun arepl-python (number)
;;   "Multiply NUMBER by seven."
;;   (interactive "p")
;;   (make-buffer '((name . "AREPL-PYTHON")))
;;   (setq display-buffer-alist
;;         (append '(("AREPL-PYTHON" (background-color . "LightBlue"))))))
(require 'url)

(defun insert-image-from-url (&optional url)
  (interactive)
  (unless url (setq url (url-get-url-at-point)))
  (unless url
    (error "Couldn't find URL."))
  (let ((buffer (url-retrieve-synchronously url)))
    (unwind-protect
         (let ((data (with-current-buffer buffer
                       (goto-char (point-min))
                       (search-forward "\n\n")
                       (buffer-substring (point) (point-max)))))
           (insert-image (create-image data nil t)))
      (kill-buffer buffer))))

(use-package org-bullets
 :custom
 (org-bullets-bullet-list '("◉" "◆" "○" "▶" "✸" "✜"))
 (org-ellipsis " ▾")
 :hook (org-mode . org-bullets-mode))

(dolist (face '((org-level-1 . 1.3)
                (org-level-2 . 1.2)
                (org-level-3 . 1.1)
                (org-level-4 . 1.0)
                (org-level-5 . 0.9)))
  (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(org-indent-mode)
(variable-pitch-mode 1)
(visual-line-mode 1)

(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-bullets-mode . efs/org-mode-visual-fill))

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq org-refile-targets
      '(("archives.org" :maxlevel . 1)
        ("agenda.org" :maxlevel . 1)))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; makes minibuffer in the middle of emacs
(ivy-posframe-mode 0)

;; babel stuff
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)


(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(defun bind-exit-insert-mode (first-key second-key)
    "Add binding to exit insert mode using FIRST-KEY followed by SECOND-KEY."
    (define-key evil-insert-state-map (char-to-string first-key)
    #'maybe-exit)
    (evil-define-command maybe-exit ()
    :repeat change
    (interactive)
    (let ((modified (buffer-modified-p)))
        (insert (char-to-string first-key))
        (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
                               nil 0.5)))
        (cond
        ((null evt) (message ""))
        ((and (integerp evt) (char-equal evt second-key))
            (delete-char -1)
            (set-buffer-modified-p modified)
            (push 'escape unread-command-events))
        (t (setq unread-command-events (append unread-command-events
                                               (list evt)))))))))

(doom/set-frame-opacity 95)

;; Usage example:
;;(bind-exit-insert-mode ?l ?h)

;; (set-frame-parameter (selected-frame) 'alpha '(92 . 90))

;; (add-to-list 'default-frame-alist '(alpha . (92 . 90)))

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

;; (let* ((variable-tuple
 ;;          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
 ;;                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
 ;;                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
 ;;                ((x-list-fonts "Verdana")         '(:font "Verdana"))
 ;;                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
 ;;                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
 ;;         (base-font-color     (face-foreground 'default nil 'default))
 ;;         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

 ;;    (custom-theme-set-faces
 ;;     'user
 ;;     `(org-level-8 ((t (,@headline ,@variable-tuple))))
 ;;     `(org-level-7 ((t (,@headline ,@variable-tuple))))
 ;;     `(org-level-6 ((t (,@headline ,@variable-tuple))))
 ;;     `(org-level-5 ((t (,@headline ,@variable-tuple))))
 ;;     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
 ;;     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
 ;;     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
 ;;     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
 ;;     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))
