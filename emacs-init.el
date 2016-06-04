;; emacs-init.el
;; This file replaces itself with the contents of emacs-init.org when first run.

(require 'org)
(find-file "~/emacs-init/emacs-init.org")
(org-babel-tangle)
(load-file "~/emacs-init/emacs-init.el")
(byte-compile-file "~/emacs-init/emacs-init.el")

;; emacs-init.el ends here.
