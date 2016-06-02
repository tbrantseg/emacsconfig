;;; tb-org-setup.el
;; Main file for org-mode tweaks

(require 'org)
(require 'ox-latex)
(require 'ob)
(require 'org-journal)

;; Org-mode latex setup
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
(setq org-latex-pdf-process (list "latexmk -f -pdf %f"))
(setq org-latex-with-hyperref nil)
(add-to-list 'org-latex-classes
             '("aastex"
               "\\documentclass{aastex}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(defun org-ref-setup ()
(setq org-ref-default-bibliography '("/Users/tbrantse/Library/texmf/bibtex/bib/biblio.bib"))
(setq org-ref-pdf-directory "~/Documents/Papers")
(setq bibtex-completion-bibliography '("/Users/tbrantse/Library/texmf/bibtex/bib/biblio.bib"))
(require 'org-ref))
(add-hook 'org-mode-hook 'org-ref-setup)

;; Setup org agenda
(setq org-agenda-files (list "~/org/work.org" "~/org/home.org"))
(add-to-list 'org-agenda-files (expand-file-name "~/Documents/journal"))
(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'\\|[0-9]+")
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done 'time)

(message "Org-mode setup loaded OK!")

;;; Footer
(provide 'tb-org-setup)
;;; tb-org-setup.el ends here
