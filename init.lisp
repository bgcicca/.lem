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

(define-color-theme "svelte-high-contrast" ()
  (:display-background-mode :dark)
  (:foreground "#c8d3f5")
  (:background "#000000")
  (:inactive-window-background nil)
  (region :foreground nil :background "#005f00")
  (modeline :bold t :foreground "#8a8a8a" :background "#121212")
  (modeline-inactive :bold t :foreground "#6c6c6c" :background "#121212")
  (syntax-warning-attribute :foreground "#ffff00")
  (syntax-string-attribute :foreground "#00d75f")
  (syntax-comment-attribute :foreground "#636da6")
  (syntax-keyword-attribute :foreground "#c73c3f")
  (syntax-constant-attribute :foreground "#00d75f")
  (syntax-function-name-attribute :foreground "#89b482")
  (syntax-variable-attribute :foreground "#87ff00")
  (syntax-type-attribute :foreground "#7daea3")
  (syntax-builtin-attribute :bold t :foreground "#a9b665"))

(define-attribute lem-lisp-mode/paren-coloring:paren-color-1
  (t :foreground "#b87be9"))
(define-attribute lem-lisp-mode/paren-coloring:paren-color-2
  (t :foreground "#ff7ca5"))
(define-attribute lem-lisp-mode/paren-coloring:paren-color-3
  (t :foreground "#faa37b"))
(define-attribute lem-lisp-mode/paren-coloring:paren-color-4
  (t :foreground "#dbc379"))
(define-attribute lem-lisp-mode/paren-coloring:paren-color-5
  (t :foreground "#b3d88b"))
(define-attribute lem-lisp-mode/paren-coloring:paren-color-6
  (t :foreground "#7be9b8"))

(lem-lisp-mode/paren-coloring:toggle-paren-coloring)

(load-theme "svelte-high-contrast") 

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
  ("C-c l" 'lem-lisp-mode:lisp-mode)
  ("C-c x" 'delete-active-window)
  ("C-c r" 'copy-region)
  ("C-e" 'exit-lem)
  ("C-r r" 'lem-lisp-mode:start-lisp-repl)
  ("C-t" 'lem-terminal/terminal-mode::terminal)
  ("C-v" 'yank)
  ("C-s" 'save-current-buffer)
  ("C-z" 'undo)
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

;; Lisp Mode
(define-command lisp-quickload-file () ()
  (lem-lisp-mode::check-connection)
  (let ((package (lem-lisp-mode::buffer-package (current-buffer))))
    (when package
      (lem-lisp-mode::eval-with-transcript
       `(ql:quickload ,(string-downcase package))))))
(define-key *global-keymap* "C-c C-q" 'lisp-quickload-file)

;; Java Mode
(lem-lsp-mode:define-language-spec (java-spec lem-java-mode:java-mode)
  :language-id "java"
  :root-uri-patterns '("pom.xml" "build.gradle" ".git")
  :command '("java-language-server")
  :install-command "git clone https://github.com/georgewfraser/java-language-server && cd java-language-server && ./gradlew build"
  :readme-url "https://github.com/georgewfraser/java-language-server"
  :connection-mode :stdio)

;; Auto-save mode
(setf (lem:variable-value 'lem/auto-save::auto-save-checkpoint-frequency :global) 1.5)
(setf (lem:variable-value 'lem/auto-save::auto-save-key-count-threshold :global) 0)

(lem/auto-save::auto-save-mode t) 