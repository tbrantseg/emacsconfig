;;; tb-other-setup.el
;; Setup for rarely-used modes or ones requiring little other setup

;; Makefile mode
(add-hook 'makefile-mode (lambda ()
                            (setq-local indent-tabs-mode t)))

;; Makefile.am mode
(add-hook 'makefile-automake-mode-hook (lambda ()
                                         (setq-local indent-tabs-mode t)))

;; Start server unless running already
(require 'server)
(unless (server-running-p) (server-start))

;; Remap command key to meta
(setq mac-command-modifier 'meta)

(message "Other modes setup loaded OK!")

(provide 'tb-other-setup)
;;; tb-other-setup.el ends here
