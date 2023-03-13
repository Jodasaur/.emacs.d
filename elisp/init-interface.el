;;======================= Global Settings ========================
;; Spaces, no tabs.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

;;Line Highlighting
(global-hl-line-mode 1)

;;Column Numbering
(column-number-mode 1)

;;Disable Toolbar
(tool-bar-mode 0)
(menu-bar-mode 0)

;; Right-click shows functions in current module
(global-set-key [mouse-3] 'imenu)

;; Highlights matching brackets
(show-paren-mode 1)

;;Zenburn
(load-theme 'zenburn t)

;;DirTrack
(add-hook 'shell-mode-hook
          (lambda ()
            (setq shell-dirtrackp nil)
            (add-hook 'comint-preoutput-filter-functions 'dirtrack nil t)
	    (dirtrack-mode t)))
(add-hook 'ssh-mode-hook (lambda () (setq dirtrackp nil)))
(custom-set-variables
 '(dirtrack-list (quote (" \\(.*\\)" 1))))

(provide 'init-interface)
