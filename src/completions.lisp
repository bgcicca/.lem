(defpackage :config/completions
  (:use :cl :lem))
(in-package :config/completions)

(setf lem-core::*default-prompt-gravity* :bottom-display
      lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window
      lem/prompt-window::*fill-width* t)

(add-hook *prompt-after-activate-hook*
          (lambda () 
            (call-command 'lem/prompt-window::prompt-completion nil)))

(add-hook *prompt-deactivate-hook*
          (lambda () 
            (lem/completion-mode:completion-end)))

(define-key lem-vi-mode:*insert-keymap* "C-n" 'lem/abbrev:abbrev-with-pop-up-window)