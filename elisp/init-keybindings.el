(require 'custom-funcs)
(require 'helm)
(require 'expand-region)

;; Helm
(global-set-key "\M-x" 'helm-M-x)
(global-set-key "\C-cl" 'helm-locate)
(global-set-key "\C-x\C-f" 'helm-find-files)
(global-set-key "\C-xb" 'helm-buffers-list)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)


;;Close emacs confirmation
(global-set-key "\C-x\C-c" 'confirm-kill-terminal)

;;Alt-x Alternative
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;;Kill words alternative
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;Back and Forward paragraphs
(global-set-key "\M-p" 'backward-paragraph)
(global-set-key "\M-n" 'forward-paragraph)

;;Shell Shortcut
(global-set-key "\C-cs" 'named-shell)

;;Newline + Indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;;Clipboard Haxx0rz
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)] 'clipboard-yank)

;;LineNum Mode Key
(global-set-key (kbd "<f5>") 'linum-mode)
(global-linum-mode 1)

;;Go to URL
(global-set-key (kbd "s-b") 'browse-url)

;; Mouse Zoom
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;; Expand Region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Avy
(global-set-key (kbd "C-;") 'avy-goto-char)

(provide 'init-keybindings)
