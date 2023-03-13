(require 'org)

(setq org-agenda-files '("~/org/todo"))
(define-key global-map "\C-ca" 'org-agenda)
(provide 'init-org)
