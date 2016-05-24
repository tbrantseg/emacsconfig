;; tb-project-setup.el
;; Project-management tweaks here (semantic, projectile, etc.)

;; Semantic-mode setup
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)
(global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

;; Projectile-mode setup
(projectile-global-mode)
(require 'projectile-speedbar)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key [f8] 'sr-speedbar-toggle)

;;; Footer
(provide 'tb-project-setup)
;;; tb-project-setup.el ends here
