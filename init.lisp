;;; My Personal lem config file
;;; 
;;; By: Bruno Ciccarino
;;; Date: 2025-02-25
;;;
;;; An idiot admires complexity, a genius admires simplicity.
;;;                                                    ― Terry Davis

(use-package :split-sequence)
(in-package :lem-user)

(asdf:clear-source-registry)

;; Load my init files.
(let ((asdf:*central-registry*
        (append (list (asdf:system-source-directory :lem)
                      #P"~/.lem/" 
                      #P"~/quicklisp/local-projects/"
                      #P"~/common-lisp/")
                asdf:*central-registry*)))
  (ql:quickload :lem-site-init))
