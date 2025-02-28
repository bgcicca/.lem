(defpackage :config/keybindings 
  (:use :cl :lem))
(in-package :config/keybindings)

(define-keys *global-keymap*
  ("C-c s" 'lem-core/commands/window:split-active-window-horizontally)
  ("C-c v" 'lem-core/commands/window:split-active-window-vertically)
  ("C-c o" 'lem-core/commands/window:next-window)
  ("C-c p" 'lem-core/commands/window:previous-window)
  ("C-c d" 'delete-window)
  ("C-c l" 'lem-lisp-mode:lisp-mode)
  ("C-c x" 'lem-core/commands/window:delete-active-window)
  ("C-c r" 'lem-core/commands/edit:copy-region-to-clipboard)
  ("C-e" 'exit-lem)
  ("C-r r" 'lem-lisp-mode:start-lisp-repl)
  ("C-t" 'lem-terminal/terminal-mode::terminal)
  ("C-v" 'yank)
  ("C-s" 'save-current-buffer)
  ("C-z" 'undo)
  ("C-/" 'lem/language-mode::comment-or-uncomment-region) 
  ("C-f" 'lem-core/commands/file:find-file)
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