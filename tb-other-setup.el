;;; tb-other-setup.el
;; Setup for rarely-used modes or ones requiring little other setup

;; Shell script mode
(add-hook 'sh-mode-hook 'nlinum-mode)

;; Emacs Lisp mode
(add-hook 'emacs-lisp-mode-hook 'nlinum-mode)

;; Configure.ac mode
(add-hook 'autoconf-mode 'nlinum-mode)

;; Makefile mode
(add-hook 'makefile-mode (lambda ()
                            (setq indent-tabs-mode t)
                            (nlinum-mode t)))

;; Makefile.am mode
(add-hook 'makefile-automake-mode-hook (lambda ()
                                         (setq-local indent-tabs-mode t)
                                         (nlinum-mode t)))

(message "Other modes setup loaded OK!")

(provide 'tb-other-setup)
;;; tb-other-setup.el ends here
