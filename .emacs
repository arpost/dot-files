;;(setq default-directory "~/EmacsProjects")

(setq vc-make-backup-files nil)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  )

(when (boundp 'global-linum-mode)
  (global-linum-mode 1))

(add-to-list 'load-path "~/.emacs.d/lisp")

(when (boundp 'electric-pair-mode)
  (electric-pair-mode 1))

;; (require 'ido)
;; (ido-mode t)
;; (when (boundp 'flx-ido-mode)
;;   (flx-ido-mode t))

(custom-set-variables
 '(speedbar-show-unknown-files t))

;; (when (boundp 'auto-complete-config)
;;   (require 'auto-complete-config)
;;   (ac-config-default)
;;   (require 'auto-complete))

(when (boundp 'helm-config)
  (require 'helm-config))

(when (boundp 'projectile-global-mode)
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

 (when (boundp 'global-company-mode)
   (add-hook 'js-mode-hook
 	    (lambda () (company-mode 1)
 	      (when (boundp 'tern)
 		(add-to-list 'company-backends 'company-tern)))
 	    t))

(when window-system
  (when (featurep 'aquamacs)
    (setq default-frame-alist nil))
  (load-theme 'solarized-dark t))


