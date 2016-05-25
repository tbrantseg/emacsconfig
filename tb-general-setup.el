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
		    :family "Inconsolata for Powerline" :height 145 :weight 'normal)

;;; Toolbar off
(tool-bar-mode -1)

;;; Smart mode line
(setq sml/theme 'automatic)
(sml/setup)

;;; If we're running in a terminal, pad the line numbers a little and
;;; change the themes we're using to match.
;;; Also enable mouse usage
(unless window-system
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

;;; Footer
(provide 'tb-general-setup)
;;; tb-general-setup.el ends here
