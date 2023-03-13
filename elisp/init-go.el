(require 'custom-funcs)
(require 'go-mode)
(require 'go-autocomplete)
(require 'auto-complete-config)

(set-env-var-from-shell "GOPATH")

;; Go Keybindings
(define-key go-mode-map (kbd "\C-c\C-c") 'compile)

(defun my-go-mode-hook ()
  ;; Formatting for success!
  (add-hook 'before-save-hook 'gofmt-before-save)

  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ;; "Click-through" binding, maybe change to C-c C-g
  (local-set-key (kbd "M-.") 'godef-jump))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
