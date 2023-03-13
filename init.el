;;;;;;;;;;;;;;;;;
;; Library Paths
;;;;;;;;;;;;;;;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elisp/themes/")

;; Import my settings
(require 'custom-funcs)
(require 'init-packagemanager)
(require 'init-keybindings)
(require 'init-interface)
(require 'init-python)
(require 'init-webdev)
;; (require 'init-go)
(require 'init-php)
(require 'init-org)
(require 'init-js)

(when (memq window-system '(x mac ns))
  (exec-path-from-shell-initialize))

;;======================= Enable Commands ========================
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;========================= Misc Extensions ==========================
;;SQL Mode
(require 'sql-stuffs)
(add-hook 'sql-mode-hook 'sql-add-bindings)
(add-hook 'sql-interactive-mode-hook 'sql-add-bindings)
(add-hook 'kill-buffer-hook 'kill-sql-buffer)

;;YAML Mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;Text Mode Spell Check
(add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))

;; Snippets
(require 'yasnippet)
(yas-reload-all)
(add-hook 'sql-mode-hook #'yas-minor-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("28a34dd458a554d34de989e251dc965e3dc72bace7d096cdc29249d60f395a82" default))
 '(dirtrack-list '(" \\(.*\\)" 1))
 '(package-selected-packages '(geben))
 '(sql-mysql-options '("-A" "--default-character-set=utf8" "-C" "-t" "-f" "-n")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; DELETE ME AFTER EMACS 29
;; overriding image.el function image-type-available-p
(defun image-type-available-p (type)
  "Return t if image type TYPE is available.
Image types are symbols like `xbm' or `jpeg'."
  (if (eq 'svg type)
      nil
    (and (fboundp 'init-image-library)
         (init-image-library type))))
