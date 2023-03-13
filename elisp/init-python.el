;;ropemacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")

;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;;pylint/pep8
(require 'tramp)
(require 'compile)
(require 'python-pep8)
(require 'python-pylint)
(setq python-pylint-options '("-rn" "-f parseable --errors-only"))

(push "~/.virtualenvs/default/bin" exec-path)
(setenv "PATH"
        (concat
         "~/.virtualenvs/default/bin" ":"
         (getenv "PATH")
         ))

(setenv "VIRTUAL_ENV" "~/.virtualenvs/default")

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t) 
;; (add-hook 'jedi-mode-hook
;;           (lambda () (remove-hook 'after-change-functions
;;                                   'jedi:after-change-handler t)))

(provide 'init-python)
