;;(setq default-directory "~/EmacsProjects")
;; ____________________________________________________________________________
;; Aquamacs custom-file warning:
;; Warning: After loading this .emacs file, Aquamacs will also load
;; customizations from `custom-file' (customizations.el). Any settings there
;; will override those made here.
;; Consider moving your startup settings to the Preferences.el file, which
;; is loaded after `custom-file':
;; ~/Library/Preferences/Aquamacs Emacs/Preferences
;; _____________________________________________________________________________

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

(when (boundp 'global-flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

 (when (boundp 'global-company-mode)
   (add-hook 'js-mode-hook
 	    (lambda () (company-mode 1)
 	      (when (boundp 'tern)
 		(add-to-list 'company-backends 'company-tern)))
 	    t))

(when window-system
  (when (featurep 'aquamacs)
    (setq default-frame-alist nil))
  (when (require 'solarized-theme)
    (load-theme 'solarized-dark t)))


(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
