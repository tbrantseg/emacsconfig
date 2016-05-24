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
		    :family "Inconsolata" :height 145 :weight 'normal)

;;; Toolbar off
(tool-bar-mode -1)

;;; Footer
(provide 'tb-general-setup)
;;; tb-general-setup.el ends here
