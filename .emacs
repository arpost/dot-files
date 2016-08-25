;;(setq default-directory "~/EmacsProjects")

(setq vc-make-backup-files nil)

(defun nxml-kill-tag-contents ()
  "Copy the contents between two tags"
;  (interactive "*p\ncCopy tag contents: ") ; this expects arguments input
  (interactive)
  (nxml-backward-up-element)
  (kill-region
    (progn
      (search-forward ">")
      (point)
    )
    (progn
      (nxml-backward-up-element)
      (nxml-forward-element)
      (search-backward "</")
      (point)
    )
  )
)

(defun nxml-copy-tag-contents ()
  "Copy the contents between two tags"
;  (interactive "*p\ncCopy tag contents: ") ; this expects arguments input
  (interactive)
  (nxml-backward-up-element)
  (copy-region-as-kill
   (progn
     (search-forward ">")
     (point)
   )
  (progn
     (nxml-backward-up-element)
     (nxml-forward-element)
     (search-backward "</")
     (point))
  )
)

(defun nxml-pretty-print-xml-region (begin end)
  "Beautiful code from Benjamin Ferrari (blog.bookwurm.at). 
   The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!")
)

(defun m-nxml-mode-hook ()
"key definitions for nxml mode"
(interactive)
(set-variable 'fill-column 99)
; nxml key bindings consistent with C-b, C-f, C-p, C-n, M-b, M-f, M-p, M-n
(define-key nxml-mode-map "\C-of" 'nxml-forward-balanced-item)     ; f for forward
(define-key nxml-mode-map "\C-ob" 'nxml-backward-balanced-item)    ; b for backward
(define-key nxml-mode-map "\C-op" 'nxml-backward-element)   ; p consistent with C-p
(define-key nxml-mode-map "\C-on" 'nxml-forward-element)  ;
(define-key nxml-mode-map "\M-of" 'nxml-forward-element)     ; f for forward, 
(define-key nxml-mode-map "\M-ob" 'nxml-backward-element)    ; b for backward
(define-key nxml-mode-map "\M-op" 'nxml-backward-paragraph)   ; p consistent with M-p
(define-key nxml-mode-map "\M-on" 'nxml-forward-paragraph)  ;
;(define-key nxml-mode-map "\M-ou" 'nxml-backward-up-element) ; u for up
;(define-key nxml-mode-map "\M-od" 'nxml-down-element)        ; d for down
(define-key nxml-mode-map "\M-ok" 'nxml-kill-element)        ; d for down

(define-key nxml-mode-map [M-insert] 'nxml-copy-tag-contents)
(define-key nxml-mode-map "\C-xw" 'nxml-kill-tag-contents)

(define-key nxml-mode-map "\C-cv" 'browse-url-of-buffer) ; should be consistent with the shortcut in the html-mode
(set-variable 'tab-width 2)

  (message "Defined extra key-bindings for nxml-mode")
)
(add-hook 'nxml-mode-hook 'm-nxml-mode-hook)

(setq dired-listing-switches "-alh")

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

(require 'ido)
(ido-mode t)
(when (boundp 'flx-ido-mode)
  (flx-ido-mode t))

(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

(add-hook 'ruby-mode-hook
      (lambda()
;	(rinari-launch)
        (add-hook 'local-write-file-hooks
                  '(lambda()
                     (save-excursion
                       (untabify (point-min) (point-max))
                       (delete-trailing-whitespace)
                       )))
        (set (make-local-variable 'indent-tabs-mode) 'nil)
        (set (make-local-variable 'tab-width) 2)
        (imenu-add-to-menubar "IMENU")
        (define-key ruby-mode-map "\C-m" 'newline-and-indent) ;Not sure if this line is 100% right!
     ;   (require 'ruby-electric)
        (ruby-electric-mode t)
	(robe-mode t)
        ))
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(custom-set-variables
 '(speedbar-show-unknown-files t))

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

(when (boundp 'auto-complete-config)
  (require 'auto-complete-config)
  (ac-config-default)
  (require 'auto-complete))

(when (boundp 'projectile-global-mode)
  (projectile-global-mode))

;(global-company-mode t)
;(push 'company-robe company-backends)

(add-hook 'robe-mode-hook 'ac-robe-setup)

(when (boundp 'global-rbenv-mode)
  (global-rbenv-mode t))
