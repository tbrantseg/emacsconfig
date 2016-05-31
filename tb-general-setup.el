;;; tb-general-setup.el
;;; Loads appearance and general-use packages

;;; Package manager setup
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;;; Theme
(load-theme 'lush t)

;;; Font
(set-face-attribute 'default nil
		    :family "Inconsolata for Powerline" :height 140 :weight 'normal)

;; Prevent font from being too big in x11
(if (eq window-system 'x)
    (set-face-attribute 'default nil :height 120)
  (scroll-bar-mode -1))

;;; Toolbar off
(tool-bar-mode -1)

;;; Smart mode line
;(require 'powerline)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'powerline)
(sml/setup)

;(require 'spaceline-config)
;(spaceline-emacs-theme)

;;; If we're running in a terminal, pad the line numbers a little and
;;; enable mouse usage
(unless window-system
  (menu-bar-mode -1)
  (setq nlinum-format "%d ")
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

(message "General setup loaded OK!")

;;; Footer
(provide 'tb-general-setup)
;;; tb-general-setup.el ends here
