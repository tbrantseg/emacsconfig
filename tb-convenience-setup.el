;;; tb-convenience-setup.el
;; Setup for packages that perform a convenient function across multiple modes
;; are used here

;; Global line number toggler
(global-set-key (kbd "<M-f10>") 'nlinum-mode)

;; YASnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Smartparens mode
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

(sp-with-modes '(c-mode c++-mode)
	       (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
	       (sp-local-pair "/*" "/*" :post-handlers '((" | " "SPC")
                                                     ("* ||\n[i]" "RET"))))

(message "Convenience setup loaded OK!")

;;; Footer
(provide 'tb-convenience-setup)
;;; tb-convenience-setup.el ends here
