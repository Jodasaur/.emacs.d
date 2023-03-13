;;Elisp file for management of the my daily journal

(defvar journal-dir "~/Dropbox/dev_journal/latest"
  "File where your daily journal is linked to")

(defun open-latest-journal ()
  (split-window-horizontally)
  (find-file journal-dir))

(provide 'daily-journal)