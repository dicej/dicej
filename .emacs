(setq load-path (cons "/home/dicej/.lisp/" load-path))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;(require 'lazy-lock)

;; Turn on font-lock mode for Emacs
(global-font-lock-mode t)

;; emacsclient support
;; (autoload 'server-edit "server" nil t)
;; (server-edit)
;; (add-hook 'server-switch-hook 'new-frame)
;; (add-hook 'server-done-hook 'kill-this-buffer)
;; (add-hook 'server-done-hook 'delete-frame)

;(setq debug-on-error t)

;(set-variable 'show-trailing-whitespace t)

(add-hook 'before-save-hook 'whitespace-cleanup)

; addresses weird terminal corruption due to Emacs concurrency bug
; when is most noticeable under VirtualBox with more than one CPU:
(add-hook 'isearch-update-post-hook 'redraw-display)

;; scheme indentation rules
(put 'with 'scheme-indent-function 1)
(put 'if 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(add-hook 'purescript-mode-hook 'turn-on-purescript-indentation)

;; no tabs for you!
(setq-default indent-tabs-mode nil)

(setq default-tab-width 2)

;(load "/usr/share/emacs/site-lisp/clang-format-3.5/clang-format.el")
;(global-set-key [C-M-tab] 'clang-format-region)

;; no menu bar for you!
(menu-bar-mode -1)

;; no startup message.
(setq inhibit-startup-message t)

(setq initial-frame-alist
      (append
       '((width . 80) (height . 24) ;; (internal-border-width . 2)
         (left-fringe . 0) (right-fringe . 0)
         (line-space . "0"))
       initial-frame-alist))

(setq default-frame-alist
      (append
       '((width . 80) (height . 24) ;; (internal-border-width . 2)
         (left-fringe . 0) (right-fringe . 0)
         (line-space . "0"))
       default-frame-alist))

;; Put autosave files (ie #foo#) in one place, *not* scattered all over the
;; file system! (The make-autosave-file-name function is invoked to determine
;; the filename of an autosave file.)
(defvar autosave-dir (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename) (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name () (concat autosave-dir (if buffer-file-name (concat "#" (file-name-nondirectory buffer-file-name) "#") (expand-file-name (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/")) (setq backup-directory-alist (list (cons "." backup-dir)))

;; sweet!!
;(require 'cua)
;(CUA-mode t)
;;(CUA-mode 'emacs)

;;PMD Java code analyzer
(autoload 'pmd-current-buffer "pmd" "PMD Mode" t)
(autoload 'pmd-current-dir "pmd" "PMD Mode" t)

(autoload 'wikipedia-mode "wikipedia-mode.el"
  "Major mode for editing documents in Wikipedia markup." t)
;(autoload 'longlines-mode "longlines.el"
;   "Minor mode for editing long lines." t)
(add-to-list 'auto-mode-alist '("mozex.\\.*" . wikipedia-mode))

(global-set-key (kbd "C-l") 'goto-line)

;; don't need the crap below - it's taken care of by (CUA-mode t)
;;(pc-selection-mode)
;;(global-set-key (kbd "C-x") 'cua-copy-region)
(global-set-key (kbd "C-z") 'undo)

;; Make sure cut and paste works right w/ japanese
;;(set-selection-coding-system 'shift_jis)

;; Use shift-jis by default
;;(set-default-coding-systems 'shift_jis)

;;(set-language-environment 'japanese)

;; misc.
(setq visible-bell t)
(setq tab-stop-list '(3 6 9 12 15 18 21 24 27 30))
;; use spaces instead of tab characters in text-mode
(defun my-text-indent-setup ()
  (setq indent-tabs-mode nil))
(add-hook 'text-mode-hook 'my-text-indent-setup)
;; default .asm mode sucks
(setq auto-mode-alist (cons '("\\.asm$" . text-mode) auto-mode-alist))
;; fundamental mode sucks too
(setq default-major-mode 'text-mode)

;; Keybindings
(global-set-key (kbd "M-`") 'toggle-input-method)
(global-set-key (kbd "C-c C-c") 'comment-region)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; html helper
;(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.htm$" . html-helper-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.jsp$" . html-helper-mode) auto-mode-alist))

(require 'sgml-mode)
(setq auto-mode-alist (cons '("\\.jsp$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tld$" . sgml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.html$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.htm$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xhtml$" . sgml-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

;; use mouse wheel
(defun up-wheel () (interactive) (scroll-up (/ (* (window-height) 1) 2)))
(defun down-wheel () (interactive) (scroll-down (/ (* (window-height) 1) 2)))
(global-set-key [mouse-4] 'down-wheel)
(global-set-key [mouse-5] 'up-wheel)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [C-mouse-4] 'down-one)
(global-set-key [C-mouse-5] 'up-one)
(global-set-key [C-prior] 'down-one)
(global-set-key [C-next] 'up-one)
(global-set-key [M-prior] 'down-one)
(global-set-key [M-next] 'up-one)

(put 'downcase-region 'disabled nil)

;; global replace
(autoload 'mqr-auto-replace  "mqr-replace" "Auto multi query replace." t)
(autoload 'mqr-query-replace "mqr-replace" "Query buffers query replace." t)
(global-set-key (kbd "C-%") 'mqr-auto-replace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(CUA-mode-inhibit-method (quote twice))
 '(blink-matching-paren nil)
 '(c++-font-lock-extra-types
   (quote
    ("\\sw+_t" "\\([iof]\\|str\\)+stream\\(buf\\)?" "ios" "string" "rope" "list" "slist" "deque" "vector" "bit_vector" "set" "multiset" "map" "multimap" "hash\\(_\\(m\\(ap\\|ulti\\(map\\|set\\)\\)\\|set\\)\\)?" "stack" "queue" "priority_queue" "type_info" "iterator" "const_iterator" "reverse_iterator" "const_reverse_iterator" "reference" "const_reference")))
 '(c++-mode-hook (quote ((lambda nil (setq tab-width 8)))))
 '(c-basic-offset 4)
 '(c-font-lock-extra-types (quote ("FILE" "\\sw+_t" "Lisp_Object" "wx.*")))
 '(c-mode-hook (quote ((lambda nil (setq tab-width 8)))))
 '(c-offsets-alist
   (quote
    ((innamespace . 0)
     (substatement-open . 0)
     (access-label . -1))))
 '(c-syntactic-indentation t)
 '(confirm-kill-emacs nil)
 '(cua-enable-cua-keys nil)
 '(display-hourglass nil)
 '(display-time-mode nil)
 '(focus-follows-mouse nil)
 '(font-lock-global-modes t)
 '(font-lock-maximum-decoration (quote ((t . t) (java-mode . t) (c++-mode . t))))
 '(font-lock-verbose nil)
 '(java-font-lock-extra-types (quote ("[A-Z�-��-�]\\sw*[a-z]\\sw*" "URL")))
 '(java-mode-hook
   (quote
    ((lambda nil
       (setq tab-width 8))
     (lambda nil "Treat Java 1.5 @-style annotations as comments."
       (setq c-comment-start-regexp "\\(@\\|/\\(/\\|[*][*]?\\)\\)")
       (modify-syntax-entry 64 "< b" java-mode-syntax-table)))))
 '(jit-lock-stealth-time 1)
 '(js-indent-level 2)
 '(mode-line-format (quote (" %70b" "%5l (%*)")))
 '(mouse-avoidance-mode nil nil (avoid))
 '(mouse-wheel-follow-mouse t)
 '(perl-indent-level 2)
 '(pmd-home "/home/code/local/pmd")
 '(pmd-java-home "/home/code/local/jdk/bin/java")
 '(pmd-ruleset-list (quote ("rulesets/imports.xml" "rulesets/basic.xml")))
 '(sgml-basic-offset 2)
 '(sgml-slash-distance 10000)
 '(sh-basic-offset 2)
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis))
 '(show-trailing-whitespace nil)
 '(standard-indent 4)
 '(tooltip-mode nil nil (tooltip))
 '(typescript-indent-level 2)
 '(undo-limit 2000000)
 '(undo-outer-limit 30000000)
 '(undo-strong-limit 3000000))

(put 'upcase-region 'disabled nil)

;; Disable indentation when in namespace blocks.
(c-set-offset 'innamespace 0)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (load-file (let ((coding-system-for-read 'utf-8))
;;              (shell-command-to-string "agda-mode locate")))
