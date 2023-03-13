(require 'creds) ;; Defines personal-user and personal-passw for DB connections.
(require 'sql-indent)
(require 'sql)

(defun sql-add-newline-first (output)
  "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'"
  (remove-hook 'comint-preoutput-filter-functions
	       'sql-add-newline-first)
  (concat "\n" output))

(defun sql-send-region-explain (start end)
  "Send a region, prepended with explain, to the SQL process."
  (interactive "r")
  (sql-send-string (concat "EXPLAIN EXTENDED " (buffer-substring-no-properties start end))))

(defun sql-describe-region (start end)
  "Send a region, prepended with explain, to the SQL process."
  (interactive "r")
  (sql-send-string (concat "DESC " (buffer-substring-no-properties start end) ";")))

(defun sql-find-column-name (column-name)
  "Given a column-name, find it using information-schema"
  (interactive "sColumn name: ")
  (sql-send-string (concat "SELECT * FROM information_schema.columns WHERE column_name LIKE \"" column-name "\";")))

(defun sql-search-table (table-name)
  "Given a column-name, search using wildcards"
  (interactive "sTable name: ")
  (sql-send-string (concat "SHOW TABLES LIKE \"%" table-name "%\";")))

(defun kill-sql-buffer ()
  (if (string= major-mode "sql-interactive-mode")
      (progn
        (ignore-errors
            (comint-kill-subjob))
        (sleep-for 0 10))))

(defun sql-send-word-describe ()
  "Sends the current word into a sql describe."
  (interactive)
  (let ((start (save-excursion
                 (backward-sexp)
                 (point)))
        (end (save-excursion
               (forward-sexp)
               (point))))
    (sql-describe-region start end)))

(defun sql-send-paragraph-explain ()
  "Send the current paragraph to the SQL process."
  (interactive)
  (let ((start (save-excursion
		 (backward-paragraph)
		 (point)))
	(end (save-excursion
	       (forward-paragraph)
	       (point))))
    (sql-send-region-explain start end)))

(defun sql-add-bindings ()
  (local-set-key (kbd "C-c C-e") 'sql-send-paragraph-explain)
  (local-set-key (kbd "C-c C-d") 'sql-send-word-describe)
  (local-set-key (kbd "C-c C-f") 'sql-find-column-name)
  (local-set-key (kbd "C-c C-t") 'sql-search-table))

(defvar sql-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'sql-send-paragraph)
    (define-key map (kbd "C-c C-r") 'sql-send-region)
    (define-key map (kbd "C-c C-s") 'sql-send-string)
    (define-key map (kbd "C-c C-b") 'sql-send-buffer)
    map)
  "Mode map used for `sql-mode'.")

;; SQL connection list
(setq sql-connection-alist
  '(
    ("docker"
	 (sql-product 'mysql)
	 (sql-server "127.0.0.1")
	 (sql-user "root")
	 (sql-database "simplisafe_DEV")
	 (sql-password "")
	 (sql-port 3306))
    ("at-at-local"
	 (sql-product 'mysql)
	 (sql-server "127.0.0.1")
	 (sql-user "root")
	 (sql-database "at_at_dev")
	 (sql-password "")
	 (sql-port 3307))
    ("albino"
	 (sql-product 'mysql)
	 (sql-server "ss-live-analytics.mariadb.prd.ss42.net")
	 (sql-user personal-user)
	 (sql-database "simplisafe_LIVE")
	 (sql-port 3306))
    ("at-at"
	 (sql-product 'mysql)
	 (sql-server "at-at.mariadb.prd.ss42.net")
	 (sql-user personal-user)
	 (sql-database "at_at")
	 (sql-port 3306))
    ("qa"
     (sql-product 'mysql)
	 (sql-server "qa-cluster.mariadb.dev.ss42.net")
	 (sql-user personal-user)
	 (sql-database "simplisafe_LIVE")
     (sql-password preprod-passw)
	 (sql-port 3306))
    ("stg"
     (sql-product 'mysql)
	 (sql-server "stg-cluster.mariadb.dev.ss42.net")
	 (sql-user personal-user)
	 (sql-database "simplisafe_LIVE")
     (sql-password preprod-passw)
	 (sql-port 3306))
    ("dev"
	 (sql-product 'mysql)
	 (sql-server "127.0.0.1")
	 (sql-user generic-user)
	 (sql-database "simplisafe_LIVE")
	 (sql-password generic-passw)
	 (sql-port 3307))))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product)))))

(defun sql-do (conn product)
  (interactive)
  (let ((sql-window-name (concat "*SQL: <" conn ">*")) (sql-scratch-buffer-name (concat conn ".sql")))
    (if (get-buffer sql-window-name)
        (progn
          (pop-to-buffer-same-window sql-window-name)
          (delete-other-windows)
          (split-window-right)
          (other-window 1)
          (pop-to-buffer-same-window sql-scratch-buffer-name))
      (progn
        (sql-set-product product)
        (sql-connect conn)
        (pop-to-buffer-same-window sql-window-name)
        (delete-other-windows)
        (toggle-truncate-lines)
        (setq sql-buffer sql-window-name)
        (split-window-right)
        (other-window 1)
        (pop-to-buffer-same-window sql-scratch-buffer-name)
        (sql-mode)
        (sql-highlight-mysql-keywords)
        (setq sql-buffer sql-window-name)))))

(defun sql-dev ()
  (interactive)
  (sql-do "dev" "mysql"))

(defun sql-albino ()
  (interactive)
  (sql-do "albino" "mysql"))

(defun sql-docker ()
  (interactive)
  (sql-do "docker" "mysql"))

(defun sql-at-at-local ()
  (interactive)
  (sql-do "at-at-local" "mysql"))

(defun sql-at-at ()
  (interactive)
  (sql-do "at-at" "mysql"))

(defun sql-qa ()
  (interactive)
  (sql-do "qa" "mysql"))

(defun sql-stg ()
  (interactive)
  (sql-do "stg" "mysql"))

(defun sql-any-mysql (dbname)
  (interactive "sDB Name: ")
  (add-to-list 'sql-connection-alist
               '(dbname
                 (sql-product 'mysql)
                 (sql-server dbname)
                 (sql-port 3306)))
  
  (sql-do dbname "mysql"))

(add-to-list 'same-window-buffer-names "*SQL*")

(defun sql-send-region-and-return (start end)
  (interactive "r")
  (let ((oldbuf (buffer-name)))
    (sql-send-region start end)
    (switch-to-buffer oldbuf)))

(global-set-key "\C-cr" 'sql-send-region-and-return)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(sql-mysql-options (quote ("-A" "--default-character-set=utf8" "-C" "-t" "-f" "-n"))))

(provide 'sql-stuffs)
