;;; tb-sql-setup.el
;; Main file for SQL mode setup tweaks

(add-to-list 'auto-mode-alist
             '("\\.psql$" . (lambda ()
                              (sql-mode))))

(add-hook 'sql-mode-hook 'sql-highlight-postgres-keywords)
(add-hook 'sql-mode-hook 'sqlup-mode)

(message "SQL mode setup loaded OK!")

;;; Footer
(provide 'tb-sql-setup)
;;; tb-sql-setup.el ends here
