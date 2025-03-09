(defpackage :config/editor-config 
  (:use :cl :lem))
(in-package :config/editor-config)

(lem/line-numbers:toggle-line-numbers)
(setf lem/line-numbers:*relative-line* t)
(lem:enable-clipboard-p)


;; (setf lem:*auto-format* t)

