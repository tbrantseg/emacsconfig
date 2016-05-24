;;; tb-org-setup.el
;; Main file for org-mode tweaks

(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)
(setq ebib-preload-bib-files
      (list "~/Library/texmf/bibtex/bib/biblio.bib"))
(org-add-link-type "ebib" 'ebib)

;; Setup org agenda
(setq org-agenda-files (list "~/org/work.org" "~/org/home.org"))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done 'time)

;;; Footer
(provide 'tb-org-setup)
;;; tb-org-setup.el ends here
