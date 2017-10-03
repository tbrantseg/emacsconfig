(setq inhibit-startup-screen t)

(setq initial-scratch-message
      (concat
       (concat ";; GNU Emacs " emacs-version  "\n")
       (concat ";; Build system: " system-configuration "\n")
       (concat ";; Build date/time: "
               (format-time-string "%Y-%m-%d %T" emacs-build-time) "\n\n")
        ";; C-j: Evaluate Lisp expression within this buffer\n\n"
        ";; C-x b: Select buffer menu\n"
        ";; C-x f: Create file\n"
        ";; C-c u: Desk utilities menu\n"
        ";; C-c p p: Jump to project\n"
        ";; C-c c: Emacs config menu\n\n"))

(require 'cl)

(setq user-full-name "Tom Brantseg")
(setq user-mail-address "tbrantse@iastate.edu")

(setq debug-on-error t)

(setq visible-bell t)

(let ((backup-dir "~/.emacs.d/backups")
      (auto-saves-dir "~/.emacs.d/auto-saves"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
        tramp-backup-directory-alist `((".*" . ,backup-dir))
        tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t)
(setq delete-old-versions t)
(setq version-control t)
(setq kept-new-versions 5)
(setq kept-old-versions 2)

(require 'package)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;                            ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.org/packages/")
                           ("org" . "http://orgmode.org/elpa/")))
  (package-initialize)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(let ((default-directory (concat user-emacs-directory "share/emacs/site-lisp")))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'exec-path (concat user-emacs-directory "bin/"))

(load-theme 'monokai t)

(set-face-attribute 'default nil
            :family "Inconsolata for Powerline" :height 140 :weight 'normal)

(if (eq window-system 'x)
    (set-face-attribute 'default nil :height 120)
  (scroll-bar-mode -1))

(tool-bar-mode -1)

(setq ns-use-srgb-colorspace nil)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'powerline)
(sml/setup)

(setq nlinum-format "%d ")
(unless window-system
  (osx-clipboard-mode)
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse(e))
  (setq mouse-sel-mode t))

(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'server)
(unless (server-running-p) (server-start))

(setq mac-command-modifier 'meta)

(defun my-add-to-multiple-hooks (function hooks)
  (mapc (lambda (hook)
          (add-hook hook function))
        hooks))


(my-add-to-multiple-hooks
 'nlinum-mode
 '(c++-mode-hook
   sql-mode-hook
   python-mode-hook
   LaTeX-mode-hook
   sh-mode-hook
   emacs-lisp-mode-hook
   autoconf-mode-hook
   makefile-mode-hook
   makefile-automake-mode-hook
   cmake-mode-hook
   ))

(global-set-key (kbd "<M-f10>") 'nlinum-mode)

(global-set-key (kbd "C-M-x C-M-f") 'view-file)
(require 'dash)

(toggle-frame-fullscreen)

(require 'helm)
(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p        t
      helm-move-to-line-cycle-in-source      t
      helm-ff-search-library-in-sexp         t
      helm-scroll-amount                         8
      helm-ff-file-name-history-use-recentf  t)
(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(setq helm-M-x-fuzzy-match t)
(setq helm-buffers-fuzzy-matching    t
      helm-recentf-fuzzy-match       t)

(helm-autoresize-mode t)

(require 'helm-gtags)
(my-add-to-multiple-hooks
 'helm-gtags-mode
 '(dired-mode-hook
   eshell-mode-hook
   c-mode-hook
   c++-mode-hook
   asm-mode-hook))

(setq helm-gtags-ignore-case t
      helm-gtags-auto-update t
      helm-gtags-use-input-at-cursor t
      helm-gtags-pulse-at-cursor t
      helm-gtags-prefix-key "\C-cg"
      helm-gtags-suggested-key-mapping t)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(require 'cc-mode)
;(require 'semantic)
;(require 'semantic/ia)
;(require 'semantic/bovine/gcc)

; (semantic-mode 1)
;; (global-ede-mode 1)
;; (global-semanticdb-minor-mode 1)
;; (global-semantic-idle-scheduler-mode 1)
;; (global-semantic-idle-summary-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

;;  (semantic-add-system-include "/opt/local/include" 'c++-mode)
;;  (semantic-add-system-include "/opt/local/include/mpich-clang35" 'c++-mode)

(require 'projectile)
(projectile-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key [f8] 'sr-speedbar-toggle)

(global-set-key (kbd "C-x g") 'magit-status)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'yasnippet)
(yas-global-mode 1)

(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)
(define-key smartparens-mode-map (kbd "M-<up>") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "M-<down>") 'sp-backward-sexp)

(sp-with-modes '(c-mode c++-mode)
           (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
           (sp-local-pair "/*" "/*" :post-handlers '((" | " "SPC")
                                                     ("* ||\n[i]" "RET"))))

(firestarter-mode)

(require 'highlight-indent-guides)
(add-hook 'emacs-startup-hook
          (lambda ()
            (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)))
(setq highlight-indent-guides-method 'character)

(require 'emms-setup)
(emms-all)
(emms-default-players)
(setq emms-source-file-default-directory "~/Music/")

(require 'emms-info-libtag)
(setq emms-info-libtag-program-name "/soft/src/emacs-ext/emms-4.1/src/emms-print-metadata")
(setq emms-info-functions '(emms-info-libtag))

;; (require 'mu4e)
;; (setq mu4e-maildir "/Users/tbrantse/Maildir")
;; (setq mu4e-get-mail-command "/opt/local/bin/mbsync -a")

;; (defun my-render-html-message ()
;;   (let ((dom (libxml-parse-html-region (point-min) (point-max))))
;;     (erase-buffer)
;;     (shr-insert-document dom)
;;     (goto-char (point-min))))

;; (setq mu4e-html2text-command 'my-render-html-message)

;; (add-to-list 'mu4e-view-actions
;;              '("ViewInBrowser" . mu4e-action-view-in-browser)
;;              '("ViewAsPdf" . mu4e-action-view-as-pdf))

;; (defun my-mu4e-set-account ()
;;   "Set the account for composing a message."
;;   (let* ((account
;;           (if mu4e-compose-parent-message
;;               (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
;;                 (string-match "/\\(.*?\\)/" maildir)
;;                 (match-string 1 maildir))
;;             (completing-read (format "Compose with account: (%s) "
;;                                      (mapconcat #'(lambda (var) (car var))
;;                                                 my-mu4e-account-alist "/"))
;;                              (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
;;                              nil t nil nil (caar my-mu4e-account-alist))))
;;          (account-vars (cdr (assoc account my-mu4e-account-alist))))
;;     (if account-vars
;;         (mapc #'(lambda (var)
;;                   (set (car var) (cadr var)))
;;               account-vars)
;;       (error "No email account found"))))

;; ;; ask for account when composing mail
;; (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; ; Default value
;; (setq mu4e-sent-folder "/iastate/sent")
;; (setq mu4e-drafts-folder "/iastate/drafts")
;; (setq mu4e-trash-folder "/iastate/trash")
;; (setq mu4e-refile-folder "/iastate/archive")

;; (defvar my-mu4e-account-alist
;;   '(("gmail"
;;      (user-mail-address  "tom.brantseg@gmail.com")
;;      (user-full-name     "Tom Brantseg")
;;      (mu4e-sent-folder   "/gmail/sent")
;;      (mu4e-drafts-folder "/gmail/drafts")
;;      (mu4e-trash-folder  "/gmail/trash")
;;      (mu4e-refile-folder "/gmail/archive"))
;;     ("iastate"
;;      (user-mail-address  "tbrantse@iastate.edu")
;;      (user-full-name     "Thomas Brantseg")
;;      (mu4e-sent-folder   "/iastate/sent")
;;      (mu4e-drafts-folder "/iastate/draft")
;;      (mu4e-trash-folder  "/iastate/trash")
;;      (mu4e-refile-folder "/iastate/archive"))))

;; (setq mu4e-user-mail-address-list
;;       (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
;;               my-mu4e-account-alist))

; use msmtp
;; (setq message-send-mail-function 'message-send-mail-with-sendmail)
;; (setq sendmail-program "/opt/local/bin/msmtp")
;; ; tell msmtp to choose the SMTP server according to the from field in the outgoing email
;; (setq message-sendmail-f-is-evil 't)
;; (setq message-sendmail-extra-arguments '("--read-envelope-from"))

;; (setq mu4e-change-filenames-when-moving t)
;; (setq mu4e-update-interval 300)

;; (mu4e-alert-set-default-style 'notifier)
;; (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
;; (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
;; (mu4e 0)

(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(add-hook 'term-mode-hook
          (lambda ()
            (yas-minor-mode -1)))

(require 'sane-term)
(global-set-key (kbd "C-x t") 'sane-term)
(global-set-key (kbd "C-x T") 'sane-term-create)
(add-hook 'term-mode-hook
          (lambda()
            (define-key term-raw-map (kbd "C-y")
              (lambda ()
                (interactive)
                (term-line-mode)
                (yank)
                (term-char-mode)))))

(add-hook 'c++-mode-hook 'projectile-mode)

(setq c-default-style "stroustrup")
(global-set-key (kbd "RET") 'newline-and-indent)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq auto-mode-alist(cons '("\\.h$"   . c++-mode)  auto-mode-alist))

(define-key c++-mode-map [f6] 'projectile-find-other-file)
(define-key c++-mode-map [f7] 'projectile-find-other-file-other-window)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map (kbd "M-RET") 'comment-indent-new-line)
(define-key c-mode-map (kbd "M-RET") 'comment-indent-new-line)

(defcustom main-compile-command nil
  "Shell command used for main project compilation."
  :type 'string
  :group 'tom-custom)
(put 'main-compile-command 'safe-local-variable #'stringp)

(defun main-compile-project ()
  (interactive)
  (setq-local compilation-read-command nil)
  (compile main-compile-command))

(global-set-key (kbd "<f5>") 'main-compile-project)

(setq compilation-scroll-output 1)

(setq gdb-many-windows t
      gdb-show-main t)

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony)

(defun irony-restart-server ()
  (irony-server-kill)
  (irony--start-server-process))

(setq company-show-numbers t)
(setq company-tooltip-limit 20)
(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)

(add-hook 'c++-mode-hook (lambda ()
                           (setq flycheck-clang-language-standard "c++11")))

(require 'rtags)
(require 'company-rtags)
(setq rtags-path (concat user-emacs-directory "bin/"))

(setq rtags-completions-enabled t)
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends 'company-rtags))
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

(defcustom compdb-command nil
  "Shell command used to generate the compilation database."
  :type 'string
  :group 'tom-custom)

(put 'compdb-command 'safe-local-variable #'stringp)

(defun regen-compilation-db ()
  (interactive)
  (setq-local compilation-read-command nil)
  (compile compdb-command))

(global-set-key (kbd "<f4>") 'regen-compilation-db)

;  (require 'srefactor)
;  (require 'srefactor-lisp)

;  (semantic-mode 1)

;  (define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)

;(require 'sql-indent)
(add-to-list 'auto-mode-alist
             '("\\.psql$" . (lambda ()
                              (sql-mode))))

(add-hook 'sql-mode-hook 'sql-highlight-postgres-keywords)
(add-hook 'sql-mode-hook 'sqlup-mode)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

(add-hook 'python-mode-hook (lambda ()
                              (make-local-variable 'company-backends)
                              (add-to-list 'company-backends 'company-anaconda)))

(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt -i")
(setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
(setq python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: ")

(setq py-force-py-shell-name-p t)
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq py-split-windows-on-execute-p nil)
(setq py-smart-indentation t)
(setq ob-ipython-command "ipython")
(add-hook 'python-mode-hook
          '(lambda () (define-key python-mode-map (kbd "M-<tab>") 'ob-ipython-inspect)))

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(defun turn-on-outline-minor-mode()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o")

(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)
;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

(setq reftex-plug-into-AUCTeX t)
(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq reftex-default-bibliography '("/Users/tbrantse/Library/texmf/bibtex/bib/biblio.bib"))
(setq reftex-cite-format 'natbib)

(setq LaTeX-eqnarray-label "eq"
      LaTeX-equation-label "eq"
      LaTeX-figure-label "fig"
      LaTeX-table-label "tab"
      LaTeX-myChapter-label "chap"
      TeX-auto-save t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-parse-self t)

(setq TeX-auto-save t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

(require 'org)
(require 'ox-latex)
(require 'ob)
(require 'ob-ipython)
(require 'org-journal)
;(require 'ox-mediawiki)
; Temporarily required to fix the ipython console in org-ipython mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(defun org-mode-reftex-setup ()
  (load-library "reftex") 
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c (") 'reftex-citation))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq ebib-preload-bib-files
      (list "~/Library/texmf/bibtex/bib/biblio.bib"))
(org-add-link-type "ebib" 'ebib)

(setq org-latex-pdf-process (list "/opt/local/bin/latexmk -f -pdf %f"))
(setq org-latex-hyperref-template nil)
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

(pdf-tools-install)
(setq doc-view-ghostscript-program "/opt/local/bin/gs")
(setq revert-without-query '("\\.pdf\\'"))
(delete '("\\.pdf\\'" . default) org-file-apps)
(add-to-list 'org-file-apps '("\\.pdf\\'" . find-file-other-window))

(defun org-ref-setup ()
  (setq org-ref-default-bibliography '("/Users/tbrantse/Library/texmf/bibtex/bib/biblio.bib"))
  (setq org-ref-pdf-directory "~/Documents/Papers")
  (setq bibtex-completion-bibliography '("/Users/tbrantse/Library/texmf/bibtex/bib/biblio.bib"))
  (require 'org-ref)
  (visual-line-mode))
(add-hook 'org-mode-hook 'org-ref-setup)

(defun my-babel-languages ()
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
  (org-babel-do-load-languages   
   'org-babel-load-languages
   '((dot . t)
     (emacs-lisp t)
     (ditaa . t)
     (python . t)
     (ipython . t)
     (shell . t)
     (gnuplot . t)
     (plantuml . t)
     (python . t))))
(add-hook 'org-mode-hook 'my-babel-languages)

(defun insert-csv-file-as-org-table (filename)
  "Insert a file into the current buffer at point, and convert it to an org table."
  (interactive (list (read-file-name "csv file: ")))
  (let* ((start (point))
    (end (+ start (nth 1 (insert-file-contents filename)))))
    (org-table-convert-region start end)))

(defun org-mode-keybind-hook ()
  (local-set-key (kbd "C-c f") 'insert-csv-file-as-org-table))

(add-hook 'org-mode-hook 'org-mode-keybind-hook)

(setq org-confirm-babel-evaluate nil)

(defun my-library-of-babel-setup ()
  (org-babel-lob-ingest "~/emacs-init/code_blocks.org"))
(add-hook 'after-init-hook #'my-library-of-babel-setup)

(require 'org-agenda)

(setq org-agenda-files (list "~/org/work.org" "~/org/home.org" "~/org/todo.org"))
(add-to-list 'org-agenda-files (expand-file-name "~/Research/Wiki"))
;(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'\\|[0-9]+")
;'(add-to-list 'org-agenda-files (expand-file-name "~/Documents/journal"))

(setq org-log-done 'time)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-include-diary t)

(require 'org-mu4e)
(setq org-mu4e-link-query-in-headers-mode nil)

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/org/todo.org" "Tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

(setq
  mu4e-index-cleanup nil      ;; don't do a full cleanup check
  mu4e-index-lazy-check t)    ;; don't consider up-to-date dirs

(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((agenda "")
          (alltodo "")))))

(defun tb-org-agenda-capture (&optional vanilla)
  "Capture a task in agenda mode, using the date at point. If VANILLA is non-nil, run the standard `org-capture'."
  (interactive "P")
  (if vanilla
      (org-capture)
    (let ((org-overriding-default-time (org-get-cursor-date)))
      (org-capture nil "a"))))

(define-key org-agenda-mode-map "c" 'tb-org-agenda-capture)

;;;###autoload
(defun ora-dired-rsync (dest)
  (interactive
   (list
    (expand-file-name
     (read-file-name
      "Rsync to:"
      (dired-dwim-target-directory)))))
  ;; store all selected files into "files" list
  (let ((files (dired-get-marked-files
                nil current-prefix-arg))
        ;; the rsync command
        (tmtxt/rsync-command
         "rsync -arvz --progress "))
    ;; add all selected file names as arguments
    ;; to the rsync command
    (dolist (file files)
      (setq tmtxt/rsync-command
            (concat tmtxt/rsync-command
                    (shell-quote-argument file)
                    " ")))
    ;; append the destination
    (setq tmtxt/rsync-command
          (concat tmtxt/rsync-command
                  (shell-quote-argument dest)))
    ;; run the async shell command
    (async-shell-command tmtxt/rsync-command "*rsync*")
    ;; finally, switch to that window
    (other-window 1)))

(define-key dired-mode-map "Y" 'ora-dired-rsync)

(add-hook 'makefile-mode (lambda ()
                            (setq-local indent-tabs-mode t)))
(add-hook 'makefile-automake-mode-hook (lambda ()
                                         (setq-local indent-tabs-mode t)))

(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/") 
(autoload 'LilyPond-mode "lilypond-mode")
(setq auto-mode-alist
      (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))

(add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))

(setq jabber-history-enabled t)
(setq jabber-use-global-history nil)
(setq jabber-backlog-number 40)
(setq jabber-backlog-days 30)

(setq idlwave-reserved-word-upcase t)
(setq idlwave-shell-explicit-file-name "gdl")
(setq idlwave-library-path
      '("+/opt/local/share/gnudatalanguage"
        "+/soft/GDL/coyote"
        "+/soft/GDL/pro"))

(require 'hydra)

(defhydra tb-system-hydra (:color blue :hint nil)
"
File system commands:
---------------
_s_: Open eshell
_t_: Open plain terminal
_d_: Open dired in current directory
_p_: Find file in project
_g_: grep in project
"
("s" eshell)
("t" ansi-term)
("d" dired)
("p" projectile-find-file)
("g" projectile-grep))

(global-set-key (kbd "C-c s") 'tb-system-hydra/body)

(defhydra tb-info-hydra (:color blue :hint nil)
"
Emacs environment (describe):
----------------------------
_k_: Describe key binding
_v_: Describe variable
_f_: Describe function
_m_: Describe current mode
"
("k" describe-key)
("v" describe-variable)
("f" describe-function)
("m" describe-mode))

(global-set-key (kbd "C-c e") 'tb-info-hydra/body)

(defhydra tb-grep-hydra (:color blue :hint nil)
"
Search functions:
----------------
_d_: Grep in directory...
_p_: Grep in project...
"
("p" projectile-grep)
("d" find-grep-dired))

(global-set-key (kbd "C-c f") 'tb-grep-hydra/body)

(defun tb-gchat-helper ()
  (interactive)
  (jabber-connect-all)
  (call-interactively 'jabber-chat-with))

(defhydra tb-utility-hydra (:color blue :hint nil)
"
Desk utilities:
----------
_c_: calculator
_d_: calendar
_g_: Google Talk...
_j_: New journal entry
_m_: Read new email
"
("c" calc)
("d" calendar)
("g" jabber-connect-all)
("j" org-journal-new-entry)
("m" (lambda() (interactive) (mu4e-alert-view-unread-mails)))
)

(global-set-key (kbd "C-c u") 'tb-utility-hydra/body)

(defhydra tb-config-hydra (:color blue :hint nil)
"
Configuration functions
-----------------------
_c_: Open emacs-init.org
_r_: Reload configuration
_e_: Open .emacs
_p_: List packages
_g_: Customize group
"
("c" (find-file "~/emacs-init/emacs-init.org"))
("e" (find-file "~/.emacs"))
("r" (load-file "~/emacs-init/emacs-init.el"))
("p" package-list-packages)
("g" customize-group))

(global-set-key (kbd "C-c c") 'tb-config-hydra/body)

(defhydra tb-music-hydra (:color pink :hint nil)
"
^Player^:         ^Library^
--------------------------------------------
_w_ : Play        _b_: Browse library
_d_ : Next        _p_: View current playlist
_a_ : Previous    _c_: Smart browser
_s_ : Stop
"

;; Player controls
("w" emms-pause)
("d" emms-next)
("a" emms-previous)
("s" emms-stop)

;; Library controls
("b" emms-browser)
("p" emms-playlist-mode-go)
("c" emms-smart-browse)

("z" nil "Close" :color blue)
)

(global-set-key (kbd "C-c m") 'tb-music-hydra/body)

(defhydra hydra-outline (:color pink :hint nil)
  "
^Hide^             ^Show^           ^Move
^^^^^^------------------------------------------------------
_q_: sublevels     _a_: all         _u_: up
_t_: body          _e_: entry       _n_: next visible
_o_: other         _i_: children    _p_: previous visible
_c_: entry         _k_: branches    _f_: forward same level
_l_: leaves        _s_: subtree     _b_: backward same level
_d_: subtree

"
  ;; Hide
  ("q" outline-hide-sublevels)    ; Hide everything but the top-level headings
  ("t" outline-hide-body)         ; Hide everything but headings (all body lines)
  ("o" outline-hide-other)        ; Hide other branches
  ("c" outline-hide-entry)        ; Hide this entry's body
  ("l" outline-hide-leaves)       ; Hide body lines in this entry and sub-entries
  ("d" outline-hide-subtree)      ; Hide everything in this entry and sub-entries
  ;; Show
  ("a" outline-show-all)          ; Show (expand) everything
  ("e" outline-show-entry)        ; Show this heading's body
  ("i" outline-show-children)     ; Show this heading's immediate child sub-headings
  ("k" outline-show-branches)     ; Show all sub-headings under this heading
  ("s" outline-show-subtree)      ; Show (expand) everything in this heading & below
  ;; Move
  ("u" outline-up-heading)                ; Up
  ("n" outline-next-visible-heading)      ; Next
  ("p" outline-previous-visible-heading)  ; Previous
  ("f" outline-forward-same-level)        ; Forward - same level
  ("b" outline-backward-same-level)       ; Backward - same level
  ("z" nil "leave"))

(global-set-key (kbd "C-c o") 'hydra-outline/body) ; by example

(setq tramp-default-method "ssh")
(setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")

(load-file "~/emacs-init/secret.el")

(appt-activate)
(display-time)

(setq debug-on-error t)

(message "emacs-init.el finished loading!")
(provide 'emacs-init)
