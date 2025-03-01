(defpackage :config/guile-mode 
  (:use :cl :lem))
(in-package :config/guile-mode)

(defvar *swank-port* 4015)

#+(or sbcl ccl)
(setf lem-scheme-mode::*default-port* *swank-port*
      lem-scheme-mode:*use-scheme-autodoc* :auto
      lem-scheme-mode:*scheme-swank-server-run-command*
      `("guile" "-l" "../lisp/scheme/r7rs-swank/guile-swank.scm"
        "-c" ,(format nil "(import (guile-swank)) (start-swank ~a)"
                      *swank-port*))
      lem-scheme-mode:*use-scheme-repl-shortcut* t )