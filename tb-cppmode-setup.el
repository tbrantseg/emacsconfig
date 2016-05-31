;;; tb-cppmode-setup
;;; All C++ mode tweaks here.

;; Display line numbers in this mode
(add-hook 'c++-mode-hook 'nlinum-mode)

;; Style and appearance tweaks
;; Automatic indentation, non-tabbed indenting, good style
(setq c-default-style "stroustrup")
(global-set-key (kbd "RET") 'newline-and-indent)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Compilation mode
;; Bind f5 to automatically compile without asking for command
;; (specify this for each project in .dir-locals.el)
(global-set-key (kbd "<f5>") (lambda ()
			       (interactive)
			       (setq-local compilation-read-command nil)
			       (call-interactively 'compile)))
;; Scroll compilation output
(setq compilation-scroll-output 1)

;; GDB debugger
(setq gdb-many-windows t
      gdb-show-main t)

;; Syntax checking with flycheck
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

;; Syntax and completion tweaks
(require 'tb-rtags-setup)
(add-hook 'c++-mode-hook (lambda()
                           (setq flycheck-clang-language-standard "c++11")))
                           (make-local-variable 'company-backends)
                           (setq company-backends '(company-rtags company-semantic company-gtags company-keywords))
                                                     ;(setq company-backends '(company-semantic company-gtags company-keywords))
 
;(add-to-list 'flycheck-clang-include-path "/opt/local/include/")
;(add-to-list 'flycheck-clang-include-path "/opt/local/include/mpich-clang35/")

;; Projectile integration
(define-key c-mode-map (kbd "C-c p f") 'helm-projectile-find-file)
(define-key c++-mode-map (kbd "C-c p f") 'helm-projectile-find-file)

;; Use f6 and f7 to switch between header and implementation modes
(define-key c++-mode-map [f6] 'projectile-find-other-file)
(define-key c++-mode-map [f7] 'projectile-find-other-file-other-window)

;; Open .h header files in C++ mode, not C mode
(setq auto-mode-alist(cons '("\\.h$"   . c++-mode)  auto-mode-alist))

;; Manual completion control
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)

(message "C++ mode setup loaded OK!")

;;; Footer
(provide 'tb-cppmode-setup)
;;; tb-cppmode-setup ends here
