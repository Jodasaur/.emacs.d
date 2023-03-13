;; Indent 2 levels in PHP
;;(add-hook 'php-mode-hook
;;          '(lambda () (setq c-basic-offset 2)))

;; Open Drupal modules in php-mode
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(provide 'init-php)
