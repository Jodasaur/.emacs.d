(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
)
(add-hook 'web-mode-hook  'web-mode-hook)

;; scss
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
 
(provide 'init-webdev)
