;;; My Personal lem config file
;;; 
;;; By: Bruno Ciccarino
;;; Date: 2025-02-25
;;;
;;; An idiot admires complexity, a genius admires simplicity.
;;;                                                    ― Terry Davis

(use-package :split-sequence)
(in-package :lem-user)

(load-theme "emacs-dark") 

;; (lem-vi-mode:vi-mode)

(lem/line-numbers:toggle-line-numbers)
(setf lem/line-numbers:*relative-line* t)

(add-hook *prompt-after-activate-hook*         
          (lambda ()           
            (call-command 'lem/prompt-window::prompt-completion nil)))(add-hook *prompt-deactivate-hook*   
                                                                                (lambda ()           
                                                                                  (setf lem-core::*default-prompt-gravity* :bottom-display)
                                                                                  (setf lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window)
                                                                                  (setf lem/prompt-window::*fill-width* t)
                                                                                  (lem/completion-mode:completion-end)))

(define-key lem-vi-mode:*insert-keymap* "C-n" 'lem/abbrev:abbrev-with-pop-up-window)

(setf lem:*auto-format* t)

;;; repl 
(define-key lem/listener-mode::*listener-mode-keymap* "C-c C-h" 'repl-history)

(defparameter *history-size* 128)

(defun buffer-history (buffer)
  (alexandria-2:line-up-first
   buffer
   (lem/listener-mode::listener-history)
   (lem/common/history:history-data-list)
   (remove-duplicates :test #'equal)
   (last *history-size*)
   (reverse)))

(define-command repl-history () ()
  (lem/listener-mode:listener-clear-input)
  (let* ((hist-completion (alexandria-2:rcurry #'completion
                                               (buffer-history (current-buffer))
                                               :test #'lem-core::fuzzy-match-p))
         (expr (prompt-for-string "Expr: " :completion-function hist-completion)))
    (insert-string (lem/listener-mode:input-start-point (current-buffer)) expr))
  (move-to-end-of-buffer)
  (lem/listener-mode:listener-return))

;; Keymaps

(define-keys *global-keymap*
  ("C-h b" 'describe-bindings)
  ("C-h k" 'describe-key)
  ("C-h a" 'lem-lisp-mode:lisp-apropos)
  ("C-h c" 'apropos-command)
  ("C-h p" 'lem-lisp-mode:lisp-apropos-package)
  ("C-h f" 'lem-lisp-mode:lisp-describe-symbol))
