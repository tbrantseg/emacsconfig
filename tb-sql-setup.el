;;; tb-sql-setup.el
;; Main file for SQL mode setup tweaks

(add-to-list 'auto-mode-alist
			 '("\\.psql$" . (lambda ()
							  (sql-mode)
							  (sqlup-mode)
							  (nlinum-mode t)
							  (sql-highlight-postgres-keywords))))

;;; Footer
(provide 'tb-sql-setup)
;;; tb-sql-setup.el ends here
