(defpackage :config/lisp-mode 
  (:use :cl :lem))
(in-package :config/lisp-mode)

(in-package :lem-user)

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

(push "~/.lem/src/modes/../../lisp/lem-pareto/" asdf:*central-registry*)
(asdf:load-system :lem-pareto)
(add-hook *find-file-hook*
          (lambda (buffer)
            (when (eq (buffer-major-mode buffer)
                      'lem-lisp-mode:lisp-mode)
              (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t)
              (change-buffer-mode buffer 'lem-pareto-mode:pareto-mode t))))

(define-command lisp-quickload-file () ()
  (lem-lisp-mode::check-connection)
  (let ((package (lem-lisp-mode::buffer-package (current-buffer))))
    (when package
      (lem-lisp-mode::eval-with-transcript
       `(ql:quickload ,(string-downcase package))))))
(define-key *global-keymap* "C-c C-q" 'lisp-quickload-file)