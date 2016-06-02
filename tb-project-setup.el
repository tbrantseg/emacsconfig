;; tb-project-setup.el
;; Project-management tweaks here (semantic, projectile, etc.)

;; Semantic-mode setup
(require 'cc-mode)
(require 'semantic)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(semantic-mode 1)
(global-ede-mode 1)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

;; Make sure semantic knows system include paths
(semantic-add-system-include "/opt/local/include" 'c++-mode)
(semantic-add-system-include "/opt/local/include/mpich-clang35" 'c++-mode)

;; Projectile-mode setup
(projectile-global-mode)
(require 'projectile-speedbar)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key [f8] 'sr-speedbar-toggle)

;; Add magit-status keybind
(global-set-key (kbd "C-c g") 'magit-status)

(message "Projectile/semantic setup loaded OK!")

;;; Footer
(provide 'tb-project-setup)
;;; tb-project-setup.el ends here
