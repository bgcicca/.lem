;;; My Personal lem config file
;;; 
;;; By: Bruno Ciccarino
;;; Date: 2025-02-25
;;;
;;; An idiot admires complexity, a genius admires simplicity.
;;;                                                    ― Terry Davis

(use-package :split-sequence)
(in-package :lem-user)

(define-color-theme "gruvbox-material" ()
  (:display-background-mode :dark)
  (:foreground "#a89984")
  (:background "#292828")
  (:inactive-window-background nil)
  (region :foreground nil :background "#005f00")
  (modeline :bold t :foreground "#8a8a8a" :background "#121212")
  (modeline-inactive :bold t :foreground "#6c6c6c" :background "#121212")
  (syntax-warning-attribute :foreground "#ffff00")
  (syntax-string-attribute :foreground "#00d75f")
  (syntax-comment-attribute :foreground "#928374")
  (syntax-keyword-attribute :foreground "#ea6962")
  (syntax-constant-attribute :foreground "#00d75f")
  (syntax-function-name-attribute :foreground "#89b482")
  (syntax-variable-attribute :foreground "#87ff00")
  (syntax-type-attribute :foreground "#7daea3")
  (syntax-builtin-attribute :bold t :foreground "#a9b665"))

(load-theme "gruvbox-material") 

;; (lem-vi-mode:vi-mode)

(lem/line-numbers:toggle-line-numbers)
(setf lem/line-numbers:*relative-line* t)

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
  ("C-c s" 'split-active-window-horizontally)
  ("C-c v" 'split-active-window-vertically)
  ("C-c o" 'next-window)
  ("C-c p" 'previous-window)
  ("C-c d" 'delete-window)
  ("C-c t" 'terminal)
  ("C-c l" 'lem-lisp-mode:lisp-mode)
  ("C-c x" 'delete-active-window)
  ("C-v" 'yank)
  ("C-s" 'save-current-buffer)
  ("C-z" 'undo)
  ("C-r o" 'toggle-read-only)
  ("C-r b" 'rename-buffer))

(define-keys *global-keymap*
  ("C-h b" 'describe-bindings)
  ("C-h k" 'describe-key)
  ("C-h a" 'lem-lisp-mode:lisp-apropos)
  ("C-h c" 'apropos-command)
  ("C-h p" 'lem-lisp-mode:lisp-apropos-package)
  ("C-h f" 'lem-lisp-mode:lisp-describe-symbol))

(define-key *global-keymap* "M-r" 'revert-buffer)
