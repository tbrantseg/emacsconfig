;;; tb-rtags-setup.el
;; Setup information for RTags

(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)
(setq rtags-use-helm t)

;;; Footer
(provide 'tb-rtags-setup)
;;; tb-rtags-setup.el ends here
