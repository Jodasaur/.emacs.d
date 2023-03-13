;; Custom functions modifying emacs' behavior

(defun confirm-kill-terminal (user-input)
  "Checks if the user wants to close emacs."
  (interactive "sAre you sure you want to close emacs you fat-fingered idiot? ")
  (if (string= user-input "yes")
      (save-buffers-kill-terminal)))

(defun aprestart ()
  "Restarts apache."
  (interactive)
  (shell-command-to-string
   (concat "echo "
	   (read-passwd "Password: " )
	   " | sudo -S /usr/local/apache2/bin/apachectl restart")))

(defun create-new-shell (shell-name)
  "Creates a new shell with the supplied name."
  (eshell)
  (rename-buffer shell-name))

(defun named-shell (user-input)
  "Creates or switches to the shell with the supplied name."
  (interactive "sShell name: ")
  (let ((shell-name (concat user-input "-shell")))
    (if (get-buffer shell-name)
	(switch-to-buffer shell-name)
      (create-new-shell shell-name))))

(defun better-less-css-compile (output-file)
  (interactive (list (read-file-name "Target CSS Directory:")))
  (setq less-css-output-directory output-file)
  (message "Derp: %s" output-file)
  (less-css-compile))

(defun hg-blame ()
  (interactive)
  (let ((blame-buf (concat "HG Blame: " (buffer-name))))
    (call-process "hg" nil blame-buf nil "blame" "-und" (buffer-file-name))
    (goto-line (line-number-at-pos) blame-buf)))

(defun git-blame ()
  (interactive)
  (let ((blame-buf (concat "git blame: " (buffer-name))))
    (call-process "git" nil blame-buf nil "blame" (buffer-file-name))
    (goto-line (line-number-at-pos) blame-buf)))

(defun hg-diff ()
  (interactive)
  (let ((blame-buf (concat "HG Diff: " (buffer-name))))
    (call-process "hg" nil blame-buf nil "diff" (buffer-file-name))
    (goto-line (line-number-at-pos) blame-buf)))

(defun nosetest ()
  (interactive)
  (let ((nose-buf (concat "Nose: " (buffer-name))))
    (if (get-buffer nose-buf)
	(kill-buffer nose-buf))
    (call-process "nosetests" nil nose-buf nil "" (buffer-file-name))
    (goto-line 1 nose-buf)))

;; Thanks, CoolRaoul.
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

;; Debug a simple PHP script.
;; Change the session key my-php-54 to any session key text you like
;; https://blogs.oracle.com/opal/entry/quick_debugging_of_php_scripts
(defun php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='idekey=emacs24' /usr/bin/php "
    (buffer-file-name) " &"))
  )

; derived from ELPA installation  
; http://tromey.com/elpa/install.html  
(defun eval-url (url)  
  (let ((buffer (url-retrieve-synchronously url)))  
  (save-excursion  
    (set-buffer buffer)  
    (goto-char (point-min))  
    (re-search-forward "^$" nil 'move)  
    (eval-region (point) (point-max))  
    (kill-buffer (current-buffer)))))  

(defun install-el-get ()  
  (eval-url  
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))  
  
(defun get-shell-var (var)
  (shell-command-to-string (concat "$SHELL -i -c 'printf $'" var " 2> /dev/null")))

(defun set-env-var-from-shell (var)
  (let ((path-from-shell (get-shell-var var))))
  (setenv var (get-shell-var var)))

(defun search-python ()
  (interactive)
  (let ((pattern (read-string "Search Pattern: ")))
    (rgrep pattern "~/flippy" "~/propjoe" "~/fk_api")))

(provide 'custom-funcs)
