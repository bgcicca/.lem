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
(setf lem: *auto-format* t)
