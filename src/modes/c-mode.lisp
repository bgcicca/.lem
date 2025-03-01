(defpackage :config/c-mode 
  (:use :cl :lem))
(in-package :config/c-mode)

(lem-lsp-mode/lsp-mode::define-language-spec (c-spec lem-c-mode:c-mode)
  :language-id "c"
  :root-uri-patterns '("makefile" "Makefile")
  :command '("clangd" "-background-index")
  :connection-mode :stdio)