(defpackage :config/css-mode 
  (:use :cl :lem))
(in-package :config/css-mode)

;; CSS mode
(lem-lsp-mode/lsp-mode::define-language-spec (css-spec lem-css-mode:css-mode)
  :language-id "css"
  :root-uri-patterns '("style.css" ".css")
  :command '("vscode-css-language-server" "--stdio")
  :connection-mode :stdio)
