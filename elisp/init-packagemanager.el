;; Setup package managers
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

(unless (require 'el-get nil t)  
  (install-el-get))

; list all packages you want installed  
(setq my-el-get-packages  
      '(python-pep8
;;        jedi
        exec-path-from-shell
        ack-and-a-half
        avy
        helm
        hydra
        mustache-mode
;;        org-jira
        csharp-mode
        yasnippet
        yasnippet-snippets
        php-mode
        expand-region
        pyenv
        org-mode
        web-mode
        markdown-mode
;;        color-theme-zenburn
;;        color-theme
        ))
  
(el-get 'sync my-el-get-packages)  
(el-get-cleanup my-el-get-packages)

(provide 'init-packagemanager)
