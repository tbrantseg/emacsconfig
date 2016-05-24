;;; tb-python-setup.el
;; Main file for everything related to python mode.

;; Mode hooks
;; Nlinum mode for line numbers
;; Anaconda mode for general python goodness
;; Flycheck mode for syntax checking
(add-hook 'python-mode-hook 'nlinum-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

;; Make sure we can find iPython
(setq-default py-shell-name "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin//ipython")
(setq-default py-which-bufname "IPython")
(setq python-shell-interpreter "ipython")
(setq py-force-py-shell-name-p t)
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq py-split-windows-on-execute-p nil)
(setq py-smart-indentation t)


(provide 'tb-python-setup)
;;; tb-python-setup.el ends here
