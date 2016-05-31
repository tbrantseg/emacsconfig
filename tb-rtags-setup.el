;;; tb-rtags-setup.el
;; Setup information for RTags

(add-to-list 'load-path "/soft/src/rtags/src")

(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)
(setq rtags-use-helm t)

(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

(require 'flycheck-rtags)
(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(defun regen-compilation-db ()
  (interactive)
  (with-output-to-temp-buffer "*Compilation Database*"
    (async-shell-command "make clean && bear make")
    (pop-to-buffer "*Compilation Database*")
    (with-current-buffer (get-buffer "*Compilation Database")
      (compilation-mode))))
  
(global-set-key (kbd "<f4>") 'regen-compilation-db)

(message "Rtags setup loaded OK!")

;;; Footer
(provide 'tb-rtags-setup)
;;; tb-rtags-setup.el ends here
