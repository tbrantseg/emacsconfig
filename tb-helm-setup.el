;;; tb-helm-setup.el
;; All configuration to set up helm here

(require 'helm)
(require 'helm-config)

;; Remap helm command prefix and other keys
;; Helm setup here taken from tuhdo.github.io/helm-intro.html
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p		 t
      helm-move-to-line-cycle-in-source		 t
      helm-ff-search-library-in-sexp		 t
      helm-scroll-amount                         8
      helm-ff-file-name-history-use-recentf	 t)

;; Remap M-x to be the helm M-x, with fuzzy matching
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)

;; Show the kill ring in helm
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; Make sure helm doesn't get too big
(helm-autoresize-mode t)

;; Use helm to open buffers
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching	 t
      helm-recentf-fuzzy-match		 t)

;; Also use helm to open files
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; And use helm to read man pages
(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

;; Set up helm to work with gtags for completion and navigation
(require 'helm-gtags)
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Useful tweaks for helm-gtags
(setq helm-gtags-ignore-case t
      helm-gtags-auto-update t
      helm-gtags-use-input-at-cursor t
      helm-gtags-pulse-at-cursor t
      helm-gtags-prefix-key "\C-cg"
      helm-gtags-suggested-key-mapping t)

;; Project navigation shortcuts for helm-gtags
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;;; Footer
(provide 'tb-helm-setup)
;;; tb-helm-setup.el ends here
