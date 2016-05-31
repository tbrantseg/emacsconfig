;;; tb-org-setup.el
;; Main file for org-mode tweaks

(require 'org)
(require 'org-journal)

(defun org-mode-reftex-setup ()
  (load-library "reftex") 
  (and (buffer-file-name)
  (file-exists-p (buffer-file-name))
  (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c (") 'reftex-citation)
  ;; (setq reftex-cite-format
  ;;     '(
  ;;       (?\C-m . "\\cite[]{%l}")
  ;;       (?t . "\\textcite{%l}")
  ;;       (?a . "\\autocite[]{%l}")
  ;;       (?p . "\\parencite{%l}")
  ;;       (?f . "\\footcite[][]{%l}")
  ;;       (?F . "\\fullcite[]{%l}")
  ;;       (?x . "%l")
  ;;       (?X . "{%l}")
  ;;       )))
)

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

(message "Or-mode setup loaded OK!")

;;; Footer
(provide 'tb-org-setup)
;;; tb-org-setup.el ends here
