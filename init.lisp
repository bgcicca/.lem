(use-package :split-sequence) 
(in-package :lem-user)

(load-theme "emacs-dark") 

(add-hook *prompt-after-activate-hook*         
          (lambda ()           
            (call-command 'lem/prompt-window::prompt-completion nil)))(add-hook *prompt-deactivate-hook*   
                                                                                (lambda ()           
                                                                                  (lem/completion-mode:completion-end)))

(lem-vi-mode:vi-mode)

(define-key lem-vi-mode:*insert-keymap* "C-n" 'lem/abbrev:abbrev-with-pop-up-window)
(lem/line-numbers:toggle-line-numbers)
(setf lem/line-numbers:*relative-line* t)

(setf lem:*auto-format* t)

;; Keymaps
(define-key lem-vi-mode:*normal-keymap* "Space s h" 'split-active-window-horizontally)
(define-key lem-vi-mode:*normal-keymap* "Space s v" 'split-active-window-vertically)

(define-key lem-vi-mode:*normal-keymap* "Space w n" 'next-window)
(define-key lem-vi-mode:*normal-keymap* "Space w p" 'previous-window)

(define-key lem-vi-mode:*normal-keymap* "C-p" 'switch-to-last-focused-window)
(define-key lem-vi-mode:*normal-keymap* "C-h" 'window-move-left)
(define-key lem-vi-mode:*normal-keymap* "C-j" 'window-move-down)
(define-key lem-vi-mode:*normal-keymap* "C-k" 'window-move-up)
(define-key lem-vi-mode:*normal-keymap* "C-l" 'window-move-right)
