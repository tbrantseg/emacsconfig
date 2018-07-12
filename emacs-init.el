;; emacs-init.el
;; This file replaces itself with the contents of emacs-init.org when first run.

(let* ((install-dir (concat user-emacs-directory "emacsconfig/"))
       (org-file (concat install-dir "emacs-init.org"))
       (el-file (concat install-dir "emacs-init.el")))
      (require 'org)
      (find-file org-file)
      (org-babel-tangle)
      (load-file el-file)
      (byte-compile-file el-file))

;; emacs-init.el ends here.
