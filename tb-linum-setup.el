;;; tb-linum-setup.el
;; Line number setup here

;; Global line number toggler
(global-set-key (kbd "<M-f10>") 'nlinum-mode)

;; Line number mode hooks
(add-hook 'c++-mode-hook 'nlinum-mode)
(add-hook 'sql-mode-hook 'nlinum-mode)
(add-hook 'python-mode-hook 'nlinum-mode)
(add-hook 'LaTeX-mode-hook 'nlinum-mode)
(add-hook 'sh-mode-hook 'nlinum-mode)
(add-hook 'emacs-lisp-mode-hook 'nlinum-mode)
(add-hook 'autoconf-mode-hook 'nlinum-mode)
(add-hook 'makefile-mode-hook 'nlinum-mode)
(add-hook 'makefile-automake-mode-hook 'nlinum-mode)

(message "Line number setup loaded OK!")

;;; Footer
(provide 'tb-linum-setup)
;;; tb-linum-setup.el ends here
