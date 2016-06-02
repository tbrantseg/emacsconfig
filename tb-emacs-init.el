;;; tb-emacs-init.el
;; Main file for emacs initialization

;; Overall setup - package management, look and feel
(require 'tb-general-setup)

;; General use packages that are used across multiple modes
(require 'tb-helm-setup)
(require 'tb-project-setup)
(require 'tb-company-setup)
(require 'tb-convenience-setup)

;; Individual mode setup
(require 'tb-cppmode-setup)
(require 'tb-sql-setup)
(require 'tb-python-setup)
(require 'tb-latex-setup)
(require 'tb-other-setup)
(require 'tb-org-setup)

;; Line number mode
;; The idle timer is necessary due to a bug in Emacs 24.5
(require 'tb-linum-setup)

;; Restore desktop
;(desktop-save-mode 1)

;;; Footer
(provide 'tb-emacs-init)
;;; tb-emacs-init.el ends here
